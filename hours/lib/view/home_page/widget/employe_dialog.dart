import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/home_page_controller.dart';

import '../../../controller/employe_controller.dart';

class EmployeDialog extends GetView<HomePageControllerImp> {
  const EmployeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetX<HomePageControllerImp>(builder: (contrller) {
            String hours = controller.hours.toString().padLeft(2, "0");
            String minute = controller.minute.toString().padLeft(2, "0");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$hours:$minute",
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  "${controller.year}-${controller.month}-${controller.day}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          }),
          GetX<EmployeControllerImp>(builder: (controller) {
            String status =
                controller.employList[controller.employeIndex].status;
            if (status == "isStoped") {
              return MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    controller.changeEmployeStatus(
                        controller.employList[controller.employeIndex],
                        "isStarted");
                  },
                  child: const Text(
                    "Star",
                    style: TextStyle(color: Colors.white),
                  ));
            } else if (status == "isStarted") {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        controller.changeEmployeStatus(
                            controller.employList[controller.employeIndex],
                            "isBreaked");
                      },
                      child: const Text(
                        "break",
                        style: TextStyle(color: Colors.white),
                      )),
                  MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        controller.changeEmployeStatus(
                            controller.employList[controller.employeIndex],
                            "isStoped");
                      },
                      child: const Text(
                        "stop",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        controller.changeEmployeStatus(
                            controller.employList[controller.employeIndex],
                            "isStarted");
                      },
                      child: const Text(
                        "star",
                        style: TextStyle(color: Colors.white),
                      )),
                  MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        controller.changeEmployeStatus(
                            controller.employList[controller.employeIndex],
                            "isStoped");
                      },
                      child: const Text(
                        "stop",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            }
          })
        ],
      ),
    );
  }
}
