
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/user_profile_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/attendance_page.dart';
import '../pages/attendance_report.dart';
import '../pages/drawer.dart';
import '../pages/insurance_page.dart';
import '../pages/leave_trip_report.dart';
import '../pages/leave_trip_tabbar.dart';
import '../pages/loan_list_page.dart';
import '../pages/organization_chart.dart';
import '../pages/over_time.dart';
import '../pages/payslip_page.dart';
import '../pages/pms_page.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HRPage extends StatefulWidget {
  @override
  _HRPageState createState() => _HRPageState();
}

class _HRPageState extends State<HRPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final box = GetStorage();

  String image = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    List hr = [];
    var employee_role = box.read("role_category");
    final leave_report = box.read("allow_leave_report");
    final travel_request = box.read("allow_travel_request");
    final leave_request = box.read("allow_leave_request");
    final attendance_report = box.read("allow_attendance_report");
    final org_chart = box.read("allow_organization_chart");
    final pms = box.read("allow_pms");
    final attendance = box.read("mobile_app_attendance");
    final overtime = box.read("allow_overtime");
    final employee_change = box.read("allow_employee_change");
    if (leave_report != null&&leave_report == true) {
      hr.add([Icons.calendar_today, labels!.leaveReport, Routes.LEAVE_TRIP_REPORT]);
    }

    if ((travel_request != null&&travel_request==true) || (leave_request != null&&leave_request==true)) {
      hr.add([
        FontAwesomeIcons.signOutAlt,
        labels?.leaveTravelRequest,
        Routes.LEAVE_TRIP_TAB_BAR
      ]);
    }
    if (attendance_report != null&&attendance_report == true) {
      hr.add([
        Icons.person_add,
        labels?.attendanceReport,
        Routes.ATTENDANCE_REPORT
      ]);
    }
    if (attendance != null&&attendance == true) {
      hr.add([Icons.fingerprint, labels?.attendance, Routes.ATTENDANCE]);
    }
    if (org_chart != null&&org_chart == true) {
      hr.add([
        Icons.account_tree_outlined,
        labels?.organizationChart,
        Routes.ORGANIZATION_CHART
      ]);
    }
    if (pms != null && pms == true) {
      hr.add([FontAwesomeIcons.plus, labels?.pms, Routes.PMS_PAGE]);
    }
    if (overtime != null && overtime == true) {
      hr.add([
        FontAwesomeIcons.clock,
        labels?.overTime,
        Routes.OVER_TIME_LIST_PAGE
      ]);
    }
   if (employee_change != null&&employee_change==true) {
      hr.add([Icons.person, labels!.employeeChanges, Routes.EMPLOYEE_CHANGE]);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, (labels!.hr), image)),
      drawer: DrawerPage(),
      body: Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white30,
          child: GridView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisSpacing: 2,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
              ),
              itemCount: hr.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: backgroundIconColor,
                        child: IconButton(
                          iconSize: 30,
                          padding: EdgeInsets.zero,
                          icon: Icon(hr[index][0]),
                          color: barBackgroundColorStyle,
                          onPressed: () {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (BuildContext context) {
                            //   return LeaveTripReport();
                            // }));

                            Get.toNamed(hr[index][2]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            (hr[index][1]),
                            style: menuTextStyle(),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Leave Trip Click!'),
      action: SnackBarAction(
            label: 'UNDO', onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar)
    ));
    // scaffold.showSnackBar(
    //   SnackBar(
    //     content: const Text('Leave Trip Click!'),
    //     action: SnackBarAction(
    //         label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    //   ),
    // );
  }

  /*void navigatePage(BuildContext context, String route) {
    var toRoute;
    if (route == "LeaveTripReport") {
      toRoute = LeaveTripReport();
    } else if (route == "LeaveTripTabBar") {
      toRoute = LeaveTripTabBar();
    } else if (route == "AttendanceReport") {
      toRoute = AttendanceReport();
    } else if (route == "Attendance") {
      toRoute = AttendancePage();
    } else if (route == "OrganizationChart") {
      toRoute = OrganizationChart();
    } else if (route == "PMS") {
      toRoute = PmsPage();
    } else if (route == "PaySlip") {
      toRoute = PaySlipPage();
    } else if (route == "Loan") {
      toRoute = LoanListPage();
    } else if (route == "Insurance") {
      toRoute = InsurancePage();
    } else if (route == "Overtime") {
      toRoute = OverTimePage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => toRoute),
    );
  }*/
}
