import 'package:eport/firebase_options.dart';
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
    if (e!.isEmpty) {
      return "Email can't be empty";
    }
    if (!e.isEmail) {
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

  void emailSignin() async {
    if (formKey.currentState!.validate()) {
      return;
    }
  }

  void googleSignin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
    } on Exception catch (err) {
      print(err.toString());
    }
  }
}
