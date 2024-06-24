import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PiketController extends GetxController {
  static PiketController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "shift": TextEditingController(),
    "lokasi": TextEditingController(),
    "tindakan": TextEditingController(),
    "jumlah": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;

  RxBool showShift = false.obs;
  RxList<LaporanTypeModel> shift = <LaporanTypeModel>[].obs;
  RxnString selectedShift = RxnString();

  RxBool showLokasi = false.obs;
  RxList<LaporanTypeModel> lokasi = <LaporanTypeModel>[].obs;
  RxnString selectedLokasi = RxnString();

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

  void getShift() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/piket/shift");
      shift.value = data;
      shift.refresh();
    } catch (_) {}
  }

  void getLokasi() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/piket/lokasi");
      lokasi.value = data;
      lokasi.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getShift();
    getLokasi();
  }
}
