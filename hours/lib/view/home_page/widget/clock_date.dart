import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../../controller/home_page_controller.dart';
import 'analog_clock.dart';

class ClockDate extends GetView<HomePageControllerImp> {
  const ClockDate({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
          width: width - 225,
          height: height,
          alignment: Alignment.center,
          color: Colors.white,
          child: GetX<HomePageControllerImp>(
            builder: (controller) {
              String hours = controller.hours.toString().padLeft(2, "0");
              String minute = controller.minute.toString().padLeft(2, "0");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AnalogClock(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hours,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                            fontSize: 40, color: AppColors.secondColors),
                      ),
                      Text(
                        minute,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${controller.year}-${controller.month}-${controller.day}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          )),
    );
  }
}
