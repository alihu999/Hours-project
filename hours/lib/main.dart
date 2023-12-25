import 'package:flutter/material.dart';
import 'package:hours/routes.dart';
import 'package:hours/theme.dart';
import 'package:hours/view/home_page/home_page.dart';
import 'package:get/get.dart';

void main() {
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
