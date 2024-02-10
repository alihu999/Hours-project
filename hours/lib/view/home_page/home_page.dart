import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/controller/employe_controller.dart';
import 'package:hours/controller/home_page_controller.dart';
import 'package:hours/core/constant/app_colors.dart';
import 'package:hours/core/share/custom_snackbar.dart';

import 'widget/change_mode_dialog.dart';
import 'widget/clock_date.dart';
import 'widget/employe_list.dart';
import '../../core/share/wait_message.dart';

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
    Get.put(HomePageControllerImp());
    EmployeControllerImp controller = Get.put(EmployeControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hours",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.firstColors,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.security_outlined,
            ),
            onPressed: () {
              Get.defaultDialog(
                  title: "Owner Mode",
                  titleStyle: const TextStyle(fontSize: 25),
                  content: const ChangeModeDialog());
            },
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.cloud_upload_outlined,
                ),
                onPressed: () async {
                  waitMassege();
                  bool res = await controller.uploadData();
                  Get.back();
                  res == true
                      ? successfulSnackBar("Data uploaded successfully")
                      : errorSnackBar(
                          "Data uploaded failed ,Make sure you are connected to the Internet and try later");
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
