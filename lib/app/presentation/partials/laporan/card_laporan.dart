import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardLaporan extends StatefulWidget {
  final LaporanModel data;
  const CardLaporan({
    super.key,
    required this.data,
  });

  @override
  State<CardLaporan> createState() => _CardLaporanState();
}

class _CardLaporanState extends State<CardLaporan> {
  dynamic laporanModel;
  Map<String, Object> dataType = {"pkl": PklModel};
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  @override
  void initState() {
    super.initState();
    setState(() {
      try {
        switch (widget.data.type) {
          case "pkl":
            laporanModel = widget.data.data as PklModel;
            return;
        }
      } catch (err) {
        showAlert(err.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = laporanModel as PklModel;

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
                  child: data.image != null
                      ? Image.network(
                          data.image!,
                          height: 80.h,
                          width: 85.w,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 85.w,
                          height: 80.h,
                          color: Colors.grey,
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Laporan PKL",
                        style: body3BTextStyle(
                          color: ColorConstants.slate[900],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "Lokasi",
                        style: body6BTextStyle(
                          color: ColorConstants.primary[70],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${dateFormat.format(data.tanggal)} | ${timeFormat.format(data.waktuMulai)} WIB",
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
                            size: 9.sp,
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
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.topRight,
            child: AppButton(
              onPressed: () {
                Get.toNamed(AppRoute.laporanPkl(widget.data.id));
              },
              text: "Buat Laporan Kegiatan",
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              textStyle: body6BTextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
