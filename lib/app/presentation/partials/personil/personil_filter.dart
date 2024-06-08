import 'package:eport/app/controller/personil_controller.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonilFilter extends StatelessWidget {
  PersonilController controller = PersonilController.i;
  PersonilFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchDropdown(
                onClick: (e) {
                  controller.handleAddPersonil(e, isSearch: true);
                },
                options: controller.personils,
              ),
            ),
            SizedBox(width: 8.w),
            Obx(
              () => AppButton(
                onPressed: controller.selectedPersonil.isEmpty
                    ? null
                    : controller.handleSave,
                text: "Simpan",
                width: 86.w,
                padding: EdgeInsets.symmetric(
                  vertical: 23.h,
                ),
                textStyle: body3TextStyle(
                  weight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
