import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/login_controller.dart';
import 'package:hours/core/constant/app_colors.dart';
import 'package:hours/core/function/validate_form.dart';
import 'package:hours/core/share/custom_textfiled.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 425 ? false : true;

    LogInControllerImp controller = Get.put(LogInControllerImp());
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 15, left: 15),
          height: isMobile ? hight * 0.6 : 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
                height: 75,
              ),
              const Text("Wellcom Back, please login "),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: CustomTextFiled(
                  lable: "Email",
                  isPassword: false,
                  filedColors: AppColors.firstColors,
                  suffixicon: const Icon(Icons.email_outlined),
                  validator: (val) => validationEmail(val!),
                  textController: controller.email,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context)
                        .requestFocus(controller.passwordFocusNode);
                  },
                  formState: controller.emailFormState,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: CustomTextFiled(
                  lable: "password",
                  isPassword: true,
                  filedColors: AppColors.firstColors,
                  suffixicon: const Icon(Icons.lock_outline),
                  validator: (val) => validationPassword(val!),
                  textController: controller.password,
                  onFieldSubmitted: (val) {
                    FocusScope.of(context)
                        .requestFocus(controller.passwordFocusNode);
                  },
                  formState: controller.passwordFormState,
                ),
              ),
              MaterialButton(
                  color: AppColors.firstColors,
                  onPressed: () {
                    controller.login();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
