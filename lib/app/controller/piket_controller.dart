import 'dart:io';

import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/piket/piket_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/piket_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PiketController extends GetxController {
  static PiketController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<LaporanType> type = LaporanType.create.obs;

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "shift": TextEditingController(),
    "lokasi": TextEditingController(),
    "tindakan": TextEditingController(),
    "keterangan": TextEditingController(),
    "location": TextEditingController(),
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxBool showShift = false.obs;
  RxList<LaporanTypeModel> shift = <LaporanTypeModel>[].obs;
  RxnString selectedShift = RxnString();

  RxBool showLokasi = false.obs;
  RxList<LaporanTypeModel> lokasi = <LaporanTypeModel>[].obs;
  RxnString selectedLokasi = RxnString();

  void handleSaveMenu<T>(T val, Rx<T> selected, RxBool show,
      List<RadioProps<T>> options, String formKey) {
    selected.value = val;
    show.value = false;
    var selectedValue = options.firstWhereOrNull((e) => e.value == val);
    if (selectedValue != null) {
      form[formKey]!.text = selectedValue.label;
    }
  }

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  Rxn<PiketModel> data = Rxn<PiketModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final tempData = await PiketRepository.getDetail(getId());
      data.value = tempData;
      form['tanggal']!.text = dateFormat.format(tempData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(tempData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(tempData.waktuSelesai);
      form['keterangan']!.text = tempData.keterangan ?? "";
      form['shift']!.text = tempData.shift ?? "";
      form['lokasi']!.text = tempData.lokasi ?? "";
      form['tindakan']!.text = tempData.tindakan ?? "";
      form['location']!.text = tempData.location;
      form['updated-at']!.text = DateTime.now().toString();

      imageUrl.value = tempData.image;
      personils.value = tempData.personils ?? [];
    } catch (_) {}
  }

  RxBool isLoading = true.obs;
  void submit() async {
    isLoading.value = true;
    if (type.value == LaporanType.history) {
      return;
    }
    if (type.value == LaporanType.update) {
      LaporanRepository.update(
        data.value!.id,
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "piket",
        ["shift", "lokasi", "tindakan" "keterangan"],
      );
    } else {
      LaporanRepository.create(
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "piket",
        ["shift", "lokasi", "tindakan" "keterangan"],
      );
    }
  }

  RxnString imageUrl = RxnString();
  Rxn<File> image = Rxn<File>();

  void uploadPhoto({bool isCamera = false}) async {
    try {
      if (isCamera) {
        final ImagePicker picker = ImagePicker();
        final file = await picker.pickImage(source: ImageSource.camera);
        if (file == null) {
          return;
        }
        image.value = File(file.path);
      } else {
        final file = await pickFile(extensions: ['jpg', 'png', 'jpeg']);
        if (file == null) {
          return;
        }
        image.value = file;
      }
    } catch (err) {
      showAlert(err.toString());
    }
  }

  void removePhoto() {
    image.value = null;
  }

  void getShift() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/piket/shift");
      shift.value = data;
      shift.refresh();
    } catch (_) {}
  }

  void getLokasi() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/piket/lokasi");
      lokasi.value = data;
      lokasi.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getShift();
    getLokasi();
    if (Get.currentRoute.contains("/laporan/kegiatan/piket")) {
      type.value = LaporanType.update;
    } else if (Get.currentRoute.contains("/laporan/riwayat/piket")) {
      type.value = LaporanType.history;
    }

    if (type.value != LaporanType.create) {
      getData();
    }
  }
}
