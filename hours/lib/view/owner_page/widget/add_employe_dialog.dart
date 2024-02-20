import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/owner_page_controller.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/function/validate_form.dart';
import '../../../core/share/custom_textfiled.dart';

class AddEmployeDialog extends GetView<OwnerPageControllerImp> {
  const AddEmployeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(right: 15, left: 15),
        height: 250,
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
              keyboardType: TextInputType.name,
              onFieldSubmitted: (val) {
                FocusScope.of(context)
                    .requestFocus(controller.lastNameFocusNode);
              },
              formState: controller.firstNameFormState,
            ),
            CustomTextFiled(
              lable: "Last Name",
              isPassword: false,
              focusNode: controller.lastNameFocusNode,
              filedColors: AppColors.secondColors,
              suffixicon: const Icon(Icons.person),
              validator: (val) => validationEmployeName(val!),
              textController: controller.lastNameController,
              formState: controller.lastNameFormState,
              keyboardType: TextInputType.name,
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
      ),
    );
  }
}
