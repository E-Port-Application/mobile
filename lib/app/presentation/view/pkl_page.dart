import 'package:eport/app/controller/pkl_controller.dart';
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

class PklPage extends GetView<PklController> {
  GlobalKey pklRef = GlobalKey();
  PklPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "PKL / Rencana Kegiatan",
      child: Column(
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
          Obx(
            () => AppSearchSelect(
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
                  "jenisPkl",
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => AppSearchSelect(
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
                  "jenisPelanggaran",
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          Obx(
            () => AppSearchSelect(
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
                  "jenisTindakan",
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['jumlah']!,
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
    );
  }
}
