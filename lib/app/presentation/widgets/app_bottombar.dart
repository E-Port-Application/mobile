import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/global_settings.dart';
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
                    Global.isExt()
                        ? Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SizedBox(
                                width: 65.w,
                                height: 65.h,
                                child: MaterialButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.w),
                                  ),
                                  color: ColorConstants.primary[50],
                                  padding: EdgeInsets.all(8.w),
                                  height: 65.h,
                                  minWidth: 65.w,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/add.svg",
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
