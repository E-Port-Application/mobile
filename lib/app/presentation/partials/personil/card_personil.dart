import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPersonil extends StatelessWidget {
  final Personil data;
  const CardPersonil({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      width: 1.sw,
      margin: EdgeInsets.all(10.h),
    );
  }
}
