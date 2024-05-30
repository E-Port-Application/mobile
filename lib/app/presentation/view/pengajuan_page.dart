import 'package:eport/app/controller/pengajuan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/card_pengajuan.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengajuanPage extends GetView<PengajuanController> {
  const PengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold(
      index: 0,
      child: Column(
          children: [
        "Penegakan Perda Perkada",
        "Perda dan Perwali",
        "Laporan PTI",
        "Laporan Pam-In"
      ].map((e) => CardPengajuan(label: e)).toList()),
    );
  }
}
