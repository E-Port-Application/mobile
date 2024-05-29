import 'package:eport/app/controller/profile_controller.dart';
import 'package:eport/app/presentation/partials/profile/profile_menu.dart';
import 'package:eport/app/presentation/widgets/app_background.dart';
import 'package:eport/app/presentation/widgets/app_bottombar.dart';
import 'package:eport/app/presentation/widgets/app_shimmer.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/extensions/map_indexed.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: ScrollableConstraints(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: 120.h,
              top: 20.h,
            ),
            child: Obx(
              () {
                final data = controller.user.value;
                final menu = controller.menu;
                return Column(
                  children: [
                    AppShimmer(
                      show: data != null,
                      overlay: Container(
                        width: 115.w,
                        height: 115.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.sw),
                            color: Colors.white),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.sw),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child:
                                data?.photoURL != null || data?.photoURL != ""
                                    ? Image.network(
                                        data?.photoURL ?? '',
                                        width: 115.w,
                                        height: 115.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/default_pp.jpg",
                                        width: 115.w,
                                        height: 115.h,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          Positioned(
                            top: 0.h,
                            right: 0.w,
                            child: GestureDetector(
                              onTap: controller.updatePhoto,
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: Color(0xff3E668B),
                                  borderRadius: BorderRadius.circular(20.w),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 21.w,
                                    color: ColorConstants.slate[200],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AppShimmer(
                      show: data != null,
                      overlay: Container(
                        width: 120.w,
                        height: 24.h,
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 3.h),
                      ),
                      child: Text(
                        data?.displayName ?? "",
                        style: h3BTextStyle(),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    AppShimmer(
                      show: data != null,
                      overlay: Container(
                        width: 140.w,
                        height: 16.h,
                        color: Colors.white,
                      ),
                      child: Text(
                        data?.email ?? "",
                        style: body3TextStyle(
                          color: ColorConstants.slate[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ...menu
                        .mapIndexed((i, e) => ProfileMenu(
                              data: e,
                              isLogout: i == menu.length - 1,
                            ))
                        .toList(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottombar(path: AppRoute.profile),
    );
  }
}
