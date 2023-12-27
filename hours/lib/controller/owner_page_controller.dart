import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OwnerPageController extends GetxController {
  addEmploye();
}

class OwnerPageControllerImp extends OwnerPageController {
  late TextEditingController nameController;
  late GlobalKey<FormState> nameFormState;

  @override
  void onInit() {
    nameController = TextEditingController();
    nameFormState = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  addEmploye() {
    final isvalidForm = nameFormState.currentState!.validate();
    if (isvalidForm) {
      print("add ${nameController.text}");
    }
  }
}
