
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../routes/app_pages.dart';

import '../services/employee_service.dart';

import 'package:get/get.dart';

import '../utils/app_utils.dart';

class OtpController extends GetxController {
  EmployeeService? employeeService;
  TextEditingController userOtpController = TextEditingController();

  final box = GetStorage();

  @override
  void onInit() {
    userOtpController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // changePassword();
  }

  compareOtpCode(String otpCode,String emp_id) async {
    if(userOtpController.text.isEmpty){
      AppUtils.showDialog('Warning', 'Please Fill Otp Code!');
    }else{
      var user_otp = userOtpController.text;

          Future.delayed(
              Duration.zero,
              () => Get.dialog(
                  Center(
                      child: SpinKitWave(
                    color: Color.fromRGBO(63, 51, 128, 1),
                    size: 30.0,
                  )),
                  barrierDismissible: false));
          await employeeService?.compareotpcode(otpCode, user_otp)
              .then((value) {
            if (value) {
              Get.back();
              // AppUtils.showConfirmDialog('Information', "Success!",() async {
              //   userOtpController.text = '';
              //   Get.back();
              //   Get.toNamed(Routes.CHANGE_PASSWORD, arguments: emp_id);
              // });

              Get.defaultDialog(title:'Information',content: Text('Success!'),confirmTextColor: Colors.white,onConfirm: () async{
                userOtpController.text = '';
                Get.back();
                Get.toNamed(Routes.CHANGE_PASSWORD, arguments: emp_id);
              });
            }
          });
    }
    
  }

  @override
  void onClose() {
    super.onClose();
  }
}
