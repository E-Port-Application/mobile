import 'package:eport/app/controller/riwayat_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatPage extends GetView<RiwayatController> {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LaporanFilter(
          onReset: controller.onReset,
          onActivity: controller.onActivity,
          activities: controller.activities,
        )
      ],
    );
  }
}
