import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum PersonilVariant { create, edit, show }

class InputPersonil extends StatelessWidget {
  final RxList<PersonilModel> personils;
  final String id;
  String docId;
  LaporanType type;

  InputPersonil({
    super.key,
    required this.personils,
    required this.id,
    this.type = LaporanType.create,
    this.docId = "",
  });

  PersonilVariant _variant() {
    switch (type) {
      case LaporanType.create:
        return PersonilVariant.create;
      case LaporanType.update:
        return PersonilVariant.edit;
      default:
        return PersonilVariant.show;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => personils.isEmpty
          ? AppInput(
              controller: TextEditingController(),
              label: "Personil/Anggota Yang Bertugas *",
              placeholder: "Personil Yang Bertugas",
              readOnly: true,
              onTap: () {
                if (_variant() == PersonilVariant.create) {
                  Get.toNamed(
                    AppRoute.personil,
                    parameters: {'id': id},
                  );
                  return;
                }
                if (_variant() == PersonilVariant.edit) {
                  // Get.toNamed(page)
                }
              },
              validator: (e) {
                if (e == null) {
                  return "Personil tidak boleh kosong";
                }
                if (e.isEmpty) {
                  return "Personil tidak boleh kosong";
                }
                return null;
              },
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Personil/Anggota Yang Bertugas",
                  style: body3BTextStyle(color: ColorConstants.slate[700]),
                ),
                SizedBox(height: 12.h),
                ...(personils.length > 3 ? personils.sublist(0, 3) : personils)
                    .map(
                      (data) => Container(
                        margin: EdgeInsets.only(bottom: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.w),
                          border: Border.all(
                            color: ColorConstants.slate[300]!,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 13.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data.name,
                            style: body3TextStyle(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: () {
                    if (_variant() == PersonilVariant.show) {
                      Get.toNamed(
                        AppRoute.riwayatPersonil("pkl"),
                        parameters: {"doc": docId},
                      );
                      return;
                    }
                    if (_variant() == PersonilVariant.create) {
                      Get.toNamed(
                        AppRoute.personil,
                        parameters: {'id': id},
                      );
                      return;
                    }
                    if (_variant() == PersonilVariant.edit) {
                      Get.toNamed(
                        AppRoute.laporanPersonil(id),
                        parameters: {"doc": docId},
                      );
                      return;
                    }
                  },
                  child: Text(
                    "Lihat ${personils.length} personil lainnya",
                    style: body3TextStyle(
                      color: ColorConstants.info[50],
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
    );
  }
}
