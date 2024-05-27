import 'package:eport/app/models/common/menu/menu_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  Rxn<User> user = Rxn<User>();
  RxList<MenuModel> menus = RxList<MenuModel>([]);

  static GlobalController get i => Get.find<GlobalController>();

  void getMenu() async {
    List<MenuModel> res =
        await convertJson<MenuModel>("assets/data/menus.json");
    menus.value = res;
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
    auth.userChanges().listen((event) {
      if (event != null) {
        user.value = event;
      }
    });
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
