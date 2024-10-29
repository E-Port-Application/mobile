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
    if (e == null || e!.isEmpty) {
      return "Email can't be empty";
    }

    if (!(e as String).isEmail) {
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

  String? passwordValidator(String? e) {
    if (e == null || e.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (e.length < 8) {
      return "Password harus memiliki minimal 8 karakter";
    }
    if (!RegExp(r'[0-9]').hasMatch(e)) {
      return "Password harus mengandung setidaknya 1 angka";
    }
    if (!RegExp(r'[A-Z]').hasMatch(e)) {
      return "Password harus mengandung setidaknya 1 huruf kapital";
    }
    if (!RegExp(r'[#@\$_-]').hasMatch(e)) {
      return "Password harus mengandung setidaknya 1 karakter spesial (#, @, \$, _, -)";
    }
    return null;
  }

  String? confirmPasswordValidator(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Konfirmasi password tidak boleh kosong";
    }

    if (confirmPassword != form['password']!.text) {
      return "Konfirmasi password harus sama dengan password";
    }
    return null;
  }

  void emailRegister() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        showLoadingDialog(Get.context!, isLoading);
        final authData = await auth.createUserWithEmailAndPassword(
          email: form['email']!.text,
          password: form['password']!.text,
        );
        await AuthRepository.roleValidate(authData, isLoading);
      } catch (err) {
        closeLoading(isLoading);
        showAlert(err.toString());
      }
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
