import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengamananController extends GetxController {
  static PengamananController get i => Get.find<PengamananController>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "kejadian": TextEditingController(),
    "tindakan": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;

  RxList<Personil> personils = RxList<Personil>();
  RxList<Rx<Personil>> currentPersonil = RxList<Rx<Personil>>();
}
