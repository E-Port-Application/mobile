import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PimpinanController extends GetxController {
  static PimpinanController get i => Get.find<PimpinanController>();
  RxBool openFilter = false.obs;
  Rx<Offset> offsetFilter = Rx(Offset(0, 0));
  RxList<ActivityModel> activities = RxList([]);
  RxList<LaporanModel> datas = RxList<LaporanModel>();

  void handleFilterTogle(bool val) {
    openFilter.value = val;
  }

  RxBool isLoading = true.obs;

  void getData() async {
    try {
      LaporanController.i.getProsesData();
      LaporanController.i.pimpinanData.listen((p0) {
        datas.value = p0;
        datas.refresh();
      });
      isLoading.value = LaporanController.i.loadingPimpinanData.value;
      LaporanController.i.loadingPimpinanData.listen((p0) {
        isLoading.value = p0;
      });
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    activities.value = LaporanController.i.activities;
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    LaporanController.i.current.value = 1;
  }

  void onReset() {
    LaporanController.i.selectedPimpinan.value = null;
    LaporanController.i.startDatePimpinan.value = null;
    LaporanController.i.endDatePimpinan.value = null;
  }

  void onActivity(ActivityModel data) {
    LaporanController.i.selectedPimpinan.value = data;
  }

  void onDate(List<DateTime?> data) {
    LaporanController.i.startDatePimpinan.value = data[0];
    LaporanController.i.endDatePimpinan.value = data[1];
  }
}
