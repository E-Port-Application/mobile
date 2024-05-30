import 'package:eport/app/controller/laporan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProsesController extends GetxController {
  static ProsesController get i => Get.find<ProsesController>();
  RxBool openFilter = false.obs;
  Rx<Offset> offsetFilter = Rx(Offset(0, 0));
  GlobalKey filterRef = GlobalKey();

  void handleFilterTogle(bool val) {
    openFilter.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    print('onint');
  }

  @override
  void onReady() {
    super.onReady();
    LaporanController.i.current.value = 1;
    RenderBox box = filterRef.currentContext!.findRenderObject() as RenderBox;
    Offset offsetTemp = box.localToGlobal(Offset.zero);
    offsetFilter.value = offsetTemp;
  }
}
