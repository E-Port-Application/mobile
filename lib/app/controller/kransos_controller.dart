import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KransosController extends GetxController {
  static KransosController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "jenis": TextEditingController(),
    "deskripsi": TextEditingController(),
    "tindakan": TextEditingController(),
    "jumlah": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;

  RxBool showJenis = false.obs;
  RxList<LaporanTypeModel> jenis = <LaporanTypeModel>[].obs;
  RxnString selectedJenis = RxnString();

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  void handleSaveMenu<T>(T val, Rx<T> selected, RxBool show,
      List<RadioProps<T>> options, String formKey) {
    selected.value = val;
    show.value = false;
    var selectedValue = options.firstWhereOrNull((e) => e.value == val);
    if (selectedValue != null) {
      form[formKey]!.text = selectedValue.label;
    }
  }

  void getJenisKeransos() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/keransos/jenis");
      jenis.value = data;
      jenis.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getJenisKeransos();
  }
}
