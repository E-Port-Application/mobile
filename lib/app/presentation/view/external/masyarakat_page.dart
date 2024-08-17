import 'package:eport/app/controller/external/masyarakat_controller.dart';
import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_image.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/datepicker.dart';
import 'package:eport/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MasyarakatPage extends GetView<MasyarakatController> {
  final LaporanType type;
  const MasyarakatPage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (type == LaporanType.create) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: content(),
      );
    }

    return LaporanScaffold.detail(
      title: "Detail Laporan Masyarakat",
      child: content(),
    );
  }

  Widget content() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Obx(
        () => Form(
          key: controller.formKey,
          child: Column(
            children: [
              AppLocation(
                address: controller.form['location']!.text,
              ),
              SizedBox(height: 12.h),
              LaporanImage(
                image: controller.image.value,
                imageUrl: controller.imageUrl.value,
                type: type,
                removePhoto: controller.removePhoto,
              ),
              AppInput(
                controller: controller.form['tanggal']!,
                label: "Tanggal",
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                ),
                readOnly: true,
                onTap: type == LaporanType.create
                    ? () {
                        datePicker(controller.form['tanggal']!);
                      }
                    : null,
                placeholder: "DD/MM/YYYY",
                validator: (e) {
                  return inputValidator(e, "Tanggal");
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['nama']!,
                label: "Nama Lengkap",
                placeholder: "Nama Lengkap",
                readOnly: type == LaporanType.history,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Nama lengkap");
                      }
                    : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['nik']!,
                label: "NIK",
                placeholder: "Input NIK",
                readOnly: type == LaporanType.history,
                keyboardType: TextInputType.number,
                validator: controller.nikValidator,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              type == LaporanType.create
                  ? AppSearchSelect(
                      options: controller.jenisKeluhan,
                      show: controller.showKeluhan.value,
                      onTogle: (e) {
                        controller.showKeluhan.value = e;
                      },
                      label: "Jenis Keluhan",
                      placeholder: "Jenis Keluhan",
                      controller: controller.form['keluhan']!,
                      value: controller.selectedKeluhan.value,
                      onSave: (data) {
                        controller.handleSaveMenu(
                          data,
                          controller.selectedKeluhan,
                          controller.showKeluhan,
                          controller.jenisKeluhan,
                          "keluhan",
                        );
                      },
                      validator: type == LaporanType.update
                          ? (e) {
                              return inputValidator(e, "Jenis Keluhan");
                            }
                          : null,
                    )
                  : AppInput(
                      controller: controller.form['keluhan']!,
                      label: "Jenis Keluhan",
                      placeholder: "Jenis Keluhan",
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                    ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['keterangan']!,
                maxLines: 8,
                label: "Keterangan",
                placeholder: "Masukkan Keterangan",
                readOnly: type == LaporanType.history,
                hint: "Tulis Keterangan dengan baik dan benar!",
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Keterangan");
                      }
                    : null,
              ),
              controller.image.value == null &&
                      controller.imageUrl.value == null
                  ? UploadPhoto(
                      uploadCamera: () {
                        controller.uploadPhoto(isCamera: true);
                      },
                      uploadGallery: controller.uploadPhoto,
                    )
                  : Container(),
              FormField(
                validator: (_) {
                  if (controller.imageUrl.value != null ||
                      controller.image.value != null) {
                    return null;
                  }
                  return "Media tidak boleh kosong";
                },
                builder: (state) {
                  if (state.errorText == null) {
                    return Container();
                  }
                  return Text(
                    state.errorText ?? "",
                    style: body3TextStyle(
                      color: ColorConstants.error,
                      weight: FontWeight.w500,
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: LaporanExternalController.i.buttonText(type),
              ),
              SizedBox(height: 8.h),
              AppButton(
                width: 1.sw,
                onPressed: () {
                  Get.back();
                },
                text: LaporanExternalController.i.cancelText(type),
                type: AppButtonType.outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
