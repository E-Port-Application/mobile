import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static LoginController get i => Get.find<LoginController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  }.obs;

  String? emailValidator(e) {
    if (e == null || e!.isEmpty) {
      return "Email can't be empty";
    }

    if (!(e as String).isEmail) {
      return "Email invalid";
    }
    return null;
  }

  String? passwordValidator(e) {
    if (e!.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  RxBool isLoading = true.obs;
  void emailSignin() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final email = form['email']!.text.trim();
        final password = form['password']!.text.trim();
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        isLoading.value = false;
        Get.offAllNamed(AppRoute.home);
      } catch (err) {
        isLoading.value = false;
        showAlert("Email or Password is invalid");
      }
    }
  }

  void googleSignin() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      showLoadingDialog(Get.context!, isLoading);
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      isLoading.value = false;
      Get.offAllNamed(AppRoute.home);
    } on Exception catch (err) {
      isLoading.value = false;
      showAlert(err.toString());
    }
  }
}
