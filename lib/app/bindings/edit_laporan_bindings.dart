import 'package:eport/app/controller/personil/edit_personil_controller.dart';
import 'package:eport/app/controller/pkl/edit_pkl_controller.dart';
import 'package:get/get.dart';

class EditLaporanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPklController>(() => EditPklController());
    Get.lazyPut<EditPersonilController>(() => EditPersonilController());
  }
}
