import 'package:eport/app/models/db/personil/personil_model.dart';
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

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();
}
