import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

Map<String, dynamic> formConverter(Map<String, TextEditingController> form) {
  return form.map((key, value) {
    DateFormat formatDate = DateFormat("dd MMMM yyyy");
    DateFormat formatTime = DateFormat.Hm();
    try {
      String? formattedDate =
          formatDate.tryParse(value.text)?.toIso8601String();
      if (formattedDate != null) {
        return MapEntry(key, formattedDate);
      }

      String? formattedTime =
          formatTime.tryParse(value.text)?.toIso8601String();
      if (formattedTime != null) {
        return MapEntry(key, formattedTime);
      }

      int? formattedInt = int.tryParse(value.text);
      if (formattedInt != null) {
        return MapEntry(key, formattedInt);
      }

      double? formattedDouble = double.tryParse(value.text);
      if (formattedDouble != null) {
        return MapEntry(key, formattedDouble);
      }

      num? formattedNum = num.tryParse(value.text);
      if (formattedNum != null) {
        return MapEntry(key, formattedNum);
      }

      if (value.text == "") {
        return MapEntry(key, null);
      }

      return MapEntry(key, value.text);
    } catch (err) {
      return MapEntry(key, value.text);
    }
  });
}
