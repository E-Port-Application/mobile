import 'package:eport/app/models/db/perizinan/perizinan_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class PerizinanRepository {
  static Future<PerizinanModel> getDetail(String id) async {
    try {
      final pklRef = store.collection("perizinan");
      var data = await pklRef.doc(id).get();
      return PerizinanModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
