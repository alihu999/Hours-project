import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/employe_model.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    await initHiveBox();
    sharedPreferences = await SharedPreferences.getInstance();

    return this;
  }

  initHiveBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeAdapter());
    await Hive.openBox<Employe>("EmployeBox");
  }

  Box<Employe> getEmploye() => Hive.box<Employe>("EmployeBox");
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
