import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBottombar extends StatelessWidget {
  GlobalController globalController = GlobalController.i;
  AppBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "app_bottombar",
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 36.w,
            ),
            width: 1.sw,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [ColorConstants.shadow[1]!],
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: globalController.menus
                    .map(
                      (val) => GestureDetector(
                        onTap: () {
                          print(val.label);
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              val.iconActive,
                              width: 26.w,
                              height: 26.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              val.label,
                              style: body5BTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
