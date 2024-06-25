import 'package:eport/app/controller/personil/riwayat_personil_controller.dart';
import 'package:eport/app/controller/pkl/riwayat_pkl_controller.dart';
import 'package:get/get.dart';

class RiwayatLaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPklController>(() => RiwayatPklController());
    Get.lazyPut<RiwayatPersonilController>(() => RiwayatPersonilController());
  }
}
