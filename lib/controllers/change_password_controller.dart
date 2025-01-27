
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/employee_service.dart';

import 'package:get/get.dart';

import '../utils/app_utils.dart';

class ChangePasswordController extends GetxController {
  EmployeeService? employeeService;
  TextEditingController employeeIDController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final box = GetStorage();

  @override
  void onInit() {
    employeeIDController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // changePassword();
  }

  changePassword() async {
    var emp_id = employeeIDController.text;
    var new_pwd = newPasswordController.text;

    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await employeeService?.changePassword(emp_id, new_pwd)
        .then((value) {
      if (value) {
        Get.back();
        AppUtils.showDialogPassword('Hello!', 'Your Password has been changed ');
      } 
      // else {
      //   AppUtils.showDialog('Information!', 'Not Success!');
      // }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
