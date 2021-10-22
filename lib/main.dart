// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mob_billing/pages/activationScreen/activation_screen.dart';
import 'package:mob_billing/pages/homeScreen/home_screen.dart';
import 'package:mob_billing/services/activate_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool USE_FIRESTORE_EMULATOR = false;
bool isActivate = false;
ActivateAppServices services = ActivateAppServices();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  isActivate = _prefs.getBool("isActivate") ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isActivate ? const HomeScreen() : const ActivationScreen(),
    );
  }
}
