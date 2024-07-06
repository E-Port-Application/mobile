import 'package:eport/app/presentation/partials/laporan/card_laporan.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
