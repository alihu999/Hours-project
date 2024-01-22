import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/owner_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';

class CalculateSalary extends GetView<OwnerPageControllerImp> {
  const CalculateSalary({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Enter the hourly wage"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                  child: SizedBox(
                height: 60,
                width: 80,
                child: TextField(
                  controller: controller.hourlyWage,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.secondColors,
                  onSubmitted: (value) {
                    controller.calculateSalary();
                  },
                  decoration: InputDecoration(
                    hintText: "here",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.secondColors.withOpacity(0.25)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondColors),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              )),
              Icon(
                Icons.arrow_forward,
                color: AppColors.secondColors,
                size: 40,
              ),
              GetX<OwnerPageControllerImp>(builder: (context) {
                return Container(
                  height: 60,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.secondColors.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Text("${controller.salary.value}"),
                );
              })
            ],
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
