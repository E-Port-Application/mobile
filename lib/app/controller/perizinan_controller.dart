import 'dart:io';

import 'package:eport/app/models/db/perizinan/perizinan_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/perizinan_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PerizinanController extends GetxController {
  static PerizinanController get i => Get.find();

  Rx<LaporanType> type = LaporanType.create.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "nama": TextEditingController(),
    "jenis": TextEditingController(),
    "pelanggaran": TextEditingController(),
    "tindakan": TextEditingController(),
    "personil": TextEditingController(),
    "keterangan": TextEditingController(),
    "location": TextEditingController(),
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  Rxn<PerizinanModel> data = Rxn<PerizinanModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final tempData = await PerizinanRepository.getDetail(getId());
      data.value = tempData;
      form['tanggal']!.text = dateFormat.format(tempData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(tempData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(tempData.waktuSelesai);
      form['nama']!.text = tempData.nama ?? "";
      form['jenis']!.text = tempData.jenis ?? "";
      form['pelanggaran']!.text = tempData.pelanggaran ?? "";
      form['tindakan']!.text = tempData.tindakan ?? "";
      form['keterangan']!.text = tempData.keterangan ?? "";
      form['updated-at']!.text = DateTime.now().toString();
      form['location']!.text = tempData.location;

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
        "perizinan",
        ["nama", "jenis", "pelanggaran", "tindakan" "keterangan"],
      );
    } else {
      LaporanRepository.create(
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "perizinan",
        ["nama", "jenis", "pelanggaran", "tindakan" "keterangan"],
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

  @override
  void onInit() {
    super.onInit();
    if (Get.currentRoute.contains("/laporan/kegiatan/perizinan")) {
      type.value = LaporanType.update;
    } else if (Get.currentRoute.contains("/laporan/riwayat/perizinan")) {
      type.value = LaporanType.history;
    }

    if (type.value != LaporanType.create) {
      getData();
    }
  }
}
