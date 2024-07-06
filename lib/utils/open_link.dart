import 'package:eport/utils/show_alert.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(Uri url) async {
  try {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (err) {
    showAlert(err.toString());
  }
}
