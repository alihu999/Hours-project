import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/owner_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';
import 'package:hours/core/constant/app_routes.dart';

import '../../controller/employe_controller.dart';
import '../employee_records.dart/widget/table_of_data.dart';
import 'widget/add_employe_dialog.dart';
import 'widget/employe_list.dart';

class OwnerPage extends StatelessWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OwnerPageControllerImp());
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 450 ? false : true;
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Owner Mode",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.secondColors,
        ),
        body: Row(
          children: [
            const EmployeList(),
            if (!isMobile)
              Expanded(
                child:
                    GetBuilder<OwnerPageControllerImp>(builder: (controller) {
                  if (controller.tableName.isEmpty) {
                    return const Center(child: Text("press on Employee Name"));
                  } else {
                    return const Center(child: TableOfData());
                  }
                }),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondColors,
          splashColor: Colors.white.withOpacity(0.25),
          onPressed: () {
            if (isMobile) {
              Get.defaultDialog(
                  title: "Add Employee",
                  titleStyle: const TextStyle(fontSize: 25),
                  content: const AddEmployeDialog());
            } else {
              Get.toNamed(AppRoutes.addEmployeePage);
            }
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        EmployeControllerImp employecontroller = Get.find();
        employecontroller.getEmployes();
      },
    );
  }
}
