import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/controller/external/laporan_masuk_controller.dart';
import 'package:eport/app/controller/external/masyarakat_controller.dart';
import 'package:eport/app/controller/external/masyarakat_detail_controller.dart';
import 'package:eport/app/controller/external/riwayat_laporan_controller.dart';
import 'package:get/get.dart';

class LaporanExternalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LaporanExternalController>(LaporanExternalController());
    Get.lazyPut<RiwayatLaporanController>(() => RiwayatLaporanController());
    Get.lazyPut<LaporanMasukController>(() => LaporanMasukController());
    Get.lazyPut<MasyarakatController>(() => MasyarakatController());
    Get.lazyPut<MasyarakatDetailController>(() => MasyarakatDetailController());
  }
}
