import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/model/employe_model.dart';
import 'package:hours/core/services/services.dart';

import '../core/share/custom_snackbar.dart';

abstract class EmployeController extends GetxController {
  addEmploye();
  getEmployes();
  changeEmployeStatus(
    Employe employe,
    String status,
  );
  deleteEmploye(Employe employe);
  bool employeIsExist();
}

class EmployeControllerImp extends EmployeController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late GlobalKey<FormState> firstNameFormState;
  late GlobalKey<FormState> lastNameFormState;

  late FocusNode lastNameFocusNode;

  RxList<Employe> employList = <Employe>[].obs;
  int employeIndex = 0;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    firstNameFormState = GlobalKey<FormState>();
    lastNameFormState = GlobalKey<FormState>();

    lastNameFocusNode = FocusNode();
    getEmployes();

    super.onInit();
  }

  @override
  void onClose() {
    MyServices.getEmploye().close();
    super.onClose();
  }

  @override
  addEmploye() {
    if (lastNameFormState.currentState!.validate() &&
        firstNameFormState.currentState!.validate() &&
        !employeIsExist()) {
      final employe = Employe()
        ..firstName = firstNameController.text.trim()
        ..lastName = lastNameController.text.trim()
        ..status = "isStoped";
      MyServices.getEmploye().add(employe);
      // sqlDb.createTable(
      //   "${firstNameController.text}_${lastNameController.text}");

      firstNameController.clear();
      lastNameController.clear();
      Get.back();
      successfulSnackBar("The employee record has been adedd successfully");

      getEmployes();
    }
  }

  @override
  getEmployes() {
    employList.value = MyServices.getEmploye().values.toList();
  }

  @override
  changeEmployeStatus(Employe employe, String status) {
    employe.status = status;
    employe.save();
    getEmployes();
  }

  @override
  deleteEmploye(Employe employe) {
    employe.delete();
    Get.back();
    successfulSnackBar("The employee record has been deleted successfully");
    getEmployes();
  }

  @override
  employeIsExist() {
    for (int i = 0; i < employList.length; i++) {
      if (employList[i].firstName == firstNameController.text.trim() &&
          employList[i].lastName == lastNameController.text.trim()) {
        errorSnackBar("The employe name is exist");
        return true;
      }
    }
    return false;
  }
}
