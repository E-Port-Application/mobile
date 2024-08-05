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

  // Laporan Progress
  static String laporanPkl(String id) => "/laporan/kegiatan/pkl/$id";
  static String laporanReklame(String id) => "/laporan/kegiatan/reklame/$id";
  static String laporanKransos(String id) => "/laporan/kegiatan/kransos/$id";
  static String laporanPengamanan(String id) =>
      "/laporan/kegiatan/pengamanan/$id";
  static String laporanPerizinan(String id) =>
      "/laporan/kegiatan/perizinan/$id";
  static String laporanPamwal(String id) => "/laporan/kegiatan/pamwal/$id";
  static String laporanPiket(String id) => "/laporan/kegiatan/piket/$id";
  static String laporanPersonil(String id) => "/laporan/kegiatan/personil/$id";

  // Riwayat
  static String riwayatPkl(String id) => "/laporan/riwayat/pkl/$id";
  static String riwayatReklame(String id) => "/laporan/riwayat/reklame/$id";
  static String riwayatPersonil(String id) => "/laporan/riwayat/personil/$id";
  static String riwayatKransos(String id) => "/laporan/riwayat/kransos/$id";
  static String riwayatPengamanan(String id) =>
      "/laporan/riwayat/pengamanan/$id";
  static String riwayatPamwal(String id) => "/laporan/riwayat/pamwal/$id";
  static String riwayatPerizinan(String id) => "/laporan/riwayat/perizinan/$id";
  static String riwayatPiket(String id) => "/laporan/riwayat/piket/$id";

  static String reportExternal = "/external/laporan";
}
