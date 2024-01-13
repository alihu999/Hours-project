import 'package:get/get.dart';

import '../core/database/sqldb.dart';

abstract class EmployeeRecordsControllert extends GetxController {}

class EmploeeRecordsControllerImp extends EmployeeRecordsControllert {
  List<Map> employeeTable = [];
  String tableName = "";

  SqlDb sqlDb = SqlDb();

  Future<List<Map>> getEmployeeTable() async {
    return await sqlDb.queryData(tableName);
  }
}
