import 'package:eport/app/controller/edit_pkl_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_dropdown.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/app_location.dart';
import 'package:eport/app/presentation/widgets/app_search_select.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPklPage extends GetView<EditPklController> {
  EditPklPage({super.key});
  GlobalKey pklRef = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "PKL / Laporan Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(() {
          return Column(
            children: [
              formOne(),
              SizedBox(height: 12.h),
              formTwo(),
              controller.image.value == null &&
                      controller.imageUrl.value == null
                  ? UploadPhoto(
                      uploadCamera: () {
                        controller.uploadPhoto(isCamera: true);
                      },
                      uploadGallery: controller.uploadPhoto,
                    )
                  : Container(),
              SizedBox(height: 32.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: "Buat Laporan Kegiatan",
              ),
              SizedBox(height: 14.h),
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
          }),
          AppInput(
            controller: controller.form['tanggal']!,
            label: "Tanggal *",
            prefixIcon: Icon(
              Icons.calendar_month_outlined,
            ),
            readOnly: true,
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
                  label: "Waktu Mulai *",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
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
                  label: "Waktu Selesai *",
                  placeholder: "Waktu ",
                  prefixIcon: Icon(Icons.access_time_outlined),
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
            label: "Jenis PKL *",
            placeholder: "Jenis PKL",
            controller: controller.form['jenis']!,
            value: controller.selectedPkl.value,
            validator: (e) {
              return inputValidator(e, "Jenis PKL");
            },
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
            label: "Jenis Pelanggaran *",
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
            validator: (e) {
              return inputValidator(e, "Jenis Pelanggaran");
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
            validator: (e) {
              return inputValidator(e, "Jenis Tindakan");
            },
          ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['jumlah-pelanggar']!,
            keyboardType: TextInputType.number,
            label: "Jumlah Pelanggar",
            placeholder: "Masukkan Jumlah Pelanggar",
            validator: (e) {
              return inputValidator(e, "Jumlah Pelanggar");
            },
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
            validator: (e) {
              return inputValidator(e, "Keterangan");
            },
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
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['nik-pelanggar']!,
          label: "NIK Pelanggar",
          placeholder: "Input NIK Pelanggar",
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 12.h),
        AppDropdown<String>(
          items: [
            AppDropdownItem(text: "Laki-Laki", value: "laki-laki"),
            AppDropdownItem(text: "Perempuan", value: "perempuan"),
          ],
          label: "Jenis Kelamin",
          placeholder: "Input Jenis Kelamin",
          onChanged: (e) {
            if (e != null) {
              controller.form['jenis-kelamin']!.text = e;
            }
          },
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['alamat-pelanggar']!,
          label: "Alamat Lengkap Pelanggar",
          placeholder: "Input Alamat Lengkap",
          maxLines: 4,
        )
      ],
    );
  }
}
