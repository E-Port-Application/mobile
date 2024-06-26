import 'dart:io';

import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/reklame/reklame_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ReklameController extends GetxController {
  static ReklameController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isEdit = false.obs;
  RxBool isRiwayat = false.obs;
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

  Rxn<ReklameModel> data = Rxn<ReklameModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final reklameData = await LaporanRepository.getReklameDetail(getId());
      data.value = reklameData;
      form['tanggal']!.text = dateFormat.format(reklameData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(reklameData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(reklameData.waktuSelesai);
      form['nama']!.text = reklameData.nama ?? "";
      form['jenis']!.text = reklameData.jenis ?? "";
      form['pelanggaran']!.text = reklameData.pelanggaran ?? "";
      form['jumlah']!.text = (reklameData.jumlah ?? "").toString();
      form['tindakan']!.text = reklameData.tindakan ?? "";
      form['keterangan']!.text = reklameData.keterangan ?? "";
      imageUrl.value = reklameData.image;
      personils.value = reklameData.personils ?? [];
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    isEdit.value = Get.currentRoute.contains("/laporan/kegiatan/reklame");
    isRiwayat.value = Get.currentRoute.contains("/laporan/riwayat/reklame");
    if (isEdit.value || isRiwayat.value) {
      getData();
    }
    getJenisReklame();
    getPelanggaranReklame();
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

  RxBool isLoading = true.obs;
  void submit() async {
    isLoading.value = true;
    if (isRiwayat.value) {
      return;
    }
    if (isEdit.value) {
      LaporanRepository.update(
        data.value!.id,
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "reklame",
        ["nama", "tindakan", "keterangan"],
      );
    } else {
      LaporanRepository.create(
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "reklame",
        ["nama", "tindakan", "keterangan"],
      );
    }
  }
}
