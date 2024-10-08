import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_scaffold.dart';
import 'package:eport/app/presentation/view/pimpinan_page.dart';
import 'package:eport/app/presentation/view/proses_page.dart';
import 'package:eport/app/presentation/view/rencana_page.dart';
import 'package:eport/app/presentation/view/riwayat_page.dart';
import 'package:eport/app/presentation/widgets/scrollable_constraints.dart';
import 'package:eport/global_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaporanPage extends GetView<LaporanController> {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Global.pimpinan) {
      return PimpinanPage();
    }
    return LaporanScaffold(
      menu: controller.menu,
      controller: controller.pageController,
      current: controller.current,
      title: "Laporan Kegiatan",
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 1.sh,
        ),
        child: PageView(
          controller: controller.pageController,
          physics: BouncingScrollPhysics(),
          onPageChanged: (e) {
            controller.current.value = e;
          },
          children: [
            ScrollableConstraints(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: RencanaPage(),
              ),
            ),
            ScrollableConstraints(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ProsesPage(),
              ),
            ),
            ScrollableConstraints(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: RiwayatPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
