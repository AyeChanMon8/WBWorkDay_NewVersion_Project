
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/overtime_request_response.dart';
import '../models/overtime_response.dart';
import '../services/overtime_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OverTimeResponseController extends GetxController {
  static OverTimeResponseController to = Get.find();
  OvertimeService? overtimeService;
  var otrList = <OvertimeResponse>[].obs;
  var otAcceptedList = <OvertimeRequestResponse>[].obs;
  var otDeclinedList = <OvertimeRequestResponse>[].obs;
  var button_show = false;
  final box = GetStorage();
  // UserProfileController({@required this.employeeService}) : assert(employeeService != null);

  @override
  void onReady() async {
    super.onReady();
    this.overtimeService = await OvertimeService().init();
    _getOtResponse();
    // print("OT list controller");
  }

  @override
  void onInit() {
    super.onInit();
  }

  _getOtResponse() async {
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
    var role = box.read('role_category');

    if (role == 'employee') {
      await overtimeService?.getEmployeeOvertimeResponseList(employee_id)
          .then((data) {
        print(role);
        otrList.value = data;
        print(otrList.value);

        Get.back();
      });
    } else {
      await overtimeService?.getManagerOvertimeResponseList(employee_id)
          .then((data) {
        print(role);
        otrList.value = data;

        Get.back();
      });
    }
  }

  _getOtAcceptedList(List<OvertimeRequestResponse> data) async {
    for (int i = 0; i < data.length; i++) {
      if (data[i].state == 'accepted') {
        otAcceptedList.add(data[i]);
      }
    }
  }

  _getOtDeclinedList(List<OvertimeRequestResponse> data) async {
    for (int i = 0; i < data.length; i++) {
      if (data[i].state == 'declined') {
        _getOtDeclinedList(data).add(data[i]);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
