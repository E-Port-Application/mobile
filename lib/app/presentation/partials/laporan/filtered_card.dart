import 'package:eport/app/presentation/partials/laporan/card_laporan.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilteredCard extends StatelessWidget {
  const FilteredCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hari ini",
          style: body2BTextStyle(),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
