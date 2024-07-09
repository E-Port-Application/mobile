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
    0: Color(0xffCECEC7),
    5: Color(0xffC1C1BA),
    10: Color(0xffB5B5AD),
    15: Color(0xffA8A8A0),
    20: Color(0xff9C9C93),
    30: Color(0xff82827A),
    40: Color(0xff696960),
    50: Color(0xff505046),
    60: Color(0xff404038),
    70: Color(0xff30302A),
    80: Color(0xff20201C),
    85: Color(0xff181815),
    90: Color(0xff10100E),
  };

  static Map<int, Color> info = {
    10: Color(0xffCCE0FD),
    20: Color(0xff99C1FC),
    30: Color(0xff66A1FA),
    40: Color(0xff3382F9),
    50: Color(0xff0063F7),
    60: Color(0xff004FC6),
    70: Color(0xff003B94),
    80: Color(0xff002863),
  };
  static Map<int, Color> success = {
    10: Color(0xffCDF3E2),
    20: Color(0xff9BE7C6),
    30: Color(0xff6ADAA9),
    40: Color(0xff38CE8D),
    50: Color(0xff06C270),
    60: Color(0xff059B5A),
    70: Color(0xff047443),
    80: Color(0xff024E2D),
  };
  static Map<int, Color> errors = {
    10: Color(0xffFBCCCC),
    20: Color(0xffF69999),
    30: Color(0xffF26666),
    40: Color(0xffED3333),
    50: Color(0xffE90000),
    60: Color(0xffBA0000),
    70: Color(0xff8C0000),
    80: Color(0xff5D0000),
  };

  static Map<int, Gradient> gradient = {
    1: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        ColorConstants.primary[70]!.withOpacity(.4),
        const Color(0xffFFFFFF).withOpacity(0),
      ],
    ),
    2: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        const Color(0xffFFFFFF).withOpacity(1),
        ColorConstants.primary[70]!.withOpacity(.41),
      ],
    ),
    3: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        ColorConstants.primary[50]!,
        ColorConstants.primary[60]!,
      ],
    ),
    4: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [ColorConstants.primary[40]!, ColorConstants.primary[60]!],
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
    6: BoxShadow(
      color: Colors.black.withOpacity(.25),
      offset: Offset(0, 1),
      blurRadius: 2.sp,
    ),
  };
  static Color error = Color(0xffFF405F);
}

final ColorScheme appColorScheme = ColorScheme(
  primary: ColorConstants.primary[50]!,
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
