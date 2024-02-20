import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/owner_page_controller.dart';
import '../../core/constant/app_colors.dart';
import '../../core/function/validate_form.dart';
import '../../core/share/custom_textfiled.dart';

class AddEmployeePage extends GetView<OwnerPageControllerImp> {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Employee",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondColors,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(right: 15, left: 15),
            margin: EdgeInsets.only(right: width * 0.25, left: width * 0.25),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Please Enter employe Name",
                  style: TextStyle(fontSize: 18),
                ),
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
        ),
      ),
    );
  }
}
