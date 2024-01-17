import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/employee_records_controller.dart';
import '../../../core/constant/app_colors.dart';

class TableOfTable extends StatelessWidget {
  const TableOfTable({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<EmploeeRecordsControllerImp>(builder: (controller) {
      return FutureBuilder<List<Map>>(
          future: controller.getEmployeeTable(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircleAvatar());
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text("no data available"));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 2),
                    child: DataTable(
                        headingRowColor:
                            MaterialStatePropertyAll(AppColors.secondColors),
                        headingTextStyle: const TextStyle(color: Colors.white),
                        columns: const [
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Sart At")),
                          DataColumn(label: Text("Finish At")),
                          DataColumn(label: Text("Break Time")),
                          DataColumn(label: Text("Work Time")),
                        ],
                        rows: List.generate(
                            snapshot.data!.length,
                            (index) => DataRow(
                                    color: MaterialStatePropertyAll(AppColors
                                        .secondColors
                                        .withOpacity(0.25)),
                                    cells: [
                                      DataCell(Text(
                                          "${snapshot.data![index]["date"]}")),
                                      DataCell(
                                        Text(
                                            "${snapshot.data![index]["startAt"]}"),
                                        onTap: () {},
                                      ),
                                      DataCell(
                                        Text(
                                            "${snapshot.data![index]["finishAt"]}"),
                                        onTap: () {},
                                      ),
                                      DataCell(Text(
                                          "${snapshot.data![index]["breakH"]}")),
                                      DataCell(Text(
                                          "${snapshot.data![index]["workH"]}")),
                                    ]))),
                  ),
                ),
              );
            }
          });
    });
  }
}
