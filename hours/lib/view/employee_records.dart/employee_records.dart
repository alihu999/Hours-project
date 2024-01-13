import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../controller/employee_records_controller.dart';
import 'widget/table_of_data.dart';

class EmployeeRecords extends GetView<EmploeeRecordsControllerImp> {
  const EmployeeRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.tableName.value,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.secondColors,
        centerTitle: true,
      ),
      body: const TableOfTable(),
    );
  }
}
