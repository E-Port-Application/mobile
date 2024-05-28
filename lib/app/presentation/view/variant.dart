import 'package:eport/app/presentation/view/external/onboard_page.dart'
    as onboard_external;
import 'package:eport/app/presentation/view/internal/onboard_page.dart'
    as onboard_internal;
import 'package:eport/global_settings.dart';
import 'package:eport/routes/app_route.dart';
import 'package:flutter/material.dart';

class Onboard {
  static Widget internal() => onboard_internal.OnboardPage();
  static Widget external() => onboard_external.OnboardPage();
  static String path() {
    return GlobalSetting.name == UserVariant.external
        ? AppRoute.onboardExternal
        : AppRoute.onboardInternal;
  }
}
