import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/extensions/map_indexed.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaporanScaffold extends StatelessWidget {
  final Widget child;
  const LaporanScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorConstants.slate[100],
      body: Stack(
        children: [
          ScrollableConstraints(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 200.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: child,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Colors.white,
              boxShadow: [ColorConstants.shadow[2]!],
            ),
            padding: EdgeInsets.only(bottom: 20.h),
            clipBehavior: Clip.hardEdge,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            iconSize: 22.sp,
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.chevron_left,
                              size: 26.w,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              SizedBox(width: 56.w),
                              Text(
                                "Laporan",
                                style: body1BTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Obx(
                      () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: LaporanController.i.menu.mapIndexed(
                            (i, data) {
                              bool active =
                                  i == LaporanController.i.current.value;
                              return Container(
                                width: 88.w,
                                height: 36.h,
                                decoration: BoxDecoration(
                                  color: active
                                      ? ColorConstants.primary[70]
                                      : ColorConstants.slate[50],
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                                child: Center(
                                  child: Text(
                                    data.label,
                                    style: body3TextStyle(
                                      color: active
                                          ? Colors.white
                                          : ColorConstants.slate[600],
                                      height: 1,
                                      size: 13.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
