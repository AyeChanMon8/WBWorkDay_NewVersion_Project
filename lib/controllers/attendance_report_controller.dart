
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/attandanceuser.dart';
import '../models/attendance.dart';
import '../models/attendance_custom_report.dart';
import '../services/attendance_service.dart';
import '../utils/app_utils.dart';

class AttendanceReportController extends GetxController {
  AttendanceService? attendanceService;
  // RxList attendance_report_list = List<Attendance>().obs;
  // var attendance_approve_list = List<Attendance>().obs;
  // RxList attendance_early_report_list = List<Attendance>().obs;
  // RxList attendance_late_report_list = List<Attendance>().obs;
  // RxList attendance_list_byDate = List<Attendance>().obs;
  // var attendance_toapprove_list = List<Attendance>().obs;
  // var attendance_own_list = List<Attendance>().obs;
  // var attendance_list = List<Attendance>();//   RxList atten
  RxList attendance_report_list = <Attendance>[].obs;
  var attendance_approve_list = <Attendance>[].obs;
  dynamic attendance_early_report_list = <Attendance>[].obs;
  dynamic attendance_late_report_list = <Attendance>[].obs;
  dynamic attendance_list_byDate = <Attendance>[].obs;
  dynamic attendance_toapprove_list = <Attendance>[].obs;
  var attendance_custom_report = <AttendanceCustomReport>[].obs;
  dynamic attendance_emp_custom_report = <AttendanceCustomReport>[].obs;
  var attendance_employee_history = <Attandanceuser>[].obs;
  var employee_history_attendance_list = <Attendance>[].obs;
  dynamic attendance_toapprove_date_list = <String>[].obs;
  var attendance_own_list = <Attendance>[].obs;
  var attendance_list = <Attendance>[];
  final box = GetStorage();
  TextEditingController? fromDateTextController;
  TextEditingController? toDateTextController;
  var check_select_all_late = false.obs;
  var check_select_all_early = false.obs;
  var check_select_all_date = false.obs;
  var check_select_all = false.obs;
  var check_select_show_late = false.obs;
  var check_select_show_early = false.obs;
  var check_select_show_date = false.obs;
  var check_select_show = false.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var attendance_ids_list = <int>[].obs;
  List<bool> check_select = <bool>[].obs;

  @override
  void onReady() async {
    super.onReady();
    this.attendanceService = await AttendanceService().init();
    var role_category = box.read('role_category');
    if (role_category == 'manager') {
      getAttendanceInfoForManager();
    } else {
      getOwnAttendance();
    }
    // getApproved();
    // getEarlyReports();
    // getLateReports();
  }

  @override
  void onInit() async {
    fromDateTextController = TextEditingController();
    toDateTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAttendanceToApprove() async {
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
    print('emp_id $emp_id');
    await attendanceService
        ?.getAttendanceRequestToApprove(emp_id, offset.toString())
        .then((data) {
      Get.back();
      if (data.length != null) {
        List<String> dateList = [];
        List<AttendanceCustomReport> customReportList = [];
        bool found = false;
        for (int i = 0; i < data.length; i++) {
          var utc_date = data[i].check_in.toString();
          var dateTime =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
          var dateLocal = dateTime.toLocal().toString();
          var split_date = dateLocal.split(" ")[0];

          if (customReportList.length != 0) {
            for (int j = 0; j < customReportList.length; j++) {
              if (customReportList[j].date == split_date) {
                customReportList[j].attendance_list.add(data[i]);
                found = true;
                break;
              } else {
                found = false;
              }
            }
            if (!found) {
              var utc_date = data[i].check_in.toString();
              var dateTime =
                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
              var dateLocal = dateTime.toLocal().toString();
              var split_date = dateLocal.split(" ")[0];
              List<Attendance> attendanceReportList = [];
              attendanceReportList.add(data[i]);
              customReportList.add(AttendanceCustomReport(
                  date: split_date, attendance_list: attendanceReportList));
            }
          } else {
            var utc_date = data[i].check_in.toString();
            var dateTime =
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
            var dateLocal = dateTime.toLocal().toString();
            var split_date = dateLocal.split(" ")[0];
            List<Attendance> attendanceReportList = [];
            attendanceReportList.add(data[i]);
            customReportList.add(AttendanceCustomReport(
                date: split_date, attendance_list: attendanceReportList));
          }
        }
        if (offset != 0) {
          isLoading.value = false;
          //attendance_custom_report.addAll(customReportList);
          customReportList.forEach((element) {
            attendance_custom_report.add(element);
          });
        } else {
          attendance_custom_report.value = customReportList;
        }

        // print('attendance report list => $attendance_custom_report');

        attendance_toapprove_list.value = data;
        if (attendance_toapprove_list.length > 0) {
          check_select_show.value = true;
        }
      }
    });
  }

  getEmpHistory() async {
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
    await attendanceService
        ?.getAttendanceInfo(int.tryParse(emp_id)!, offset.toString())
        .then((data) {
      Get.back();
      if (data.length != 0) {
        if (offset != 0) {
          isLoading.value = false;
          //attendance_employee_history.addAll(data);
          for (var i = 0; i < data.length; i++) {
            attendance_employee_history
                .add(data[i]); // prints each element of the array
          }
          // data.forEach((element) {
          //   attendance_employee_history.add(element);
          // });
        } else {
          attendance_employee_history.value = data;
        }
      }
    });
  }

  Future<void> getOwnAttendance() async {
    isLoading.value = true;
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
    await attendanceService
        ?.getOwnAtendance(int.tryParse(emp_id)!, offset.toString())
        .then((data) {
      Get.back();
      // List<Attendance> tempData = [];
      if (data.length != 0) {
        // print('getOwnAttendance: $data');
        // data.forEach((element) {
        //   element.check_in = AppUtils().changeToLocalDateTime(element.check_in);
        //   element.check_out =
        //       AppUtils().changeToLocalDateTime(element.check_out);
        // });

        // print('tempData => $tempData');
        if (offset != 0) {
          isLoading.value = false;
          //attendance_own_list.addAll(data) ;
          for (var i = 0; i < data.length; i++) {
            attendance_own_list
                .add(data[i]); // prints each element of the array
          }
          // data.forEach((element) {
          //   print('element=> $element');
          //   attendance_own_list.add(element);
          // });
        } else {
          attendance_own_list.value = data;
        }
        // print('attendance_own_list => $attendance_own_list');
      }
    });
  }

  void getAttendanceEmployeeHistoryList(int emp_id, String date) async {
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
    // var emp_id = box.read('emp_id');
    await attendanceService
        ?.getAttendanceEmployeeHistoryList(emp_id, date)
        .then((data) {
      Get.back();
      if (offset != 0) {
        isLoading.value = false;
        //employee_history_attendance_list.addAll(data);
        for (var i = 0; i < data.length; i++) {
          employee_history_attendance_list
              .add(data[i]); // prints each element of the array
        }
        // data.forEach((element) {
        //   employee_history_attendance_list.add(element);
        // });
      } else {
        employee_history_attendance_list.value = data;
      }

      update();
    });
  }

  void getEarlyReports() async {
    //this.attendanceService = await AttendanceService().init();
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: SpinKitWave(
    //   color: Color.fromRGBO(63, 51, 128, 1),
    //   size: 30.0,
    // )),
    //         barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var emp_id = box.read('emp_id');
    await attendanceService
        ?.getAttendanceEarlyReport(int.tryParse(emp_id)!)
        .then((data) {
      if (data.length != 0) {
        attendance_early_report_list.value = data;
        attendance_early_report_list.value
            .sort((a, b) => a.employee_id.name.compareTo(b.employee_id.name));
        if (attendance_early_report_list.length > 0) {
          check_select_show_early.value = true;
        }
      }
    });
  }

  void getLateReports() async {
    //this.attendanceService = await AttendanceService().init();
    //fetch emp_id from GetX Storage
    var emp_id = box.read('emp_id');
    await attendanceService
        ?.getAttendanceLateReport(int.tryParse(emp_id)!)
        .then((data) {
      if (data.length != 0) {
        attendance_late_report_list.value = data;
        attendance_late_report_list.value
            .sort((a, b) => a.employee_id.name.compareTo(b.employee_id.name));
        if (attendance_late_report_list.length > 0) {
          check_select_show_late.value = true;
        }
      }
    });
  }

  void filterByDate(DateTime selectedFromDate, DateTime selectedToDate) {
    for (int j = 0; j < attendance_list.length; j++) {
      attendance_list[j].check = false;
    }
    var attendance_filter_list = <Attendance>[];
    for (int i = 0; i < attendance_list.length; i++) {
      if (attendance_list[i].check_in != null &&
          attendance_list[i].check_out.isNotEmpty) {
        var dateTime_utc_checkin = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(attendance_list[i].check_in, true);
        var dateLocal_check_in = dateTime_utc_checkin.toLocal();
        var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(attendance_list[i].check_out, true);
        var dateLocal_check_out = dateTime.toLocal();
        if (dateLocal_check_in.isAfter(selectedFromDate) &&
            dateLocal_check_out.isBefore(selectedToDate)) {
          // do something
          attendance_filter_list.add(attendance_report_list[i]);
        }
      }
    }
    if (attendance_filter_list.length > 0) {
      check_select_show_date.value = true;
      attendance_list_byDate.value = attendance_filter_list;
    }
  }

  void updateSingleCheck(int index, bool value, int childIndex) {
    var attendance_id =
        attendance_custom_report[index].attendance_list[childIndex].id;
    if (value) {
      bool found = false;
      for (int i = 0; i < attendance_ids_list.length; i++) {
        if (attendance_ids_list[i] == attendance_id) {
          found = true;
          break;
        }
      }
      if (!found) {
        attendance_ids_list.add(
            attendance_custom_report[index].attendance_list[childIndex].id);
      }
    } else {
      attendance_ids_list.removeWhere((item) => item == attendance_id);
    }
    attendance_custom_report[index]
        .attendance_list
        .elementAt(childIndex)
        .check = value;
    attendance_custom_report.refresh();
  }

  void updateCheck(int index, bool value, String state) {
    if (state == 'all') {
      attendance_toapprove_list.elementAt(index).check = value;
      attendance_toapprove_list.refresh();
    } else if (state == 'early') {
      // attendance_early_report_list.value[index].check = value;
      // var attendance = attendance_early_report_list.value[index];
      // attendance_early_report_list.removeAt(index);
      // attendance_early_report_list.value.insert(index, attendance);
      attendance_early_report_list.elementAt(index).check = value;
      attendance_early_report_list.refresh();
    } else if (state == 'late') {
      attendance_late_report_list.elementAt(index).check = value;
      attendance_late_report_list.refresh();
    } else {
      attendance_list_byDate.elementAt(index).check = value;
      attendance_list_byDate.refresh();
    }
  }

  void updateCheckSelectALlForAllReport(bool value) {
    //update state by select all
    attendance_custom_report.forEach((element) {
      //element.check = value;
      for (int i = 0; i < element.attendance_list.length; i++) {
        element.attendance_list[i].check = value;
      }
      //print(element.approved);
    });
    attendance_custom_report.refresh();
    attendance_ids_list.clear();
    if (value) {
      for (int i = 0; i < attendance_custom_report.length; i++) {
        for (int j = 0;
            j < attendance_custom_report[i].attendance_list.length;
            j++) {
          attendance_ids_list
              .add(attendance_custom_report[i].attendance_list[j].id);
        }
      }
    } else {
      attendance_ids_list.clear();
    }
  }

  void updateCheckSelectALlForAllLateReport(bool value) {
    attendance_late_report_list.update((val) {
      val.forEach((element) {
        element.check = value;
        //print(element.approved);
      });
    });
  }

  void updateCheckSelectALlForAllEarlyReport(bool value) {
    attendance_ids_list.clear();
    attendance_ids_list.value = attendance_early_report_list.update((val) {
      val.forEach((element) {
        element.check = value;
        //print(element.approved);
      });
    });
  }

  void updateCheckSelectALlForAllDateReport(bool value) {
    attendance_list_byDate.update((val) {
      val.forEach((element) {
        element.check = value;
        //print(element.approved);
      });
    });
  }

  void approveOneAttendance(int parent_index, int index) async {
    await attendanceService
        ?.approveAttendance(
            attendance_custom_report[parent_index].attendance_list[index].id)
        .then((data) {
      getAttendanceToApprove();
      //updateCheck(index, false, state);
      //AppUtils.showDialog('Information', 'Successfully Approved!');
      // AppUtils.showConfirmDialog('Information', 'Successfully Approved!', () {
      //   Get.back();
      //   getAttendanceToApprove();
      // });
      Get.defaultDialog(title:'Information',content: Text('Successfully Approved!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          getAttendanceToApprove();
      });
    });
  }

  void declineOneAttendance(int parent_index, int index) async {
    await attendanceService
        ?.declineAttendance(
            attendance_custom_report[parent_index].attendance_list[index].id)
        .then((data) {
      // getAttendanceToApprove();
      // AppUtils.showDialog('Information', 'Successfully Declined!');
      // AppUtils.showConfirmDialog('Information', 'Successfully Declined!', () {
      //   Get.back();
      //   getAttendanceToApprove();
      // });
       Get.defaultDialog(title:'Information',content: Text('Successfully Declined!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
        getAttendanceToApprove();
      });
    });
  }

  void approveSingleAttendance(String state, int index) async {
    if (state == 'all') {
      await attendanceService
          ?.approveAttendance(attendance_toapprove_list[index].id)
          .then((data) {
        getAttendanceToApprove();
        //updateCheck(index, false, state);
        AppUtils.showDialog('Information', 'Successfully Approved!');
        // attendance_report_list[index].check = false;
        // attendance_report_list[index].state = 'approve';
        // update();
      });
    } else if (state == 'early') {
      await attendanceService
          ?.approveAttendance(attendance_early_report_list[index].id)
          .then((data) {
        getEarlyReports();
        //updateCheck(index, false, state);
        AppUtils.showDialog('Information', 'Successfully Approved!');
        // attendance_early_report_list[index].check = false;
        // attendance_early_report_list[index].state = 'approve';
        // update();
      });
    } else if (state == 'late') {
      await attendanceService
          ?.approveAttendance(attendance_late_report_list[index].id)
          .then((data) {
        getLateReports();
        // updateCheck(index, false, state);
        AppUtils.showDialog('Information', 'Successfully Approved!');
        // attendance_late_report_list[index].check = false;
        // attendance_late_report_list[index].state = 'approve';
        // update();
      });
    } else {
      await attendanceService
          ?.approveAttendance(attendance_list_byDate[index].id)
          .then((data) {
        updateCheck(index, false, state);
        AppUtils.showDialog('Information', 'Successfully Approved!');
        attendance_list_byDate[index].check = false;
        attendance_list_byDate[index].state = 'approve';
        update();
      });
    }
  }

  void getApproved() async {
    //fetch emp_id from GetX Storage
    var emp_id = box.read('emp_id');
    await attendanceService
        ?.getAttendanceApproveReport(int.tryParse(emp_id)!)
        .then((data) {
      if (data.length != null) {
        attendance_approve_list.value = data;
        attendance_approve_list.value
            .sort((a, b) => a.employee_id.name.compareTo(b.employee_id.name));
        if (attendance_approve_list.length > 0) {
          check_select_show_early.value = true;
        }
      }
    });
  }

  void approveAllAttendance() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));

    // for (int i = 0; i < attendance_custom_report.length; i++) {
    //   for (int j = 0;
    //       j < attendance_custom_report[i].attendance_list.length;
    //       j++) {
    //     await attendanceService
    //         .approveAttendance(
    //             attendance_custom_report[i].attendance_list[j].id)
    //         .then((data) {
    //       //updateCheckSelectALlForAllReport(false);
    //       check_select_all.value = false;
    //     });
    //   }
    // }

    for (int i = 0; i < attendance_ids_list.length; i++) {
      await attendanceService
          ?.approveAttendance(attendance_ids_list[i])
          .then((data) {
        check_select_all.value = false;
      });
    }
    await getAttendanceToApprove();
    Get.back();
    AppUtils.showDialog('Information', 'On Duty Successfully Completed!');
  }

  void declineAllAttendance() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));

    // for (int i = 0; i < attendance_custom_report.length; i++) {
    //   for (int j = 0;
    //   j < attendance_custom_report[i].attendance_list.length;
    //   j++) {
    //     await attendanceService
    //         .declineAttendance(
    //         attendance_custom_report[i].attendance_list[j].id)
    //         .then((data) {
    //       //updateCheckSelectALlForAllReport(false);
    //       check_select_all.value = false;
    //     });
    //   }
    // }

    for (int i = 0; i < attendance_ids_list.length; i++) {
      await attendanceService
          ?.declineAttendance(attendance_ids_list[i])
          .then((data) {
        //updateCheckSelectALlForAllReport(false);
        check_select_all.value = false;
      });
    }

    Get.back();
      Get.defaultDialog(title:'Information',content: Text('Action Successfully Completed!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          getAttendanceToApprove();
      });

    // AppUtils.showConfirmDialog('Information', 'Action Successfully Completed!',
    //     () {
    //   Get.back();
    //   getAttendanceToApprove();
    // });
  }

  void approveAttendance(String state) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    if (state == 'all') {
      for (int i = 0; i < attendance_toapprove_list.length; i++) {
        await attendanceService
            ?.approveAttendance(attendance_toapprove_list[i].id)
            .then((data) {
          //updateCheckSelectALlForAllReport(false);
          check_select_all.value = false;
        });
      }
      getAttendanceToApprove();
      Get.back();
    } else if (state == 'early') {
      for (int i = 0; i < attendance_early_report_list.length; i++) {
        await attendanceService
            ?.approveAttendance(attendance_early_report_list[i].id)
            .then((data) {
          updateCheckSelectALlForAllEarlyReport(false);
          check_select_all_early.value = false;
        });
      }
      getEarlyReports();
      Get.back();
    } else if (state == 'late') {
      for (int i = 0; i < attendance_late_report_list.length; i++) {
        await attendanceService
            ?.approveAttendance(attendance_late_report_list[i].id)
            .then((data) {
          updateCheckSelectALlForAllLateReport(false);
          check_select_all_late.value = false;
        });
      }
      getLateReports();
      Get.back();
    } else {
      for (int i = 0; i < attendance_list_byDate.length; i++) {
        await attendanceService
            ?.approveAttendance(attendance_list_byDate[i].id)
            .then((data) {
          updateCheckSelectALlForAllDateReport(false);
          check_select_all_date.value = false;
        });
      }
      Get.back();
    }
  }

  getAttendanceInfoForManager() async {
    isLoading.value = true;
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
    await attendanceService
        ?.getOwnAtendance(int.tryParse(emp_id)!, 0.toString())
        .then((data) {
      if (data.length != 0) {
        attendance_own_list.value = data;
      }
    });

    await attendanceService
        ?.getAttendanceRequestToApprove(emp_id, 0.toString())
        .then((data) {
      if (data.length != 0) {
        List<String> dateList = [];
        List<AttendanceCustomReport> customReportList = [];
        bool found = false;
        for (int i = 0; i < data.length; i++) {
          var utc_date = data[i].check_in.toString();
          var dateTime =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
          var dateLocal = dateTime.toLocal().toString();
          var split_date = dateLocal.split(" ")[0];
          if (customReportList.length != 0) {
            for (int j = 0; j < customReportList.length; j++) {
              if (customReportList[j].date == split_date) {
                customReportList[j].attendance_list.add(data[i]);
                found = true;
                break;
              } else {
                found = false;
              }
            }
            if (!found) {
              var utc_date = data[i].check_in.toString();
              var dateTime =
                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
              var dateLocal = dateTime.toLocal().toString();
              var split_date = dateLocal.split(" ")[0];
              List<Attendance> attendanceReportList = [];
              attendanceReportList.add(data[i]);
              customReportList.add(AttendanceCustomReport(
                  date: split_date, attendance_list: attendanceReportList));
            }
          } else {
            var utc_date = data[i].check_in.toString();
            var dateTime =
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(utc_date, true);
            var dateLocal = dateTime.toLocal().toString();
            var split_date = dateLocal.split(" ")[0];
            List<Attendance> attendanceReportList = [];
            attendanceReportList.add(data[i]);
            customReportList.add(AttendanceCustomReport(
                date: split_date, attendance_list: attendanceReportList));
          }
        }

        attendance_custom_report.value = customReportList;
        attendance_toapprove_list.value = data;
        if (attendance_toapprove_list.length > 0) {
          check_select_show.value = true;
        }
      }
    });
    await attendanceService
        ?.getAttendanceInfo(int.tryParse(emp_id)!, 0.toString())
        .then((data) {
      Get.back();
      if (data.length != 0) {
        attendance_employee_history.value = data;
      }
    });
    /*await attendanceService
        .getAttendanceEmployeeHistoryList(int.tryParse(emp_id))
        .then((data) {
      Get.back();
      if (data.length != 0) {
        List<AttendanceCustomReport> customReportList = [];
        bool found = false;
        for (int i = 0; i < data.length; i++) {
          if (customReportList.length != 0) {
            for (int j = 0; j < customReportList.length; j++) {
              if (customReportList[j].date == data[i].employee_id.name) {
                customReportList[j].attendance_list.add(data[i]);
                found = true;
                break;
              } else {
                found = false;
              }
            }
            if (!found) {
              List<Attendance> attendanceReportList = [];
              attendanceReportList.add(data[i]);
              customReportList.add(AttendanceCustomReport(
                  date: data[i].employee_id.name,
                  attendance_list: attendanceReportList));
            }
          } else {
            List<Attendance> attendanceReportList = [];
            attendanceReportList.add(data[i]);
            customReportList.add(AttendanceCustomReport(
                date: data[i].employee_id.name,
                attendance_list: attendanceReportList));
          }
        }
        print("customReportListSize");
        print(customReportList[0].attendance_list.length);
        attendance_emp_custom_report.value = customReportList;
      }
    });*/
  }
}
