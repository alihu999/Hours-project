import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/owner_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../controller/employe_controller.dart';
import '../../controller/employee_records_controller.dart';
import '../employee_records.dart/widget/table_of_data.dart';
import 'widget/add_employe_dialog.dart';
import 'widget/employe_list.dart';

class OwnerPage extends StatelessWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    EmploeeRecordsControllerImp controller =
        Get.put(EmploeeRecordsControllerImp(), permanent: false);
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
                child: GetX<EmploeeRecordsControllerImp>(builder: (controller) {
                  if (controller.tableName.value.isEmpty) {
                    return const Center(child: Text("press on Employee Name"));
                  } else {
                    return const TableOfTable();
                  }
                }),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondColors,
          splashColor: Colors.white.withOpacity(0.25),
          onPressed: () {
            Get.defaultDialog(
                title: "Add Employee",
                titleStyle: const TextStyle(fontSize: 25),
                content: const AddEmployeDialog());
          },
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
          ),
        ),
      ),
      onPopInvoked: (didPop) {
        controller.tableName.value = "";
        EmployeControllerImp employecontroller = Get.find();
        employecontroller.getEmployes();
      },
    );
  }
}
