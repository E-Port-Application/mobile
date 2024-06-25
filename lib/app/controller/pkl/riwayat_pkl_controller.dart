import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/utils/get_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatPklController extends GetxController {
  static RiwayatPklController get i => Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  Rxn<PklModel> data = Rxn<PklModel>(null);
  DateFormat dateFormat = DateFormat("dd MMMM yyyy");
  final DateFormat timeFormat = DateFormat.Hm();
  RxnString imageUrl = RxnString();
  RxList<PersonilModel> personils = RxList<PersonilModel>();

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
      form['alamat-pelanggar']!.text = pklData.alamatPelanggar ?? "";
      imageUrl.value = pklData.image;
      personils.value = pklData.personils ?? [];
    } catch (_) {}
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void submit() {}

  void cancel() {}
}
