import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PType { input, textarea, date, dropdown }

class P {
  final String? id;
  final PType? type;
  final String? label;
  String? placeholder;
  String? hint;
  List<P>? datas;

  P({
    this.type,
    this.label,
    this.id,
    this.hint,
    this.placeholder,
    this.datas,
  });
}

class PerkadaController extends GetxController {
  static PerkadaController get i => Get.find<PerkadaController>();

  RxList<P> inputList = RxList([
    P(
      type: PType.input,
      label: "Jenis Kegiatan",
      id: "jenis-kegiatan",
      placeholder: "Input Jenis Kegiatan",
    ),
    P(
      type: PType.input,
      label: "Jenis Pelanggaran",
      id: "jenis-pelanggaran",
      placeholder: "Input Jenis Kegiatan",
    ),
    P(
      type: PType.date,
      label: "Tanggal Pelanggaran",
      id: "tanggal",
      placeholder: "Input Jenis Kegiatan",
    ),
    P(
      type: PType.textarea,
      label: "Keterangan",
      id: "keterangan",
      placeholder: "Input Keterangan",
    ),
    P(
      type: PType.dropdown,
      label: "Dropdown",
      id: "jenis-elah",
      placeholder: "Input Keterangan",
    ),
  ]);

  RxMap<String, dynamic> form = {
    "jenis-kegiatan": TextEditingController(),
    "jenis-pelanggaran": TextEditingController(),
    "tanggal": TextEditingController(),
    "keterangan": TextEditingController(),
    "jenis-elah": RxnString(),
  }.obs;
}
