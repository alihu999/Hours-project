import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/reset_password_page_controller.dart';

import '../../core/constant/app_colors.dart';
import '../../core/function/validate_form.dart';
import '../../core/share/custom_textfiled.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordPageControllerImp controller =
        Get.put(ResetPasswordPageControllerImp());
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 425 ? false : true;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "reset Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.firstColors,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 25, left: 25),
            margin: isMobile
                ? null
                : EdgeInsets.only(right: width * 0.25, left: width * 0.25),
            height: height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("please Enter current password and new password"),
                CustomTextFiled(
                  lable: "current password",
                  isPassword: true,
                  filedColors: AppColors.firstColors,
                  suffixicon: const Icon(Icons.lock_outline),
                  validator: (val) =>
                      controller.validationCurrentPassword(val!),
                  textController: controller.currentPassword,
                  formState: controller.currentPasswordFormState,
                  onFieldSubmitted: (val) {
                    if (controller.currentPasswordFormState.currentState!
                        .validate()) {
                      FocusScope.of(context)
                          .requestFocus(controller.newPasswordFocusNode);
                    }
                  },
                ),
                CustomTextFiled(
                  lable: "New password",
                  isPassword: true,
                  filedColors: AppColors.firstColors,
                  suffixicon: const Icon(Icons.lock_outline),
                  validator: (val) => validationPassword(val!),
                  textController: controller.newPassword,
                  formState: controller.newPasswordFormState,
                  focusNode: controller.newPasswordFocusNode,
                  onFieldSubmitted: (val) {
                    if (controller.newPasswordFormState.currentState!
                        .validate()) {
                      FocusScope.of(context)
                          .requestFocus(controller.confirmNewPasswordFocusNode);
                    }
                  },
                ),
                CustomTextFiled(
                  lable: "confirm password",
                  isPassword: true,
                  filedColors: AppColors.firstColors,
                  suffixicon: const Icon(Icons.lock_outline),
                  validator: (val) =>
                      controller.validationConfirmNewPassword(val!),
                  textController: controller.confirmNewPassword,
                  formState: controller.confirmNewPasswordFormState,
                  focusNode: controller.confirmNewPasswordFocusNode,
                  onFieldSubmitted: (val) {
                    controller.confirmNewPasswordFormState.currentState!
                        .validate();
                  },
                ),
                MaterialButton(
                    color: AppColors.firstColors,
                    onPressed: () {
                      controller.submit();
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
