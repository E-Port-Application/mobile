import 'package:eport/app.dart';
import 'package:eport/global_settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.name = UserVariant.internal;

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    name: "e-port-application",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
