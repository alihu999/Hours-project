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
                GetX<ResetPasswordPageControllerImp>(builder: (controller) {
                  return CustomTextFiled(
                    lable: "current password",
                    isPassword: !controller.showcurrentPassword.value,
                    filedColors: AppColors.firstColors,
                    suffixicon: IconButton(
                        onPressed: () {
                          controller.showcurrentPassword.value =
                              !controller.showcurrentPassword.value;
                        },
                        icon: Icon(
                          controller.showcurrentPassword.value
                              ? Icons.lock_open_outlined
                              : Icons.lock_outline,
                          color: AppColors.firstColors,
                        )),
                    validator: (val) =>
                        controller.validationCurrentPassword(val!),
                    textController: controller.currentPassword,
                    formState: controller.currentPasswordFormState,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (val) {
                      if (controller.currentPasswordFormState.currentState!
                          .validate()) {
                        FocusScope.of(context)
                            .requestFocus(controller.newPasswordFocusNode);
                      }
                    },
                  );
                }),
                GetX<ResetPasswordPageControllerImp>(builder: (controller) {
                  return CustomTextFiled(
                    lable: "New password",
                    isPassword: !controller.shownewPassword.value,
                    filedColors: AppColors.firstColors,
                    suffixicon: IconButton(
                        onPressed: () {
                          controller.shownewPassword.value =
                              !controller.shownewPassword.value;
                        },
                        icon: Icon(
                          controller.shownewPassword.value
                              ? Icons.lock_open_outlined
                              : Icons.lock_outline,
                          color: AppColors.firstColors,
                        )),
                    validator: (val) => validationPassword(val!),
                    textController: controller.newPassword,
                    formState: controller.newPasswordFormState,
                    focusNode: controller.newPasswordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (val) {
                      if (controller.newPasswordFormState.currentState!
                          .validate()) {
                        FocusScope.of(context).requestFocus(
                            controller.confirmNewPasswordFocusNode);
                      }
                    },
                  );
                }),
                GetX<ResetPasswordPageControllerImp>(builder: (controller) {
                  return CustomTextFiled(
                    lable: "confirm password",
                    isPassword: !controller.showconfirmNewPassword.value,
                    filedColors: AppColors.firstColors,
                    suffixicon: IconButton(
                        onPressed: () {
                          controller.showconfirmNewPassword.value =
                              !controller.showconfirmNewPassword.value;
                        },
                        icon: Icon(
                          controller.showconfirmNewPassword.value
                              ? Icons.lock_open_outlined
                              : Icons.lock_outline,
                          color: AppColors.firstColors,
                        )),
                    validator: (val) =>
                        controller.validationConfirmNewPassword(val!),
                    textController: controller.confirmNewPassword,
                    formState: controller.confirmNewPasswordFormState,
                    focusNode: controller.confirmNewPasswordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    onFieldSubmitted: (val) {
                      controller.confirmNewPasswordFormState.currentState!
                          .validate();
                    },
                  );
                }),
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
