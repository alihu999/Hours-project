import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/model/employe_model.dart';
import 'package:hours/core/services/services.dart';

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

  List<Employe> employList = [];

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
      Get.back();
      firstNameController.clear;
      lastNameController.clear;
      getEmployes();
    }
  }

  @override
  getEmployes() {
    employList = MyServices.getEmploye().values.toList();
    print(employList);
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
  }

  @override
  employeIsExist() {
    for (int i = 0; i < employList.length; i++) {
      if (employList[i].firstName == firstNameController.text &&
          employList[i].lastName == lastNameController.text) {
        Get.snackbar(" Error", "The employe name is exist",
            duration: const Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM);
        return true;
      }
    }
    return false;
  }
}
