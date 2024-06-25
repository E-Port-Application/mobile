import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  static RiwayatController get i => Get.find<RiwayatController>();
  RxList<ActivityModel> activities = RxList([]);
  Rxn<ActivityModel> selectedActivity = Rxn<ActivityModel>();
  RxList<LaporanModel> datas = RxList<LaporanModel>();

  void getData() async {
    try {
      datas.value = await LaporanRepository.getReportData(
        isProgress: false,
      );
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    activities.value = LaporanController.i.activities;
    getData();
  }

  void onReset() {
    selectedActivity.value = null;
  }

  void onActivity(ActivityModel data) {
    selectedActivity.value = data;
  }
}
