import 'package:eport/services/api/fetch_data.dart';
import 'package:eport/services/api/request_method.dart';
import 'package:eport/utils/open_link.dart';
import 'package:eport/utils/show_alert.dart';

class RekapRepository {
  static Future<String> get() async {
    try {
      var data = await fetchData<String>(
        url: "/api/rekap",
        method: RequestMethod.GET,
      );
      openLink(Uri.parse(data.data!));
      return data.data!;
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }
}
