import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/repository/auth_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterController extends GetxController {
  static RegisterController get i => Get.find<RegisterController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = true.obs;

  RxMap<String, TextEditingController> form = {
    "email": TextEditingController(),
    "name": TextEditingController(),
    "nik": TextEditingController(),
    "password": TextEditingController(),
    "confirmPassword": TextEditingController(),
  }.obs;

  String? emailValidator(e) {
    if (e!.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!e.isEmail) {
      return "Email invalid";
    }
    return null;
  }

  String? nikValidator(e) {
    final regex = RegExp(
        r'^\d{6}([04][1-9]|[1256][0-9]|[37][01])(0[1-9]|1[0-2])\d{2}\d{4}$');
    if (e == null || e.isEmpty) {
      return "NIK tidak boleh kosong";
    } else if (!regex.hasMatch(e)) {
      return 'NIK invalid';
    }
    return null;
  }

  String? passwordValidator(e) {
    if (e!.isEmpty) {
      return "Password tidak boleh kosong";
    }
    return null;
  }

  void emailRegister() async {
    if (formKey.currentState!.validate()) {
      return;
    }
  }

  void googleSignin() async {
    try {
      isLoading.value = true;
      showLoadingDialog(Get.context!, isLoading);
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

      final authData = await auth.signInWithCredential(credential);
      await AuthRepository.roleValidate(authData, isLoading);
    } on Exception catch (err) {
      closeLoading(isLoading);
      showAlert(err.toString());
    }
  }
}
