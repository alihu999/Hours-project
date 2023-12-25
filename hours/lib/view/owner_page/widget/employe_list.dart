import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_colors.dart';

import '../../../controller/home_page_controller.dart';

class EmployeList extends GetView<HomePageControllerImp> {
  const EmployeList({super.key});

  @override
  Widget build(BuildContext context) {
    List employ = ["Ali mohamed", "Mohamed ali", "alosh"];
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 450 ? false : true;

    return Container(
      color: AppColors.secondColors.withOpacity(0.25),
      width: isMobile ? width : 200,
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: ListView.builder(
          itemCount: employ.length,
          itemBuilder: ((context, index) {
            return ListTile(
              contentPadding:
                  const EdgeInsets.only(bottom: 7, top: 7, right: 10, left: 10),
              title: Text(
                employ[index],
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {},
            );
          })),
    );
  }
}
