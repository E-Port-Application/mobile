import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/common/menu/laporan_menu_model.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanController extends GetxController {
  static LaporanController get i => Get.find<LaporanController>();
  RxList<LaporanMenuModel> menu = RxList<LaporanMenuModel>([]);
  RxInt current = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  RxList<ActivityModel> activities = RxList<ActivityModel>([
    ActivityModel(
      label: "Laporan Pamwal",
      id: "perda-perkada",
    ),
    ActivityModel(
      label: "Perda dan Perwali",
      id: "perda-perwali",
    ),
    ActivityModel(
      label: "Laporan PTI",
      id: "laporan-pti",
    ),
    ActivityModel(
      label: "Laporan Pam-In",
      id: "pam-in",
    ),
  ]);

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
