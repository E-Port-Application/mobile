import 'package:eport/app/controller/login_controller.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ScrollableConstraints(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 48.h,
                    width: 1.sw,
                  ),
                  Image.asset(
                    "assets/images/app-logo-no-text.png",
                    height: 100.h,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Login",
                    style: h1BTextStyle(
                      size: 32.sp,
                      color: ColorConstants.slate[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Kami senang bertemu Anda lagi!",
                    style: body2BTextStyle(
                      weight: FontWeight.w500,
                      color: ColorConstants.slate[700],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AppInput(
                    label: "Email",
                    controller: controller.form['email']!,
                    placeholder: "Masukkan Email Anda",
                    validator: controller.emailValidator,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10.h),
                  AppInput(
                    label: "Password",
                    controller: controller.form['password']!,
                    obscureText: true,
                    placeholder: "Masukkan Passowrd Anda",
                    validator: controller.passwordValidator,
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
                    onPressed: controller.emailSignin,
                    text: "Login",
                    width: 1.sw,
                  ),
                  SizedBox(height: 80.h),
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
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
