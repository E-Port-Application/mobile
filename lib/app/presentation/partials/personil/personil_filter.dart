import 'package:eport/app/controller/personil_controller.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                onClick: controller.handleAddPersonil,
                options: [
                  Personil(id: "1", name: "Fadli Hasan"),
                  Personil(id: "2", name: "Bintang Lazuardi"),
                  Personil(id: "3", name: "Pak Handoyo"),
                  Personil(id: "4", name: "Pak Budi"),
                  Personil(id: "5", name: "Setjen Angkasa 2"),
                  Personil(id: "6", name: "Roiyan Zain"),
                  Personil(id: "7", name: "Tukang Bakso 5"),
                  Personil(id: "8", name: "Pak Cak Man"),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            AppButton(
              onPressed: () {},
              text: "Simpan",
              width: 86.w,
              padding: EdgeInsets.symmetric(
                vertical: 23.h,
              ),
              textStyle: body3TextStyle(
                weight: FontWeight.w500,
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
