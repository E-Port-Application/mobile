import 'package:eport/app/controller/pkl_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/utils/datepicker.dart';
import 'package:eport/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PklPage extends GetView<PklController> {
  GlobalKey pklRef = GlobalKey();
  PklPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "PKL / Rencana Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            children: [
              AppLocation(),
              SizedBox(height: 12.h),
              controller.image.value != null
                  ? Container(
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
                    )
                  : Container(),
              AppInput(
                controller: controller.form['tanggal']!,
                label: "Tanggal",
                prefixIcon: Icon(
                  Icons.calendar_month_outlined,
                ),
                readOnly: true,
                onTap: () {
                  datePicker(controller.form['tanggal']!);
                },
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
                      onTap: () {
                        timePicker(controller.form['waktu-mulai']!);
                      },
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
                      onTap: () {
                        timePicker(controller.form['waktu-selesai']!);
                      },
                      readOnly: true,
                      validator: (e) {
                        return inputValidator(e, "Waktu selesai");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppSearchSelect(
                options: controller.jenisPkl,
                show: controller.showPkl.value,
                onTogle: (e) {
                  controller.showPkl.value = e;
                },
                label: "Jenis PKL",
                placeholder: "Jenis PKL",
                controller: controller.form['jenis']!,
                value: controller.selectedPkl.value,
                onSave: (data) {
                  controller.handleSaveMenu(
                    data,
                    controller.selectedPkl,
                    controller.showPkl,
                    controller.jenisPkl,
                    "jenis",
                  );
                },
              ),
              SizedBox(height: 12.h),
              AppSearchSelect(
                options: controller.jenisPelanggaran,
                show: controller.showPelanggaran.value,
                onTogle: (e) {
                  controller.showPelanggaran.value = e;
                },
                label: "Jenis Pelanggaran",
                placeholder: "Jenis Pelanggaran",
                controller: controller.form['pelanggaran']!,
                value: controller.selectedPelanggaran.value,
                onSave: (data) {
                  controller.handleSaveMenu(
                    data,
                    controller.selectedPelanggaran,
                    controller.showPelanggaran,
                    controller.jenisPelanggaran,
                    "pelanggaran",
                  );
                },
              ),
              SizedBox(height: 12.h),
              AppSearchSelect(
                options: controller.jenisTindakan,
                show: controller.showTindakan.value,
                onTogle: (e) {
                  controller.showTindakan.value = e;
                },
                label: "Jenis Tindakan",
                placeholder: "Jenis Tindakan",
                controller: controller.form['tindakan']!,
                value: controller.selectedTindakan.value,
                onSave: (data) {
                  controller.handleSaveMenu(
                    data,
                    controller.selectedTindakan,
                    controller.showTindakan,
                    controller.jenisTindakan,
                    "tindakan",
                  );
                },
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['jumlah-pelanggar']!,
                keyboardType: TextInputType.number,
                label: "Jumlah Pelanggar",
                placeholder: "Masukkan Jumlah Pelanggar",
              ),
              SizedBox(height: 12.h),
              InputPersonil(personils: controller.personils, id: "pkl"),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['keterangan']!,
                maxLines: 8,
                label: "Keterangan",
                placeholder: "Masukkan Keterangan",
                hint: "Tulis Keterangan dengan baik dan benar!",
              ),
              controller.image.value == null
                  ? UploadPhoto(
                      uploadCamera: () {
                        controller.uploadPhoto(isCamera: true);
                      },
                      uploadGallery: controller.uploadPhoto,
                    )
                  : Container(),
              SizedBox(height: 40.h),
              AppButton(
                width: 1.sw,
                onPressed: () {},
                text: "Buat Rencana Kegiatan",
              ),
              SizedBox(height: 8.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
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
