import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProsesController extends GetxController {
  static ProsesController get i => Get.find<ProsesController>();
  RxBool openFilter = false.obs;
  Rx<Offset> offsetFilter = Rx(Offset(0, 0));
  RxList<ActivityModel> activities = RxList([]);
  Rxn<ActivityModel> selectedActivity = Rxn<ActivityModel>();

  void handleFilterTogle(bool val) {
    openFilter.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    activities.value = LaporanController.i.activities;
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
