import 'dart:io';

import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PklController extends GetxController {
  static PklController get i => Get.find<PklController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<Offset> pklOffset = Rx<Offset>(Offset.zero);
  RxBool showPkl = false.obs;
  RxnString selectedPkl = RxnString();
  RxList<LaporanTypeModel> jenisPkl = <LaporanTypeModel>[].obs;

  RxInt formPhase = 1.obs;

  RxBool showTindakan = false.obs;
  RxList<LaporanTypeModel> jenisTindakan = <LaporanTypeModel>[].obs;
  RxnString selectedTindakan = RxnString();

  RxBool showPelanggaran = false.obs;
  RxList<LaporanTypeModel> jenisPelanggaran = <LaporanTypeModel>[].obs;
  RxnString selectedPelanggaran = RxnString();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "jenis": TextEditingController(),
    "pelanggaran": TextEditingController(),
    "tindakan": TextEditingController(),
    "jumlah-pelanggar": TextEditingController(),
    "keterangan": TextEditingController(),
    "nama-pelanggar": TextEditingController(),
    "nik-pelanggar": TextEditingController(),
    "jenis-kelamin": TextEditingController(),
    "alamat-pelanggar": TextEditingController(),
    "location": TextEditingController(),
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxnString jenisKelamin = RxnString();

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  void getJenisPkl() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/pkl/jenis");
      jenisPkl.value = data;
      jenisPkl.refresh();
    } catch (_) {}
  }

  void getPelanggaranPkl() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/pkl/pelanggaran");
      jenisPelanggaran.value = data;
      jenisPelanggaran.refresh();
    } catch (_) {}
  }

  void getTindakanPkl() async {
    try {
      var data =
          await LaporanRepository.getSearchData("rencana-laporan/pkl/tindakan");
      jenisTindakan.value = data;
      jenisTindakan.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getJenisPkl();
    getTindakanPkl();
    getPelanggaranPkl();
  }

  void getOffset(GlobalKey ref) {
    RenderBox box = ref.currentContext!.findRenderObject() as RenderBox;
    pklOffset.value = box.localToGlobal(Offset.zero);
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

  void cancel() async {
    if (formPhase.value == 1) {
      Get.back();
      return;
    }
    formPhase.value = 1;
  }

  RxBool isLoading = true.obs;
  void submit() async {
    if (formPhase.value == 1) {
      if (formKey.currentState!.validate()) {
        formPhase.value = 2;
      }
      return;
    }

    LaporanRepository.create(
      isLoading,
      formKey,
      form,
      personils,
      image.value,
      "pkl",
      ['nik-pelanggar', 'alamat-pelanggar', 'nama-pelanggar', 'keterangan'],
    );
  }

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
}
