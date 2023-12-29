import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import 'employe_dialog.dart';

class EmployeList extends StatelessWidget {
  const EmployeList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 450 ? false : true;
    List employee = ["ali almostfa ", "alooosh "];

    return Container(
      color: AppColors.firstColors.withOpacity(0.25),
      width: isMobile ? width : 200,
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: ListView.builder(
          itemCount: employee.length,
          itemBuilder: ((context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.only(bottom: 7, top: 7, right: 10, left: 10),
              title: Text(
                employee[index],
                style: const TextStyle(fontSize: 18),
              ),
              trailing: const Icon(
                Icons.fiber_manual_record,
                color: Colors.red,
              ),
              onTap: () {
                Get.defaultDialog(
                    title: employee[index],
                    titleStyle: const TextStyle(fontSize: 25),
                    content: const EmployeDialog());
              },
            );
          })),
    );
  }
}
