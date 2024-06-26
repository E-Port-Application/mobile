import 'package:eport/app/models/db/kransos/kransos_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class KransosRepository {
  static Future<KransosModel> getDetail(String id) async {
    try {
      final pklRef = store.collection("kransos");
      var data = await pklRef.doc(id).get();
      return KransosModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
