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
  var data = [
    {
      "title": "E-Port hadir untuk memudahkan\npelaporan anda",
      "description": "Aplikasi resmi pelaporan pelanggaran Kota Batu",
      "thumbnail": "assets/images/onboard/external_1.png",
    },
    {
      "title": "Kemudahan di Tangan Anda",
      "description": "Laporkan pelanggaran ketertiban dengan cepat\ndan tepat.",
      "thumbnail": "assets/images/onboard/external_2.png",
    },
    {
      "title": "Transparansi dan Pembaharuan",
      "description":
          "Pantau perkembangan laporanmu dan berita\nseputar penertiban masyarakat.",
      "thumbnail": "assets/images/onboard/external_3.png",
    },
  ];

  int index = 0;

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
            SizedBox(height: .11.sh),
            // Expanded(child: Container()),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 520.h),
                child: PageView(
                    onPageChanged: (e) {
                      setState(() {
                        index = e;
                      });
                    },
                    physics: BouncingScrollPhysics(),
                    children: data
                        .map(
                          (e) => Column(
                            children: [
                              AnimatedOpacity(
                                opacity: isMounted ? 1 : 0,
                                duration: Duration(seconds: 1),
                                child: Image.asset(
                                  e['thumbnail']!,
                                  height: 380.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                  height: 64.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e['title']!,
                                        style: h4BTextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 4.h),
                              Text(
                                e['description']!,
                                style: body3TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2]
                      .map(
                        (e) => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          curve: Curves.easeInOut,
                          height: 12.h,
                          width: e == index ? 40.w : 12.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.w),
                            color: e == index
                                ? ColorConstants.primary[50]
                                : ColorConstants.slate[200],
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 28.h),
                AppButton(
                  onPressed: () {
                    Get.toNamed(Login.path());
                  },
                  text: "Login",
                ),
                SizedBox(height: 12.h),
                AppButton(
                  onPressed: () {
                    Get.toNamed(Register.path());
                  },
                  variant: AppButtonVariant.secondary,
                  text: "Register",
                  boxShadow: [ColorConstants.shadow[3]!],
                ),
                SizedBox(height: 28.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
