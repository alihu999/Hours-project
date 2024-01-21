import 'package:flutter/material.dart';
import 'package:hours/core/constant/app_colors.dart';

showChangeTimeDialog(BuildContext context, String column, String value) {
  return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(value.substring(0, 2)),
          minute: int.parse(value.substring(3, 5))),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      helpText: "Edite $column value",
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: AppColors.secondColors,
              entryModeIconColor: AppColors.secondColors,
              helpTextStyle: const TextStyle(fontSize: 17),
            ),
          ),
          child: child!,
        );
      });
}
