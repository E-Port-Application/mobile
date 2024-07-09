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
  final int index;
  final String title;
  final bool isDetail;
  const LaporanScaffold({
    super.key,
    required this.child,
    this.index = 0,
    this.title = "Laporan",
    this.isDetail = false,
  });

  const LaporanScaffold.detail({
    super.key,
    required this.child,
    this.index = 0,
    this.title = "Laporan",
    this.isDetail = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isDetail) {
      return laporanDetail();
    }

    return Scaffold(
      backgroundColor: ColorConstants.slate[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Container(
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
                  height: title.length > 30 ? 64.h : 50.h,
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
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(width: 56.w),
                            Flexible(
                              child: Text(
                                title,
                                style: body1BTextStyle(
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Obx(
                    () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: LaporanController.i.menu.mapIndexed(
                          (i, data) {
                            bool active =
                                i == LaporanController.i.current.value;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: GestureDetector(
                                  onTap: () {
                                    LaporanController.i.pageController
                                        .animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.linear,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 88.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      color: active
                                          ? ColorConstants.primary[50]
                                          : ColorConstants.slate[50],
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.label,
                                        style: body5BTextStyle(
                                          color: active
                                              ? Colors.white
                                              : ColorConstants.slate[600],
                                          height: 1,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
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
      ),
      body: child,
    );
  }

  Widget laporanDetail() {
    return Scaffold(
      backgroundColor: ColorConstants.slate[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  offset: Offset(0, 2),
                  blurRadius: 8.w,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  10.w,
                ),
                bottomRight: Radius.circular(
                  10.w,
                ),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 1,
              flexibleSpace: Stack(
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
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(width: 56.w),
                        Text(
                          title,
                          style: body1BTextStyle(
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ScrollableConstraints(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: child,
        ),
      ),
    );
  }
}
