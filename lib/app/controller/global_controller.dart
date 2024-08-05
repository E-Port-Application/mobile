import 'package:eport/app/models/common/menu/menu_model.dart';
import 'package:eport/app/repository/auth_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rxn<User> user = Rxn<User>();
  RxList<MenuModel> menus = RxList<MenuModel>([]);

  static GlobalController get i => Get.find<GlobalController>();

  void getMenu() async {
    String path = Global.name == UserVariant.internal
        ? "assets/data/menus.json"
        : "assets/data/menus_ext.json";
    List<MenuModel> res = await convertJson<MenuModel>(path);
    menus.value = res;
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
    auth.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          this.user.value = user;
          AuthRepository.assignRole(user);
        } else {
          this.user.value = null;
        }
      },
    );
  }
}
