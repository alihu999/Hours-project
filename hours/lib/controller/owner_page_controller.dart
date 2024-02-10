import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/function/split_data_to_tables.dart';
import 'package:hours/core/function/time_format.dart';
import 'package:hours/core/share/custom_snackbar.dart';

import '../core/database/firebase_data.dart';
import '../core/database/sqldb.dart';
import '../core/function/calculate_time.dart';
import '../core/model/employe_model.dart';
import '../core/services/services.dart';
import '../view/employee_records.dart/widget/calculate_salary.dart';
import '../view/employee_records.dart/widget/show_change_time_dialog.dart';

abstract class OwnerPageController extends GetxController {
  addEmploye();
  bool employeIsExist();
  getEmployes();
  deleteEmploye(Employe employe);
  getEmployeeTable();
  totalWorking(String month);
  changeTimeValue(String column, String name, String value, int id);
  calculateSalary(int totalminute);
  deleteRow(int id);
  deleteMonthTable(int firstId, int lastId);
  restoreData();
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
  Map<String, List<Map>> splitedData = {};

  int totalMinute = 0;
  RxDouble salary = 0.0.obs;

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
  deleteEmploye(Employe employe) async {
    bool res = await deletDocument("${employe.firstName}_${employe.lastName}");
    if (res) {
      employe.delete();
      Get.back();
      successfulSnackBar("The employee record has been deleted successfully");
      getEmployes();
      sqlDb.dropTable("${employe.firstName}_${employe.lastName}");
      update();
    } else {
      Get.back();
      errorSnackBar("No internet connection, Try again later");
    }
  }

  @override
  Future<Map<String, List<Map>>> getEmployeeTable() async {
    List<Map> allData = await sqlDb.queryData(tableName);
    splitedData = splitDataToTables(allData);
    return splitedData;
  }

  @override
  totalWorking(String month) {
    List<Map> dataTable = splitedData[month]!;
    int totoalMinute = 0;
    for (Map element in dataTable) {
      totoalMinute = totoalMinute +
          (int.parse(element["workH"].substring(0, 2))) * 60 +
          (int.parse(element["workH"].substring(3, 5)));
    }
    return totoalMinute;
  }

  @override
  changeTimeValue(String column, String name, String value, int id) async {
    //column:name of column in table Ex:Start At
    //name:name of column in database Ex:startAt
    //value: old value
    //id:value of id in database

    //Get new value from user
    TimeOfDay newTime = await showChangeTimeDialog(Get.context!, column, value);
    String newWorkTime = "00:00";
    String breakTime = "00:00";

    //Check if there is a change in value
    if (value != timeFormat(newTime.hour, newTime.minute)) {
      //update value in database
      await sqlDb.updateData(
          tableName, name, timeFormat(newTime.hour, newTime.minute), id);
      //Get break time from database
      breakTime = await sqlDb.queryTime(tableName, "breakH", id);
      //calculate new work time
      if (name == "startAt") {
        //Get finish time from database
        String finishTime = await sqlDb.queryTime(tableName, "finishAt", id);
        //calculate new time
        //new work time=differance between(finish time,start time(new))-break time
        newWorkTime = subTime(
            differenceTime(
                timeFormat(newTime.hour, newTime.minute), finishTime),
            breakTime);
      } else {
        //Get Start time from database
        String startWork = await sqlDb.queryTime(tableName, "startAt", id);
        //calculate new time
        //new work time=differance between(finish time(new),start time)-break time
        newWorkTime = subTime(
            differenceTime(startWork, timeFormat(newTime.hour, newTime.minute)),
            breakTime);
      }
      //save new work time
      await sqlDb.updateData(tableName, "workH", newWorkTime, id);
      //update UI
      update();
      //get  new record
      Map newRow = await sqlDb.queryRow(tableName, id);
      //upload new record
      int upload = await uploadRecord(tableName, newRow);
      //check if upload failed and update upload value in database to false
      if (upload == 0) {
        await sqlDb.updateData(tableName, "upload", "$upload", id);
      }
    }
  }

  @override
  deleteRow(int id) {
    //show confirm dialog to delete Row from table
    Get.defaultDialog(
        title: "Delete Row",
        titleStyle: const TextStyle(fontSize: 20),
        middleText: "Do you want delete the Row?",
        onCancel: () {},
        onConfirm: () async {
          //delete row from table in database
          int respons = await sqlDb.deleteRow(tableName, id);
          if (respons == 1) {
            //show sucessful snackBar
            Get.back();
            successfulSnackBar("the Row has been deleted");
            update();
          }
        });
  }

  @override
  deleteMonthTable(int firstId, int lastId) {
    Get.defaultDialog(
        title: "Delete Table",
        titleStyle: const TextStyle(fontSize: 20),
        middleText: "Do you want delete the Table?",
        onCancel: () {},
        onConfirm: () async {
          int respons = await sqlDb.deleteMultiRow(tableName, firstId, lastId);
          Get.back();
          if (respons == 1) {
            successfulSnackBar("the Table has been deleted");
          }
          update();
        });
  }

  @override
  calculateSalary(int totalminute) {
    Get.defaultDialog(
        title: "calculate Salary", content: const CalculateSalary());
    totalMinute = totalminute;
  }

  @override
  restoreData() async {
    Map firebaseData = await getAllFirebaseData();
    for (var employee in employList) {
      String tablename = "${employee.firstName}_${employee.lastName}";
      if (firebaseData.keys.contains(tablename)) {
        print(tablename);
      }
    }
  }
}
