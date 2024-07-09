import 'package:eport/app/presentation/widgets/app_button.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppModal extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimary;
  final VoidCallback onSecondary;
  final String? description;
  final String title;

  const AppModal({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimary,
    required this.onSecondary,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h,
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: h5BTextStyle(),
                ),
                description != null
                    ? Column(
                        children: [
                          SizedBox(height: 8.h),
                          Text(
                            description!,
                            style: body4TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: onPrimary,
                        text: primaryText,
                        textStyle: body3BTextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppButton(
                        variant: AppButtonVariant.secondary,
                        onPressed: onSecondary,
                        text: secondaryText,
                        type: AppButtonType.outlined,
                        textStyle: body3BTextStyle(
                          color: ColorConstants.primary[50],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
