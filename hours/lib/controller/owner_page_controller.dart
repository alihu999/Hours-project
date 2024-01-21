import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/function/time_format.dart';
import 'package:hours/core/share/custom_snackbar.dart';

import '../core/database/sqldb.dart';
import '../core/model/employe_model.dart';
import '../core/services/services.dart';
import '../view/employee_records.dart/widget/show_change_time_dialog.dart';

abstract class OwnerPageController extends GetxController {
  addEmploye();
  bool employeIsExist();
  getEmployes();
  deleteEmploye(Employe employe);
  getEmployeeTable();
  totalWorking();
  changeTimeValue(String column, String name, String value, int id);
}

class OwnerPageControllerImp extends OwnerPageController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late GlobalKey<FormState> firstNameFormState;
  late GlobalKey<FormState> lastNameFormState;

  late FocusNode lastNameFocusNode;

  SqlDb sqlDb = SqlDb();

  List<Employe> employList = <Employe>[];
  String tableName = "";
  List<Map> dataTable = <Map>[];

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
  getEmployes() {
    employList = MyServices.getEmploye().values.toList();
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
      sqlDb.createTable(
          "${firstNameController.text.trim()}_${lastNameController.text.trim()}");

      firstNameController.clear();
      lastNameController.clear();
      Get.back();
      successfulSnackBar("The employee record has been adedd successfully");

      getEmployes();
      update();
    }
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

  @override
  deleteEmploye(Employe employe) {
    employe.delete();
    Get.back();
    successfulSnackBar("The employee record has been deleted successfully");
    getEmployes();
    sqlDb.dropTable("${employe.firstName}_${employe.lastName}");
    update();
  }

  @override
  Future<List<Map>> getEmployeeTable() async {
    dataTable = await sqlDb.queryData(tableName);
    return dataTable;
  }

  @override
  totalWorking() {
    int totoalMinute = 0;
    for (Map element in dataTable) {
      totoalMinute = totoalMinute +
          (int.parse(element["workH"].substring(0, 2))) * 60 +
          (int.parse(element["workH"].substring(3, 5)));
    }
    return "${totoalMinute ~/ 60} hours & ${totoalMinute % 60}";
  }

  @override
  changeTimeValue(String column, String name, String value, int id) async {
    TimeOfDay newTime = await showChangeTimeDialog(Get.context!, column, value);
    if (value != timeFormat(newTime.hour, newTime.minute)) {
      await sqlDb.updateData(
          tableName, name, timeFormat(newTime.hour, newTime.minute), id);
      update();
    }
  }
}
