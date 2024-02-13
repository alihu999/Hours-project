import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/login_controller.dart';
import '../../../core/constant/app_routes.dart';

class RestoreDataContent extends GetView<LogInControllerImp> {
  const RestoreDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "There is a copy of the data. Do you want to restore it?",
            style: TextStyle(fontSize: 17),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    if (!controller.processLogin.value) {
                      Get.offAllNamed(AppRoutes.homePage);
                    }
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 30,
                  ),
                  label: const Text(
                    "No",
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  )),
              ElevatedButton.icon(
                  onPressed: () {
                    controller.addDataTolocalStorge();
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.green, fontSize: 17),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
