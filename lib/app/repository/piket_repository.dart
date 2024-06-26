import 'package:eport/app/models/db/piket/piket_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PiketRepository {
  static Future<PiketModel> getDetail(String id) async {
    try {
      final pklRef = store.collection("piket");
      var data = await pklRef.doc(id).get();
      return PiketModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
