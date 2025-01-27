import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/leave_balance.dart';
import '../models/leave_report.dart';
import '../models/leave_report_list.dart';
import '../services/leave_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LeaveTripReportController extends GetxController {
  LeaveService? leaveService;
  var leaveReportList = <LeaveReportList>[];
  var leave_report_list = <LeaveReportList>[].obs;

  final box = GetStorage();
  // UserProfileController({@required this.employeeService}) : assert(employeeService != null);

  @override
  void onReady() async {
    super.onReady();
    this.leaveService = await LeaveService().init();
    _getLeaveReport();
  }

  @override
  void onInit() {
    super.onInit();
  }

  _getLeaveReport() async {
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
    await leaveService?.getLeaveReport(int.tryParse(employee_id)!).then((data) {
      createLeaveReport(data);
      Get.back();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void createLeaveReport(List<LeaveReport> list) {
    bool found = false;
    for (int i = 0; i < list.length; i++) {
      var leave_balance = LeaveBalance(
          name: list[i].x_leave_type!,
          entitle: list[i].x_entitle!,
          taken: list[i].x_taken!,
          balance: list[i].x_balance!);

      if (leaveReportList.length != 0) {
        for (int j = 0; j < leaveReportList.length; j++) {
          if (list[i].x_employee_id == leaveReportList[j].employee_id) {
            leaveReportList[j].balance_list!.add(leave_balance);
            found = true;
            break;
          } else {
            found = false;
          }
        }

        if (!found) {
          List<LeaveBalance> leave_balance_list = <LeaveBalance>[];
          leave_balance_list.add(leave_balance);
          var leaveReport = LeaveReportList(
              employee_id: list[i].x_employee_id!,
              employee_name: list[i].x_name!,
              balance_list: leave_balance_list);
          leaveReportList.add(leaveReport);
        }
      } else {
        List<LeaveBalance> leave_balance_list = <LeaveBalance>[];
        leave_balance_list.add(leave_balance);
        var leaveReport = LeaveReportList(
            employee_id: list[i].x_employee_id!,
            employee_name: list[i].x_name!,
            balance_list: leave_balance_list);
        leaveReportList.add(leaveReport);
      }
    }
    leave_report_list.value = leaveReportList;
  }
}
