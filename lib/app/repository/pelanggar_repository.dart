import 'package:eport/app/models/db/pelanggar/pelanggar_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PelanggarRepository {
  static final ref = store.collection("pelanggar");

  static Future<int> name(String filter) async {
    try {
      var data = await ref
          .where("name", isEqualTo: filter.toLowerCase())
          .count()
          .get();
      return data.count ?? 0;
    } catch (err) {
      showAlert(err.toString());

      rethrow;
    }
  }

  static Future<int> nik(String filter) async {
    try {
      var data =
          await ref.where("nik", isEqualTo: filter.toLowerCase()).count().get();
      return data.count ?? 0;
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<PelanggarModel> set(PelanggarModel data) async {
    try {
      final formJson = data.toJson();
      formJson["nik"] = formJson["nik"]?.toString();

      final dataDoc = ref.doc(data.id);
      await dataDoc.set(formJson);
      final res = await dataDoc.get();
      return PelanggarModel.fromJson(res.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<PelanggarModel> update(PelanggarModel data) async {
    try {
      final formJson = data.toJson();
      formJson["nik"] = formJson["nik"]?.toString();

      final dataDoc = ref.doc(data.id);
      await dataDoc.update(formJson);
      final res = await dataDoc.get();
      return PelanggarModel.fromJson(res.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
