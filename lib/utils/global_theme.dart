import 'package:flutter/material.dart';
import 'package:eport/styles/color_constants.dart';

ThemeData globalTheme() {
  return ThemeData(
    fontFamily: "Kumbh",
    scaffoldBackgroundColor: ColorConstants.slate[25],
    colorScheme: appColorScheme,
  );
}
