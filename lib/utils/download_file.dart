import 'package:eport/utils/show_alert.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

void downloadFile(String url) async {
  try {
    await FlutterDownloader.enqueue(
      url: url,
      headers: {},
      savedDir: (await getApplicationDocumentsDirectory()).path,
      saveInPublicStorage: true,
      showNotification: true,
      openFileFromNotification: true,
    );
  } catch (e) {
    showAlert(e.toString());
  }
}
