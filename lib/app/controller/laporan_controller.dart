import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/common/menu/laporan_menu_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
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

  String buttonText(LaporanType type, {bool isPkl = false}) {
    switch (type) {
      case LaporanType.create:
        return "Buat Rencana Kegiatan";
      case LaporanType.update:
        return "Buat Laporan Kegiatan";
      default:
        return "Unduh Laporan Kegiatan";
    }
  }

  String title(LaporanType type) {
    switch (type) {
      case LaporanType.create:
        return "Rencana";
      case LaporanType.update:
        return "Laporan";
      default:
        return "Riwayat";
    }
  }

  RxList<LaporanModel> prosesData = RxList<LaporanModel>();
  RxBool loadingProsesData = true.obs;
  RxList<LaporanModel> riwayatData = RxList<LaporanModel>();
  RxBool loadingRiwayatData = true.obs;

  void getMenu() async {
    menu.value =
        await convertJson<LaporanMenuModel>("assets/data/menu_laporan.json");
  }

  void getData() async {
    try {
      LaporanRepository.getReportData(isProgress: true).then((value) {
        prosesData.value = value;
        loadingProsesData.value = false;
      }).catchError((_) {});
      LaporanRepository.getReportData(isProgress: false).then((value) {
        riwayatData.value = value;
        loadingRiwayatData.value = false;
      }).catchError((_) {});
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
    getData();
  }
}
