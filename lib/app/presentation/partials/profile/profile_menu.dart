import 'package:eport/app/models/common/profile/profile_model.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileMenu extends StatelessWidget {
  final ProfileModel data;
  const ProfileMenu({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4.w),
      onTap: data.path != null
          ? () {
              Get.toNamed(data.path!);
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorConstants.slate[100]!,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              data.icon,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                data.label,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.chevron_right,
              size: 20.w,
              color: ColorConstants.slate[500],
            ),
          ],
        ),
      ),
    );
  }
}
