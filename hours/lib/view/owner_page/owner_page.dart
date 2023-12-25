import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import 'widget/add_employe_dialog.dart';
import 'widget/employe_list.dart';

class OwnerPage extends StatelessWidget {
  const OwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Owner Mode",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondColors,
      ),
      body: const Row(
        children: [
          EmployeList(),
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
    );
  }
}
