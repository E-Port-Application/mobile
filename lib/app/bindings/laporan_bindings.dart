import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/pengajuan_controller.dart';
import 'package:eport/app/controller/perkada_page_controller.dart';
import 'package:eport/app/controller/proses_controller.dart';
import 'package:get/get.dart';

class LaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LaporanController>(LaporanController());
    Get.lazyPut<PengajuanController>(() => PengajuanController());
    Get.lazyPut<ProsesController>(() => ProsesController());

    // Tibum
    Get.lazyPut<PerkadaController>(() => PerkadaController());
  }
}
