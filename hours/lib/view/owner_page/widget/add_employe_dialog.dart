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
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Please Enter employe Name"),
          CustomTextFiled(
            lable: "First Name",
            isPassword: false,
            filedColors: AppColors.secondColors,
            suffixicon: const Icon(Icons.person),
            validator: (val) => validationEmployeName(val!),
            textController: controller.firstNameController,
            formState: controller.firstNameFormState,
          ),
          CustomTextFiled(
            lable: "Last Name",
            isPassword: false,
            filedColors: AppColors.secondColors,
            suffixicon: const Icon(Icons.person),
            validator: (val) => validationEmployeName(val!),
            textController: controller.lastNameController,
            formState: controller.lastNameFormState,
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
