class AppRoute {
  static String splash = "/splash";
  static String onboardInternal = "/internal/onboard";
  static String onboardExternal = "/external/onboard";

  // Auth
  static String loginInternal = "/internal/login";
  static String loginExternal = "/external/login";
  static String forgetPassword = "/forget-password";
  static String forgetPasswordSuccess = "/forget-password/success";

  static String registerInternal = "/internal/register";
  static String registerExternal = "/external/register";
  static String registerAddPhone = "/register/add-phone";
  static String registerVerifyEmail = "/register/verify-email";
  static String registerSuccess = "/register/success";

  static String home = "/home";
  static String notification = "/notification";
  static String profile = "/profile";

  static String report = "/laporan";
  static String reportRencana = "/laporan/rencana";
  static String reportProses = "/laporan/proses";
  static String reportPenindakan = "/laporan/penindakan";
  static String reportSelesai = "/laporan/selesai";
  static String reportRiwayat = "/laporan/riwayat";

  static String rencanaPatroliPkl = "/laporan/rencana/patroli/pkl";
  static String rencanaPatroliReklame = "/laporan/rencana/patroli/reklame";
  static String rencanaPatroliKransos = "/laporan/rencana/patroli/kransos";
  static String rencanaPatroliPengamanan =
      "/laporan/rencana/patroli/pengamanan";
  static String rencanaPatroliPamwal = "/laporan/rencana/patroli/pamwal";
  static String rencanaPatroliPerizinan = "/laporan/rencana/patroli/perizinan";
  static String rencanaPatroliPiket = "/laporan/rencana/patroli/piket";

  static String personil = "/laporan/rencana/patroli/pkl/personil";

  static String laporanPkl(String id) => "/laporan/kegiatan/pkl/$id";
  static String laporanReklame(String id) => "/laporan/kegiatan/reklame/$id";
}
