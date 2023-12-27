import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_routes.dart';

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

  late TextEditingController nameController;
  late GlobalKey<FormState> nameFormState;

  @override
  void onInit() {
    nameController = TextEditingController();
    nameFormState = GlobalKey<FormState>();
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
  checkOwnerPassword() {
    Get.offNamed(AppRoutes.ownerPage);
  }
}
