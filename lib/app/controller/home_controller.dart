import 'package:eport/app/controller/cache_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find<HomeController>();
  Rxn<ScrollEndNotification> scrolled = Rxn<ScrollEndNotification>();

  @override
  void onInit() {
    super.onInit();
    CacheController.i.getCurrentPosition();
  }
}
