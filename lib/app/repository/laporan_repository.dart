import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class LaporanRepository {
  static Future<List<LaporanTypeModel>> getSearchData(String ref) async {
    try {
      final storeRef = store.collection(ref);
      var data = await storeRef.get();
      return data.docs.map((e) {
        return LaporanTypeModel.fromJson(e.data());
      }).toList();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future createPkl() async {
    try {} catch (err) {
      showAlert(err.toString());
    }
  }

  static Future<List<LaporanModel>> getProsesReport() async {
    try {
      final laporanRef =
          store.collection("laporan").orderBy("date", descending: false);

      var laporans = await laporanRef.get();
      return (await Future.wait(
        laporans.docs.map(
          (e) async {
            var temp = LaporanModel.fromJson(e.data());
            final dataRef = store.collection(temp.type).doc(temp.id);
            var data = await dataRef.get();
            temp.data = PklModel.fromJson(data.data()!);
            return temp;
          },
        ),
      ))
          .toList();
    } catch (err) {
      print(err.toString());
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<PklModel> getPklDetail(String id) async {
    try {
      final pklRef = store.collection("pkl");
      var data = await pklRef.doc(id).get();
      return PklModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
