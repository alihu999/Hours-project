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
    LogInControllerImp controller = Get.put(LogInControllerImp());
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 425 ? false : true;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 25, left: 25),
          margin: isMobile
              ? null
              : EdgeInsets.only(right: width * 0.25, left: width * 0.25),
          height: height * 0.50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.contain,
                    height: 45,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Wellcom Back, please login "),
                ],
              ),
              CustomTextFiled(
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
              CustomTextFiled(
                lable: "password",
                isPassword: true,
                filedColors: AppColors.firstColors,
                suffixicon: const Icon(Icons.lock_outline),
                validator: (val) => validationPassword(val!),
                textController: controller.password,
                formState: controller.passwordFormState,
                focusNode: controller.passwordFocusNode,
              ),
              GetX<LogInControllerImp>(builder: (context) {
                return MaterialButton(
                    color: AppColors.firstColors,
                    height: 45,
                    onPressed: () {
                      controller.login();
                    },
                    child: controller.processLogin.value == true
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeAlign: -2,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ));
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
