import 'dart:io';

import 'package:eport/app/models/db/kransos/kransos_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/kransos_repository.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class KransosController extends GetxController {
  static KransosController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<LaporanType> type = LaporanType.create.obs;

  RxMap<String, TextEditingController> form = {
    "tanggal": TextEditingController(),
    "waktu-mulai": TextEditingController(),
    "waktu-selesai": TextEditingController(),
    "jenis": TextEditingController(),
    "deskripsi-pelanggaran": TextEditingController(),
    "tindakan-pelanggaran": TextEditingController(),
    "jumlah-pelanggar": TextEditingController(),
    "keterangan": TextEditingController(),
    "created-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxBool showJenis = false.obs;
  RxList<LaporanTypeModel> jenis = <LaporanTypeModel>[].obs;
  RxnString selectedJenis = RxnString();

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

  void getJenisKeransos() async {
    try {
      var data = await LaporanRepository.getSearchData(
          "rencana-laporan/keransos/jenis");
      jenis.value = data;
      jenis.refresh();
    } catch (_) {}
  }

  Rxn<KransosModel> data = Rxn<KransosModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final tempData = await KransosRepository.getDetail(getId());
      data.value = tempData;
      form['tanggal']!.text = dateFormat.format(tempData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(tempData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(tempData.waktuSelesai);
      form['jenis']!.text = tempData.jenis ?? "";
      form['deskripsi-pelanggaran']!.text = tempData.deskripsi ?? "";
      form['tindakan-pelanggaran']!.text = tempData.tindakan ?? "";
      form['keterangan']!.text = tempData.keterangan ?? "";
      form['jumlah-pelanggar']!.text = (tempData.jumlah ?? "").toString();
      form['updated-at']!.text = DateTime.now().toString();
      imageUrl.value = tempData.image;
      personils.value = tempData.personils ?? [];
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getJenisKeransos();
    if (Get.currentRoute.contains("/laporan/kegiatan/kransos")) {
      type.value = LaporanType.update;
    } else if (Get.currentRoute.contains("/laporan/riwayat/kransos")) {
      type.value = LaporanType.history;
    }

    if (type.value != LaporanType.create) {
      getData();
    }
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
        "kransos",
        ["deskripsi-pelanggaran", "tindakan-pelanggaran", "keterangan"],
      );
    } else {
      LaporanRepository.create(
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "kransos",
        ["deskripsi-pelanggaran", "tindakan-pelanggaran", "keterangan"],
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
}
