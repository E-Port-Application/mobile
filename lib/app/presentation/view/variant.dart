import 'package:eport/app/presentation/view/external/onboard_page.dart'
    as onboard_external;
import 'package:eport/app/presentation/view/internal/login_page.dart'
    as login_internal;
import 'package:eport/app/presentation/view/external/login_page.dart'
    as login_external;
import 'package:eport/app/presentation/view/internal/onboard_page.dart'
    as onboard_internal;
import 'package:eport/app/presentation/view/internal/register_page.dart'
    as register_internal;
import 'package:eport/app/presentation/view/external/register_page.dart'
    as register_external;
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

class Login {
  static Widget internal() => login_internal.LoginPage();
  static Widget external() => login_external.LoginPage();
  static String path() {
    return GlobalSetting.name == UserVariant.external
        ? AppRoute.loginExternal
        : AppRoute.loginInternal;
  }
}

class Register {
  static Widget internal() => register_internal.RegisterPage();
  static Widget external() => register_external.RegisterPage();
  static String path() {
    return GlobalSetting.name == UserVariant.external
        ? AppRoute.registerExternal
        : AppRoute.registerInternal;
  }
}
