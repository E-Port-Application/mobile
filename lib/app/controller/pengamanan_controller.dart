import 'dart:io';

import 'package:eport/app/models/db/pengamanan/pengamanan_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/pengamanan_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/download_file.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PengamananController extends GetxController {
  static PengamananController get i => Get.find<PengamananController>();

  Rx<LaporanType> type = LaporanType.create.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "kejadian": TextEditingController(),
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

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<Rx<PersonilState>> currentPersonil = RxList<Rx<PersonilState>>();

  Rxn<PengamananModel> data = Rxn<PengamananModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final tempData = await PengamananRepository.getDetail(getId());
      data.value = tempData;
      form['tanggal']!.text = dateFormat.format(tempData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(tempData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(tempData.waktuSelesai);
      form['kejadian']!.text = tempData.kejadian ?? "";
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
      downloadFile(
          "${dotenv.env['BASE_URL']}/api/pdf/${"pengamanan"}/${data.value!.id}");
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
        "pengamanan",
        ["tindakan", "kejadian", "keterangan"],
      );
    } else {
      LaporanRepository.create(
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "pengamanan",
        ["tindakan", "kejadian", "keterangan"],
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
    if (Get.currentRoute.contains("/laporan/kegiatan/pengamanan")) {
      type.value = LaporanType.update;
    } else if (Get.currentRoute.contains("/laporan/riwayat/pengamanan")) {
      type.value = LaporanType.history;
    }

    if (type.value != LaporanType.create) {
      getData();
    }
  }
}
