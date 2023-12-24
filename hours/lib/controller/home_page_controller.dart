import 'dart:async';

import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  updateTime();
}

class HomePageControllerImp extends HomePageController {
  //clock and data
  int hours = DateTime.now().hour;
  RxInt minute = DateTime.now().minute.obs;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  @override
  void onInit() {
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
}
