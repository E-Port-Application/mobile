import 'package:eport/app/controller/personil_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/card_personil.dart';
import 'package:eport/app/presentation/partials/personil/personil_filter.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonilPage extends GetView<PersonilController> {
  const PersonilPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Personil",
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PersonilFilter(),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [ColorConstants.shadow[6]!],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
              child: Text(
                "Total Personil: ${controller.selectedPersonil.length} orang",
                style: body5BTextStyle(),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Personil / Anggota yang bertugas",
                  style: body3TextStyle(),
                ),
                GestureDetector(
                  child: Text(
                    "Lihat Semua Personil",
                    style: body6BTextStyle(
                      color: ColorConstants.info[60],
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ...controller.selectedPersonil
                .map((data) => CardPersonil(data: data))
                .toList()
          ],
        ),
      ),
    );
  }
}
