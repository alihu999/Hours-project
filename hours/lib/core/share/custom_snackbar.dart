import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(String message) {
  return Get.snackbar("Error", message,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 40,
      ),
      backgroundColor: Colors.black.withOpacity(0.5));
}

successfulSnackBar(String message) {
  return Get.snackbar("Done", message,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      icon: const Icon(
        Icons.done_outline_rounded,
        color: Colors.green,
        size: 40,
      ),
      backgroundColor: Colors.black.withOpacity(0.5));
}
