import 'package:eport/app/controller/kransos_controller.dart';
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

class KransosPage extends GetView<KransosController> {
  final LaporanType type;
  const KransosPage({
    super.key,
    required this.type,
  });

  String _title() {
    switch (type) {
      case LaporanType.create:
        return "Rencana";
      case LaporanType.update:
        return "Laporan";
      default:
        return "Riwayat";
    }
  }

  String _buttonText() {
    switch (type) {
      case LaporanType.create:
        return "Buat Rencana Kegiatan";
      case LaporanType.update:
        return "Buat Laporan Kegiatan";
      default:
        return "Unduh Laporan Kegiatan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold.detail(
      title: "Keransos / ${LaporanController.i.title(type)} Kegiatan",
      child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            children: [
              AppLocation(),
              SizedBox(height: 8.h),
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              type == LaporanType.history
                  ? AppInput(
                      label: "Jenis Keransos",
                      placeholder: "Jenis Keransos",
                      controller: controller.form['jenis']!,
                      readOnly: true,
                    )
                  : AppSearchSelect(
                      options: controller.jenis,
                      show: controller.showJenis.value,
                      onTogle: (e) {
                        controller.showJenis.value = e;
                      },
                      label: "Jenis Keransos",
                      placeholder: "Jenis Keransos",
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
              AppInput(
                controller: controller.form['deskripsi-pelanggaran']!,
                maxLines: 8,
                label: "Deskripsi Pelanggaran",
                placeholder: "Masukkan deskripsi pelanggaran",
                hint: "Tulis deskripsi dengan baik dan benar!",
                readOnly: type == LaporanType.history,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Deskripsi pelanggaran");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['tindakan-pelanggaran']!,
                placeholder: "Masukkan Tindakan",
                label: "Tindakan",
                readOnly: type == LaporanType.history,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Tindakan pelanggaran");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['jumlah-pelanggar']!,
                label: "Jumlah Pelanggar",
                placeholder: "Masukkan Jumlah Pelanggar",
                readOnly: type == LaporanType.history,
                validator: type == LaporanType.update
                    ? (e) {
                        return inputValidator(e, "Jumlah pelanggar");
                      }
                    : null,
              ),
              SizedBox(height: 12.h),
              InputPersonil(
                personils: controller.personils,
                id: "kransos",
                docId: "kransos/${controller.data.value?.id}",
                type: type,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: controller.form['keterangan']!,
                maxLines: 8,
                label: "Keterangan",
                placeholder: "Masukkan Keterangan",
                hint: "Tulis Keterangan dengan baik dan benar!",
                readOnly: type == LaporanType.history,
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
              type != LaporanType.create
                  ? LaporanAction(
                      onPdf: () {},
                      collection: "kransos",
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
