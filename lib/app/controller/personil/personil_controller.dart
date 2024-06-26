import 'package:eport/app/controller/kransos_controller.dart';
import 'package:eport/app/controller/pengamanan_controller.dart';
import 'package:eport/app/controller/perizinan_controller.dart';
import 'package:eport/app/controller/piket_controller.dart';
import 'package:eport/app/controller/pkl/pkl_controller.dart';
import 'package:eport/app/controller/reklame/reklame_controller.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/repository/personil_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  RxList<PersonilModel> selectedPersonil = RxList();
  RxList<Rx<PersonilState>> personils = RxList<Rx<PersonilState>>();
  RxList<Rx<PersonilState>> komandos = RxList<Rx<PersonilState>>();
  RxList<Rx<PersonilState>> anggotas = RxList<Rx<PersonilState>>();

  Future initData() async {
    try {
      var data = await PersonilRepository.getPersonels();
      personils.value = data[0]
          .map((e) => Rx<PersonilState>(PersonilState(
                personil: e,
                isSelected: false,
              )))
          .toList();
      personils.refresh();
      komandos.value = data[1]
          .map((e) => Rx<PersonilState>(PersonilState(
                personil: e,
                isSelected: false,
              )))
          .toList();
      anggotas.value = data[2]
          .map((e) => Rx<PersonilState>(PersonilState(
                personil: e,
                isSelected: false,
              )))
          .toList();
    } catch (_) {}
  }

  void getKomando() {
    var temp = personils.where((data) => data.value.personil.komando).toList();
    var tempRx = temp.map((e) => Rx<PersonilState>(e.value)).toList();
    komandos.value = tempRx;
  }

  void getAnggota() {
    var temp = personils.where((data) => !data.value.personil.komando).toList();
    var tempRx = temp.map((e) => Rx<PersonilState>(e.value)).toList();
    anggotas.value = tempRx;
  }

  void copyData() {
    final controller = controllers[Get.parameters["id"]]!;
    final ctr1 = controller[0] as RxList<PersonilModel>;
    final ctr2 = controller[1] as RxList<Rx<PersonilState>>;
    if (ctr1.isEmpty) {
      return;
    }

    selectedPersonil.value = ctr1.map((e) => e).toList();
    personils.value = ctr2
        .map((e) => Rx<PersonilState>(PersonilState(
            personil: e.value.personil, isSelected: e.value.isSelected)))
        .toList();
  }

  @override
  void onInit() async {
    super.onInit();
    await initData();

    copyData();
    getKomando();
    getAnggota();
  }

  void handleAddPersonil(PersonilModel data,
      {Rx<PersonilState>? ref, bool? isSearch = false}) {
    if (ref != null) {
      ref.value.isSelected = true;
    }
    var found = selectedPersonil.firstWhereOrNull((e) => e.id == data.id);
    if (found != null) {
      return;
    }
    if (isSearch!) {
      Rx<PersonilState> p0 = personils
          .firstWhere((element) => element.value.personil.id == data.id);
      p0.value.isSelected = true;
    }

    selectedPersonil.add(data);
    selectedPersonil.refresh();
  }

  void handleRemovePersonil(
    PersonilModel data, {
    Rx<PersonilState>? ref,
    bool isAnggota = false,
  }) {
    if (ref != null) {
      ref.value.isSelected = false;
    }
    if (isAnggota) {
      Rx<PersonilState> p0 = personils
          .firstWhere((element) => element.value.personil.id == data.id);
      p0.value.isSelected = false;
    }
    selectedPersonil.remove(data);
    selectedPersonil.refresh();
  }

  void handleSave() {
    final controller = controllers[Get.parameters["id"]]!;
    final ctr1 = controller[0] as RxList<PersonilModel>;
    final ctr2 = controller[1] as RxList<Rx<PersonilState>>;
    ctr1.value = selectedPersonil;
    ctr2.value = personils;

    Get.back();
  }
}
