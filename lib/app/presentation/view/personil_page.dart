import 'package:eport/app/controller/personil_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/card_personil.dart';
import 'package:eport/app/presentation/partials/personil/personil_filter.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  style: body3TextStyle(
                    weight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.show.value = !controller.show.value;
                  },
                  child: Text(
                    controller.show.value
                        ? "Sembunyikan"
                        : "Lihat Semua Personil",
                    style: body6BTextStyle(
                      color: ColorConstants.info[60],
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            controller.selectedPersonil.isEmpty && controller.show.value
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      SvgPicture.asset(
                        "assets/icons/search-not-found.svg",
                        width: 220.w,
                      ),
                      Text(
                        "Tidak ada personil yang ditambahkan",
                        style: body3BTextStyle(),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Silakan tambah personil dengan memilih opsi dibawah atau menggunakan pencarian.",
                        style: body4TextStyle(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                : Container(),
            SizedBox(height: 12.h),
            controller.show.value
                ? Column(
                    children: controller.selectedPersonil
                        .map(
                          (data) => CardPersonil(
                            data: data,
                            onRemove: (e) {
                              controller.handleRemovePersonil(e,
                                  isAnggota: true);
                            },
                          ),
                        )
                        .toList(),
                  )
                : Container(),
            SizedBox(height: 20.h),
            Text(
              "Jajaran Komando",
              style: body3TextStyle(
                weight: FontWeight.w500,
                color: ColorConstants.slate[600],
              ),
            ),
            SizedBox(height: 12.h),
            ...controller.komandos
                .map(
                  (element) => CardPersonil(
                    data: element.value.personil,
                    onRemove: (e) {
                      controller.handleRemovePersonil(e, ref: element);
                    },
                    onAdd: (e) {
                      controller.handleAddPersonil(e, ref: element);
                    },
                    state: element.value.isSelected,
                  ),
                )
                .toList(),
            SizedBox(height: 32.h),
            Text(
              "Pasukan",
              style: body3TextStyle(
                weight: FontWeight.w500,
                color: ColorConstants.slate[600],
              ),
            ),
            SizedBox(height: 12.h),
            ...controller.anggotas
                .map(
                  (element) => CardPersonil(
                    data: element.value.personil,
                    onRemove: (e) {
                      controller.handleRemovePersonil(e, ref: element);
                    },
                    onAdd: (e) {
                      controller.handleAddPersonil(e, ref: element);
                    },
                    state: element.value.isSelected,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
