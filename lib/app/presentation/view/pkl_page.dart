import 'package:eport/app/controller/pkl_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PklPage extends GetView<PklController> {
  GlobalKey pklRef = GlobalKey();
  PklPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Patroli / Rencana Kegiatan/ PKL",
      child: Column(
        children: [
          AppLocation(),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['tanggal']!,
            label: "Tanggal",
            gap: 8.h,
            prefixIcon: Icon(
              Icons.calendar_month_outlined,
              color: ColorConstants.slate[400],
            ),
            readOnly: true,
            onTap: () async {
              try {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1000),
                  lastDate: DateTime(2999),
                );

                if (date != null) {
                  // controller.form[element.id]!.text =
                  //     DateFormat('dd MMMM yyyy').format(date);
                }
              } catch (err) {
                showAlert(err.toString());
              }
            },
            placeholder: "DD/MM/YYYY",
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: AppInput(
                  controller: controller.form['waktuMulai']!,
                  label: "Waktu Mulai",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: AppInput(
                  controller: controller.form['waktuSelesai']!,
                  label: "Waktu Selesai",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(
            () => AppSearchSelect<int>(
              options: controller.jenisPkl,
              show: controller.showPkl.value,
              onTogle: (e) {
                controller.showPkl.value = e;
              },
              label: "Jenis PKL",
              placeholder: "Jenis PKL",
              controller: controller.form['jenisPkl']!,
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
            () => AppSearchSelect<String>(
              options: controller.jenisPelanggaran,
              show: controller.showPelanggaran.value,
              onTogle: (e) {
                controller.showPelanggaran.value = e;
              },
              label: "Jenis Pelanggaran",
              placeholder: "Jenis Pelanggaran",
              controller: controller.form['jenisPelanggaran']!,
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
            () => AppSearchSelect<String>(
              options: controller.jenisTindakan,
              show: controller.showTindakan.value,
              onTogle: (e) {
                controller.showTindakan.value = e;
              },
              label: "Jenis Tindakan",
              placeholder: "Jenis Tindakan",
              controller: controller.form['jenisTindakan']!,
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
            controller: controller.form['jumlahPelanggar']!,
            keyboardType: TextInputType.number,
            label: "Jumlah Pelanggar",
            gap: 8.h,
            placeholder: "Masukkan Jumlah Pelanggar",
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: TextEditingController(),
            label: "Personil/Anggota Yang Berugas",
            gap: 8.h,
            placeholder: "Personil Yang Bertugas",
            readOnly: true,
            onTap: () {
              Get.toNamed(AppRoute.personil);
            },
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['keterangan']!,
            maxLines: 8,
            label: "Keterangan",
            gap: 8.h,
            placeholder: "Masukkan Keterangan",
            hint: "Tulis Keterangan dengan baik dan benar!",
          ),
        ],
      ),
    );
  }
}
