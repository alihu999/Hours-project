import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/home_page_controller.dart';

class EmployeDialog extends GetView<HomePageControllerImp> {
  const EmployeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GetX<HomePageControllerImp>(builder: (contrller) {
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
            MaterialButton(
                color: Colors.green,
                onPressed: () {},
                child: const Text(
                  "Star",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      }),
    );
  }
}
