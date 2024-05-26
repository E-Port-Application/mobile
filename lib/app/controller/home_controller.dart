import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find<HomeController>();
  Rxn<ScrollEndNotification> scrolled = Rxn<ScrollEndNotification>();
}
