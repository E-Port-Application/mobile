import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PersonilRepository {
  static Future<List<List<PersonilModel>>> getPersonels() async {
    try {
      final personilRef = store.collection("personil");
      var data = [
        await personilRef.get(),
        await personilRef.where("komando", isEqualTo: true).get(),
        await personilRef.where("komando", isEqualTo: false).get(),
      ];
      return data.map((e) {
        return e.docs.map((val) => PersonilModel.fromJson(val.data())).toList();
      }).toList();
    } catch (err) {
      showAlert(err.toString());

      rethrow;
    }
  }

  static Future<List<PersonilModel>> getDetailPersonil(String path) async {
    try {
      if (path.split("/").length < 2) {
        throw Exception("Error on GET Personils");
      }

      var [storeId, docId] = [path.split("/")[0], path.split("/")[1]];
      final personilRef = store.collection(storeId).doc(docId);
      var data = await personilRef.get();
      return (data.data()?['personils'] as List)
          .map((e) => PersonilModel.fromJson(e))
          .toList();
    } catch (err) {
      showAlert(err.toString());

      rethrow;
    }
  }

  static Future updatePersonil(String path, data) async {
    try {
      if (path.split("/").length < 2) {
        throw Exception("Error on Path personils");
      }

      var [storeId, docId] = [path.split("/")[0], path.split("/")[1]];
      final personilRef = store.collection(storeId).doc(docId);
      await personilRef.update(data);
    } catch (err) {
      showAlert(err.toString());

      rethrow;
    }
  }
}
