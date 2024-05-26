import 'package:eport/app/controller/notification_controller.dart';
import 'package:get/get.dart';
import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/app/controller/global_controller.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController());
    Get.put<CacheController>(CacheController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
