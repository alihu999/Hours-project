import 'package:get/get.dart';
import 'package:hours/core/constant/app_routes.dart';
import 'package:hours/core/middleware/my_middleware.dart';
import 'package:hours/view/employee_records.dart/employee_records.dart';
import 'package:hours/view/home_page/home_page.dart';
import 'package:hours/view/login_page/login_page.dart';
import 'package:hours/view/owner_page/add_employee_page.dart';
import 'package:hours/view/owner_page/owner_page.dart';
import 'package:hours/view/reset_password_page.dart/reset_password_page.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
      name: "/", page: () => const LoginPage(), middlewares: [MyMiddleware()]),
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.ownerPage, page: () => const OwnerPage()),
  GetPage(
      name: AppRoutes.employeeRecordsPage, page: () => const EmployeeRecords()),
  GetPage(name: AppRoutes.addEmployeePage, page: () => const AddEmployeePage()),
  GetPage(name: AppRoutes.loginPage, page: () => const LoginPage()),
  GetPage(
      name: AppRoutes.resetPasswordPage, page: () => const ResetPasswordPage())
];
