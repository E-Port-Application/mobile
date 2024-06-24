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
}
