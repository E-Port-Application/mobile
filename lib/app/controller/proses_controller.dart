import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProsesController extends GetxController {
  static ProsesController get i => Get.find<ProsesController>();
  RxBool openFilter = false.obs;
  Rx<Offset> offsetFilter = Rx(Offset(0, 0));
  RxList<ActivityModel> activities = RxList([]);
  Rxn<ActivityModel> selectedActivity = Rxn<ActivityModel>();
  RxList<LaporanModel> datas = RxList<LaporanModel>();

  void handleFilterTogle(bool val) {
    openFilter.value = val;
  }

  RxBool isLoading = true.obs;

  void getData() async {
    try {
      LaporanController.i.getData();
      LaporanController.i.prosesData.listen((p0) {
        datas.value = p0;
        datas.refresh();
      });
      isLoading.value = LaporanController.i.loadingProsesData.value;
      LaporanController.i.loadingProsesData.listen((p0) {
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
    selectedActivity.value = null;
  }

  void onActivity(ActivityModel data) {
    selectedActivity.value = data;
  }
}
