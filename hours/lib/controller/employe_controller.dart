import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/model/employe_model.dart';
import 'package:hours/core/services/services.dart';
import 'package:hours/view/home_page/widget/end_day_info.dart';

import '../core/database/sqldb.dart';
import '../core/function/calculate_time.dart';
import '../core/function/time_format.dart';
import '../core/share/custom_snackbar.dart';

abstract class EmployeController extends GetxController {
  addEmploye();
  getEmployes();
  changeEmployeStatus(Employe employe, String status);
  deleteEmploye(Employe employe);
  bool employeIsExist();

  getCurrentId();
  startWork();
  finishWork();
  startBreak();
  finishBreak();
}

class EmployeControllerImp extends EmployeController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late GlobalKey<FormState> firstNameFormState;
  late GlobalKey<FormState> lastNameFormState;

  late FocusNode lastNameFocusNode;

  RxList<Employe> employList = <Employe>[].obs;
  int employeIndex = 0;

  SqlDb sqlDb = SqlDb();
  int currentId = 0;

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
      sqlDb.createTable(
          "${firstNameController.text.trim()}_${lastNameController.text.trim()}");

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
    sqlDb.dropTable("${employe.firstName}_${employe.lastName}");
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
  getCurrentId() async {
    currentId = await sqlDb.numberRows(
        "${employList[employeIndex].firstName}_${employList[employeIndex].lastName}");
  }

  getTableName() {
    return "${employList[employeIndex].firstName}_${employList[employeIndex].lastName}";
  }

  @override
  startWork() async {
    changeEmployeStatus(employList[employeIndex], "isStarted");
    sqlDb.insertData(getTableName());
    getCurrentId();
  }

  @override
  finishWork() async {
    changeEmployeStatus(employList[employeIndex], "isStoped");
    String finishTime = timeFormat(DateTime.now().hour, DateTime.now().minute);
    String startTime =
        await sqlDb.queryTime(getTableName(), "startAt", currentId);
    String breakTime =
        await sqlDb.queryTime(getTableName(), "breakH", currentId);
    String workTime = subTime(differenceTime(startTime, finishTime), breakTime);
    sqlDb.updateData(getTableName(), "finishAt", finishTime, currentId);
    sqlDb.updateData(getTableName(), "workH", workTime, currentId);
    Map rowData = await sqlDb.queryRow(getTableName(), currentId);
    Get.back();
    endDayInfo(
        "${employList[employeIndex].firstName} ${employList[employeIndex].lastName}",
        rowData);
  }

  @override
  startBreak() async {
    changeEmployeStatus(employList[employeIndex], "isBreaked");
    sqlDb.updateData(getTableName(), "breakSat",
        timeFormat(DateTime.now().hour, DateTime.now().minute), currentId);
  }

  @override
  finishBreak() async {
    changeEmployeStatus(employList[employeIndex], "isStarted");
    String finishTime = timeFormat(DateTime.now().hour, DateTime.now().minute);
    String startTime =
        await sqlDb.queryTime(getTableName(), "breakSat", currentId);
    String breakTime =
        await sqlDb.queryTime(getTableName(), "breakH", currentId);
    breakTime = addTime(differenceTime(startTime, finishTime), breakTime);
    sqlDb.updateData(getTableName(), "breakFat", finishTime, currentId);
    sqlDb.updateData(getTableName(), "breakH", breakTime, currentId);
  }
}
