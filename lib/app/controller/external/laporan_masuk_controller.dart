import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:get/get.dart';

class LaporanMasukController extends GetxController {
  static LaporanMasukController get i => Get.find<LaporanMasukController>();
  RxList<LaporanExternalModel> datas = RxList<LaporanExternalModel>();
  RxBool isLoading = false.obs;

  void onReset() {
    LaporanExternalController.i.selectedMasuk.value = null;
    LaporanExternalController.i.startDateMasuk.value = null;
    LaporanExternalController.i.endDateMasuk.value = null;
  }

  void onActivity(ActivityModel data) {
    LaporanExternalController.i.selectedMasuk.value = data;
  }

  void onDate(List<DateTime?> data) {
    LaporanExternalController.i.startDateMasuk.value = data[0];
    LaporanExternalController.i.endDateMasuk.value = data[1];
  }

  void getData() async {
    try {
      LaporanExternalController.i.getMasukData();
      LaporanExternalController.i.masukData.listen((p0) {
        datas.value = p0;
        datas.refresh();
      });
      isLoading.value = LaporanExternalController.i.loadingMasukData.value;
      LaporanExternalController.i.loadingMasukData.listen((p0) {
        isLoading.value = p0;
      });
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
    LaporanExternalController.i.current.value = 0;
  }
}
