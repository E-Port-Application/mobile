import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void datePicker(TextEditingController controller) async {
  try {
    var date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime(2999),
    );

    if (date != null) {
      controller.text = DateFormat('dd MMMM yyyy').format(date);
    }
  } catch (err) {
    showAlert(err.toString());
  }
}
