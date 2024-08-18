import 'package:eport/app/controller/home_controller.dart';
import 'package:eport/app/presentation/partials/laporan/card_laporan.dart';
import 'package:eport/app/presentation/partials/masyarakat/masyarakat_card.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyLaporan extends GetView<HomeController> {
  const MyLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int length = Global.isExt()
          ? controller.myLaporan.length
          : controller.reportData.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Informasi Terbaru",
            style: body2BTextStyle(),
          ),
          SizedBox(height: 20.h),
          !controller.loadingMyLaporan.value && controller.myLaporan.isEmpty
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
          Global.isExt()
              ? Column(
                  children: controller.loadingMyLaporan.value
                      ? List.filled(5, 0)
                          .map((e) => MasyarakatCard.loading())
                          .toList()
                      : controller.myLaporan
                          .take(3)
                          .map((data) => MasyarakatCard(data: data))
                          .toList(),
                )
              : Column(
                  children: controller.loadingReportData.value
                      ? List.filled(5, 0)
                          .map((e) => CardLaporan.loading())
                          .toList()
                      : controller.reportData
                          .take(3)
                          .map((data) => CardLaporan(data: data))
                          .toList(),
                ),
          length > 3
              ? GestureDetector(
                  onTap: () {
                    if (Global.isExt()) {
                      Get.toNamed(AppRoute.reportExternal);
                      return;
                    }
                    Get.toNamed(AppRoute.report);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lihat Selengkapnya",
                        style: body2BTextStyle(
                          weight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 20.w,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
