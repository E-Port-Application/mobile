import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/pamwal_controller.dart';
import 'package:eport/app/controller/rencana_controller.dart';
import 'package:eport/app/controller/perkada_page_controller.dart';
import 'package:eport/app/controller/proses_controller.dart';
import 'package:eport/app/controller/riwayat_controller.dart';
import 'package:get/get.dart';

class LaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LaporanController>(LaporanController());
    Get.lazyPut<RencanaController>(() => RencanaController());
    Get.lazyPut<ProsesController>(() => ProsesController());
    Get.lazyPut<RiwayatController>(() => RiwayatController());

    // Tibum
    Get.lazyPut<PerkadaController>(() => PerkadaController());
    Get.lazyPut<PamwalController>(() => PamwalController());
  }
}
