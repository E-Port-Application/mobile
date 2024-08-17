import 'package:flutter/material.dart';
import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/presentation/view/variant.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2, milliseconds: 500),
    );

    for (int i = 0; i < "Satpol Saja".length; i++) {
      _animations.add(Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            i * 0.09,
            1.0,
            curve: Curves.bounceOut,
          ),
        ),
      ));
    }
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 2500));
      Get.offAndToNamed(Onboard.path());
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
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: "Satpol Saja".characters.map((char) {
                    int index = "Satpol Saja".indexOf(char);
                    return Transform.translate(
                      offset: Offset(0.0, _animations[index].value * 200),
                      child: Text(
                        char,
                        style: h1BTextStyle(
                          fontFamily: "PottaOne",
                          size: 40.sp,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
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
