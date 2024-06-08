import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/presentation/partials/home/card_information.dart';
import 'package:eport/app/presentation/partials/home/home_service.dart';
import 'package:eport/app/presentation/widgets/app_background.dart';
import 'package:eport/app/presentation/widgets/app_bottombar.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  GlobalController globalController = GlobalController.i;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: AppBackground(
        child: NotificationListener(
          onNotification: (e) {
            if (e is ScrollEndNotification) {
              controller.scrolled.value = e;
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Obx(
                    () => Text(
                      "Hello, Bang ${globalController.user.value?.displayName}",
                      style: h1BTextStyle(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Global.isExt()
                      ? Column(
                          children: [
                            AppInput(
                              controller: TextEditingController(),
                              placeholder: "Cari disini...",
                              suffixIcon: Icon(Icons.search),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        )
                      : Container(),
                  Container(
                    width: 100.sw,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.w),
                      boxShadow: [ColorConstants.shadow[2]!],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/app-logo-no-text.png",
                          width: 45.w,
                        ),
                        SizedBox(width: 12.w),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "E-Port",
                                style: body1BTextStyle(),
                              ),
                              Text(
                                "Sistem Layanan Satuan Polisi Pamong Praja Kota Batu",
                                style: body5TextStyle(
                                  weight: FontWeight.w600,
                                  color: Colors.black,
                                  size: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Image.asset(
                          "assets/images/batu-government.png",
                          height: 50.h,
                        ),
                        SizedBox(width: 6.w),
                        Image.asset(
                          "assets/images/pamong-praja.png",
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Global.isExt() ? 12.h : 28.h),
                  Global.isExt()
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Layanan Kami",
                              style: body2BTextStyle(),
                            ),
                            SizedBox(height: 12.h),
                            HomeService(),
                          ],
                        ),
                  SizedBox(height: 12.h),
                  Text(
                    "Informasi Terbaru",
                    style: body2BTextStyle(),
                  ),
                  SizedBox(height: 20.h),
                  CardInformation(),
                  SizedBox(height: 12.h),
                  CardInformation(),
                  SizedBox(height: 12.h),
                  CardInformation(),
                  SizedBox(height: 12.h),
                  CardInformation(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottombar(path: AppRoute.home),
    );
  }
}
