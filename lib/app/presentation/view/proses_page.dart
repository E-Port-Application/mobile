import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/presentation/partials/laporan/filtered_card.dart';
import 'package:eport/app/presentation/partials/laporan/laporan_filter.dart';
import 'package:eport/app/presentation/widgets/app_input.dart';
import 'package:eport/app/presentation/widgets/popover.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/proses_controller.dart';

class ProsesPage extends GetView<ProsesController> {
  const ProsesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => LaporanFilter(
            activities: controller.activities,
            onReset: controller.onReset,
            onActivity: controller.onActivity,
            value: controller.selectedActivity.value,
          ),
        ),
        SizedBox(height: 20.h),
        FilteredCard(),
        FilteredCard(),
      ],
    );
  }
}
