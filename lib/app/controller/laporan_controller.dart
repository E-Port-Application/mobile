import 'package:eport/app/models/common/menu/laporan_menu_model.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:get/get.dart';

class LaporanController extends GetxController {
  static LaporanController get i => Get.find<LaporanController>();
  RxList<LaporanMenuModel> menu = RxList<LaporanMenuModel>([]);
  RxInt current = 0.obs;

  void getMenu() async {
    menu.value =
        await convertJson<LaporanMenuModel>("assets/data/menu_laporan.json");
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
  }
}
