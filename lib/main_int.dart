import 'package:eport/app.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/services/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.name = UserVariant.internal;

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    name: "e-port-application",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  runApp(const App());
}
