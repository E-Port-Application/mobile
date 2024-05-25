import 'package:eport/app/controller/login_controller.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
                width: 100.sw,
              ),
              Image.asset("assets/images/app-logo-no-text.png"),
              SizedBox(height: 30.h),
              Text(
                "Login",
                style: h1BTextStyle(
                  size: 32.sp,
                  color: ColorConstants.slate[700],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Kami senang bertemu Anda lagi!",
                style: body2BTextStyle(
                  weight: FontWeight.w500,
                  color: ColorConstants.slate[700],
                ),
              ),
              AppInput(
                label: "Email",
                controller: TextEditingController(),
                placeholder: "Masukkan Email Anda",
              ),
              SizedBox(height: 10.h),
              AppInput(
                label: "Password",
                controller: TextEditingController(),
                obscureText: true,
                placeholder: "Masukkan Passowrd Anda",
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Lupa Password?",
                  style: body3TextStyle(color: ColorConstants.slate[700]),
                ),
              ),
              SizedBox(height: 32.h),
              AppButton(
                onPressed: () {},
                text: "Login",
                width: 100.sw,
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: .5,
                        color: ColorConstants.slate[600],
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "Masuk dengan",
                      style: body4TextStyle(
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Divider(
                        thickness: .5,
                        color: ColorConstants.slate[600],
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              AppButton(
                onPressed: () {},
                text: "",
                width: 100.sw,
                type: AppButtonType.outlined,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/google.svg",
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Google",
                      style: body2BTextStyle(),
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun? ",
                    style: body3TextStyle(
                      weight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.register);
                    },
                    child: Text(
                      "Daftar",
                      style: body3BTextStyle(
                        color: ColorConstants.primary[60],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
