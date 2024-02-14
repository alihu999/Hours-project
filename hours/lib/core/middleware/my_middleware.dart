import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hours/core/constant/app_routes.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return const RouteSettings(name: AppRoutes.homePage);
    } else {
      return const RouteSettings(name: AppRoutes.loginPage);
    }
  }
}
