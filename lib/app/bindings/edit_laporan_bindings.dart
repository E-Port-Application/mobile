import 'package:eport/app/controller/edit_pkl_controller.dart';
import 'package:get/get.dart';

class EditLaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPklController>(() => EditPklController());
  }
}
