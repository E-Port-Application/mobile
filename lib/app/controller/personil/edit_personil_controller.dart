import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/repository/personil_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPersonilController extends GetxController {
  static EditPersonilController get i => Get.find();

  TextEditingController searchInput = TextEditingController();
  RxList<Rx<PersonilState>> personils = RxList<Rx<PersonilState>>();
  RxList<Rx<PersonilState>> komandos = RxList<Rx<PersonilState>>();
  RxList<Rx<PersonilState>> anggotas = RxList<Rx<PersonilState>>();

  RxBool isEdit = false.obs;

  void handleAddPersonil(PersonilModel data,
      {Rx<PersonilState>? ref, bool? isSearch = false}) {
    personils.refresh();
    komandos.refresh();
    anggotas.refresh();
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
  }

  RxBool isLoading = true.obs;
  void handleSave() async {
    final updatedJson = {
      "personils": personils.map((e) => e.value.personil.toJson())
    };
    try {
      isLoading.value = true;
      showLoadingDialog(Get.context!, isLoading);
      await PersonilRepository.updatePersonil(
        Get.parameters['doc']!,
        updatedJson,
      );
      await closeLoading(isLoading);
      Get.back();
    } catch (_) {
      await closeLoading(isLoading);
    }
  }

  Future initData() async {
    print(Get.parameters['doc']);
    try {
      var data =
          await PersonilRepository.getDetailPersonil(Get.parameters['doc']!);

      personils.value = data
          .map((e) => Rx(PersonilState(personil: e, isSelected: false)))
          .toList();
      personils.refresh();

      komandos.value = data
          .where((e) => e.komando)
          .map((e) => Rx(PersonilState(personil: e, isSelected: false)))
          .toList();
      komandos.refresh();

      anggotas.value = data
          .where((e) => !e.komando)
          .map((e) => Rx(PersonilState(personil: e, isSelected: false)))
          .toList();
      anggotas.refresh();
    } catch (_) {}
  }

  @override
  void onInit() async {
    super.onInit();
    await initData();
  }
}
