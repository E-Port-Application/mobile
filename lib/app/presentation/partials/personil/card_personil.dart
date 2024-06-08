import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef HandleTogle = void Function(Personil data);

class CardPersonil extends StatelessWidget {
  Personil data;
  final HandleTogle? onRemove;
  final HandleTogle? onAdd;
  final bool state;
  CardPersonil({
    super.key,
    required this.data,
    this.onRemove,
    this.state = true,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!state) {
          onAdd!(data);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 46.h,
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          color: state ? ColorConstants.success[10] : Colors.white,
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(color: ColorConstants.slate[300]!),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                style: body3TextStyle(),
              ),
              GestureDetector(
                onTap: () {
                  if (state) {
                    onRemove!(data);
                  }
                },
                child: state
                    ? Icon(
                        Icons.close,
                        color: ColorConstants.slate[500],
                      )
                    : Container(
                        width: 16.w,
                        height: 16.h,
                        margin: EdgeInsets.only(right: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          border: Border.all(color: ColorConstants.slate[300]!),
                          color: ColorConstants.slate[50],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
