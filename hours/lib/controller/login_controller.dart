import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_routes.dart';

abstract class LogInController extends GetxController {
  login();
}

class LogInControllerImp extends LogInController {
  late TextEditingController email;
  late TextEditingController password;

  late GlobalKey<FormState> emailFormState;
  late GlobalKey<FormState> passwordFormState;

  late FocusNode passwordFocusNode;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();

    emailFormState = GlobalKey<FormState>();
    passwordFormState = GlobalKey<FormState>();

    passwordFocusNode = FocusNode();

    super.onInit();
  }

  @override
  login() {
    Get.offNamed(AppRoutes.homePage);
  }
}
