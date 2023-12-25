import 'package:flutter/material.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/share/custom_textfiled.dart';

class AddEmployeDialog extends StatelessWidget {
  const AddEmployeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      height: 200,
      child: Column(
        children: [
          const Text("Please Enter employe Name"),
          const SizedBox(
            height: 25,
          ),
          CustomTextFiled(
            lable: "employe Name",
            isPassword: true,
            filedColors: AppColors.secondColors,
            suffixicon: const Icon(Icons.lock_outline),
          ),
          const SizedBox(
            height: 50,
          ),
          MaterialButton(
              color: AppColors.secondColors,
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
