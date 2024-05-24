import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app-logo.png",
              width: 55.w,
            ),
            SizedBox(height: 60.h),
            Container(
              width: 315.w,
              height: 315.h,
              decoration: BoxDecoration(
                gradient: ColorConstants.gradient[1],
              ),
            ),
            Text(
              "Aplikasi E-Port hadir untuk memudahkan  pelaporan anda",
              style: h4BTextStyle(),
            ),
            AppButton(
              onPressed: () async {
                // _googleSignIn.signIn().then((value) async {
                //   final googleAuth = await value?.authentication;
                //   final credential = GoogleAuthProvider.credential(
                //     accessToken: googleAuth?.accessToken,
                //     idToken: googleAuth?.idToken,
                //   );
                //   await auth.signInWithCredential(credential);
                // }).catchError((err) {
                //   print('errr $err');
                //   err.printError();
                // });

                try {
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();

                  // if (googleUser == null) {
                  //   return;
                  // }

                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;
                  // if (googleAuth == null) {
                  //   return;
                  // }

                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  await auth.signInWithCredential(credential);
                } on Exception catch (e) {
                  print('exception->$e');
                }
              },
              text: "Masuk",
            ),
            AppButton(
              onPressed: () async {
                try {
                  await auth.signOut();
                  await _googleSignIn.signOut();
                } catch (e) {
                  print('exception->$e');
                }
              },
              text: "Logout",
            ),
            AppButton(
              onPressed: () async {
                try {
                  final u = auth.currentUser;
                  print(u);
                } catch (e) {}
              },
              text: "cek akun",
            ),
            AppButton(
              onPressed: () async {
                try {
                  final a = await auth.signInWithEmailAndPassword(
                      email: "test+1@gmail.com", password: "password");

                  print(a);
                } catch (err) {}
              },
              text: "Login Email",
            ),
          ],
        ),
      ),
    );
  }
}
