import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/routes/app_route.dart';
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
      "description": "Aplikasi resmi pelaporan pelanggaran Kota Batu"
    },
    {
      "title": "Kemudahan di Tangan Anda",
      "description": "Laporkan pelanggaran ketertiban dengan cepat\ndan tepat."
    },
    {
      "title": "Transparansi dan Pembaharuan",
      "description":
          "Pantau perkembangan laporanmu dan berita\nseputar penertiban masyarakat."
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
            Expanded(flex: 2, child: Container()),
            AnimatedOpacity(
              opacity: isMounted ? 1 : 0,
              duration: Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.sw),
                  boxShadow: [ColorConstants.shadow[3]!],
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.sw),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xff446927).withOpacity(.4),
                      const Color(0xffFFFFFF).withOpacity(0),
                    ],
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      Positioned(
                        bottom: -40.h,
                        child: Image.asset(
                          "assets/images/onboard/visual.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              constraints: BoxConstraints(maxHeight: 100.h),
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
                            SizedBox(
                                height: 60.h,
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
            SizedBox(height: 28.h),
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
                            ? ColorConstants.primary[70]
                            : ColorConstants.slate[200],
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            AppButton(
              onPressed: () {
                Get.toNamed(AppRoute.login);
              },
              text: "Login",
            ),
            SizedBox(height: 20.h),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
