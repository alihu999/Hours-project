import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/model/employe_model.dart';
import 'package:hours/core/services/services.dart';

import '../core/share/custom_snackbar.dart';

abstract class EmployeController extends GetxController {
  addEmploye();
  getEmployes();
  editEmploye(Employe employe, String fname, String lname);
  deleteEmploye(Employe employe);
  bool employeIsExist();
}

class EmployeControllerImp extends EmployeController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late GlobalKey<FormState> firstNameFormState;
  late GlobalKey<FormState> lastNameFormState;

  RxList<Employe> employList = <Employe>[].obs;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    firstNameFormState = GlobalKey<FormState>();
    lastNameFormState = GlobalKey<FormState>();
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
        ..firstName = firstNameController.text
        ..lastName = lastNameController.text
        ..status = "isStoped";
      MyServices.getEmploye().add(employe);
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
  editEmploye(Employe employe, String fname, String lname) {
    employe.firstName = fname;
    employe.lastName = lname;
    employe.save();
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
      if (employList[i].firstName == firstNameController.text &&
          employList[i].lastName == lastNameController.text) {
        errorSnackBar("The employe name is exist");
        return true;
      }
    }
    return false;
  }
}
