import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/services.dart';

abstract class ResetPasswordPageController extends GetxController {
  validationCurrentPassword(String val);
  validationConfirmNewPassword(String val);
  submit();
}

class ResetPasswordPageControllerImp extends ResetPasswordPageController {
  late TextEditingController currentPassword;
  late TextEditingController newPassword;
  late TextEditingController confirmNewPassword;

  late GlobalKey<FormState> currentPasswordFormState;
  late GlobalKey<FormState> newPasswordFormState;
  late GlobalKey<FormState> confirmNewPasswordFormState;

  late FocusNode newPasswordFocusNode;
  late FocusNode confirmNewPasswordFocusNode;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    currentPassword = TextEditingController();
    newPassword = TextEditingController();
    confirmNewPassword = TextEditingController();

    currentPasswordFormState = GlobalKey<FormState>();
    newPasswordFormState = GlobalKey<FormState>();
    confirmNewPasswordFormState = GlobalKey<FormState>();

    newPasswordFocusNode = FocusNode();
    confirmNewPasswordFocusNode = FocusNode();

    super.onInit();
  }

  @override
  void onClose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();

    super.onClose();
  }

  @override
  validationCurrentPassword(String val) {
    String? password = myServices.sharedPreferences.getString("password");
    if (password != val) {
      return "The password is incorrect";
    } else
      return null;
  }

  @override
  validationConfirmNewPassword(String val) {
    if (val != newPassword.text.trim()) {
      return "Password mismatch";
    } else if (val.length == 0) {
      return "It cannot be Empty";
    } else
      return null;
  }

  @override
  submit() {
    if (currentPasswordFormState.currentState!.validate() &&
        newPasswordFormState.currentState!.validate() &&
        confirmNewPasswordFormState.currentState!.validate()) {
      myServices.sharedPreferences
          .setString("password", newPassword.text.trim());
      Get.back();
    }
  }
}
