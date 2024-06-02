import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardLaporan extends StatelessWidget {
  const CardLaporan({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: Image.asset(
                "assets/images/card-thumbnail.png",
                height: 80.h,
                width: 85.w,
                fit: BoxFit.cover,
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
                    "Ketertiban Umum dan Ketentraman Masyarakat",
                    style: body6BTextStyle(
                      color: ColorConstants.primary[70],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "10th Jan 2024 | 10.00 WIB",
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
    );
  }
}
