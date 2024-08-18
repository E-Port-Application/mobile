import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/view/external/laporan_masuk_page.dart';
import 'package:eport/app/presentation/view/external/masyarakat_page.dart';
import 'package:eport/app/presentation/view/external/riwayat_laporan_page.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/global_settings.dart';

class LaporanExternalPage extends GetView<LaporanExternalController> {
  const LaporanExternalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LaporanScaffold(
      controller: controller.pageController,
      menu: controller.menu,
      title: !Global.isExt() ? "Laporan Masyarakat" : "Laporan",
      current: controller.current,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 1.sh,
        ),
        child: PageView(
          onPageChanged: (e) {
            controller.current.value = e;
          },
          controller: controller.pageController,
          physics: BouncingScrollPhysics(),
          children: [
            Global.isExt()
                ? MasyarakatPage(type: LaporanType.create)
                : ScrollableConstraints(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: LaporanMasukPage(),
                    ),
                  ),
            ScrollableConstraints(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: RiwayatLaporanPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
