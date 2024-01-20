import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/owner_page_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/function/month_name.dart';

class TotalWorkingTime extends GetView<OwnerPageControllerImp> {
  const TotalWorkingTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 450,
            alignment: Alignment.center,
            color: AppColors.secondColors.withOpacity(0.25),
            child: Text(
              "Total working hours for ${getMonthName(DateTime.now().month)}: ${controller.totalWorking()}",
            ),
          ),
          MaterialButton(
              color: AppColors.secondColors,
              height: 50,
              onPressed: () {},
              child: const Text(
                "Calculate",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
