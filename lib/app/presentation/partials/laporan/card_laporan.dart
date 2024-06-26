import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_shimmer.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardLaporan extends StatefulWidget {
  final LaporanModel data;
  bool isLoading;

  CardLaporan({
    super.key,
    required this.data,
    this.isLoading = false,
  });

  factory CardLaporan.loading() {
    LaporanModel data = LaporanModel(
      date: DateTime.now(),
      id: "",
      progress: false,
      type: "",
      data: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return CardLaporan(
      data: data,
      isLoading: true,
    );
  }

  @override
  State<CardLaporan> createState() => _CardLaporanState();
}

class _CardLaporanState extends State<CardLaporan> {
  dynamic laporanModel;
  Map<String, Object> dataType = {"pkl": PklModel};
  final DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();
  bool progress = false;
  String title = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      progress = widget.data.progress;
      laporanModel = widget.data.data;
      switch (widget.data.type) {
        case "pkl":
          title = "PKL";
          break;
        case "reklame":
          title = "Reklame";
          break;
        case "kransos":
          title = "Keransos";
          break;
        case "pengamanan":
          title = "Pengamanan";
          break;
        case "pamwal":
          title = "Pamwal";
          break;
        case "piket":
          title = "Piket";
          break;
        case "perizinan":
          title = "Perizinan";
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant CardLaporan oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      laporanModel = widget.data.data;
      switch (widget.data.type) {
        case "pkl":
          title = "PKL";
          break;
        case "reklame":
          title = "Reklame";
          break;
        case "kransos":
          title = "Keransos";
          break;
        case "pengamanan":
          title = "Pengamanan";
          break;
        case "pamwal":
          title = "Pamwal";
          break;
        case "piket":
          title = "Piket";
          break;
        case "perizinan":
          title = "Perizinan";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return _loadingWidget();
    }
    if (laporanModel == null) {
      return _loadingWidget();
    }
    var data = laporanModel as LaporanBase;

    return widget.data.progress ? _progressWidget(data) : _riwayatWidget(data);
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

  Widget _progressWidget(LaporanBase data) {
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
                          width: 85.w,
                          height: 80.h,
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
                        "Laporan $title",
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
          Column(
            children: [
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.topRight,
                child: AppButton(
                  onPressed: () {
                    switch (widget.data.type) {
                      case "pkl":
                        Get.toNamed(AppRoute.laporanPkl(widget.data.id));
                        return;
                      case "reklame":
                        Get.toNamed(AppRoute.laporanReklame(widget.data.id));
                        return;
                      case "kransos":
                        Get.toNamed(AppRoute.laporanKransos(widget.data.id));
                        return;
                      case "pengamanan":
                        Get.toNamed(AppRoute.laporanPengamanan(widget.data.id));
                        return;
                      case "pamwal":
                        Get.toNamed(AppRoute.laporanPamwal(widget.data.id));
                        return;
                      case "piket":
                        Get.toNamed(AppRoute.laporanPiket(widget.data.id));
                        return;
                      case "perizinan":
                        Get.toNamed(AppRoute.laporanPerizinan(widget.data.id));
                        return;
                    }
                  },
                  text: "Buat Laporan Kegiatan",
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  textStyle: body6BTextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _riwayatWidget(LaporanBase data) {
    return GestureDetector(
      onTap: () {
        switch (widget.data.type) {
          case "pkl":
            Get.toNamed(AppRoute.riwayatPkl(widget.data.id));
            return;
          case "reklame":
            Get.toNamed(AppRoute.riwayatReklame(widget.data.id));
            return;
          case "kransos":
            Get.toNamed(AppRoute.riwayatKransos(widget.data.id));
            return;
          case "pengamanan":
            Get.toNamed(AppRoute.riwayatPengamanan(widget.data.id));
            return;
          case "pamwal":
            Get.toNamed(AppRoute.riwayatPamwal(widget.data.id));
            return;
          case "piket":
            Get.toNamed(AppRoute.riwayatPiket(widget.data.id));
            return;
          case "perizinan":
            Get.toNamed(AppRoute.riwayatPerizinan(widget.data.id));
            return;
        }
      },
      child: Container(
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
                            width: 101.w,
                            height: 101.h,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 101.w,
                            height: 101.h,
                            color: Colors.grey,
                          ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Laporan $title",
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
          ],
        ),
      ),
    );
  }
}
