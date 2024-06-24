import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/partials/personil/input_personil.dart';
import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef HandleTogle = void Function(PersonilModel data);

class CardPersonil extends StatelessWidget {
  PersonilModel data;
  final HandleTogle? onRemove;
  final HandleTogle? onAdd;
  final bool state;
  final PersonilVariant variant;
  final HandleTogle? onToggle;

  CardPersonil({
    super.key,
    required this.data,
    this.onRemove,
    this.state = true,
    this.onToggle,
    this.onAdd,
    this.variant = PersonilVariant.create,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (variant == PersonilVariant.create) {
          if (!state) {
            onAdd!(data);
          }
          return;
        }
        if (variant == PersonilVariant.edit) {
          onToggle!(data);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 46.h,
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          color: variant == PersonilVariant.create
              ? state
                  ? ColorConstants.success[10]
                  : Colors.white
              : data.hadir
                  ? ColorConstants.success[20]
                  : ColorConstants.errors[20],
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(color: ColorConstants.slate[300]!),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data.name,
                  style: body3TextStyle(
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              variant == PersonilVariant.edit
                  ? Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.w),
                        border: Border.all(color: ColorConstants.slate[300]!),
                      ),
                    )
                  : Container(),
              variant == PersonilVariant.create
                  ? GestureDetector(
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
                                border: Border.all(
                                    color: ColorConstants.slate[300]!),
                                color: ColorConstants.slate[50],
                              ),
                            ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
