import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hours/core/model/employe_model.dart';
import 'package:hours/core/services/services.dart';
import 'package:hours/view/home_page/widget/end_day_info.dart';

import '../core/database/firebase_data.dart';
import '../core/database/sqldb.dart';
import '../core/function/calculate_time.dart';
import '../core/function/time_format.dart';

abstract class EmployeController extends GetxController {
  getEmployes();
  changeEmployeStatus(Employe employe, String status);

  getCurrentId();
  startWork();
  finishWork();
  startBreak();
  finishBreak();
  uploadData();
}

class EmployeControllerImp extends EmployeController {
  RxList<Employe> employList = <Employe>[].obs;
  int employeIndex = 0;

  SqlDb sqlDb = SqlDb();
  int currentId = 0;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    getEmployes();

    super.onInit();
  }

  @override
  void onClose() {
    myServices.getEmploye().close();
    super.onClose();
  }

  @override
  getEmployes() {
    employList.value = myServices.getEmploye().values.toList();
  }

  @override
  changeEmployeStatus(Employe employe, String status) {
    employe.status = status;
    employe.save();
    getEmployes();
  }

  @override
  getCurrentId() async {
    currentId = await sqlDb.numberRows(getTableName());
  }

  getTableName() {
    return "${employList[employeIndex].firstName}_${employList[employeIndex].lastName}";
  }

  @override
  startWork() async {
    changeEmployeStatus(employList[employeIndex], "isStarted");
    await sqlDb.insertData(getTableName());
    getCurrentId();
    Get.back();
  }

  @override
  finishWork() async {
    changeEmployeStatus(employList[employeIndex], "isStoped");
    String finishTime = timeFormat(DateTime.now().hour, DateTime.now().minute);
    await getCurrentId();
    String startTime =
        await sqlDb.queryTime(getTableName(), "startAt", currentId);

    String breakTime =
        await sqlDb.queryTime(getTableName(), "breakH", currentId);

    String workTime = subTime(differenceTime(startTime, finishTime), breakTime);

    await sqlDb.updateData(getTableName(), "finishAt", finishTime, currentId);
    await sqlDb.updateData(getTableName(), "workH", workTime, currentId);
    Map rowData = await sqlDb.queryRow(getTableName(), currentId);
    Get.back();
    endDayInfo(
        "${employList[employeIndex].firstName} ${employList[employeIndex].lastName}",
        rowData);
    int upload = await uploadRecord(getTableName(), rowData);
    if (upload == 1) {
      await sqlDb.updateData(getTableName(), "upload", "$upload", currentId);
    }
  }

  @override
  startBreak() async {
    changeEmployeStatus(employList[employeIndex], "isBreaked");
    await getCurrentId();
    await sqlDb.updateData(getTableName(), "breakSat",
        timeFormat(DateTime.now().hour, DateTime.now().minute), currentId);
    Get.back();
  }

  @override
  finishBreak() async {
    changeEmployeStatus(employList[employeIndex], "isStarted");
    String finishTime = timeFormat(DateTime.now().hour, DateTime.now().minute);
    await getCurrentId();
    String startTime =
        await sqlDb.queryTime(getTableName(), "breakSat", currentId);
    String breakTime =
        await sqlDb.queryTime(getTableName(), "breakH", currentId);
    breakTime = addTime(differenceTime(startTime, finishTime), breakTime);
    sqlDb.updateData(getTableName(), "breakFat", finishTime, currentId);
    sqlDb.updateData(getTableName(), "breakH", breakTime, currentId);
    Get.back();
  }

  @override
  uploadData() async {
    //check internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      //loop on employees list
      for (Employe employee in employList) {
        //create table name
        String tableName = "${employee.firstName}_${employee.lastName}";
        //get data of table from database
        List<Map> tablesData = await sqlDb.queryData(tableName);
        //loop on row in table
        for (Map row in tablesData) {
          //check row in table and upload row
          if (row["upload"] == 0) {
            int upload = await uploadRecord(tableName, row);
            if (upload == 1) {
              await sqlDb.updateData(
                  tableName, "upload", "$upload", row["_id"]);
            }
          }
        }
      }
      return true;
    } else {
      return false;
    }
  }
}
