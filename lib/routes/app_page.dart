import 'package:eport/app/bindings/auth_bindings.dart';
import 'package:eport/app/bindings/laporan_bindings.dart';
import 'package:eport/app/bindings/profile_bindings.dart';
import 'package:eport/app/controller/piket_page.dart';
import 'package:eport/app/presentation/view/personil/edit_personil_page.dart';
import 'package:eport/app/presentation/view/personil/riwayat_personil_page.dart';
import 'package:eport/app/presentation/view/pkl/edit_pkl_page.dart';
import 'package:eport/app/presentation/view/kransos_page.dart';
import 'package:eport/app/presentation/view/laporan_page.dart';
import 'package:eport/app/presentation/view/notification_page.dart';
import 'package:eport/app/presentation/view/pengamanan_page.dart';
import 'package:eport/app/presentation/view/perizinan_page.dart';
import 'package:eport/app/presentation/view/personil/personil_page.dart';
import 'package:eport/app/presentation/view/pkl/pkl_page.dart';
import 'package:eport/app/presentation/view/pkl/riwayat_pkl_page.dart';
import 'package:eport/app/presentation/view/reklame_page.dart';
import 'package:eport/app/presentation/view/rencana_page.dart';
import 'package:eport/app/presentation/view/profile_page.dart';
import 'package:eport/app/presentation/view/proses_page.dart';
import 'package:eport/app/presentation/view/riwayat_page.dart';
import 'package:eport/app/presentation/view/variant.dart';
import 'package:flutter_portal/flutter_portal.dart';
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
      name: AppRoute.loginInternal,
      page: () => Login.internal(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.loginExternal,
      page: () => Login.external(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.registerInternal,
      page: () => Register.internal(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoute.registerExternal,
      page: () => Register.external(),
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
    GetPage(
      name: AppRoute.reportRencana,
      page: () => RencanaPage(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.reportProses,
      page: () => ProsesPage(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.report,
      page: () => LaporanPage(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.reportRiwayat,
      page: () => RiwayatPage(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliPkl,
      page: () => Portal(child: PklPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliReklame,
      page: () => Portal(child: ReklamePage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliKransos,
      page: () => Portal(child: KransosPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliPengamanan,
      page: () => Portal(child: PengamananPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliPamwal,
      page: () => Portal(child: PengamananPage(isPamwal: true)),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliPiket,
      page: () => Portal(child: PiketPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.rencanaPatroliPerizinan,
      page: () => Portal(child: PerizinanPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.personil,
      page: () => Portal(child: PersonilPage()),
      binding: LaporanBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
        name: AppRoute.laporanPersonil(":id"),
        page: () => Portal(
              child: EditPersonilPage(),
            ),
        binding: LaporanBinding()),
    GetPage(
      name: AppRoute.laporanPkl(":id"),
      page: () => Portal(child: EditPklPage()),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.riwayatPkl(":id"),
      page: () => Portal(
        child: RiwayatPklPage(),
      ),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoute.riwayatPersonil(":id"),
      page: () => Portal(
        child: RiwayatPersonilPage(),
      ),
      binding: LaporanBinding(),
    )
  ];
}
