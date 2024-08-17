import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_shimmer.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MasyarakatCard extends StatelessWidget {
  final bool isLoading;
  final LaporanExternalModel data;
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy");

  MasyarakatCard({
    super.key,
    required this.data,
    this.isLoading = false,
  });

  factory MasyarakatCard.loading() {
    LaporanExternalModel data = LaporanExternalModel(
      createdAt: DateTime.now(),
      id: "",
      image: "",
      keluhan: "",
      keterangan: "",
      location: "",
      nama: "",
      nik: "",
      status: 0,
      tanggal: DateTime.now(),
      uid: "",
      updatedAt: DateTime.now(),
    );

    return MasyarakatCard(
      data: data,
      isLoading: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _loadingWidget();
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [ColorConstants.shadow[2]!],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: Image.network(
                    data.image,
                    width: 85.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Laporan ${data.keluhan}",
                              style: body3BTextStyle(
                                color: ColorConstants.slate[900],
                              ),
                            ),
                          ),
                          _status(),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        data.nama,
                        style: body6TextStyle(
                          color: ColorConstants.primary[60],
                          weight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        dateFormat.format(data.tanggal),
                        style: body4TextStyle(
                          color: ColorConstants.slate[500],
                        ),
                      ),
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Lihat Detail",
                          style: body6BTextStyle(
                            color: Color(0xff004FC6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.topRight,
                child: AppButton(
                  onPressed: () {
                    // TODO
                    Get.toNamed(AppRoute.prosesMasyarakat(data.id));
                  },
                  text: "Lihat Laporan",
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                  ),
                  textStyle: body6BTextStyle(
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Map<String, dynamic> statusMap() {
    Color bgColor;
    Color textColor;
    String text;

    switch (data.status) {
      case 0:
        if (Global.isExt()) {
          bgColor = ColorConstants.info[10]!;
          textColor = ColorConstants.info[70]!;
          text = "Terkirim";
        } else {
          bgColor = ColorConstants.info[10]!;
          textColor = ColorConstants.info[70]!;
          text = "Belum Diperiksa";
        }
      case 1:
        bgColor = ColorConstants.warning[10]!;
        textColor = ColorConstants.warning[70]!;
        text = "Sedang Diperiksa";
      default:
        bgColor = ColorConstants.success[10]!;
        textColor = ColorConstants.success[80]!;
        text = "Telah Diperiksa";
    }

    return {
      "bgColor": bgColor,
      "textColor": textColor,
      "text": text,
    };
  }

  Widget _status() {
    final data = statusMap();
    return Container(
      width: 72.w,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: data['bgColor'],
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Text(
        data['text'],
        style: body6BTextStyle(
          size: 8.sp,
          color: data['textColor'],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _loadingWidget() {
    return AppShimmer.loading(
      overlay: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 105.w,
                    height: 105.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120.w,
                          height: 22.h,
                          margin: EdgeInsets.only(bottom: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        Container(
                          width: 1.sw,
                          height: 14.h,
                          margin: EdgeInsets.only(bottom: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        Container(
                          width: 1.sw,
                          height: 12.h,
                          margin: EdgeInsets.only(bottom: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        Expanded(child: Container()),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100.w,
                            height: 16.h,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
