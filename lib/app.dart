import 'package:eport/app/bindings/global_bindings.dart';
import 'package:eport/routes/app_page.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/utils/app_token.dart';
import 'package:eport/utils/global_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: ((context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: FutureBuilder(
            future: UserToken.checkToken(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  key: navigatorKey,
                  initialBinding: GlobalBinding(),
                  title: dotenv.env['PROJECT_NAME']!,
                  theme: globalTheme(),
                  getPages: appPage(),
                  initialRoute: AppRoute.splash,
                  builder: (context, child) {
                    return Portal(
                      child: MediaQuery(
                        data:
                            MediaQuery.of(context).copyWith(textScaleFactor: 1),
                        child: child ?? Container(),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        );
      }),
    );
  }
}
