import 'package:eport/app/controller/laporan_controller.dart';
import 'package:get/get.dart';

class ProsesController extends GetxController {
  static ProsesController get i => Get.find<ProsesController>();

  @override
  void onReady() {
    super.onReady();
    LaporanController.i.current.value = 1;
  }
}
