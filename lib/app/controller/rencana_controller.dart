import 'package:eport/app/controller/laporan_controller.dart';
import 'package:get/get.dart';

class RencanaController extends GetxController {
  static RencanaController get i => Get.find<RencanaController>();

  @override
  void onReady() {
    super.onReady();
    LaporanController.i.current.value = 0;
  }
}
