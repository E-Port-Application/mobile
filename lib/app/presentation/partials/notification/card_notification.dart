import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [ColorConstants.shadow[4]!],
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/notification/calendar.png",
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Agenda Operasi Satgas',
                        style: body4TextStyle(weight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "2 hari yang lalu",
                      style: body6TextStyle(
                        color: ColorConstants.slate[400],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200.w),
                  child: Text(
                    "Semangat pagi, jangan lupa untuk lakukan olahraga hari ini 😆",
                    style: body5TextStyle(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
