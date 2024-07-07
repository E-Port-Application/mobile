import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/pkl/pkl_controller.dart';
import 'package:eport/app/presentation/partials/edit_laporan/laporan_action.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/partials/laporan/upload_photo.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_dropdown.dart';
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

class PklPage extends GetView<PklController> {
  final LaporanType type;
  GlobalKey pklRef = GlobalKey();
  PklPage({
    super.key,
    this.type = LaporanType.create,
  });

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "PKL / Rencana Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(() {
          int phase = controller.formPhase.value;
          return Column(
            children: [
              type == LaporanType.create
                  ? phase == 1
                      ? formOne()
                      : formTwo()
                  : formOne(),
              controller.image.value == null &&
                      controller.imageUrl.value == null &&
                      type == LaporanType.create
                  ? UploadPhoto(
                      uploadCamera: () {
                        controller.uploadPhoto(isCamera: true);
                      },
                      uploadGallery: controller.uploadPhoto,
                    )
                  : Container(),
              SizedBox(height: type == LaporanType.create ? 28.h : 12.h),
              type != LaporanType.create ? formTwo() : Container(),
              Builder(builder: (context) {
                if (type != LaporanType.update) {
                  return Container();
                }
                return Column(
                  children: [
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
                        return Text(
                          state.errorText ?? "",
                          style: body3TextStyle(
                            color: ColorConstants.error,
                            weight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
              Builder(builder: (context) {
                return type != LaporanType.create
                    ? Column(
                        children: [
                          SizedBox(height: 32.h),
                          LaporanAction(
                            onPdf: () {},
                            collection: "pkl",
                          )
                        ],
                      )
                    : Container();
              }),
              Expanded(child: Container()),
              AppButton(
                width: 1.sw,
                onPressed: controller.submit,
                text: type == LaporanType.create
                    ? phase == 1
                        ? "Selanjutnya"
                        : "Buat Rencana Kegiatan"
                    : LaporanController.i.buttonText(type),
              ),
              SizedBox(height: 8.h),
              AppButton(
                width: 1.sw,
                onPressed: controller.cancel,
                text: type == LaporanType.create
                    ? phase == 1
                        ? "Batal"
                        : "Kembali"
                    : "Batal",
                type: AppButtonType.outlined,
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
          AppLocation(
            address: controller.form['location']!.text,
          ),
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
            label: "Tanggal *",
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
                  label: "Waktu Mulai *",
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
                  label: "Waktu Selesai *",
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
          type == LaporanType.history
              ? AppInput(
                  controller: controller.form['jenis']!,
                  label: "Jenis PKL",
                  placeholder: "Jenis PKL",
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                )
              : AppSearchSelect(
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
                  validator: type == LaporanType.update
                      ? (e) {
                          return inputValidator(e, "Jenis PKL");
                        }
                      : null,
                ),
          SizedBox(height: 12.h),
          type == LaporanType.history
              ? AppInput(
                  controller: controller.form['pelanggaran']!,
                  label: "Jenis Pelanggaran",
                  placeholder: "Jenis Pelanggaran",
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                )
              : AppSearchSelect(
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
                  validator: type == LaporanType.update
                      ? (e) {
                          return inputValidator(e, "Jenis pelanggaran");
                        }
                      : null,
                ),
          SizedBox(height: 12.h),
          type == LaporanType.history
              ? AppInput(
                  label: "Jenis Tindakan",
                  placeholder: "Jenis Tindakan",
                  controller: controller.form['tindakan']!,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                )
              : AppSearchSelect(
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
                  validator: type == LaporanType.update
                      ? (e) {
                          return inputValidator(e, "Jenis tindakan");
                        }
                      : null,
                ),
          SizedBox(height: 12.h),
          AppInput(
            controller: controller.form['jumlah-pelanggar']!,
            keyboardType: TextInputType.number,
            label: "Jumlah Pelanggar",
            placeholder: "Masukkan Jumlah Pelanggar",
            readOnly: type == LaporanType.history,
            validator: type == LaporanType.update
                ? (e) {
                    return inputValidator(e, "Jumlah pelanggar");
                  }
                : null,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 12.h),
          InputPersonil(
            personils: controller.personils,
            id: "pkl",
            docId: "pkl/${controller.data.value?.id}",
            type: type,
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
            textInputAction: TextInputAction.next,
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
          readOnly: type == LaporanType.history,
          validator: type == LaporanType.update
              ? (e) {
                  return inputValidator(e, "Nama pelanggar");
                }
              : null,
          textInputAction: TextInputAction.next,
        ),
        Obx(
          () {
            if (controller.jumlahNama.value != 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 6.h),
                  Text(
                    "Nama ini telah tercatat melanggar ${controller.jumlahNama.value} kali",
                    textAlign: TextAlign.end,
                    style: body3TextStyle(
                      color: ColorConstants.info[50],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['nik-pelanggar']!,
          label: "NIK Pelanggar",
          placeholder: "Input NIK Pelanggar",
          readOnly: type == LaporanType.history,
          keyboardType: TextInputType.number,
          validator: controller.nikValidator,
          textInputAction: TextInputAction.next,
        ),
        Obx(
          () {
            if (controller.jumlahNik.value != 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 6.h),
                  Text(
                    "NIK ini telah tercatat melanggar ${controller.jumlahNik.value} kali",
                    textAlign: TextAlign.end,
                    style: body3TextStyle(
                      color: ColorConstants.info[50],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        SizedBox(height: 12.h),
        Obx(
          () => type == LaporanType.history
              ? AppInput(
                  controller: controller.form['jenis-kelamin']!,
                  label: "Jenis Kelamin",
                  placeholder: "Input Jenis Kelamin",
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                )
              : AppDropdown<String>(
                  items: [
                    AppDropdownItem(text: "Laki-Laki", value: "laki-laki"),
                    AppDropdownItem(text: "Perempuan", value: "perempuan"),
                  ],
                  label: "Jenis Kelamin",
                  placeholder: "Input Jenis Kelamin",
                  value: controller.jenisKelamin.value,
                  onChanged: (e) {
                    if (e != null) {
                      controller.form['jenis-kelamin']!.text = e;
                      controller.jenisKelamin.value = e;
                    }
                  },
                  validator: type == LaporanType.update
                      ? (e) {
                          return inputValidator(e, "Jenis kelamin");
                        }
                      : null,
                ),
        ),
        SizedBox(height: 12.h),
        AppInput(
          controller: controller.form['alamat-pelanggar']!,
          label: "Alamat Lengkap Pelanggar",
          placeholder: "Input Alamat Lengkap",
          maxLines: 4,
          readOnly: type == LaporanType.history,
          validator: type == LaporanType.update
              ? (e) {
                  return inputValidator(e, "Alamat pelanggar");
                }
              : null,
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }
}
