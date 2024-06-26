import 'dart:io';

import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/reklame/reklame_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/form_converter.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReklameController extends GetxController {
  static ReklameController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "nama": TextEditingController(),
    "jenis": TextEditingController(),
    "pelanggaran": TextEditingController(),
    "jumlah": TextEditingController(),
    "tindakan": TextEditingController(),
    "keterangan": TextEditingController(),
  }.obs;

  RxBool showJenis = false.obs;
  RxList<LaporanTypeModel> jenis = <LaporanTypeModel>[].obs;
  RxnString selectedJenis = RxnString();

  RxBool showPelanggaran = false.obs;
  RxList<LaporanTypeModel> pelanggaran = <LaporanTypeModel>[].obs;
  RxnString selectedPelanggaran = RxnString();

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  void handleSaveMenu<T>(T val, Rx<T> selected, RxBool show,
      List<RadioProps<T>> options, String formKey) {
    selected.value = val;
    show.value = false;
    var selectedValue = options.firstWhereOrNull((e) => e.value == val);
    if (selectedValue != null) {
      form[formKey]!.text = selectedValue.label;
    }
  }

  void getJenisReklame() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/reklame/jenis");
      jenis.value = data;
      jenis.refresh();
    } catch (_) {}
  }

  void getPelanggaranReklame() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/reklame/pelanggaran");
      pelanggaran.value = data;
      pelanggaran.refresh();
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getJenisReklame();
    getPelanggaranReklame();
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

  RxBool isLoading = true.obs;
  void submit() async {
    try {
      if (formKey.currentState!.validate()) {
        showLoadingDialog(Get.context!, isLoading);
        final formJson = formConverter(form);
        List<PersonilModel> personils = <PersonilModel>[];

        for (var personil in this.personils) {
          personils.add(personil);
        }

        formJson['personils'] = personils.map((e) => e.toJson()).toList();
        formJson['id'] = "dummy-id";

        final data = ReklameModel.fromJson(formJson);

        final dataRef = store.collection("reklame");
        final laporanRef = store.collection("laporan");
        var storedData = await dataRef.add(data.toJson());

        if (image.value != null) {
          var splittedFile = image.value!.path.split(".");
          final pklStorage = storage.child("laporan/reklame");
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
        var updateId = {"id": storedData.id};
        await storedData.update(updateId);

        final laporanData = LaporanModel(
                id: storedData.id,
                type: "reklame",
                progress: true,
                data: null,
                date: data.tanggal)
            .toJson();

        await laporanRef.doc(storedData.id).set(laporanData);

        await closeLoading(isLoading);
        await Future.delayed(Duration(milliseconds: 200));
        showAlert("Berhasil membaut rencana kegiatan", isSuccess: true);
        LaporanController.i.getData();
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
  }
}
