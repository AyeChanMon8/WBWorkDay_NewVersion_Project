

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/attendance_report_controller.dart';
import '../models/attandanceuser.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AttendanceApprovalList extends StatefulWidget {
  @override
  _AttendanceApprovalListState createState() => _AttendanceApprovalListState();
}

class _AttendanceApprovalListState extends State<AttendanceApprovalList> {
  final AttendanceReportController controller = Get.find();
  final box = GetStorage();
  String image = '';
  Attandanceuser employee = Attandanceuser();
  @override
  void initState() {
    controller.offset.value = 0;
    employee = Get.arguments;
    controller.getAttendanceEmployeeHistoryList(
        employee.employee_id, employee.search_date);
    super.initState();
  }

  Future _loadData() async {
    print("****loadmore****");
    controller.getAttendanceEmployeeHistoryList(
        employee.employee_id, employee.search_date);
  }

  @override
  Widget build(BuildContext context) {
    //final labels = AppLocalizations.of(context);

    image = box.read('emp_image');
    var limit = Globals.pag_limit;
    // employee = Get.arguments;
    var labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels?.attendanceApprovalList, image)),
      body: Obx(() => NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                print("*****BottomOfLeaveList*****");
                // start loading data
                controller.offset.value += limit;
                controller.isLoading.value = true;
                _loadData();
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.employee_history_attendance_list.length,
              itemBuilder: (BuildContext context, int index) {
                var status = controller
                        .employee_history_attendance_list[index].is_absent
                    ? "Absent"
                    : controller.employee_history_attendance_list[index].missed
                        ? "Missed"
                        : controller
                                .employee_history_attendance_list[index].travel
                            ? "Travel"
                            : controller.employee_history_attendance_list[index]
                                    .leave
                                ? "Leave"
                                : controller
                                        .employee_history_attendance_list[index]
                                        .no_worked_day
                                    ? "No Work Day Leave"
                                    : controller
                                            .employee_history_attendance_list[
                                                index]
                                            .plan_trip
                                        ? "Plan Trip"
                                        : controller
                                                .employee_history_attendance_list[
                                                    index]
                                                .day_trip
                                            ? "Day Trip"
                                            : "";
                var num1 = controller
                    .employee_history_attendance_list[index].worked_hours;
                var work_hours = double.parse(num1.toStringAsFixed(2));
                var utc_checkin_date = controller
                    .employee_history_attendance_list[index].check_in
                    .toString();
                var utc_checkout_date = controller
                    .employee_history_attendance_list[index].check_out
                    .toString();
                var check_in_value = '------------';
                if (utc_checkin_date.isNotEmpty) {
                  var checkIn = DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(utc_checkin_date, true);
                  check_in_value = checkIn
                      .toLocal()
                      .toString()
                      .split(" ")[1]
                      .split(".000")[0];
                }
                var check_out_value = '-------------';
                if (utc_checkout_date.isNotEmpty) {
                  var checkOut = DateFormat("yyyy-MM-dd HH:mm:ss")
                      .parse(utc_checkout_date, true);
                  check_out_value = checkOut
                      .toLocal()
                      .toString()
                      .split(" ")[1]
                      .split(".000")[0];
                }
                var attendance_date = AppUtils.changeDateFormat(controller
                    .employee_history_attendance_list[index].check_in
                    .toString()
                    .split(" ")[0]);
                return Card(
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0, right: 10),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                attendance_date,
                                textAlign: TextAlign.start,
                                style: datalistStyle(),
                              ),
                            ),
                            Container(
                              child: Text(
                                check_in_value + " to " + check_out_value,
                                textAlign: TextAlign.center,
                                style: subtitleStyle(),
                              ),
                            ),
                            Container(
                              child: Text(
                                work_hours.toString() + " Hr",
                                textAlign: TextAlign.end,
                                style: subtitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Text(
                              status,
                              textAlign: TextAlign.end,
                              style: subtitleStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
