import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../controller/employee_records_controller.dart';

class EmployeeRecords extends GetView<EmploeeRecordsControllerImp> {
  const EmployeeRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.tableName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.firstColors,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Map>>(
                future: controller.getEmployeeTable(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircleAvatar();
                  } else if (snapshot.data!.isEmpty) {
                    return const Text("Not Data");
                  } else {
                    return DataTable(
                        columns: const [
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Sart At")),
                          DataColumn(label: Text("Finish At")),
                          DataColumn(label: Text("Break Time")),
                          DataColumn(label: Text("Work Time")),
                        ],
                        rows: List.generate(
                            snapshot.data!.length,
                            (index) => DataRow(cells: [
                                  DataCell(
                                      Text("${snapshot.data![index]["date"]}")),
                                  DataCell(Text(
                                      "${snapshot.data![index]["startAt"]}")),
                                  DataCell(Text(
                                      "${snapshot.data![index]["finishAt"]}")),
                                  DataCell(Text(
                                      "${snapshot.data![index]["breakH"]}")),
                                  DataCell(Text(
                                      "${snapshot.data![index]["workH"]}")),
                                ])));
                  }
                }),
          ),
        ),
      ),
    );
  }
}
