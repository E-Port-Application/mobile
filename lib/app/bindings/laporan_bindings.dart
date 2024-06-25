import 'package:eport/app/controller/kransos_controller.dart';
import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/pamwal_controller.dart';
import 'package:eport/app/controller/pengamanan_controller.dart';
import 'package:eport/app/controller/perizinan_controller.dart';
import 'package:eport/app/controller/personil/personil_controller.dart';
import 'package:eport/app/controller/piket_controller.dart';
import 'package:eport/app/controller/pkl/pkl_controller.dart';
import 'package:eport/app/controller/reklame_controller.dart';
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

    // Patroli
    Get.lazyPut<PklController>(() => PklController());
    Get.lazyPut<ReklameController>(() => ReklameController());
    Get.lazyPut<KransosController>(() => KransosController());
    Get.lazyPut<PengamananController>(() => PengamananController());
    Get.lazyPut<PiketController>(() => PiketController());
    Get.lazyPut<PerizinanController>(() => PerizinanController());

    Get.lazyPut<PersonilController>(() => PersonilController());
  }
}
