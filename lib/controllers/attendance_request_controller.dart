import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/globals.dart';
import '../models/attendance.dart';
import '../models/attendance_request.dart';
import '../services/attendance_service.dart';
import '../utils/app_utils.dart';

class AttendanceRequestController extends GetxController {
  static AttendanceRequestController to = Get.find();
  AttendanceService? attendanceService;
  var attendance_list = <Attendance>[].obs;
  var attendance_report_list = <Attendance>[].obs;
  String emp_name = '';
  final box = GetStorage();
  var check_in = false.obs;
  var user_latitude = 0.0.obs;
  var user_longitude = 0.0.obs;

  @override
  void onReady() async {
    super.onReady();
    this.attendanceService = await AttendanceService().init();
    getAttendance();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void makeAttendance(String fingerprint_id) async {
    var emp_id = box.read('emp_id');
    var now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
    var current_date_time = formatter.format(now);
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    AttendanceRequest attendanceRequest = AttendanceRequest(
        fingerprint_id: fingerprint_id,
        employee_id: int.tryParse(emp_id)!,
        check_in: current_date_time,latitude: user_latitude.value,longitude: user_longitude.value);

    await attendanceService?.createAttendanceCheckIn(attendanceRequest)
        .then((value) {
      if(value){
      Get.back();
      box.write(Globals.check_in_or_not, !check_in.value);
      check_in.value=!check_in.value;
      getAttendance();
      AppUtils.showDialog('Information', 'Successfully Created Attendance');
      }
    });
  }

  updateCheckInOutState() {
    check_in.value = true;
  }

  void getAttendance() async {
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
    var emp_id = box.read('emp_id');
    await attendanceService?.getOwnAtendance(int.tryParse(emp_id)!,0.toString()).then((data) {
      if (data.length != 0) {
        attendance_list.value = data;
      }
      Get.back();
    });
  }
}
