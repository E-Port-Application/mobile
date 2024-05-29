import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/controller/pengajuan_controller.dart';
import 'package:get/get.dart';

class LaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanController>(() => LaporanController());
    Get.lazyPut<PengajuanController>(() => PengajuanController());
  }
}
