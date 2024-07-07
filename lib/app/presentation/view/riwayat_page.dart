import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/riwayat_controller.dart';
import 'package:eport/app/presentation/partials/laporan/card_laporan.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RiwayatPage extends GetView<RiwayatController> {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          LaporanFilter(
            activities: LaporanController.i.activities,
            value: LaporanController.i.selectedRiwayat.value,
            onReset: controller.onReset,
            onActivity: controller.onActivity,
            data: controller.datas,
            filterDate: [
              LaporanController.i.startDateRiwayat.value,
              LaporanController.i.endDateRiwayat.value,
            ],
            onDate: controller.onDate,
          ),
          !controller.isLoading.value && controller.datas.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: .15.sh),
                    SvgPicture.asset(
                      "assets/icons/search-not-found.svg",
                      width: 220.w,
                    ),
                    Text(
                      "Data tidak ditemukan",
                      style: body3BTextStyle(),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Silakan menambahkan data laporan kegiatan melalui\ntab rencana kegiatan terlebih dahulu",
                      style: body4TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Container(),
          Column(
            children: controller.isLoading.value
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
