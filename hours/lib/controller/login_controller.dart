import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hours/core/constant/app_routes.dart';
import 'package:hours/core/services/services.dart';
import 'package:hours/core/share/custom_snackbar.dart';
import 'package:hours/core/share/wait_message.dart';

import '../core/database/firebase_data.dart';
import '../core/database/sqldb.dart';
import '../core/model/employe_model.dart';
import '../view/login_page/widget/restore_data_dialog.dart';

abstract class LogInController extends GetxController {
  login();
  addDataTolocalStorge();
}

class LogInControllerImp extends LogInController {
  late TextEditingController email;
  late TextEditingController password;

  late GlobalKey<FormState> emailFormState;
  late GlobalKey<FormState> passwordFormState;

  late FocusNode passwordFocusNode;

  Map firebaseData = {};
  SqlDb sqlDb = SqlDb();

  MyServices myServices = Get.find();

  RxBool processLogin = false.obs;
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();

    emailFormState = GlobalKey<FormState>();
    passwordFormState = GlobalKey<FormState>();

    passwordFocusNode = FocusNode();

    super.onInit();
  }

  @override
  login() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      if (emailFormState.currentState!.validate() &&
          passwordFormState.currentState!.validate()) {
        processLogin.value = true;
        var respons =
            await firebsaeSignIn(email.text.trim(), password.text.trim());
        if (respons != null) {
          firebaseData = await getAllFirebaseData();
          if (firebaseData.isNotEmpty) {
            Get.defaultDialog(
              title: "Restore Data",
              content: const RestoreDataContent(),
            );
          } else {
            Get.offNamed(AppRoutes.homePage);
          }
        }
        processLogin.value = false;
      }
    } else {
      errorSnackBar("check internet connection and Try again ");
    }
  }

  @override
  addDataTolocalStorge() async {
    Get.back();
    waitMassege();
    for (String tableName in firebaseData.keys) {
      final employe = Employe()
        ..firstName = tableName.substring(0, tableName.indexOf("_"))
        ..lastName = tableName.substring(tableName.indexOf("_") + 1)
        ..status = "isStoped";
      myServices.getEmploye().add(employe);
      await sqlDb.createTable(tableName);
      for (Map record in firebaseData[tableName]) {
        await sqlDb.insertDataFromfirebase(tableName, record);
      }
      Get.offAllNamed(AppRoutes.homePage);
    }
  }
}
