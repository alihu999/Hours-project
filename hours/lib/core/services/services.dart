import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/employe_model.dart';

class MyServices extends GetxService {
  Future<MyServices> init() async {
    await initHiveBox();
    return this;
  }

  initHiveBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeAdapter());
    await Hive.openBox<Employe>("EmployeBox");
  }

  static Box<Employe> getEmploye() => Hive.box<Employe>("EmployeBox");
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
