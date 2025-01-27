
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/overtime_request_response.dart';
import '../routes/app_pages.dart';
import '../services/employee_service.dart';

class OverTimeTabController extends GetxController {
  static OverTimeTabController to = Get.find();
  EmployeeService? employeeService;
  var otList = <OvertimeRequestResponse>[].obs;
  var otAcceptedList = <OvertimeRequestResponse>[].obs;
  var otDeclinedList = <OvertimeRequestResponse>[].obs;
  final box = GetStorage();
  var tabbarshow = 1.obs;

  var button_show = false;
  // UserProfileController({@required this.employeeService}) : assert(employeeService != null);

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // _getOtList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
