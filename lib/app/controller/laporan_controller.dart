import 'package:eport/app/models/common/activity/activity_model.dart';
import 'package:eport/app/models/common/menu/laporan_menu_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanController extends GetxController {
  static LaporanController get i => Get.find<LaporanController>();
  RxList<LaporanMenuModel> menu = RxList<LaporanMenuModel>([]);
  RxInt current = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  RxList<ActivityModel> activities = RxList<ActivityModel>([
    ActivityModel(
      label: "PKL",
      id: "pkl",
    ),
    ActivityModel(
      label: "Reklame",
      id: "reklame",
    ),
    ActivityModel(
      label: "Kransos",
      id: "kransos",
    ),
    ActivityModel(
      label: "Pengamanan",
      id: "pengamanan",
    ),
    ActivityModel(
      label: "Pamwal",
      id: "pamwal",
    ),
    ActivityModel(
      label: "Perizinan",
      id: "perizinan",
    ),
    ActivityModel(
      label: "Piket",
      id: "piket",
    ),
  ]);

  // Filter
  Rxn<ActivityModel> selectedProses = Rxn<ActivityModel>();
  Rxn<DateTime> startDateProses = Rxn<DateTime>();
  Rxn<DateTime> endDateProses = Rxn<DateTime>();

  Rxn<ActivityModel> selectedRiwayat = Rxn<ActivityModel>();
  Rxn<DateTime> startDateRiwayat = Rxn<DateTime>();
  Rxn<DateTime> endDateRiwayat = Rxn<DateTime>();

  Rxn<ActivityModel> selectedPimpinan = Rxn<ActivityModel>();
  Rxn<DateTime> startDatePimpinan = Rxn<DateTime>();
  Rxn<DateTime> endDatePimpinan = Rxn<DateTime>();

  String buttonText(LaporanType type, {bool isPkl = false}) {
    switch (type) {
      case LaporanType.create:
        return "Buat Rencana Kegiatan";
      case LaporanType.update:
        return "Buat Laporan Kegiatan";
      default:
        return "Unduh Laporan Kegiatan";
    }
  }

  String cancelText(LaporanType type) {
    print("cancel text $type");
    switch (type) {
      case LaporanType.create:
        return "Batal";
      default:
        return "Kembali";
    }
  }

  String title(LaporanType type) {
    switch (type) {
      case LaporanType.create:
        return "Rencana";
      case LaporanType.update:
        return "Laporan";
      default:
        return "Riwayat";
    }
  }

  RxList<LaporanModel> prosesData = RxList<LaporanModel>();
  RxBool loadingProsesData = true.obs;
  RxList<LaporanModel> riwayatData = RxList<LaporanModel>();
  RxBool loadingRiwayatData = true.obs;
  RxList<LaporanModel> pimpinanData = RxList<LaporanModel>();
  RxBool loadingPimpinanData = true.obs;

  void getMenu() async {
    menu.value =
        await convertJson<LaporanMenuModel>("assets/data/menu_laporan.json");
  }

  void getPimpinanData() {
    loadingPimpinanData.value = true;
    LaporanRepository.getReportData(
      isProgress: false,
      startDate: startDatePimpinan.value,
      endDate: endDatePimpinan.value,
      type: selectedPimpinan.value?.id,
    ).then((value) {
      pimpinanData.value = value;
      loadingPimpinanData.value = false;
    }).catchError((_) {});
  }

  void getProsesData() {
    loadingProsesData.value = true;
    final type = selectedProses.value?.id == "laporan-masyarakat"
        ? null
        : selectedProses.value?.id;
    final externalFilter = selectedProses.value?.id == "laporan-masyarakat";
    LaporanRepository.getReportData(
      isProgress: true,
      startDate: startDateProses.value,
      endDate: endDateProses.value,
      type: type,
      externalFilter: externalFilter,
    ).then((value) {
      prosesData.value = value;
      loadingProsesData.value = false;
    }).catchError((_) {});
  }

  void getRiwayatData() {
    loadingRiwayatData.value = true;
    final type = selectedProses.value?.id == "laporan-masyarakat"
        ? null
        : selectedProses.value?.id;
    final externalFilter = selectedProses.value?.id == "laporan-masyarakat";
    LaporanRepository.getReportData(
      isProgress: false,
      startDate: startDateRiwayat.value,
      endDate: endDateRiwayat.value,
      type: type,
      externalFilter: externalFilter,
    ).then((value) {
      riwayatData.value = value;
      loadingRiwayatData.value = false;
    }).catchError((_) {});
  }

  void getData() async {
    try {
      everAll([startDateProses, endDateProses, selectedProses], (_) {
        getProsesData();
      });
      getProsesData();
      everAll([startDateRiwayat, endDateRiwayat, selectedRiwayat], (_) {
        getRiwayatData();
      });
      getRiwayatData();
      everAll([startDatePimpinan, endDatePimpinan, selectedPimpinan], (_) {
        getPimpinanData();
      });
      getPimpinanData();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
    getData();
    if (Global.role == "admin") {
      activities.add(ActivityModel(
        label: "Laporan Masyarakat",
        id: "laporan-masyarakat",
      ));
    }
  }
}
