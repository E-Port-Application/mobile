import 'package:eport/app/presentation/widgets/app_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonilController extends GetxController {
  static PersonilController get i => Get.find<PersonilController>();

  RxBool show = false.obs;
  TextEditingController searchInput = TextEditingController();
  RxList<Personil> selectedPersonil = RxList();

  void handleAddPersonil(Personil data) {
    var found = selectedPersonil.firstWhereOrNull((e) => e.id == data.id);
    if (found != null) {
      return;
    }
    selectedPersonil.add(data);
    selectedPersonil.refresh();
  }
}
