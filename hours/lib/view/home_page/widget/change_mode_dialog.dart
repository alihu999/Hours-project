import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/home_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../../core/share/custom_textfiled.dart';

class ChangeModeDialog extends GetView<HomePageControllerImp> {
  const ChangeModeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Please Enter password"),
          CustomTextFiled(
            lable: "password",
            isPassword: true,
            filedColors: AppColors.firstColors,
            suffixicon: const Icon(Icons.lock_outline),
            formState: controller.passwordFormState,
            textController: controller.passwordController,
            validator: (val) {
              return null;
            },
          ),
          MaterialButton(
              color: AppColors.firstColors,
              onPressed: () {
                controller.checkOwnerPassword();
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
