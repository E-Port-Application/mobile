import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLocation extends StatelessWidget {
  const AppLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        color: Colors.white,
        border: Border.all(color: ColorConstants.slate[300]!),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.location_on_rounded,
              color: ColorConstants.primary[70],
              size: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              "Lokasi Anda",
              style: body3BTextStyle(
                color: ColorConstants.primary[70],
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Text(
                "Jalan Soehat Mentari Malang Raya iya betul",
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: body3TextStyle(
                  color: ColorConstants.slate[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
