import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hours/firebase_options.dart';
import 'package:hours/routes.dart';
import 'package:hours/theme.dart';
import 'package:hours/view/home_page/home_page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: const HomePage(),
      theme: apptheme,
    );
  }
}
