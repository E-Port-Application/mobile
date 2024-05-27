import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isExpand = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 0)).then((value) => {
          setState(() {
            isExpand = true;
          })
        });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 2500));
      Get.offAndToNamed(AppRoute.onboarding);
      if (GlobalController.i.user.value == null) {
        return;
      }
      Get.offAndToNamed(AppRoute.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(child: Container()),
            AnimatedSize(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: Image.asset(
                "assets/images/app-logo.png",
                height: isExpand ? 195.h : 10.h,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/batu-government.png",
                  height: 36.h,
                ),
                SizedBox(width: 12.w),
                Image.asset(
                  "assets/images/pamong-praja.png",
                  height: 36.h,
                ),
                SizedBox(width: 20.w),
                Flexible(
                  child: Text(
                    "Dikelola di bawah Satuan Polisi Pamong\nPraja Kota Batu dan Pemerintah Kota Batu",
                    style: body4TextStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.h),
          ],
        ),
      ),
    );
  }
}
