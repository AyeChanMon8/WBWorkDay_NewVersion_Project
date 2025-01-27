import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/employee_service.dart';

import 'package:get/get.dart';

import '../utils/app_utils.dart';
import '../routes/app_pages.dart';

class ForgetPasswordController extends GetxController {
  EmployeeService? employeeService;
  TextEditingController barcodeController = TextEditingController();

  final box = GetStorage();

  @override
  void onInit() {
    barcodeController = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
  }

  forgetPassword() async {
    var barcode = barcodeController.text;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await employeeService?.forgetPassword(barcode).then((value) {
      //Get.back();
      if (value.isNotEmpty) {
        Get.back();
        // AppUtils.showDialog(
        //     'Information!', 'Successfully Sent Code to Your Phone!' + value);
        barcodeController.text = '';
        // AppUtils.showConfirmDialog('Information', "Successfully Sent Code to Your Phone!",() async {
        //   Get.back();
        //   Get.toNamed(Routes.OTPCONFIRM, arguments: [
        //   {"value": value},
        //   {"emp_id": barcode}]);
        // });

        Get.defaultDialog(title:'Information', content: Text("Successfully Sent Code to Your Phone!"), confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          Get.toNamed(Routes.OTPCONFIRM, arguments: [
          {"value": value},
          {"emp_id": barcode}]);
        });
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
