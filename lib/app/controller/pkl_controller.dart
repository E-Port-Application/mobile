import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PklController extends GetxController {
  static PklController get i => Get.find<PklController>();
  Rx<Offset> pklOffset = Rx<Offset>(Offset.zero);
  RxBool showPkl = false.obs;
  RxnInt selectedPkl = RxnInt();
  List<RadioProps<int>> jenisPkl = [
    RadioProps(label: "Lapak", value: 0),
    RadioProps(label: "Penjual Bermobil", value: 1),
    RadioProps(label: "Penjual Bersepeda", value: 2),
    RadioProps(label: "Penjual Bermotor", value: 3),
    RadioProps(label: "Penjual Bermotor Roda 3", value: 4),
    RadioProps(label: "Rombong", value: 5),
    RadioProps(label: "Asongan", value: 6),
    RadioProps(label: "Tenda", value: 7),
    RadioProps(label: "Gerobak", value: 8),
    RadioProps(label: "Becak", value: 9),
    RadioProps(label: "Lesehan/Beberan", value: 10),
  ].obs;

  RxBool showTindakan = false.obs;
  List<RadioProps<String>> jenisTindakan = [
    RadioProps(label: "Peringatan Lisan", value: "peringatan-lisan"),
    RadioProps(label: "Peringatan Tertulis", value: "peringatan-tertulis"),
    RadioProps(label: "Dihalau", value: "dihalau"),
    RadioProps(label: "Penyegelan", value: "penyegelan"),
    RadioProps(label: "Penyitaan", value: "penyitaan"),
    RadioProps(label: "Penguncian", value: "penguncian"),
    RadioProps(label: "Penderekan", value: "penderekan"),
    RadioProps(label: "Pemindahan", value: "pemindahan"),
    RadioProps(label: "Pemberian Denda", value: "pemberian-denda"),
    RadioProps(label: "Pembongkaran", value: "pembongkaran"),
    RadioProps(label: "Tipiring", value: "tipiring"),
  ].obs;
  RxString selectedTindakan = "".obs;

  RxBool showPelanggaran = false.obs;
  List<RadioProps<String>> jenisPelanggaran = [
    RadioProps(label: "Menggunakan Trotoar", value: "trotoal"),
    RadioProps(label: "Jalan Raya", value: "jalan-raya"),
    RadioProps(label: "Bahu Jalan", value: "bahu-jalan"),
    RadioProps(label: "Diatas Gorong-Gorong", value: "gorong-gorong"),
    RadioProps(label: "Diatas Irigasi", value: "irigasi"),
    RadioProps(label: "Fasilitas Umum", value: "fasilitas-umum"),
  ].obs;
  RxString selectedPelanggaran = "".obs;

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
