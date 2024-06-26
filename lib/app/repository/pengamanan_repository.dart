import 'package:eport/app/models/db/pengamanan/pengamanan_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PengamananRepository {
  static Future<PengamananModel> getDetail(String id) async {
    try {
      final pklRef = store.collection("pengamanan");
      var data = await pklRef.doc(id).get();
      return PengamananModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
