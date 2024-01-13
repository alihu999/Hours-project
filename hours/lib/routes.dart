import 'package:flutter/material.dart';
import 'package:hours/core/constant/app_routes.dart';
import 'package:hours/view/employee_records.dart/employee_records.dart';
import 'package:hours/view/home_page/home_page.dart';
import 'package:hours/view/owner_page/owner_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.homePage: (context) => const HomePage(),
  AppRoutes.ownerPage: (context) => const OwnerPage(),
  AppRoutes.employeeRecordsPage: (context) => const EmployeeRecords()
};
