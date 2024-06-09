import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/show_alert.dart';

class LaporanRepository {
  static final jenisPklRef = store.collection("rencana-laporan/pkl/jenis");
  static final pelanggaranPklRef =
      store.collection("rencana-laporan/pkl/pelanggaran");
  static final tindakanPklRef =
      store.collection("rencana-laporan/pkl/tindakan");

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
}
