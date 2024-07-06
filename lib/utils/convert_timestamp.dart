import 'package:cloud_firestore/cloud_firestore.dart';

void convertTimestamp(Map<String, dynamic> formJson, List<String> keys) {
  for (var key in keys) {
    formJson[key] = Timestamp.fromDate(DateTime.parse(formJson[key]));
  }
}
