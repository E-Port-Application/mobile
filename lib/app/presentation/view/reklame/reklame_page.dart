import 'package:eport/app/presentation/partials/edit_laporan/laporan_action.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/datepicker.dart';
import 'package:eport/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/reklame/reklame_controller.dart';

class ReklamePage extends GetView<ReklameController> {
  final bool edit;
  const ReklamePage({
    super.key,
    this.edit = false,
  });

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Reklame / ${edit ? "Laporan" : "Rencana"} Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            children: [
              AppLocation(),
              SizedBox(height: 12.h),
              Obx(
                () {
                  if (controller.imageUrl.value != null) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      clipBehavior: Clip.antiAlias,
                      constraints: BoxConstraints(maxHeight: 240.h),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.imageUrl.value!,
                            width: 1.sw,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 10.h,
                            right: 12.w,
                            child: GestureDetector(
                              onTap: controller.removePhoto,
                              child: Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (controller.image.value != null) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      clipBehavior: Clip.antiAlias,
                      constraints: BoxConstraints(maxHeight: 240.h),
                      child: Stack(
                        children: [
                          Image.file(
                            controller.image.value!,
                            width: 1.sw,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 10.h,
                            right: 12.w,
                            child: GestureDetector(
                              onTap: controller.removePhoto,
                              child: Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              AppInput(
                controller: controller.form['tanggal']!,
                label: "Tanggal",
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                ),
                readOnly: true,
                onTap: !edit
                    ? () {
                        datePicker(controller.form['tanggal']!);
                      }
                    : null,
                placeholder: "DD/MM/YYYY",
                validator: (e) {
                  return inputValidator(e, "Tanggal");
                },
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
                      onTap: !edit
                          ? () {
                              timePicker(controller.form['waktu-mulai']!);
                            }
                          : null,
                      readOnly: true,
                      validator: (e) {
                        return inputValidator(e, "Waktu mulai");
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppInput(
                      controller: controller.form['waktu-selesai']!,
                      label: "Waktu Selesai",
                      placeholder: "Waktu ",
                      prefixIcon: Icon(Icons.access_time_outlined),
                      onTap: !edit
                          ? () {
                              timePicker(controller.form['waktu-selesai']!);
                            }
                          : null,
                      readOnly: true,
                      validator: (e) {
                        return inputValidator(e, "Waktu selesai");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['nama']!,
                label: "Nama Reklame",
                placeholder: "contoh: nama toko/yang diiklankan",
                validator: edit
                    ? (e) {
                        return inputValidator(e, "Nama reklame");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              AppSearchSelect(
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
                validator: edit
                    ? (e) {
                        return inputValidator(e, "Jenis reklame");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              AppSearchSelect(
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
                validator: edit
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
                keyboardType: TextInputType.number,
                validator: edit
                    ? (e) {
                        return inputValidator(e, "Jumlah reklame");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              InputPersonil(
                personils: controller.personils,
                id: "reklame",
                variant: edit ? PersonilVariant.edit : PersonilVariant.create,
                docId: "reklame/${controller.data.value?.id}",
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['tindakan']!,
                label: "Tindakan",
                maxLines: 4,
                placeholder: "Masukkan Tindakan",
                hint: "Tulis tindakan dengan baik dan benar!",
                validator: edit
                    ? (e) {
                        return inputValidator(e, "Tindakan");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['keterangan']!,
                label: "Keterangan",
                maxLines: 8,
                placeholder: "Masukkan keterangan",
                hint: "Tulis keterangan dengan baik dan benar!",
                validator: edit
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
              edit
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
              SizedBox(height: 20.h),
              edit
                  ? LaporanAction(
                      onPdf: () {},
                      collection: "reklame",
                    )
                  : Container(),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: "Buat Rencana Kegiatan",
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
