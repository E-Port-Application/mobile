import 'package:eport/app/presentation/partials/laporan/card_laporan.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/proses_controller.dart';

class ProsesPage extends GetView<ProsesController> {
  const ProsesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          LaporanFilter(
            activities: controller.activities,
            onReset: controller.onReset,
            onActivity: controller.onActivity,
            value: controller.selectedActivity.value,
            data: controller.datas,
          ),
          Column(
            children: controller.datas.isEmpty
                ? List.filled(5, 0).map((e) => CardLaporan.loading()).toList()
                : controller.datas
                    .map((data) => CardLaporan(data: data))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
