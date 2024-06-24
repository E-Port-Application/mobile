import 'package:eport/app/models/db/pelanggar/pelanggar_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PelanggarRepository {
  static final ref = store.collection("pelanggar");

  static Future<List<PelanggarModel>> name(String filter) async {
    try {
      var data = await ref.where("name", isEqualTo: filter.toLowerCase()).get();
      if (data.docs.isEmpty) {
        return <PelanggarModel>[];
      }
      return data.docs.map((e) => PelanggarModel.fromJson(e.data())).toList();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<List<PelanggarModel>> nik(String filter) async {
    try {
      var data = await ref.where("nik", isEqualTo: filter.toLowerCase()).get();
      if (data.docs.isEmpty) {
        return <PelanggarModel>[];
      }
      return data.docs.map((e) => PelanggarModel.fromJson(e.data())).toList();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
