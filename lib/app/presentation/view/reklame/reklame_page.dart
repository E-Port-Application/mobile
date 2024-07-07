import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/partials/edit_laporan/laporan_action.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_image.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
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
import 'package:eport/app/controller/reklame/reklame_controller.dart';

class ReklamePage extends GetView<ReklameController> {
  final LaporanType type;
  const ReklamePage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Reklame / ${LaporanController.i.title(type)} Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
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
              Row(
                children: [
                  Expanded(
                    child: AppInput(
                      controller: controller.form['waktu-mulai']!,
                      label: "Waktu Mulai",
                      placeholder: "Waktu ",
                      prefixIcon: Icon(Icons.access_time_outlined),
                      onTap: type == LaporanType.create
                          ? () {
                              timePicker(controller.form['waktu-mulai']!);
                            }
                          : null,
                      readOnly: true,
                      validator: (e) {
                        return inputValidator(e, "Waktu mulai");
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppInput(
                      controller: controller.form['waktu-selesai']!,
                      label: "Waktu Selesai",
                      placeholder: "Waktu ",
                      prefixIcon: Icon(Icons.access_time_outlined),
                      onTap: type == LaporanType.create
                          ? () {
                              timePicker(controller.form['waktu-selesai']!);
                            }
                          : null,
                      readOnly: true,
                      validator: (e) {
                        return inputValidator(e, "Waktu selesai");
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['nama']!,
                label: "Nama Reklame",
                placeholder: "contoh: nama toko/yang diiklankan",
                readOnly: type == LaporanType.history,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Nama reklame");
                      }
                    : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              type == LaporanType.history
                  ? AppInput(
                      controller: controller.form['jenis']!,
                      label: "Jenis Reklame",
                      placeholder: "Jenis Reklame",
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                    )
                  : AppSearchSelect(
                      options: controller.jenis,
                      show: controller.showJenis.value,
                      onTogle: (e) {
                        controller.showJenis.value = e;
                      },
                      label: "Jenis Reklame",
                      placeholder: "Jenis Reklame",
                      controller: controller.form['jenis']!,
                      value: controller.selectedJenis.value,
                      onSave: (data) {
                        controller.handleSaveMenu(
                          data,
                          controller.selectedJenis,
                          controller.showJenis,
                          controller.jenis,
                          "jenis",
                        );
                      },
                      validator: type == LaporanType.update
                          ? (e) {
                              return inputValidator(e, "Jenis reklame");
                            }
                          : null,
                    ),
              SizedBox(height: 12.h),
              type == LaporanType.history
                  ? AppInput(
                      label: "Pelanggaran Reklame",
                      placeholder: "Pelanggaran Reklame",
                      controller: controller.form['pelanggaran']!,
                      readOnly: true,
                      textInputAction: TextInputAction.next,
                    )
                  : AppSearchSelect(
                      options: controller.pelanggaran,
                      show: controller.showPelanggaran.value,
                      onTogle: (e) {
                        controller.showPelanggaran.value = e;
                      },
                      label: "Pelanggaran Reklame",
                      placeholder: "Pelanggaran Reklame",
                      controller: controller.form['pelanggaran']!,
                      value: controller.selectedPelanggaran.value,
                      onSave: (data) {
                        controller.handleSaveMenu(
                          data,
                          controller.selectedPelanggaran,
                          controller.showPelanggaran,
                          controller.pelanggaran,
                          "pelanggaran",
                        );
                      },
                      validator: type == LaporanType.update
                          ? (e) {
                              return inputValidator(e, "Pelanggaran reklame");
                            }
                          : null,
                    ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['jumlah']!,
                label: "Jumlah Reklame",
                placeholder: "Masukkan Jumlah Reklame",
                readOnly: type == LaporanType.history,
                keyboardType: TextInputType.number,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Jumlah reklame");
                      }
                    : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              InputPersonil(
                personils: controller.personils,
                id: "reklame",
                docId: "reklame/${controller.data.value?.id}",
                type: type,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['tindakan']!,
                label: "Tindakan",
                maxLines: 4,
                readOnly: type == LaporanType.history,
                placeholder: "Masukkan Tindakan",
                hint: "Tulis tindakan dengan baik dan benar!",
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Tindakan");
                      }
                    : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['keterangan']!,
                label: "Keterangan",
                maxLines: 8,
                readOnly: type == LaporanType.history,
                placeholder: "Masukkan keterangan",
                hint: "Tulis keterangan dengan baik dan benar!",
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Keterangan");
                      }
                    : null,
                textInputAction: TextInputAction.done,
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
              type == LaporanType.update
                  ? FormField(
                      validator: (_) {
                        if (controller.imageUrl.value != null ||
                            controller.image.value != null) {
                          return null;
                        }
                        return "Media tidak boleh kosong";
                      },
                      builder: (state) {
                        return Text(
                          state.errorText ?? "",
                          style: body3TextStyle(
                            color: ColorConstants.error,
                            weight: FontWeight.w500,
                          ),
                        );
                      },
                    )
                  : Container(),
              SizedBox(height: 32.h),
              type == LaporanType.update || type == LaporanType.history
                  ? LaporanAction(
                      onPdf: () {},
                      collection: "reklame",
                    )
                  : Container(),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: LaporanController.i.buttonText(type),
              ),
              SizedBox(height: 8.h),
              AppButton(
                width: 1.sw,
                onPressed: () {},
                text: "Batal",
                type: AppButtonType.outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
