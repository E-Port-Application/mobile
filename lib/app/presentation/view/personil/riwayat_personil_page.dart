import 'package:eport/app/controller/personil/riwayat_personil_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/card_personil.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RiwayatPersonilPage extends GetView<RiwayatPersonilController> {
  const RiwayatPersonilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Laporan PKL / Personil",
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.w),
                      boxShadow: [ColorConstants.shadow[6]!],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 7.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Total Personil Hadir: ",
                          style: body5TextStyle(weight: FontWeight.w500),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "${controller.hadir} orang",
                          style: body4BTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.w),
                      boxShadow: [ColorConstants.shadow[6]!],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 7.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Total Personil Tidak Hadir: ",
                          style: body5TextStyle(weight: FontWeight.w500),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "${controller.notHadir} orang",
                          style: body4BTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Jajaran Komando",
              style: body3BTextStyle(
                weight: FontWeight.w500,
                color: ColorConstants.slate[600],
              ),
            ),
            SizedBox(height: 12.h),
            ...controller.komandos
                .map(
                  (element) => CardPersonil(
                    data: element,
                    variant: PersonilVariant.show,
                  ),
                )
                .toList(),
            SizedBox(height: 20.h),
            Text(
              "Personil",
              style: body3BTextStyle(
                weight: FontWeight.w500,
                color: ColorConstants.slate[600],
              ),
            ),
            SizedBox(height: 12.h),
            ...controller.anggotas
                .map(
                  (element) => CardPersonil(
                    data: element,
                    variant: PersonilVariant.show,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
