import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double cWidth = 150;
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
      await Future.delayed(Duration(milliseconds: 3000));
      Get.offAndToNamed(AppRoute.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(width: 100.sw),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            left: isExpand ? -36.w : 100.w,
            right: isExpand ? -36.w : 100.w,
            bottom: -140.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: ColorConstants.gradient[1],
                borderRadius: BorderRadius.circular(100.sw),
              ),
              width: 100.sw,
              child: AspectRatio(
                aspectRatio: 1 / 1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center.add(Alignment(0, -0.2)),
            child: AnimatedSize(
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              child: Image.asset(
                "assets/images/app-logo.png",
                height: isExpand ? 195.h : 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
