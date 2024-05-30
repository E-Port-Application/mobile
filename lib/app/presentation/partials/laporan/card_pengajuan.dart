import 'package:eport/app/presentation/widgets/app_modal.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PengajuanData {
  final String label;
  final String path;

  const PengajuanData({
    required this.label,
    required this.path,
  });
}

class CardPengajuan extends StatelessWidget {
  final PengajuanData data;
  const CardPengajuan({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AppModal(
              primaryText: "Proses Laporan",
              secondaryText: "Buat Manual",
              onPrimary: () {
                Get.toNamed(data.path);
              },
              onSecondary: () {},
              title: "Buat Laporan Penegakan Perda Perkada",
            );
          },
        );
      },
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.02),
              offset: Offset(0, 2),
              blurRadius: 4.w,
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 16.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.label,
                style: body3BTextStyle(),
              ),
              Icon(
                Icons.chevron_right,
                size: 26.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
