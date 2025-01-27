import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
// import '../localization.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ConfigurationController extends GetxController{
  final box = GetStorage();
  List hr = [];
  List admin = [];
  List home = [];
  var storage = LocalStorage('storefunction');
  @override
  void onInit() async{
    final labels = AppLocalizations.of(Get.context!);
    var employee_role = box.read("role_category");
    final leave_report = box.read("allow_leave_report");
    final travel_request = box.read("allow_travel_request");
    final leave_request = box.read("allow_leave_request");
    final attendance_report = box.read("allow_attendance_report");
    final org_chart = box.read("allow_organization_chart");
    final pms = box.read("allow_pms");
    final payslip = box.read("allow_payslip");
    final loan = box.read("allow_loan");
    final attendance = box.read("mobile_app_attendance");
    final insurance = box.read("allow_insurance");
    final overtime = box.read("allow_overtime");
    var storage = LocalStorage('storefunction');
    //bool value  = await storage.ready;
   home = storage.getItem('home_function');
   print( home[0]);
    if (leave_report != null) {
      hr.add([FontAwesomeIcons.calendar.codePoint, labels?.leaveTravelReport, Routes.LEAVE_TRIP_REPORT,false]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (travel_request != null || leave_request != null) {
      hr.add([
        FontAwesomeIcons.plus.codePoint,
        labels?.leaveTravelRequest,
        Routes.LEAVE_TRIP_TAB_BAR,
        false
      ]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (attendance_report != null) {
      hr.add([
        FontAwesomeIcons.personBooth.codePoint,
        labels?.attendanceReport,
        Routes.ATTENDANCE_REPORT,
        false
      ]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (attendance != null) {
      hr.add([FontAwesomeIcons.fingerprint.codePoint, labels?.attendance, Routes.ATTENDANCE, false]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (org_chart != null) {
      hr.add([
        FontAwesomeIcons.tree.codePoint,
        labels?.organizationChart,
        Routes.ORGANIZATION_CHART, home.contains(Routes.ORGANIZATION_CHART)
      ]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (pms != null) {
      hr.add([FontAwesomeIcons.plus.codePoint, labels?.pms, Routes.PMS_PAGE, false]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (payslip != null) {
      hr.add([
        FontAwesomeIcons.solidPaperPlane.codePoint,
        labels?.paySlip,
        Routes.PAY_SLIP_PAGE, home.contains(Routes.PAY_SLIP_PAGE)
      ]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (loan != null) {
      hr.add(
          [FontAwesomeIcons.longArrowAltDown.codePoint, labels?.loan, Routes.LOAN_PAGE, home.contains(Routes.LOAN_PAGE)]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (insurance != null) {
      hr.add([FontAwesomeIcons.inbox.codePoint, labels?.insurance, Routes.INSURANCE, home.contains(Routes.INSURANCE)]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }
    if (overtime != null) {
      hr.add([
        FontAwesomeIcons.clock.codePoint,
        labels?.overTime,
        Routes.OVER_TIME_LIST_PAGE, home.contains(Routes.OVER_TIME_LIST_PAGE)
      ]);
      home.where((element)=> element[1]==hr[hr.length-1][1]).length>0 ? hr[hr.length-1][3]=true : hr[hr.length-1][3]=false;
    }

    final reward = box.read("allow_reward");
    final warning = box.read("allow_warning");
    final approval = box.read("allow_approval");
    final expense_claim = box.read("allow_expense_claim");
    final doc = box.read("allow_document");
    final fleet = box.read("allow_fleet_info");
    final maintenance = box.read("allow_maintenance_request");
    final plan_trip = box.read("allow_plan_trip");
    final day_trip = box.read("allow_day_trip");

    if (expense_claim != null) {
      admin.add([
        FontAwesomeIcons.plus.codePoint,
        labels?.createExpenseReport,
        Routes.CREATE_EXPENSE, false
      ]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (fleet != null) {
      admin.add([FontAwesomeIcons.personBooth.codePoint, labels?.fleet, Routes.FLEET_LIST_PAGE,false]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (maintenance != null) {
      admin.add([
        FontAwesomeIcons.fingerprint.codePoint,
        labels?.maintenanceRequest,
        Routes.MAINTENANCE_LIST, false
      ]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (plan_trip != null) {
      admin
          .add([FontAwesomeIcons.airbnb.codePoint, labels?.planTrip, Routes.CREATE_PLAN_TRIP, false]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (day_trip != null) {
      admin.add(
          [FontAwesomeIcons.plus.codePoint, labels?.dayTrip, Routes.CREATE_DAY_TRIP, false]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (approval != null) {
      admin.add([
        FontAwesomeIcons.solidPaperPlane.codePoint,
        labels?.approval,
        Routes.APPROVAL, false
      ]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (doc != null) {
      admin.add([
        FontAwesomeIcons.longArrowAltDown.codePoint,
        labels?.documents,
        Routes.DOCUMENTS, false
      ]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (reward != null) {
      admin.add([FontAwesomeIcons.inbox.codePoint, labels?.rewards, Routes.REWARD_PAGE, false]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    if (warning != null) {
      admin.add(
          [FontAwesomeIcons.timesCircle.codePoint, labels?.warning, Routes.WARNING_PAGE, false]);
      home.where((element)=> element[1]==admin[admin.length-1][1]).length>0 ? admin[admin.length-1][3]=true : admin[admin.length-1][3]=false;
    }
    super.onInit();
  }

  void saveData()async {

      bool value = await storage.ready;
      if (value)
        storage.setItem('home_function', home);
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    }

}