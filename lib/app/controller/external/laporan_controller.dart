import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/common/menu/laporan_menu_model.dart';
import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:eport/app/repository/masyarakat_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanExternalController extends GetxController {
  static LaporanExternalController get i =>
      Get.find<LaporanExternalController>();

  RxList<LaporanMenuModel> menu = RxList<LaporanMenuModel>([]);
  RxInt current = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  RxList<ActivityModel> activities = RxList<ActivityModel>([
    ActivityModel(
      label: "Pencurian",
      id: "Pencurian",
    ),
    ActivityModel(
      label: "Anjal",
      id: "Anjal",
    ),
    ActivityModel(
      label: "Orang Gila",
      id: "Orang Gila",
    ),
    ActivityModel(
      label: "Orang Hilang",
      id: "Orang Hilang",
    ),
    ActivityModel(
      label: "Pengemis",
      id: "Pengemis",
    ),
    ActivityModel(
      label: "Bullying/Perundungan",
      id: "Bullying/Perundungan",
    ),
    ActivityModel(
      label: "Sampah",
      id: "Sampah",
    ),
    ActivityModel(
      label: "Miras",
      id: "Miras",
    ),
    ActivityModel(
      label: "Kebisingan",
      id: "Kebisingan",
    ),
    ActivityModel(
      label: "Keramaian",
      id: "Keramaian",
    ),
    ActivityModel(
      label: "Bencana Alam",
      id: "Bencana Alam",
    ),
    ActivityModel(
      label: "Perkelahian",
      id: "Perkelahian",
    ),
    ActivityModel(
      label: "Pembegalan",
      id: "Pembegalan",
    ),
    ActivityModel(
      label: "Pelecehan",
      id: "Pelecehan",
    ),
  ]);

  Rxn<ActivityModel> selectedRiwayat = Rxn<ActivityModel>();
  Rxn<DateTime> startDateRiwayat = Rxn<DateTime>();
  Rxn<DateTime> endDateRiwayat = Rxn<DateTime>();

  RxList<LaporanExternalModel> riwayatData = RxList<LaporanExternalModel>();
  RxBool loadingRiwayatData = true.obs;

  void getMenu() async {
    menu.value = await convertJson<LaporanMenuModel>(
      "assets/data/menu_laporan_external.json",
    );
    menu.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
    getData();
  }

  String buttonText(LaporanType type, {bool isPkl = false}) {
    switch (type) {
      case LaporanType.create:
        return "Buat Laporan";
      case LaporanType.update:
        return "Verifikasi Laporan";
      default:
        return "Unduh Laporan Kegiatan";
    }
  }

  String cancelText(LaporanType type) {
    switch (type) {
      case LaporanType.create:
        return "Batal";
      default:
        return "Kembali";
    }
  }

  void getRiwayatData() {
    loadingRiwayatData.value = true;
    final type = selectedRiwayat.value?.id;
    MasyarakatRepository.getAll(type: type).then((value) async {
      riwayatData.value = value;
      loadingRiwayatData.value = false;
    }).catchError((_) {
      loadingRiwayatData.value = false;
    });
  }

  void getData() async {
    try {
      everAll([startDateRiwayat, endDateRiwayat, selectedRiwayat], (_) {
        getRiwayatData();
      });
      getRiwayatData();
    } catch (_) {}
  }
}
