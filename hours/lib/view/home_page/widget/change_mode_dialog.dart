import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/home_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';
import 'package:hours/core/constant/app_routes.dart';

import '../../../core/share/custom_textfiled.dart';

class ChangeModeDialog extends GetView<HomePageControllerImp> {
  const ChangeModeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      height: 225,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Please Enter password"),
          GetX<HomePageControllerImp>(builder: (controller) {
            return CustomTextFiled(
              lable: "password",
              isPassword: !controller.showPassword.value,
              filedColors: AppColors.firstColors,
              formState: controller.passwordFormState,
              textController: controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              suffixicon: IconButton(
                  onPressed: () {
                    controller.showPassword.value =
                        !controller.showPassword.value;
                  },
                  icon: Icon(
                    controller.showPassword.value
                        ? Icons.lock_open_outlined
                        : Icons.lock_outline,
                    color: AppColors.firstColors,
                  )),
              validator: (val) {
                return null;
              },
            );
          }),
          MaterialButton(
              color: AppColors.firstColors,
              onPressed: () {
                controller.checkOwnerPassword();
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.resetPasswordPage);
              },
              child: const Text(
                "Reset password",
                style: TextStyle(fontSize: 15),
              ))
        ],
      ),
    );
  }
}
