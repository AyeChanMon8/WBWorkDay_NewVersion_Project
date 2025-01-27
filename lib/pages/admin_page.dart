
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/drawer.dart';
import '../pages/expense_tab.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final box = GetStorage();
  String image = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    List admin = [];
    image = box.read('emp_image');
    final calender = box.read("allow_calendar");
    final approval = box.read("allow_approval");
    final expense_oop = box.read("allow_out_of_pocket");
    final expense_travel = box.read("allow_travel_expense");
    final doc = box.read("allow_document");
    final fleet = box.read("allow_fleet_info");
    final maintenance = box.read("allow_maintenance_request");
    final plan_trip = box.read("allow_plan_trip");
    final plan_trip_waybill = box.read("allow_plan_trip_waybill");
    final day_trip = box.read("allow_day_trip");
    final purchase_order = box.read("allow_purchase_order_approval");
    final employee_benefit = box.read("allow_employee_benefit");
   /* if (expense_report != null) {
      admin.add([
        Icons.calendar_today,
        labels?.expenseReports,
        Routes.EXPENSE_REPORT
      ]);
    }*/

     if (calender != null&&calender==true) {
      admin.add([
        Icons.calendar_today,
        labels?.calendar,
        Routes.CALENDAR
      ]);
    }
    if ((expense_oop != null&& expense_oop==true)||(expense_travel!=null&&expense_travel==true)) {
      admin.add([
        FontAwesomeIcons.signOutAlt,
        labels?.createExpenseReport,
        Routes.CREATE_EXPENSE
      ]);
    }
    if (fleet != null&&fleet==true) {
      admin.add([Icons.directions_car_rounded, labels?.fleet, Routes.FLEET_LIST_PAGE]);
    }
    if (maintenance != null&&maintenance==true) {
      admin.add([
        FontAwesomeIcons.tools,
        labels?.maintenanceRequest,
        Routes.MAINTENANCE_LIST
      ]);
    }
    if (plan_trip != null&&plan_trip==true) {
      admin
          .add([FontAwesomeIcons.luggageCart, labels!.plantipProduct, Routes.PLAN_TRIP_PAGE]);
    }
    if (plan_trip_waybill != null&&plan_trip_waybill==true) {
      admin
          .add([FontAwesomeIcons.suitcaseRolling, labels!.pantripWaybill, Routes.PLAN_TRIP_WAYBILL_PAGE]);
    }
    if (day_trip != null&&day_trip==true) {
      admin.add(
          [FontAwesomeIcons.road, labels?.dayTrip, Routes.DAY_TRIP_TABAR]);
    }
    if (approval != null&&approval==true) {
      admin.add([
        FontAwesomeIcons.solidPaperPlane,
        labels?.approval,
        Routes.APPROVAL
      ]);
    }
    if (doc != null&&doc ==true) {
      admin.add([
        FontAwesomeIcons.folderOpen,
        labels?.documents,
        Routes.DOCUMENTS
      ]);
    }
    if (purchase_order != null&&purchase_order == true) {
      admin.add([
        FontAwesomeIcons.shoppingCart,
        labels?.purchaseOrder,
        Routes.PURCHASE_ORDER_LIST
      ]);
    }
    if (employee_benefit != null&&employee_benefit == true) {
      admin.add([
        FontAwesomeIcons.award,
        labels?.benefit,
        Routes.EMPLOYEE_BENEFIT_LIST
      ]);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels?.adminTitle, image)),
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
              itemCount: admin.length,
              itemBuilder: (context, index) {
                return Card(
                 // color: Colors.grey[50],
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
                        // radius: circleAvatorRadius,
                        child: IconButton(
                          iconSize: 17,
                          padding: EdgeInsets.zero,
                          icon: Icon(admin[index][0]),
                          color: barBackgroundColorStyle,
                          onPressed: () {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (BuildContext context) {
                            //   return LeaveTripReport();
                            // }));

                            Get.toNamed(admin[index][2]);
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
                            (admin[index][1]),
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

  void navigatePage(BuildContext context, String route) {
    var toRoute;
    if (route == "LeaveTripReport") {
      //toRoute = LeaveTripReport();
    } else if (route == "LeaveTripRequest") {
      //toRoute = LeaveTripRequest();
    } else if (route == "AttendanceReport") {
      //toRoute = AttendanceReport();
    } else if (route == "Attendance") {
      //toRoute = AttendancePage();
    } else if (route == "OrganizationChart") {
      //toRoute = OrganizationChart();
    } else if (route == "PMS") {
      //toRoute = PmsPage();
    } else if (route == "PaySlip") {
      //toRoute = PaySlipPage();
    } else if (route == "Loan") {
      //toRoute = LoanPage();
    } else if (route == "Insurance") {
      //toRoute = InsurancePage();
    } else if (route == "Overtime") {
      //toRoute = OvertimePage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => toRoute),
    );
  }
}
