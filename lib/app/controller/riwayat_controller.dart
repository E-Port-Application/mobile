import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  static RiwayatController get i => Get.find<RiwayatController>();
  RxList<ActivityModel> activities = RxList([]);
  Rxn<ActivityModel> selectedActivity = Rxn<ActivityModel>();
  RxList<LaporanModel> datas = RxList<LaporanModel>();
  RxBool isLoading = true.obs;

  void getData() async {
    try {
      LaporanController.i.getData();
      LaporanController.i.riwayatData.listen((p0) {
        datas.value = p0;
        datas.refresh();
      });
      isLoading.value = LaporanController.i.loadingRiwayatData.value;
      LaporanController.i.loadingRiwayatData.listen((p0) {
        isLoading.value = p0;
      });
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    activities.value = LaporanController.i.activities;
    getData();
  }

  void onReset() {
    LaporanController.i.selectedRiwayat.value = null;
    LaporanController.i.startDateRiwayat.value = null;
    LaporanController.i.endDateRiwayat.value = null;
  }

  void onActivity(ActivityModel data) {
    LaporanController.i.selectedRiwayat.value = data;
  }

  void onDate(List<DateTime?> data) {
    LaporanController.i.startDateRiwayat.value = data[0];
    LaporanController.i.endDateRiwayat.value = data[1];
  }
}
