import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MyServices extends GetxService {
  Box? employeBox;

  Future<MyServices> init() async {
    employeBox = await openHiveBox("EmployeBox");

    return this;
  }

  Future<Box> openHiveBox(String boxname) async {
    if (!Hive.isBoxOpen(boxname)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    return await Hive.openBox(boxname);
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
