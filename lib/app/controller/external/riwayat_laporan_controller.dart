import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:get/get.dart';

class RiwayatLaporanController extends GetxController {
  static RiwayatLaporanController get i => Get.find<RiwayatLaporanController>();
  RxList<LaporanExternalModel> datas = RxList<LaporanExternalModel>();
  RxBool isLoading = false.obs;

  void onReset() {
    LaporanExternalController.i.selectedRiwayat.value = null;
    LaporanExternalController.i.startDateRiwayat.value = null;
    LaporanExternalController.i.endDateRiwayat.value = null;
  }

  void onActivity(ActivityModel data) {
    LaporanExternalController.i.selectedRiwayat.value = data;
  }

  void onDate(List<DateTime?> data) {
    LaporanExternalController.i.startDateRiwayat.value = data[0];
    LaporanExternalController.i.endDateRiwayat.value = data[1];
  }

  void getData() async {
    try {
      LaporanExternalController.i.getRiwayatData();
      LaporanExternalController.i.riwayatData.listen((p0) {
        datas.value = p0;
        datas.refresh();
      });
      isLoading.value = LaporanExternalController.i.loadingRiwayatData.value;
      LaporanExternalController.i.loadingRiwayatData.listen((p0) {
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
    LaporanExternalController.i.current.value = 1;
  }
}
