import 'package:eport/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rxn<User> user = Rxn<User>();

  static GlobalController get i => Get.find<GlobalController>();

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          this.user.value = user;
          // userData.value = await UserRepository.get();
        } else {
          this.user.value = null;
          // userData.value = null;
        }
      },
    );
  }
}
