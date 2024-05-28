import 'package:eport/app/bindings/auth_bindings.dart';
import 'package:eport/app/bindings/profile_bindings.dart';
import 'package:eport/app/presentation/view/login_page.dart';
import 'package:eport/app/presentation/view/notification_page.dart';
import 'package:eport/app/presentation/view/profile_page.dart';
import 'package:eport/app/presentation/view/register_page.dart';
import 'package:eport/app/presentation/view/variant.dart';
import 'package:get/get.dart';
import 'package:eport/app/bindings/home_bindings.dart';
import 'package:eport/app/presentation/view/home_page.dart';
import 'package:eport/app/presentation/view/splash_page.dart';
import 'package:eport/routes/app_route.dart';

List<GetPage<dynamic>> appPage() {
  return <GetPage<dynamic>>[
    GetPage(
      name: AppRoute.splash,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoute.onboardExternal,
      page: () => Onboard.external(),
    ),
    GetPage(
      name: AppRoute.onboardInternal,
      page: () => Onboard.internal(),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoute.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.register,
      page: () => RegisterPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.notification,
      page: () => NotificationPage(),
    ),
    GetPage(
      name: AppRoute.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
