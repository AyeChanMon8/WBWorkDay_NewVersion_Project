import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/leave_list_response.dart';
import '../models/loan.dart';
import '../models/overtime_request_response.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoanController extends GetxController {
  static LoanController to = Get.find();
  EmployeeService? employeeService;
  var loanList = <Loan>[].obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
   // getloanList();
  }

  @override
  void onInit() {
    super.onInit();
    // _getloanList();
  }

  getloanList() async {
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
    this.employeeService = await EmployeeService().init();
    await employeeService?.fetchLoan(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        print("offsetnotzero");
        print(data.length);
        isLoading.value = false;
        //loanList.value.addAll(data);
        // data.forEach((element) {
        //   loanList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          loanList.add(data[i]);
        }
      }else{
        loanList.value = data;
      }
      update();
      Get.back();
    });
  }

  approveLeave(int id) async {
    print(id);
  }

  decllinedLeave(int id) async {
    print(id);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
