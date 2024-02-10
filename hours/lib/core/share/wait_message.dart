import 'package:flutter/material.dart';
import 'package:get/get.dart';

waitMassege() {
  return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Please Wait....",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none),
              )
            ],
          ));
}
