import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/reklame_controller.dart';

class ReklamePage extends GetView<ReklameController> {
  const ReklamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Reklame / Rencana Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            children: [
              AppLocation(),
              SizedBox(height: 12.h),
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
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppInput(
                      controller: controller.form['waktu-selesai']!,
                      label: "Waktu Selesai",
                      placeholder: "Waktu ",
                      prefixIcon: Icon(Icons.access_time_outlined),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['nama']!,
                label: "Nama Reklame",
                placeholder: "contoh: nama toko/yang diiklankan",
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
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['jumlah']!,
                label: "Jumlah",
                placeholder: "Masukkan Jumlah",
              ),
              SizedBox(height: 12.h),
              InputPersonil(personils: controller.personils, id: "reklame"),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['tindakan']!,
                label: "Tindakan",
                maxLines: 8,
                placeholder: "Masukkan Tindakan",
                hint: "Tulis tindakan dengan baik dan benar!",
              ),
              SizedBox(height: 40.h),
              Text(
                "Pilih salah satu opsi",
                style: body6TextStyle(color: ColorConstants.slate[500]),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 28.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Kamera",
                        style: body5BTextStyle(),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.photo_library_outlined,
                              size: 28.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Galeri",
                        style: body5BTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              AppButton(
                width: 1.sw,
                onPressed: () {},
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
