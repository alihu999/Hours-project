import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/employe_controller.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/function/validate_form.dart';
import '../../../core/share/custom_textfiled.dart';

class AddEmployeDialog extends GetView<EmployeControllerImp> {
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
            isPassword: false,
            filedColors: AppColors.secondColors,
            suffixicon: const Icon(Icons.lock_outline),
            validator: (val) => validationEmployeName(val!),
            textController: controller.nameController,
            formState: controller.nameFormState,
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              color: AppColors.secondColors,
              onPressed: () {
                controller.addEmploye();
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
