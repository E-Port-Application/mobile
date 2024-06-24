import 'dart:io';

import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/form_converter.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxnString jenisKelamin = RxnString();

  RxList<Personil> personils = RxList<Personil>();
  RxList<Rx<Personil>> currentPersonil = RxList<Rx<Personil>>();

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

  void cancel() {
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
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        showLoadingDialog(Get.context!, isLoading);
        isLoading.value = true;
        final formJson = formConverter(form);
        List<String> personils = <String>[];
        for (var personil in this.personils) {
          personils.add(personil.name);
        }
        formJson['personils'] = personils;

        final data = PklModel.fromJson(formJson);

        final pklRef = store.collection("pkl");
        final laporanRef = store.collection("laporan");
        var storedData = await pklRef.add(data.toJson());

        if (image.value != null) {
          var splittedFile = image.value!.path.split(".");
          final pklStorage = storage.child("laporan/pkl");
          String fileName = "${storedData.id}.${splittedFile.last}";
          final photo = pklStorage.child(fileName);
          await photo.putFile(
            image.value!,
            SettableMetadata(
              contentType: "image/${splittedFile.last}",
            ),
          );
          final imageUrl = await photo.getDownloadURL();
          formJson['image'] = imageUrl;
          await storedData.set(formJson);
        }

        final laporanData = LaporanModel(
                id: storedData.id,
                type: "pkl",
                progress: true,
                data: null,
                date: data.tanggal)
            .toJson();

        await laporanRef.doc(storedData.id).set(laporanData);

        await closeLoading(isLoading);
        showAlert("Berhasil membaut Laporan PKL", isSuccess: true);
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
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
