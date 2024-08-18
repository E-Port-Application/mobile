import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/controller/external/laporan_masuk_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:eport/app/presentation/partials/masyarakat/masyarakat_card.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LaporanMasukPage extends GetView<LaporanMasukController> {
  const LaporanMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          LaporanFilter(
            titleDate: "Tanggal Laporan",
            activities: LaporanExternalController.i.activities,
            value: LaporanExternalController.i.selectedRiwayat.value,
            onReset: controller.onReset,
            onActivity: controller.onActivity,
            data: controller.datas,
            filterDate: [
              LaporanExternalController.i.startDateRiwayat.value,
              LaporanExternalController.i.endDateRiwayat.value,
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
                      "Silakan menambahkan data laporan kegiatan\nmelalui tab Buat Laporan",
                      style: body4TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Container(),
          Column(
            children: controller.isLoading.value
                ? List.filled(5, 0)
                    .map((e) => MasyarakatCard.loading())
                    .toList()
                : controller.datas
                    .map((data) => MasyarakatCard(data: data))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
