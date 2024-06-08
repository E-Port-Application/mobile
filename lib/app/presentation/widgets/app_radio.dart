import 'package:eport/styles/color_constants.dart';
import 'package:eport/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnChange<T> = void Function(T item);

class RadioProps<T> {
  final T value;
  final String label;
  const RadioProps({
    required this.label,
    required this.value,
  });
}

class AppRadio<T> extends StatelessWidget {
  final RadioProps<T> data;
  final bool active;
  final OnChange onChange;

  const AppRadio({
    super.key,
    required this.data,
    required this.active,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(data.value);
      },
      splashColor: ColorConstants.primary[70]!.withOpacity(.25),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 6.w,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorConstants.slate[400]!,
              width: .75.h,
            ),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: active
                      ? ColorConstants.primary[60]!
                      : ColorConstants.slate[300]!,
                  width: active ? 3.5.w : 1.5.w,
                ),
                borderRadius: BorderRadius.circular(16.w),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                data.label,
                style: body4TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppRadioGroup<T> extends StatelessWidget {
  final List<RadioProps<T>> data;
  final T? value;
  final OnChange onChange;
  const AppRadioGroup({
    super.key,
    required this.data,
    this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map(
            (e) => AppRadio(
              data: e,
              active: e.value == value,
              onChange: onChange,
            ),
          )
          .toList(),
    );
  }
}
