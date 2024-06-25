import 'package:eport/app/controller/personil/personil_controller.dart';
import 'package:eport/app/controller/pkl/pkl_controller.dart';
import 'package:get/get.dart';

class PklBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PklController>(() => PklController());
    Get.lazyPut<PersonilController>(() => PersonilController());
  }
}
