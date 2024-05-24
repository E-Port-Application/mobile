import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
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
                // _googleSignIn.signIn().then((userData) {
                //   // setState(() {
                //   // });
                //   print('cok anjay $userData');
                // }).catchError((e) {
                //   print(e);
                // });

                try {
                  print('cok bisa cok');

                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();

                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;

                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  await auth.signInWithCredential(credential);
                } catch (e) {
                  print('exception->$e');
                }
              },
              text: "Masuk",
            ),
          ],
        ),
      ),
    );
  }
}
