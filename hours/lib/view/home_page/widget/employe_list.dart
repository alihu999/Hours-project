import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/employe_controller.dart';
import 'package:hours/core/constant/app_colors.dart';

import 'employe_dialog.dart';

class EmployeList extends StatelessWidget {
  const EmployeList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 450 ? false : true;

    return Container(
      color: AppColors.firstColors.withOpacity(0.25),
      width: isMobile ? width : 200,
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: GetX<EmployeControllerImp>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.employList.length,
            itemBuilder: ((context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.only(
                    bottom: 7, top: 7, right: 10, left: 10),
                title: Text(
                  controller.employList[index]["name"].toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: const Icon(
                  Icons.fiber_manual_record,
                  color: Colors.green,
                ),
                onTap: () {
                  Get.defaultDialog(
                      title: controller.employList[index]["name"].toString(),
                      titleStyle: const TextStyle(fontSize: 25),
                      content: const EmployeDialog());
                },
              );
            }));
      }),
    );
  }
}
