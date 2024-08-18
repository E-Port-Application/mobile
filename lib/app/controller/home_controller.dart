import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/masyarakat_repository.dart';
import 'package:eport/global_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find<HomeController>();
  Rxn<ScrollEndNotification> scrolled = Rxn<ScrollEndNotification>();

  RxList<LaporanExternalModel> myLaporan = <LaporanExternalModel>[].obs;
  RxBool loadingMyLaporan = true.obs;

  RxList<LaporanModel> reportData = <LaporanModel>[].obs;
  RxBool loadingReportData = true.obs;

  void getMyLaporan() {
    MasyarakatRepository.getAll().then((value) async {
      myLaporan.value = value;
      loadingMyLaporan.value = false;
    }).catchError((_) {
      loadingMyLaporan.value = false;
    });
  }

  void getReportData() {
    loadingReportData.value = true;
    LaporanRepository.getReportData(isProgress: true).then((value) {
      reportData.value = value;
      loadingReportData.value = false;
    }).catchError((_) {
      loadingReportData.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
    CacheController.i.getCurrentPosition();
    if (Global.isExt()) {
      getMyLaporan();
    } else {
      getReportData();
    }
  }
}
