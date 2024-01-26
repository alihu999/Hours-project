import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/owner_page_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/function/month_name.dart';

class TableOfData extends StatelessWidget {
  const TableOfData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerPageControllerImp>(builder: (controller) {
      return FutureBuilder<Map<String, List<Map>>>(
          future: controller.getEmployeeTable(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircleAvatar());
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text("no data available"));
            } else {
              List month = snapshot.data!.keys.toList();
              return SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 2),
                    child: Column(
                      children: List.generate(month.length, (index) {
                        int totalMinute = controller.totalWorking(month[index]);
                        return Column(
                          children: [
                            DataTable(
                                headingRowColor: MaterialStatePropertyAll(
                                    AppColors.secondColors),
                                headingTextStyle:
                                    const TextStyle(color: Colors.white),
                                columns: const [
                                  DataColumn(label: Text("Date")),
                                  DataColumn(label: Text("Start At")),
                                  DataColumn(label: Text("Finish At")),
                                  DataColumn(label: Text("Break Time")),
                                  DataColumn(label: Text("Work Time")),
                                ],
                                rows: List.generate(
                                    snapshot.data!["${month[index]}"]!.length,
                                    (ind) => DataRow(
                                            color: MaterialStatePropertyAll(
                                                AppColors.secondColors
                                                    .withOpacity(0.25)),
                                            cells: [
                                              DataCell(Text(
                                                  "${snapshot.data!["${month[index]}"]![ind]["date"]}")),
                                              DataCell(
                                                  Text(
                                                      "${snapshot.data!["${month[index]}"]![ind]["startAt"]}"),
                                                  onDoubleTap: () {
                                                controller.changeTimeValue(
                                                    "Start At",
                                                    "startAt",
                                                    "${snapshot.data!["${month[index]}"]![ind]["startAt"]}",
                                                    snapshot.data![
                                                            "${month[index]}"]![
                                                        ind]["_id"]);
                                              }),
                                              DataCell(
                                                Text(
                                                    "${snapshot.data!["${month[index]}"]![ind]["finishAt"]}"),
                                                onDoubleTap: () {
                                                  controller.changeTimeValue(
                                                      "Finish At",
                                                      "finishAt",
                                                      "${snapshot.data!["${month[index]}"]![ind]["finishAt"]}",
                                                      snapshot.data![
                                                              "${month[index]}"]![
                                                          ind]["_id"]);
                                                },
                                              ),
                                              DataCell(Text(
                                                  "${snapshot.data!["${month[index]}"]![ind]["breakH"]}")),
                                              DataCell(Text(
                                                  "${snapshot.data!["${month[index]}"]![ind]["workH"]}")),
                                            ]))),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 50, bottom: 50),
                                  height: 50,
                                  width: 450,
                                  alignment: Alignment.center,
                                  color:
                                      AppColors.secondColors.withOpacity(0.25),
                                  child: Text(
                                    "Total working hours for ${getMonthName(int.parse(month[index]))}:${totalMinute ~/ 60} Hour ${totalMinute % 60} Minute ",
                                  ),
                                ),
                                MaterialButton(
                                    color: AppColors.secondColors,
                                    height: 50,
                                    onPressed: () {
                                      controller.calculateSalary(totalMinute);
                                    },
                                    child: const Text(
                                      "Calculate",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              );
            }
          });
    });
  }
}
