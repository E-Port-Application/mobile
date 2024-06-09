import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerizinanController extends GetxController {
  static PerizinanController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "nama": TextEditingController(),
    "jenis": TextEditingController(),
    "pelanggaran": TextEditingController(),
    "tindakan": TextEditingController(),
    "personil": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;

  RxList<Personil> personils = RxList<Personil>();
  RxList<Rx<Personil>> currentPersonil = RxList<Rx<Personil>>();
}
