import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eport/app/bindings/global_bindings.dart';
import 'package:eport/routes/app_page.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/utils/app_token.dart';
import 'package:eport/utils/global_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    name: "e-port-application",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
          child: Portal(
            child: FutureBuilder(
              future: UserToken.checkToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GetMaterialApp(
                    initialBinding: GlobalBinding(),
                    title: dotenv.env['PROJECT_NAME']!,
                    theme: globalTheme(),
                    getPages: appPage(),
                    initialRoute: AppRoute.splash,
                    // initialRoute: snapshot.data ?? false
                    //     ? AppRoute.home
                    //     : AppRoute.splash,
                    builder: (context, child) {
                      return MediaQuery(
                        data:
                            MediaQuery.of(context).copyWith(textScaleFactor: 1),
                        child: child ?? Container(),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        );
      }),
    );
  }
}
