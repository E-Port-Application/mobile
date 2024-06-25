import 'dart:io';

import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/app/repository/laporan_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:eport/utils/form_converter.dart';
import 'package:eport/utils/get_id.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPklController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<Offset> pklOffset = Rx<Offset>(Offset.zero);
  RxBool showPkl = false.obs;
  RxnString selectedPkl = RxnString();
  RxList<LaporanTypeModel> jenisPkl = <LaporanTypeModel>[].obs;

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
    "updated-at": TextEditingController(
      text: DateTime.now().toString(),
    ),
  }.obs;

  RxList<PersonilModel> personils = RxList<PersonilModel>();

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

  String? nikValidator(String? e) {
    if (e == null || e.isEmpty) {
      return "NIK tidak boleh kosong";
    }
    if (e.length != 16) {
      return "NIK tidak valid";
    }
    return null;
  }

  Rxn<PklModel> data = Rxn<PklModel>(null);
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
      form['alamat-pelanggar']!.text = pklData.alamatPelanggar ?? "";
      imageUrl.value = pklData.image;
      jenisKelamin.value = pklData.jenisKelamin;
      personils.value = pklData.personils ?? [];
    } catch (_) {}
  }

  RxnString jenisKelamin = RxnString();

  @override
  void onInit() {
    super.onInit();
    getJenisPkl();
    getTindakanPkl();
    getPelanggaranPkl();
    getData();
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
    Get.back();
  }

  RxBool isLoading = true.obs;
  void submit() async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        showLoadingDialog(Get.context!, isLoading);

        final formJson = formConverter(form);
        formJson['id'] = data.value!.id;
        final pklRef = store.collection("pkl").doc(data.value!.id);
        final laporanRef = store.collection("laporan").doc(data.value!.id);
        formJson['nik-pelanggar'] = formJson['nik-pelanggar'].toString();
        formJson['alamat-pelanggar'] = formJson['alamat-pelanggar'].toString();
        formJson['nama-pelanggar'] = formJson['nama-pelanggar'].toString();
        formJson['keterangan'] = formJson['keterangan'].toString();

        if (image.value != null) {
          var splittedFile = image.value!.path.split(".");
          final pklStorage = storage.child("laporan/pkl");
          String fileName = "${data.value!.id}.${splittedFile.last}";
          final photo = pklStorage.child(fileName);
          await photo.putFile(
            image.value!,
            SettableMetadata(
              contentType: "image/${splittedFile.last}",
            ),
          );
          final imageUrl = {"image": await photo.getDownloadURL()};
          await pklRef.update(imageUrl);
        }
        await laporanRef.update({"progress": false});
        await pklRef.update(formJson);

        await closeLoading(isLoading);
        showAlert("Berhasil membuat Laporan PKL", isSuccess: true);
        LaporanController.i.getData();
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
  }

  Rxn<File> image = Rxn<File>();
  RxnString imageUrl = RxnString();

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
    if (imageUrl.value != null) {
      imageUrl.value = null;
      return;
    }
    image.value = null;
  }
}
