import 'package:eport/firebase_options.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeService extends StatelessWidget {
  const HomeService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: ColorConstants.gradient[3],
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {},
            child: Column(
              children: [
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/piket.svg",
                      width: 32.w,
                      height: 32.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Piket",
                  style: body4BTextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            height: 45.h,
            width: 1.w,
            decoration: BoxDecoration(
              color: Color(0xffC1D4F9),
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
          GestureDetector(
            child: Column(
              children: [
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/panduan.svg",
                      width: 32.w,
                      height: 32.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Panduan",
                  style: body4BTextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            height: 45.h,
            width: 1.w,
            decoration: BoxDecoration(
              color: Color(0xffC1D4F9),
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
          GestureDetector(
            child: Column(
              children: [
                Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/faq.svg",
                      width: 32.w,
                      height: 32.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "FAQ",
                  style: body4BTextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
