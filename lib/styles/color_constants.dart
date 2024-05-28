import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorConstants {
  static Map<int, Color> slate = {
    25: Color(0xffF9FAFB),
    50: Color(0xffF0F3F9),
    100: Color(0xffE9EFF6),
    200: Color(0xffD7DFE9),
    300: Color(0xffAFBACA),
    400: Color(0xff8897AE),
    500: Color(0xff5E718D),
    600: Color(0xff455468),
    700: Color(0xff3D4A5C),
    800: Color(0xff2D3643),
    900: Color(0xff1C222B),
  };

  static Map<int, Color> primary = {
    20: Color(0xffBCC29A),
    30: Color(0xff8CA367),
    40: Color(0xff6B8534),
    50: Color(0xff4C6601),
    60: Color(0xff1B5201),
    70: Color(0xff143D01),
    80: Color(0xff0B2901),
    90: Color(0xff000B14),
  };

  static Map<int, Gradient> gradient = {
    1: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xff446927).withOpacity(.4),
        const Color(0xffFFFFFF).withOpacity(0),
      ],
    ),
    2: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        const Color(0xffFFFFFF).withOpacity(1),
        const Color(0xff446927).withOpacity(.41),
      ],
    ),
    3: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        ColorConstants.primary[70]!,
        ColorConstants.primary[60]!,
      ],
    ),
    4: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xffADBAA7), Color(0xff78946B)],
    ),
  };

  static Map<int, BoxShadow> shadow = {
    1: BoxShadow(
      color: Colors.black.withOpacity(.1),
      offset: Offset(0, 0),
      blurRadius: 40.sp,
    ),
    2: BoxShadow(
      color: Colors.black.withOpacity(.1),
      offset: Offset(0, 4),
      blurRadius: 40.sp,
    ),
    3: BoxShadow(
      color: Colors.black.withOpacity(.1),
      offset: Offset(4, 12),
      blurRadius: 12.sp,
      spreadRadius: 1.sp,
    ),
    4: BoxShadow(
      color: Color(0xff5A5A5A).withOpacity(.3),
      offset: Offset(3, 5),
      blurRadius: 15.w,
    ),
    5: BoxShadow(
      color: Colors.black.withOpacity(.25),
      offset: Offset(4, 4),
      blurRadius: 12.sp,
      spreadRadius: 4.sp,
    ),
  };
  static Color error = Color(0xffFF405F);
}

final ColorScheme appColorScheme = ColorScheme(
  primary: ColorConstants.primary[70]!,
  secondary: ColorConstants.slate[500]!,
  background: ColorConstants.slate[25]!,
  surface: ColorConstants.slate[50]!,
  error: Colors.red[400]!,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onBackground: Colors.black,
  onSurface: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);
