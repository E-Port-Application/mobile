import 'package:eport/app/controller/pengajuan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/card_pengajuan.dart';
import 'package:eport/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengajuanPage extends GetView<PengajuanController> {
  const PengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PengajuanData(label: "Laporan Pamwal", path: AppRoute.pamwal),
        PengajuanData(label: "Perda dan Perwali", path: AppRoute.perdaPerwali),
        PengajuanData(label: "Laporan PTI", path: AppRoute.laporanPti),
        PengajuanData(label: "Laporan Pam-In", path: AppRoute.laporanPamin),
      ].map((e) => CardPengajuan(data: e)).toList(),
    );
  }
}
