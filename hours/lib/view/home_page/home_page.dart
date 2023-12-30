import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/employe_controller.dart';
import 'package:hours/controller/home_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';

import 'widget/change_mode_dialog.dart';
import 'widget/clock_date.dart';
import 'widget/employe_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width > 425 ? false : true;
    Get.put(HomePageControllerImp(), permanent: true);
    Get.put(EmployeControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hours",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.firstColors,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.security,
                ),
                onPressed: () {
                  Get.defaultDialog(
                      title: "Owner Mode",
                      titleStyle: const TextStyle(fontSize: 25),
                      content: const ChangeModeDialog());
                },
              ))
        ],
      ),
      body: Row(
        children: [const EmployeList(), if (!isMobile) const ClockDate()],
      ),
    );
  }
}
