import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_routes.dart';
import 'package:hours/core/services/services.dart';
import 'package:hours/core/share/custom_snackbar.dart';

abstract class HomePageController extends GetxController {
  updateTime();
  checkOwnerPassword();
}

class HomePageControllerImp extends HomePageController {
  //clock and data
  int hours = DateTime.now().hour;
  RxInt minute = DateTime.now().minute.obs;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  late TextEditingController passwordController;
  late GlobalKey<FormState> passwordFormState;
  MyServices myServices = Get.find();
  @override
  void onInit() {
    passwordController = TextEditingController();
    passwordFormState = GlobalKey<FormState>();
    super.onInit();
    updateTime();
  }

  @override
  updateTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      hours = DateTime.now().hour;
      minute.value = DateTime.now().minute;
    });
  }

  @override
  checkOwnerPassword() async {
    String? password = myServices.sharedPreferences.getString("password");
    if (passwordController.text.trim() == password) {
      Get.back();
      Get.toNamed(AppRoutes.ownerPage);
    } else {
      errorSnackBar("The password is incorrect");
    }
  }
}
