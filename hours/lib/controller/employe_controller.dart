import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/services/services.dart';

abstract class EmployeController extends GetxController {
  getEmployeList();
  addEmploye();
}

class EmployeControllerImp extends EmployeController {
  late TextEditingController nameController;
  late GlobalKey<FormState> nameFormState;
  RxList<Map> employList = <Map>[].obs;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    nameController = TextEditingController();
    nameFormState = GlobalKey<FormState>();
    getEmployeList();
    super.onInit();
  }

  @override
  getEmployeList() {
    employList.clear();
    Map? employe;
    int i = 0;
    while (true) {
      employe = myServices.employeBox!.get(i);
      i = i + 1;
      if (employe != null) {
        employList.add(employe);
      } else {
        break;
      }
    }
  }

  @override
  addEmploye() async {
    final isvalidForm = nameFormState.currentState!.validate();
    if (isvalidForm) {
      int num = await myServices.employeBox!
          .add({"name": nameController.text, "status": "isStoped"});
      if (num >= 0) {
        employList.add({"name": nameController.text, "status": "isStoped"});
        Get.back();
        nameController.clear();
      }
    }
  }
}
