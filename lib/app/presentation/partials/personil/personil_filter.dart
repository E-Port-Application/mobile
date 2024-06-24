import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef AddPersonil = void Function(
  PersonilModel data, {
  bool? isSearch,
  Rx<PersonilState>? ref,
});

typedef HandleSave = void Function();

class PersonilFilter extends StatelessWidget {
  final AddPersonil handleAddPersonil;
  final bool disabled;
  final HandleSave handleSave;
  final RxList<Rx<PersonilState>> personils;
  final PersonilVariant variant;

  const PersonilFilter({
    super.key,
    required this.handleAddPersonil,
    required this.handleSave,
    required this.personils,
    required this.disabled,
    this.variant = PersonilVariant.create,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchDropdown(
                onClick: (e) {
                  if (variant == PersonilVariant.edit) {
                    e.personil.hadir = true;
                  }
                  handleAddPersonil(e.personil, isSearch: true);
                },
                options: personils,
              ),
            ),
            SizedBox(width: 8.w),
            AppButton(
              onPressed: disabled ? null : handleSave,
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
          ],
        ),
      ],
    );
  }
}
