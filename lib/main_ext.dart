import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app.dart';
import 'package:eport/global_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Global.name = UserVariant.external;

  await dotenv.load(fileName: ".env");
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  auth = FirebaseAuth.instanceFor(app: app);
  store = FirebaseFirestore.instanceFor(app: app);

  runApp(const App());
}
