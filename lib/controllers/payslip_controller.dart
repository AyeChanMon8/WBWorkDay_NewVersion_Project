
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/hr_rule.dart';
import '../models/loan.dart';
import '../models/payslip.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class PayslipController extends GetxController {
  static PayslipController to = Get.find();
  EmployeeService? employeeService;
  var paySlips = <PaySlips>[].obs;
  var rulesList = <Hr_rule>[].obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();

    this.employeeService = await EmployeeService().init();
    // _getloanList();
    getPaySlips();
  }

  @override
  void onInit() {
    super.onInit();
    // _getloanList();
  }

  getPaySlips() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var employee_id = box.read('emp_id');
    await employeeService?.fetchPayslip(employee_id,offset.toString()).then((data) {
      print("payslipLength");
      print(data.length);
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   paySlips.add(element);
        // });
        for(var i=0;i<data.length;i++){
          paySlips.add(data[i]);
        }
      }else{
        paySlips.value = data;
      }
      Get.back();
    });

  }

  @override
  void onClose() {
    super.onClose();
  }
}
