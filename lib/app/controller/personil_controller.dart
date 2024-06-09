import 'package:eport/app/controller/kransos_controller.dart';
import 'package:eport/app/controller/pengamanan_controller.dart';
import 'package:eport/app/controller/perizinan_controller.dart';
import 'package:eport/app/controller/piket_controller.dart';
import 'package:eport/app/controller/pkl_controller.dart';
import 'package:eport/app/controller/reklame_controller.dart';
import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bjir extends GetxController {}

class PersonilController extends GetxController {
  static PersonilController get i => Get.find<PersonilController>();

  Map<String, List> controllers = {
    "pkl": [PklController.i.personils, PklController.i.currentPersonil],
    "reklame": [
      ReklameController.i.personils,
      ReklameController.i.currentPersonil
    ],
    "keransos": [
      KransosController.i.personils,
      KransosController.i.currentPersonil
    ],
    "pengamanan": [
      PengamananController.i.personils,
      PengamananController.i.currentPersonil
    ],
    "piket": [PiketController.i.personils, PiketController.i.currentPersonil],
    "perizinan": [
      PerizinanController.i.personils,
      PerizinanController.i.currentPersonil
    ],
  };

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
    final controller = controllers[Get.parameters["id"]]!;
    final ctr1 = controller[0] as RxList<Personil>;
    final ctr2 = controller[1] as RxList<Rx<Personil>>;
    if (ctr1.isEmpty) {
      return;
    }

    selectedPersonil.value = ctr1.map((e) => e).toList();
    personils.value = ctr2
        .map((e) => Rx<Personil>(Personil(
              id: e.value.id,
              name: e.value.name,
              isKomando: e.value.isKomando,
              selected: e.value.selected,
            )))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    copyData();
    getKomando();
    getAnggota();
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
    final controller = controllers[Get.parameters["id"]]!;
    final ctr1 = controller[0] as RxList<Personil>;
    final ctr2 = controller[1] as RxList<Rx<Personil>>;
    ctr1.value = selectedPersonil;
    ctr2.value = personils;

    print('cokk ${Get.parameters["id"]}');
    Get.back();
  }
}
