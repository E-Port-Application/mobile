import 'package:eport/app/presentation/view/variant.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with TickerProviderStateMixin {
  bool isMounted = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      setState(() {
        isMounted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 4, child: Container()),
            AnimatedOpacity(
              opacity: isMounted ? 1 : 0,
              duration: Duration(seconds: 1),
              child: Image.asset(
                "assets/images/onboard/visual.png",
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Satpol Saja hadir untuk\nmemudahkan pelaporan anda",
              style: h4BTextStyle(
                color: ColorConstants.slate[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Aplikasi resmi pelaporan pelanggaran Kota Batu",
              style: body3TextStyle(
                color: ColorConstants.slate[600],
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            AppButton(
              onPressed: () {
                Get.toNamed(Login.path());
              },
              text: "Login",
            ),
            SizedBox(height: 20.h),
            AppButton(
              onPressed: () {
                Get.toNamed(Register.path());
              },
              variant: AppButtonVariant.secondary,
              foregroundColor: ColorConstants.slate[300],
              text: "Daftar",
              boxShadow: [ColorConstants.shadow[3]!],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
