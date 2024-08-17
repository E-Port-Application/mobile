import 'dart:io';

import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/app/controller/external/laporan_controller.dart';
import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/masyarakat_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MasyarakatController extends GetxController {
  static MasyarakatController get i => Get.find<MasyarakatController>();
  Rx<LaporanType> type = LaporanType.create.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool showKeluhan = false.obs;
  RxnString selectedKeluhan = RxnString();
  RxList<LaporanTypeModel> jenisKeluhan = <LaporanTypeModel>[].obs;

  RxMap<String, TextEditingController> form = {
    "location": TextEditingController(text: CacheController.i.address.value),
    "tanggal": TextEditingController(),
    "nama": TextEditingController(),
    "nik": TextEditingController(),
    "keluhan": TextEditingController(),
    "keterangan": TextEditingController(),
    "status": TextEditingController(text: "0"),
    "uid": TextEditingController(text: GlobalController.i.user.value!.uid),
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  @override
  void onInit() {
    super.onInit();
    getJenisKeluhan();
  }

  String? nikValidator(String? e) {
    if ((e == null || e.isEmpty) && type.value == LaporanType.create) {
      return null;
    }
    if ((e == null || e.isEmpty) && type.value == LaporanType.update) {
      return "NIK tidak boleh kosong";
    }

    if ((e ?? "").length != 16) {
      return "NIK tidak valid";
    }
    return null;
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

  void getJenisKeluhan() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/masyarakat/jenis");
      jenisKeluhan.value = data;
      jenisKeluhan.refresh();
    } catch (_) {}
  }

  void handleSaveMenu<T>(T val, Rx<T> selected, RxBool show,
      List<RadioProps<T>> options, String formKey) {
    selected.value = val;
    show.value = false;
    var selectedValue = options.firstWhereOrNull((e) => e.value == val);
    if (selectedValue != null) {
      form[formKey]!.text = selectedValue.label;
    }
  }

  RxBool isLoading = false.obs;
  void submit() {
    if (formKey.currentState!.validate()) {
      if (type.value == LaporanType.create) {
        MasyarakatRepository.create(
          isLoading,
          formKey,
          form,
          image.value!,
          ["nik"],
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    LaporanExternalController.i.current.value = 0;
  }
}
