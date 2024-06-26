import 'package:eport/app/models/db/pamwal/pamwal_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PamwalRepository {
  static Future<PamwalModel> getDetail(String id) async {
    try {
      final pklRef = store.collection("pamwal");
      var data = await pklRef.doc(id).get();
      return PamwalModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
