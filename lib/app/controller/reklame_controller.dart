import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReklameController extends GetxController {
  static ReklameController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "nama": TextEditingController(),
    "jenis": TextEditingController(),
    "pelanggaran": TextEditingController(),
    "jumlah": TextEditingController(),
    "tindakan": TextEditingController(),
  }.obs;

  RxBool showJenis = false.obs;
  RxList<LaporanTypeModel> jenis = <LaporanTypeModel>[].obs;
  RxnString selectedJenis = RxnString();

  RxBool showPelanggaran = false.obs;
  RxList<LaporanTypeModel> pelanggaran = <LaporanTypeModel>[].obs;
  RxnString selectedPelanggaran = RxnString();

  RxList<Personil> personils = RxList<Personil>();
  RxList<Rx<Personil>> currentPersonil = RxList<Rx<Personil>>();

  void handleSaveMenu<T>(T val, Rx<T> selected, RxBool show,
      List<RadioProps<T>> options, String formKey) {
    selected.value = val;
    show.value = false;
    var selectedValue = options.firstWhereOrNull((e) => e.value == val);
    if (selectedValue != null) {
      form[formKey]!.text = selectedValue.label;
    }
  }
}
