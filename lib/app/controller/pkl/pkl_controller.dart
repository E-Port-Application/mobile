import 'dart:io';

import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/app/repository/pelanggar_repository.dart';
import 'package:eport/app/types/laporan_type.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PklController extends GetxController {
  static PklController get i => Get.find<PklController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<LaporanType> type = LaporanType.create.obs;

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

  RxString namaPelanggar = "".obs;
  RxString nikPelanggar = "".obs;

  RxInt jumlahNama = 0.obs;
  RxInt jumlahNik = 0.obs;

  void addListenerPelanggar() async {
    form["nama-pelanggar"]!.addListener(() {
      final namaPelanggar = form["nama-pelanggar"]!.text;
      if (namaPelanggar == "") {
        jumlahNama.value = 0;
      } else {
        PelanggarRepository.name(namaPelanggar).then((value) {
          jumlahNama.value = value;
        });
      }
    });
    form["nik-pelanggar"]!.addListener(() {
      final nikPelanggar = form["nik-pelanggar"]!.text;
      if (nikPelanggar == "") {
        jumlahNik.value = 0;
      } else {
        PelanggarRepository.nik(nikPelanggar).then((value) {
          jumlahNik.value = value;
        });
      }
    });
  }

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

  Rxn<PklModel> data = Rxn<PklModel>();
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();

  void getData() async {
    try {
      final pklData = await LaporanRepository.getPklDetail(getId());
      data.value = pklData;
      form['tanggal']!.text = dateFormat.format(pklData.tanggal);
      form['waktu-mulai']!.text = timeFormat.format(pklData.waktuMulai);
      form['waktu-selesai']!.text = timeFormat.format(pklData.waktuSelesai);
      form['jenis']!.text = pklData.jenis ?? "";
      form['pelanggaran']!.text = pklData.pelanggaran ?? "";
      form['tindakan']!.text = pklData.tindakan ?? "";
      form['jumlah-pelanggar']!.text =
          (pklData.jumlahPelanggar ?? "").toString();
      form['keterangan']!.text = pklData.keterangan ?? "";
      form['nama-pelanggar']!.text = pklData.namaPelanggar ?? "";
      form['nik-pelanggar']!.text = pklData.nikPelanggar ?? "";
      form['jenis-kelamin']!.text = pklData.jenisKelamin ?? "";
      form['location']!.text = pklData.location;
      form['alamat-pelanggar']!.text = pklData.alamatPelanggar ?? "";
      form['updated-at']!.text = DateTime.now().toString();
      jenisKelamin.value = pklData.jenisKelamin;
      imageUrl.value = pklData.image;
      personils.value = pklData.personils ?? [];
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.currentRoute.contains("/laporan/rencana/patroli/pkl")) {
      type.value = LaporanType.create;
    } else if (Get.currentRoute.contains("/laporan/kegiatan/pkl")) {
      type.value = LaporanType.update;
    } else {
      type.value = LaporanType.history;
    }
    if (type.value != LaporanType.create) {
      getData();
    }
    getJenisPkl();
    getTindakanPkl();
    getPelanggaranPkl();
    addListenerPelanggar();
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
    if (type.value == LaporanType.create) {
      if (formPhase.value == 1) {
        Get.back();
        return;
      }
      formPhase.value = 1;
    } else {
      Get.back();
    }
  }

  RxBool isLoading = true.obs;
  void submit() async {
    if (type.value == LaporanType.history) {
      LaporanRepository.pdf("pkl", getId(), isLoading)
          .then((value) {})
          .catchError((_) {});
      return;
    }
    if (type.value == LaporanType.create) {
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
    } else {
      LaporanRepository.update(
        data.value!.id,
        isLoading,
        formKey,
        form,
        personils,
        image.value,
        "pkl",
        ['nik-pelanggar', 'alamat-pelanggar', 'nama-pelanggar', 'keterangan'],
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
}
