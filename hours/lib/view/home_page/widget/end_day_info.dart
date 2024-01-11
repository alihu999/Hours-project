import 'package:flutter/material.dart';
import 'package:get/get.dart';

endDayInfo(String name, Map info) {
  return Get.defaultDialog(
      title: name,
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${info["date"]}"),
            Text("Started work At: ${info["startAt"]}"),
            Text("Finish work At: ${info["finishAt"]}"),
            Text(
                "Break For: ${info["breakH"].toString().substring(0, 2)} hour & ${info["breakH"].toString().substring(3, 5)} minute"),
            Text(
                "Work For: ${info["workH"].toString().substring(0, 2)} hour & ${info["workH"].toString().substring(3, 5)} minute")
          ],
        ),
      ));
}
