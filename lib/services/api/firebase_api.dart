import 'package:eport/utils/show_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _messaging = FirebaseMessaging.instance;

  Future initNotification() async {
    try {
      await _messaging.requestPermission();
      final fCMToken = await _messaging.getToken();
      print(fCMToken);
    } catch (err) {
      showAlert(err.toString());
    }
  }
}
