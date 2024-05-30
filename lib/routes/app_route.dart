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
  static String reportPengajuan = "/laporan/pengajuan";
  static String reportProses = "/laporan/proses";
  static String reportPenindakan = "/laporan/penindakan";
  static String reportSelesai = "/laporan/selesai";

  // Tibum
  static String perdaPerkada = "/laporan/perda-perkada";
  static String perdaPerkadaDetail(String id) => "/laporan/perda-perkada/$id";
  static String perdaPerwali = "/laporan/perda-perwali";
  static String perdaPerwaliDetail(String id) => "/laporan/perda-perwali/$id";
  static String laporanPti = "/laporan/pti";
  static String laporanPtiDetail(String id) => "/laporan/pti/$id";
  static String laporanPamin = "/laporan/pam-in";
  static String laporanPaminDetail(String id) => "/laporan/pam-in/$id";
}
