import 'package:eport/app/controller/personil/edit_personil_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/card_personil.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/partials/personil/personil_filter.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPersonilPage extends GetView<EditPersonilController> {
  const EditPersonilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Kehadiran Personil",
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PersonilFilter(
              handleAddPersonil: controller.handleAddPersonil,
              handleSave: controller.handleSave,
              personils: controller.personils,
              disabled: !controller.isEdit.value,
              variant: PersonilVariant.edit,
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.w),
                boxShadow: [ColorConstants.shadow[6]!],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 7.h,
              ),
              child: Text(
                "Total Personil : ${controller.personils.length} orang",
                style: body5BTextStyle(),
              ),
            ),
            SizedBox(height: 12.h),
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
                    data: element.value.personil,
                    variant: PersonilVariant.edit,
                    onToggle: (e) {
                      e.hadir = !e.hadir;
                      controller.personils.refresh();
                      controller.komandos.refresh();
                      controller.isEdit.value = true;
                    },
                  ),
                )
                .toList(),
            SizedBox(height: 16.h),
            Text(
              "Pasukan",
              style: body3BTextStyle(
                weight: FontWeight.w500,
                color: ColorConstants.slate[600],
              ),
            ),
            SizedBox(height: 12.h),
            ...controller.anggotas
                .map(
                  (element) => CardPersonil(
                    data: element.value.personil,
                    variant: PersonilVariant.edit,
                    onToggle: (e) {
                      e.hadir = !e.hadir;
                      controller.personils.refresh();
                      controller.anggotas.refresh();
                      controller.isEdit.value = true;
                    },
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
