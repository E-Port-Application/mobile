import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPengajuan extends StatelessWidget {
  final String label;
  const CardPengajuan({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              label,
              style: body3BTextStyle(),
            ),
            Icon(
              Icons.chevron_right,
              size: 26.w,
            ),
          ],
        ),
      ),
    );
  }
}
