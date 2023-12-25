import 'package:flutter/material.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../../core/share/custom_textfiled.dart';

class ChangeModeDialog extends StatelessWidget {
  const ChangeModeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      height: 200,
      child: Column(
        children: [
          const Text("Please Enter password"),
          const SizedBox(
            height: 25,
          ),
          CustomTextFiled(
            lable: "password",
            isPassword: true,
            filedColors: AppColors.firstColors,
            suffixicon: const Icon(Icons.lock_outline),
          ),
          const SizedBox(
            height: 50,
          ),
          MaterialButton(
              color: AppColors.firstColors,
              onPressed: () {},
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
