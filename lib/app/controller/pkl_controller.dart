import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class A<T> extends RadioProps<T> {
  final String? a;

  const A({required super.label, required super.value, this.a = ""});
}

class PklController extends GetxController {
  static PklController get i => Get.find<PklController>();
  Rx<Offset> pklOffset = Rx<Offset>(Offset.zero);
  RxBool showPkl = false.obs;
  RxnString selectedPkl = RxnString();
  RxList<LaporanTypeModel> jenisPkl = <LaporanTypeModel>[].obs;

  RxBool showTindakan = false.obs;
  RxList<LaporanTypeModel> jenisTindakan = <LaporanTypeModel>[].obs;
  RxnString selectedTindakan = RxnString();

  RxBool showPelanggaran = false.obs;
  RxList<LaporanTypeModel> jenisPelanggaran = <LaporanTypeModel>[].obs;
  RxnString selectedPelanggaran = RxnString();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktuMulai": TextEditingController(),
    "waktuSelesai": TextEditingController(),
    "jenisPkl": TextEditingController(),
    "jenisPelanggaran": TextEditingController(),
    "jenisTindakan": TextEditingController(),
    "jumlahPelanggar": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;
  RxList<Personil> personils = RxList<Personil>();
  RxList<Rx<Personil>> currentPersonil = RxList<Rx<Personil>>();

  void getJenisPkl() async {
    try {
      var data = await LaporanRepository.getJenisPkl();
      jenisPkl.value = data;
      jenisPkl.refresh();
    } catch (_) {}
  }

  void getPelanggaranPkl() async {
    try {
      var data = await LaporanRepository.getPelanggaranPkl();
      jenisPelanggaran.value = data;
      jenisPelanggaran.refresh();
    } catch (_) {}
  }

  void getTindakanPkl() async {
    try {
      var data = await LaporanRepository.getTindakanPkl();
      jenisTindakan.value = data;
      jenisTindakan.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getJenisPkl();
    getTindakanPkl();
    getPelanggaranPkl();
  }

  void getOffset(GlobalKey ref) {
    RenderBox box = ref.currentContext!.findRenderObject() as RenderBox;
    pklOffset.value = box.localToGlobal(Offset.zero);
  }

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
