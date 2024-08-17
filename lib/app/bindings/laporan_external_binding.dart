import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/controller/external/masyarakat_controller.dart';
import 'package:eport/app/controller/external/riwayat_laporan_controller.dart';
import 'package:get/get.dart';

class LaporanExternalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanExternalController>(() => LaporanExternalController());
    Get.lazyPut<MasyarakatController>(() => MasyarakatController());
    Get.lazyPut<RiwayatLaporanController>(() => RiwayatLaporanController());
  }
}
