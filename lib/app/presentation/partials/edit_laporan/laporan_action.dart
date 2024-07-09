import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/widgets/app_modal.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/open_link.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaporanAction extends StatelessWidget {
  final VoidCallback? onPdf;
  final VoidCallback? onExcel;
  final String collection;

  const LaporanAction({
    super.key,
    this.onExcel,
    required this.collection,
    this.onPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aksi",
                style: body4BTextStyle(),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AppModal(
                            primaryText: "Hapus",
                            secondaryText: "Batal",
                            onPrimary: () async {
                              try {
                                await LaporanRepository.remove(
                                  collection,
                                  getId(),
                                );
                                LaporanController.i.getData();
                                showAlert(
                                  "Berhasil hapus data laporan",
                                  isSuccess: true,
                                );
                                Get.back();
                                Get.back();
                              } catch (_) {}
                            },
                            onSecondary: () {
                              Get.back();
                            },
                            title: "Konfirmasi Penghapusan Laporan",
                            description:
                                "Apakah Anda yakin ingin menghapus laporan ini? Tindakan ini tidak dapat dibatalkan. Pastikan Anda telah memeriksa kembali data yang akan dihapus.",
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      size: 32.w,
                      color: ColorConstants.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
          (onExcel != null || onPdf != null) &&
                  (Get.currentRoute.contains("laporan/riwayat/"))
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Unduh Laporan",
                      style: body4BTextStyle(),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        onPdf != null
                            ? GestureDetector(
                                onTap: () async {
                                  try {
                                    String id = getId();
                                    openLink(Uri.parse(
                                        "${dotenv.env['BASE_URL']!}api/pdf/$collection/$id"));
                                  } catch (err) {
                                    showAlert(err.toString());
                                  }
                                },
                                child: Image.asset(
                                  "assets/icons/pdf.png",
                                  width: 32.w,
                                  height: 32.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                        onExcel != null
                            ? GestureDetector(
                                child: Image.asset(
                                  "assets/icons/excel.png",
                                  width: 32.w,
                                  height: 32.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
