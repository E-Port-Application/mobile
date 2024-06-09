import 'package:eport/app/controller/pkl_controller.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonilController extends GetxController {
  static PersonilController get i => Get.find<PersonilController>();

  RxBool show = true.obs;
  TextEditingController searchInput = TextEditingController();
  RxList<Personil> selectedPersonil = RxList();
  RxList<Rx<Personil>> personils = [
    Rx<Personil>(Personil(id: "1", name: "Fadli Hasan", isKomando: true)),
    Rx<Personil>(Personil(id: "2", name: "Bintang Lazuardi")),
    Rx<Personil>(Personil(id: "3", name: "Pak Handoyo")),
    Rx<Personil>(Personil(id: "4", name: "Pak Budi")),
    Rx<Personil>(Personil(id: "5", name: "Setjen Angkasa 2")),
    Rx<Personil>(Personil(id: "6", name: "Roiyan Zain")),
    Rx<Personil>(Personil(id: "7", name: "Tukang Bakso 5")),
    Rx<Personil>(Personil(id: "8", name: "Pak Cak Man")),
    Rx<Personil>(Personil(
        id: "satrio", name: "Satrio Eko Laksono, Let.", isKomando: true)),
    Rx<Personil>(
        Personil(id: "prawobo", name: "Bridgen Prawobo", isKomando: true)),
    Rx<Personil>(Personil(id: "aidit", name: "TNI Aidit", isKomando: true)),
  ].obs;

  RxList<Rx<Personil>> komandos = <Rx<Personil>>[].obs;
  RxList<Rx<Personil>> anggotas = <Rx<Personil>>[].obs;

  void getKomando() {
    var temp = personils.where((data) => data.value.isKomando).toList();
    var tempRx = temp.map((e) => Rx<Personil>(e.value)).toList();
    komandos.value = tempRx;
  }

  void getAnggota() {
    var temp = personils.where((data) => !data.value.isKomando).toList();
    var tempRx = temp.map((e) => Rx<Personil>(e.value)).toList();
    anggotas.value = tempRx;
  }

  void copyData() {
    if (PklController.i.personils.isEmpty) {
      return;
    }
    selectedPersonil.value = PklController.i.personils;
    personils.value = PklController.i.currentPersonil;
  }

  @override
  void onInit() {
    super.onInit();
    getKomando();
    getAnggota();
    copyData();
  }

  void handleAddPersonil(Personil data,
      {Rx<Personil>? ref, bool? isSearch = false}) {
    if (ref != null) {
      ref.value.selected = true;
    }
    var found = selectedPersonil.firstWhereOrNull((e) => e.id == data.id);
    if (found != null) {
      return;
    }
    if (isSearch!) {
      Rx<Personil> p0 =
          personils.firstWhere((element) => element.value.id == data.id);
      p0.value.selected = true;
    }

    selectedPersonil.add(data);
    selectedPersonil.refresh();
  }

  void handleRemovePersonil(
    Personil data, {
    Rx<Personil>? ref,
    bool isAnggota = false,
  }) {
    if (ref != null) {
      ref.value.selected = false;
    }
    if (isAnggota) {
      Rx<Personil> p0 =
          personils.firstWhere((element) => element.value.id == data.id);
      p0.value.selected = false;
    }
    selectedPersonil.remove(data);
    selectedPersonil.refresh();
  }

  void handleSave() {
    PklController.i.personils.clear();
    PklController.i.personils.value = selectedPersonil;
    PklController.i.currentPersonil.clear();
    PklController.i.currentPersonil.value = personils;
    Get.back();
  }
}
