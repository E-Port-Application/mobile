import 'package:eport/app/controller/laporan_controller.dart';
import 'package:get/get.dart';

class PengajuanController extends GetxController {
  static PengajuanController get i => Get.find<PengajuanController>();

  @override
  void onReady() {
    super.onReady();
    LaporanController.i.current.value = 0;
  }
}
