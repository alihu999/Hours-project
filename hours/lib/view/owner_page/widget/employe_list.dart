import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';
import 'package:hours/core/constant/app_routes.dart';

import '../../../controller/owner_page_controller.dart';

class EmployeList extends StatelessWidget {
  const EmployeList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 450 ? false : true;

    return Container(
      color: AppColors.secondColors.withOpacity(0.25),
      width: isMobile ? width : 225,
      height: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: GetBuilder<OwnerPageControllerImp>(builder: (controller) {
        if (controller.employList.isEmpty) {
          return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "No Data available,Add employee records",
                style: TextStyle(fontSize: 17),
              ));
        } else {
          return ListView.builder(
              itemCount: controller.employList.length,
              itemBuilder: ((context, index) {
                String tablename =
                    "${controller.employList[index].firstName}_${controller.employList[index].lastName}";
                return ListTile(
                  contentPadding: const EdgeInsets.only(
                      bottom: 7, top: 7, right: 10, left: 10),
                  title: Text(
                    "${controller.employList[index].firstName} ${controller.employList[index].lastName}",
                    style: const TextStyle(fontSize: 17),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Delete Employe Record",
                            titleStyle: const TextStyle(fontSize: 20),
                            middleText:
                                "do you want delete ${controller.employList[index].firstName} ${controller.employList[index].lastName} record?",
                            middleTextStyle: const TextStyle(fontSize: 17),
                            onCancel: () {},
                            onConfirm: () {
                              controller
                                  .deleteEmploye(controller.employList[index]);
                            });
                      },
                      icon: const Icon(Icons.delete)),
                  selected: isMobile
                      ? false
                      : controller.tableName.value == tablename,
                  selectedTileColor: AppColors.secondColors,
                  selectedColor: Colors.white,
                  onTap: () {
                    controller.tableName.value = tablename;
                    if (isMobile) {
                      Get.toNamed(AppRoutes.employeeRecordsPage);
                    } else {
                      controller.update();
                    }
                  },
                );
              }));
        }
      }),
    );
  }
}
