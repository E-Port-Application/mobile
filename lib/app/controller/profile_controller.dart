import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/models/common/profile/profile_model.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get i => Get.find<ProfileController>();
  Rxn<User> user = Rxn<User>();
  RxList<ProfileModel> menu = RxList<ProfileModel>([]);

  @override
  void onInit() async {
    super.onInit();
    user.value = GlobalController.i.user.value;
    menu.value = await convertJson<ProfileModel>("assets/data/profiles.json");
  }
}
