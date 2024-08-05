import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBottombar extends StatelessWidget {
  GlobalController globalController = GlobalController.i;
  final String path;
  AppBottombar({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "app_bottombar",
      child: Obx(
        () => globalController.menus.isNotEmpty
            ? SizedBox(
                height: 100.h,
                child: Stack(
                  children: [
                    SizedBox(height: 100.h, width: 1.sw),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                        ),
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [ColorConstants.shadow[1]!],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: globalController.menus
                              .map(
                                (val) => GestureDetector(
                                  onTap: () {
                                    Get.toNamed(val.path);
                                  },
                                  child: SizedBox(
                                    width: 75.w,
                                    child: Column(
                                      children: [
                                        val.focus ?? false
                                            ? SizedBox(height: 26.h)
                                            : SvgPicture.asset(
                                                path == val.path
                                                    ? val.iconActive
                                                    : val.iconInactive,
                                                width: 26.w,
                                                height: 26.h,
                                                fit: BoxFit.cover,
                                              ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          val.label,
                                          style: body5BTextStyle(
                                            color: path == val.path
                                                ? ColorConstants.primary[50]
                                                : ColorConstants.slate[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
