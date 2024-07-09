import 'package:eport/app/controller/login_controller.dart';
import 'package:eport/app/presentation/view/variant.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
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
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorConstants.gradient[4],
        ),
        child: ScrollableConstraints(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Selamat Datang\nKembali!",
                    style: h1BTextStyle(
                      size: 28.sp,
                      color: ColorConstants.primary[80],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 47.h),
                        width: 1.sw,
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: 32.h,
                          top: 60.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.w),
                          boxShadow: [ColorConstants.shadow[5]!],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Login",
                              style: h1BTextStyle(size: 40.sp),
                              textAlign: TextAlign.center,
                            ),
                            AppInput(
                              label: "Email",
                              controller: controller.form['email']!,
                              placeholder: "Masukkan Email Anda",
                              validator: controller.emailValidator,
                            ),
                            SizedBox(height: 12.h),
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
                                style: body3TextStyle(
                                    color: ColorConstants.slate[700]),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            AppButton(
                              onPressed: () {},
                              text: "Login",
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: .5,
                                      color: ColorConstants.slate[900],
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
                                      color: ColorConstants.slate[900],
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            AppButton(
                              onPressed: controller.googleSignin,
                              text: "",
                              width: 1.sw,
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
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 94.w,
                          height: 94.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1.sw),
                            border: Border.all(
                              color:
                                  ColorConstants.primary[60]!.withOpacity(.8),
                              width: 3.w,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/app-logo-no-text.png",
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? ",
                        style: body3TextStyle(
                          weight: FontWeight.w500,
                          color: ColorConstants.primary[50],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Register.path());
                        },
                        child: Text(
                          "Daftar",
                          style: body3BTextStyle(),
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
