import 'dart:io';
import 'package:ecommerce/views/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Check if Firebase is already initialized
    if (Firebase.apps.isEmpty) {
      if (Platform.isAndroid) {
        await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCsq9BaPAjD0oe45g0d4nb1LLin80EcqVM",
            appId: "1:602464933285:android:382277aeea9d14296e044c",
            messagingSenderId: "602464933285",
            projectId: "job-connect-d8fa7",
            storageBucket: "gs://job-connect-d8fa7.appspot.com",
          ),
        );
      } else {
        await Firebase.initializeApp();
      }
    }
  } catch (e) {
    print("Firebase initialization error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),
    );
  }
}
