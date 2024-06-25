import 'package:eport/app/controller/pkl/riwayat_pkl_controller.dart';
import 'package:eport/app/presentation/partials/edit_laporan/laporan_action.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RiwayatPklPage extends GetView<RiwayatPklController> {
  const RiwayatPklPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "PKL / Riwayat Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(() {
          return Column(
            children: [
              formOne(),
              SizedBox(height: 12.h),
              formTwo(),
              SizedBox(height: 32.h),
              LaporanAction(
                onPdf: () {},
                collection: "pkl",
              ),
              SizedBox(height: 20.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: "Unduh Laporan Kegiatan",
              ),
              SizedBox(height: 10.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.cancel,
                text: "Kembali",
                color: ColorConstants.slate[300],
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget formOne() {
    return Obx(
      () => Column(
        children: [
          AppLocation(),
          SizedBox(height: 12.h),
          Obx(() {
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
                  ],
                ),
              );
            }
            return Container();
          }),
          AppInput(
            controller: controller.form['tanggal']!,
            label: "Tanggal *",
            prefixIcon: Icon(
              Icons.calendar_month_outlined,
            ),
            readOnly: true,
            placeholder: "DD/MM/YYYY",
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: AppInput(
                  controller: controller.form['waktu-mulai']!,
                  label: "Waktu Mulai *",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
                  readOnly: true,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: AppInput(
                  controller: controller.form['waktu-selesai']!,
                  label: "Waktu Selesai *",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
                  readOnly: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['jenis']!,
            label: "Jenis PKL *",
            placeholder: "Jenis PKL",
            readOnly: true,
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['pelanggaran']!,
            label: "Jenis Pelanggaran",
            placeholder: "Jenis Pelanggaran",
            readOnly: true,
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['tindakan']!,
            label: "Jenis Tindakan",
            placeholder: "Jenis Tindakan",
            readOnly: true,
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['jumlah-pelanggar']!,
            keyboardType: TextInputType.number,
            label: "Jumlah Pelanggar",
            placeholder: "Masukkan Jumlah Pelanggar",
            readOnly: true,
          ),
          SizedBox(height: 12.h),
          InputPersonil(
            personils: controller.personils,
            id: "pkl",
            variant: PersonilVariant.show,
            docId: "pkl/${controller.data.value?.id}",
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['keterangan']!,
            maxLines: 8,
            label: "Keterangan",
            placeholder: "Masukkan Keterangan",
            hint: "Tulis Keterangan dengan baik dan benar!",
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget formTwo() {
    return Column(
      children: [
        AppInput(
          controller: controller.form['nama-pelanggar']!,
          label: "Nama Pelanggar",
          placeholder: "Input Nama Pelanggar",
          readOnly: true,
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['nik-pelanggar']!,
          label: "NIK Pelanggar *",
          placeholder: "Input NIK Pelanggar",
          keyboardType: TextInputType.number,
          readOnly: true,
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['jenis-kelamin']!,
          label: "Jenis Kelamin",
          placeholder: "Input Jenis Kelamin",
          readOnly: true,
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['alamat-pelanggar']!,
          label: "Alamat Lengkap Pelanggar *",
          placeholder: "Input Alamat Lengkap",
          maxLines: 4,
          readOnly: true,
        )
      ],
    );
  }
}
