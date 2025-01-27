import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/company.dart';
import '../models/department.dart';
import '../models/employee_id.dart';
import '../models/partner.dart';

import 'job.dart';

class Employee {
  final int id;
  String name;
  final String image_128;
  final String job_title;
  final Department? department_id;
  final Job? job_id;
  String work_location = "";
  String mobile_phone = "";
  String work_email = "";
  final Company? company_id;
  final Partner? parent_id;
  final String ssb_no;
  final String ssb_issue_date;
  final String ssb_temporary_card;
  final String ssb_temporary_card_no;
  final String smart_card;
  final String smart_card_issue_date;
  final String smart_card_no;
  final String fingerprint_id;
  final List<EmployeeID>? child_ids;
  final bool allow_leave_report;
  final bool allow_leave_request;
  final bool allow_attendance_report;
  final bool allow_organization_chart;
  final bool allow_pms;
  final bool allow_payslip;
  final bool allow_loan;
  final bool allow_calendar;
  final bool allow_reward;
  final bool allow_warning;
  final bool allow_overtime;
  final bool allow_approval;
  final bool mobile_app_attendance;
  final bool allow_travel_request;
  final bool allow_insurance;
  final bool allow_expense_claim;
  final bool allow_expense_report;
  final bool allow_document;
  final bool allow_fleet_info;
  final bool allow_maintenance_request;
  final bool allow_plan_trip;
  final bool allow_plan_trip_waybill;
  final bool allow_day_trip;
  final bool allow_out_of_pocket;
  final bool allow_travel_expense;
  bool allow_employee_change = true;
  final bool allow_purchase_order_approval;
  final bool allow_employee_benefit;
  Company? branch_id;
  Employee(
      {this.id = 0,
      this.name = "",
      this.image_128 = '',
      this.job_title = '',
      this.department_id,
      this.job_id,
      this.work_location = "",
      this.mobile_phone = "",
      this.work_email = "",
      this.company_id,
      this.parent_id,
      this.ssb_no = '',
      this.ssb_issue_date = '',
      this.ssb_temporary_card = '',
      this.ssb_temporary_card_no = '',
      this.smart_card = '',
      this.smart_card_issue_date = '',
      this.smart_card_no = '',
      this.fingerprint_id = '',
      this.child_ids,
      this.allow_leave_report = false,
      this.allow_leave_request = false,
      this.allow_attendance_report = false,
      this.allow_organization_chart = false,
      this.allow_pms = false,
      this.allow_payslip = false,
      this.allow_loan = false,
      this.allow_calendar = false,
      this.allow_reward = false,
      this.allow_warning = false,
      this.allow_overtime = false,
      this.allow_approval = false,
      this.mobile_app_attendance = false,
      this.allow_travel_request = false,
      this.allow_insurance = false,
      this.allow_expense_claim = false,
      this.allow_expense_report = false,
      this.allow_document = false,
      this.allow_fleet_info = false,
      this.allow_maintenance_request = false,
      this.allow_plan_trip = false,
      this.allow_plan_trip_waybill = false,
      this.allow_day_trip = false,
      this.allow_out_of_pocket = false,
      this.allow_travel_expense = false,
      this.allow_employee_change = true,
      this.allow_purchase_order_approval = false,
      this.allow_employee_benefit = false,
      this.branch_id});

  Employee copyWith({
    int? id,
    String? name,
    String? image_128,
    String? job_title,
    Department? department_id,
    Job? job_id,
    String? work_location,
    String? mobile_phone,
    String? work_email,
    Company? company_id,
    Partner? parent_id,
    String? ssb_no,
    String? ssb_issue_date,
    String? ssb_temporary_card,
    String? ssb_temporary_card_no,
    String? smart_card,
    String? smart_card_issue_date,
    String? smart_card_no,
    String? fingerprint_id,
    List<EmployeeID>? child_ids,
    bool? allow_leave_report,
    bool? allow_leave_request,
    bool? allow_attendance_report,
    bool? allow_organization_chart,
    bool? allow_pms,
    bool? allow_payslip,
    bool? allow_loan,
    bool? allow_calendar,
    bool? allow_reward,
    bool? allow_warning,
    bool? allow_overtime,
    bool? allow_approval,
    bool? mobile_app_attendance,
    bool? allow_travel_request,
    bool? allow_insurance,
    bool? allow_expense_claim,
    bool? allow_expense_report,
    bool? allow_document,
    bool? allow_fleet_info,
    bool? allow_maintenance_request,
    bool? allow_plan_trip,
    bool? allow_plan_trip_waybill,
    bool? allow_day_trip,
    bool? allow_out_of_pocket,
    bool? allow_travel_expense,
    bool? allow_employee_change,
    bool? allow_purchase_order_approval,
    bool? allow_employee_benefit,
    Company? branch_id,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      image_128: image_128 ?? this.image_128,
      job_title: job_title ?? this.job_title,
      department_id: department_id ?? this.department_id,
      job_id: job_id ?? this.job_id,
      work_location: work_location ?? this.work_location,
      mobile_phone: mobile_phone ?? this.mobile_phone,
      work_email: work_email ?? this.work_email,
      company_id: company_id ?? this.company_id,
      parent_id: parent_id ?? this.parent_id,
      ssb_no: ssb_no ?? this.ssb_no,
      ssb_issue_date: ssb_issue_date ?? this.ssb_issue_date,
      ssb_temporary_card: ssb_temporary_card ?? this.ssb_temporary_card,
      ssb_temporary_card_no:
          ssb_temporary_card_no ?? this.ssb_temporary_card_no,
      smart_card: smart_card ?? this.smart_card,
      smart_card_issue_date:
          smart_card_issue_date ?? this.smart_card_issue_date,
      smart_card_no: smart_card_no ?? this.smart_card_no,
      fingerprint_id: fingerprint_id ?? this.fingerprint_id,
      child_ids: child_ids ?? this.child_ids,
      allow_leave_report: allow_leave_report ?? this.allow_leave_report,
      allow_leave_request: allow_leave_request ?? this.allow_leave_request,
      allow_attendance_report:
          allow_attendance_report ?? this.allow_attendance_report,
      allow_organization_chart:
          allow_organization_chart ?? this.allow_organization_chart,
      allow_pms: allow_pms ?? this.allow_pms,
      allow_payslip: allow_payslip ?? this.allow_payslip,
      allow_loan: allow_loan ?? this.allow_loan,
      allow_calendar: allow_calendar ?? this.allow_calendar,
      allow_reward: allow_reward ?? this.allow_reward,
      allow_warning: allow_warning ?? this.allow_warning,
      allow_overtime: allow_overtime ?? this.allow_overtime,
      allow_approval: allow_approval ?? this.allow_approval,
      mobile_app_attendance:
          mobile_app_attendance ?? this.mobile_app_attendance,
      allow_travel_request: allow_travel_request ?? this.allow_travel_request,
      allow_insurance: allow_insurance ?? this.allow_insurance,
      allow_expense_claim: allow_expense_claim ?? this.allow_expense_claim,
      allow_expense_report: allow_expense_report ?? this.allow_expense_report,
      allow_document: allow_document ?? this.allow_document,
      allow_fleet_info: allow_fleet_info ?? this.allow_fleet_info,
      allow_maintenance_request:
          allow_maintenance_request ?? this.allow_maintenance_request,
      allow_plan_trip: allow_plan_trip ?? this.allow_plan_trip,
      allow_plan_trip_waybill:
          allow_plan_trip_waybill ?? this.allow_plan_trip_waybill,
      allow_day_trip: allow_day_trip ?? this.allow_day_trip,
      allow_out_of_pocket: allow_out_of_pocket ?? this.allow_out_of_pocket,
      allow_travel_expense: allow_travel_expense ?? this.allow_travel_expense,
      allow_employee_change:
          allow_employee_change ?? this.allow_employee_change,
      allow_purchase_order_approval:
          allow_purchase_order_approval ?? this.allow_purchase_order_approval,
      allow_employee_benefit:
          allow_employee_benefit ?? this.allow_employee_benefit,
      branch_id: branch_id ?? this.branch_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_128': image_128,
      'job_title': job_title,
      'department_id': department_id?.toMap(),
      'job_id': job_id?.toMap(),
      'work_location': work_location,
      'mobile_phone': mobile_phone,
      'work_email': work_email,
      'company_id': company_id?.toMap(),
      'parent_id': parent_id?.toMap(),
      'ssb_no': ssb_no,
      'ssb_issue_date': ssb_issue_date,
      'ssb_temporary_card': ssb_temporary_card,
      'ssb_temporary_card_no': ssb_temporary_card_no,
      'smart_card': smart_card,
      'smart_card_issue_date': smart_card_issue_date,
      'smart_card_no': smart_card_no,
      'fingerprint_id': fingerprint_id,
      'child_ids': child_ids,
      'allow_leave_report': allow_leave_report,
      'allow_leave_request': allow_leave_request,
      'allow_attendance_report': allow_attendance_report,
      'allow_organization_chart': allow_organization_chart,
      'allow_pms': allow_pms,
      'allow_payslip': allow_payslip,
      'allow_loan': allow_loan,
      'allow_calendar': allow_calendar,
      'allow_reward': allow_reward,
      'allow_warning': allow_warning,
      'allow_overtime': allow_overtime,
      'allow_approval': allow_approval,
      'mobile_app_attendance': mobile_app_attendance,
      'allow_travel_request': allow_travel_request,
      'allow_insurance': allow_insurance,
      'allow_expense_claim': allow_expense_claim,
      'allow_expense_report': allow_expense_report,
      'allow_document': allow_document,
      'allow_fleet_info': allow_fleet_info,
      'allow_maintenance_request': allow_maintenance_request,
      'allow_plan_trip': allow_plan_trip,
      'allow_plan_trip_waybill': allow_plan_trip_waybill,
      'allow_day_trip': allow_day_trip,
      'allow_out_of_pocket': allow_out_of_pocket,
      'allow_travel_expense': allow_travel_expense,
      'allow_employee_change': allow_employee_change,
      'allow_purchase_order_approval': allow_purchase_order_approval,
      'allow_employee_benefit': allow_employee_benefit,
      'branch_id': branch_id
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee(
      id: map['id'],
      name: map['name'],
      image_128: map['image_128'] ?? "",
      job_title: map['job_title'] ?? "",
      department_id: Department.fromMap(map['department_id']),
      job_id: Job.fromMap(map['job_id']),
      work_location: map['work_location'] ?? "",
      mobile_phone: map['mobile_phone'],
      work_email: map['work_email'] ?? "",
      company_id: Company.fromMap(map['company_id']),
      parent_id: Partner.fromMap(map['parent_id']),
      ssb_no: map['ssb_no'] ?? "",
      ssb_issue_date: map['ssb_issue_date'] ?? "",
      ssb_temporary_card: map['ssb_temporary_card'] ?? "",
      ssb_temporary_card_no: map['ssb_temporary_card_no'] ?? "",
      smart_card: map['smart_card'] ?? "",
      smart_card_issue_date: map['smart_card_issue_date'] ?? "",
      smart_card_no: map['smart_card_no'] ?? "",
      fingerprint_id: map['fingerprint_id'] ?? "",
      child_ids: List<EmployeeID>.from(
          map['child_ids']?.map((x) => EmployeeID.fromMap(x))),
      allow_leave_report: map['allow_leave_report'] ?? false,
      allow_leave_request: map['allow_leave_request'] ?? false,
      allow_attendance_report: map['allow_attendance_report'] ?? false,
      allow_organization_chart: map['allow_organization_chart'] ?? false,
      allow_pms: map['allow_pms'] ?? false,
      allow_payslip: map['allow_payslip'] ?? false,
      allow_loan: map['allow_loan'] ?? false,
      allow_calendar: map['allow_calendar'] ?? false,
      allow_reward: map['allow_reward'] ?? false,
      allow_warning: map['allow_warning'] ?? false,
      allow_overtime: map['allow_overtime'] ?? false,
      allow_approval: map['allow_approval'] ?? false,
      mobile_app_attendance: map['mobile_app_attendance'] ?? false,
      allow_travel_request: map['allow_travel_request'] ?? false,
      allow_insurance: map['allow_insurance'] ?? false,
      allow_expense_claim: map['allow_expense_claim'] ?? false,
      allow_expense_report: map['allow_expense_report'] ?? false,
      allow_document: map['allow_document'] ?? false,
      allow_fleet_info: map['allow_fleet_info'] ?? false,
      allow_maintenance_request: map['allow_maintenance_request'] ?? false,
      allow_plan_trip: map['allow_plan_trip'] ?? false,
      allow_plan_trip_waybill: map['allow_plan_trip_waybill'] ?? false,
      allow_day_trip: map['allow_day_trip'] ?? false,
      allow_out_of_pocket: map['allow_out_of_pocket'] ?? false,
      allow_travel_expense: map['allow_travel_expense'] ?? false,
      allow_employee_change: map['allow_employee_change'] ?? false,
      allow_purchase_order_approval:
          map['allow_purchase_order_approval'] ?? false,
      allow_employee_benefit: map['allow_employee_benefit'] ?? false,
      branch_id: Company.fromMap(map['branch_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() =>
      'Employee(id: $id, name: $name, image_128: $image_128, job_title: $job_title, department_id: $department_id, job_id: $job_id, work_location: $work_location, mobile_phone: $mobile_phone, work_email: $work_email, company_id: $company_id, parent_id: $parent_id, ssb_no: $ssb_no, ssb_issue_date: $ssb_issue_date, smart_card_no: $smart_card_no, fingerprint_id: $fingerprint_id, child_ids: $child_ids, allow_leave_report: $allow_leave_report, allow_leave_request: $allow_leave_request, allow_attendance_report: $allow_attendance_report, allow_organization_chart: $allow_organization_chart, allow_pms: $allow_pms, allow_payslip: $allow_payslip, allow_loan: $allow_loan, allow_calendar: $allow_calendar, allow_reward: $allow_reward, allow_warning: $allow_warning, allow_overtime: $allow_overtime, allow_approval: $allow_approval, mobile_app_attendance: $mobile_app_attendance, allow_travel_request: $allow_travel_request, allow_insurance: $allow_insurance, allow_expense_claim: $allow_expense_claim, allow_expense_report: $allow_expense_report, allow_document: $allow_document, allow_fleet_info: $allow_fleet_info, allow_maintenance_request: $allow_maintenance_request, allow_plan_trip: $allow_plan_trip, allow_plan_trip_waybill: $allow_plan_trip_waybill, allow_day_trip: $allow_day_trip, allow_out_of_pocket: $allow_out_of_pocket, allow_travel_expense: $allow_travel_expense, allow_employee_change: $allow_employee_change, allow_purchase_order_approval: $allow_purchase_order_approval, allow_employee_benefit: $allow_employee_benefit, branch_id: $branch_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee &&
        o.id == id &&
        o.name == name &&
        o.image_128 == image_128 &&
        o.job_title == job_title &&
        o.department_id == department_id &&
        o.job_id == job_id &&
        o.work_location == work_location &&
        o.mobile_phone == mobile_phone &&
        o.work_email == work_email &&
        o.company_id == company_id &&
        o.parent_id == parent_id &&
        o.ssb_no == ssb_no &&
        o.ssb_issue_date == ssb_issue_date &&
        o.smart_card_no == smart_card_no &&
        o.fingerprint_id == fingerprint_id &&
        o.child_ids == child_ids &&
        o.allow_leave_report == allow_leave_report &&
        o.allow_leave_request == allow_leave_request &&
        o.allow_attendance_report == allow_attendance_report &&
        o.allow_organization_chart == allow_organization_chart &&
        o.allow_pms == allow_pms &&
        o.allow_payslip == allow_payslip &&
        o.allow_loan == allow_loan &&
        o.allow_calendar == allow_calendar &&
        o.allow_reward == allow_reward &&
        o.allow_warning == allow_warning &&
        o.allow_overtime == allow_overtime &&
        o.allow_approval == allow_approval &&
        o.mobile_app_attendance == mobile_app_attendance &&
        o.allow_travel_request == allow_travel_request &&
        o.allow_insurance == allow_insurance &&
        o.allow_expense_claim == allow_expense_claim &&
        o.allow_expense_report == allow_expense_report &&
        o.allow_document == allow_document &&
        o.allow_fleet_info == allow_fleet_info &&
        o.allow_maintenance_request == allow_maintenance_request &&
        o.allow_plan_trip == allow_plan_trip &&
        o.allow_plan_trip_waybill == allow_plan_trip_waybill &&
        o.allow_day_trip == allow_day_trip &&
        o.allow_out_of_pocket == allow_out_of_pocket &&
        o.allow_travel_expense == allow_travel_expense &&
        o.allow_employee_change == allow_employee_change &&
        o.allow_purchase_order_approval == allow_purchase_order_approval &&
        o.allow_employee_benefit == allow_employee_benefit &&
        o.branch_id == branch_id;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      image_128.hashCode ^
      job_title.hashCode ^
      department_id.hashCode ^
      job_id.hashCode ^
      work_location.hashCode ^
      mobile_phone.hashCode ^
      work_email.hashCode ^
      company_id.hashCode ^
      parent_id.hashCode ^
      ssb_no.hashCode ^
      ssb_issue_date.hashCode ^
      smart_card_no.hashCode ^
      fingerprint_id.hashCode ^
      child_ids.hashCode ^
      allow_leave_report.hashCode ^
      allow_leave_request.hashCode ^
      allow_attendance_report.hashCode ^
      allow_organization_chart.hashCode ^
      allow_pms.hashCode ^
      allow_payslip.hashCode ^
      allow_loan.hashCode ^
      allow_calendar.hashCode ^
      allow_reward.hashCode ^
      allow_warning.hashCode ^
      allow_overtime.hashCode ^
      allow_approval.hashCode ^
      mobile_app_attendance.hashCode ^
      allow_travel_request.hashCode ^
      allow_insurance.hashCode ^
      allow_expense_claim.hashCode ^
      allow_expense_report.hashCode ^
      allow_document.hashCode ^
      allow_fleet_info.hashCode ^
      allow_maintenance_request.hashCode ^
      allow_plan_trip.hashCode ^
      allow_plan_trip_waybill.hashCode ^
      allow_day_trip.hashCode ^
      allow_out_of_pocket.hashCode ^
      allow_travel_expense.hashCode ^
      allow_employee_change.hashCode ^
      allow_purchase_order_approval.hashCode ^
      allow_employee_benefit.hashCode ^
      branch_id.hashCode;
}

// class Employee {
//   final int id;
//   String name;
//   final String image_128;
//   final String job_title;
//   final Department department_id;
//   final Job job_id;
//   String work_location = "";
//   String mobile_phone = "";
//   String work_email = "";
//   final Company company_id;
//   final Partner parent_id;
//   final String ssb_no;
//   final String ssb_issue_date;
//   final String ssb_temporary_card;
//   final String ssb_temporary_card_no;
//   final String smart_card;
//   final String smart_card_issue_date;
//   final String smart_card_no;
//   final String fingerprint_id;
//   final List<EmployeeID> child_ids;
//   final bool allow_leave_report;
//   final bool allow_leave_request;
//   final bool allow_attendance_report;
//   final bool allow_organization_chart;
//   final bool allow_pms;
//   final bool allow_payslip;
//   final bool allow_loan;
//   final bool allow_calendar;
//   final bool allow_reward;
//   final bool allow_warning;
//   final bool allow_overtime;
//   final bool allow_approval;
//   final bool mobile_app_attendance;
//   final bool allow_travel_request;
//   final bool allow_insurance;
//   final bool allow_expense_claim;
//   final bool allow_expense_report;
//   final bool allow_document;
//   final bool allow_fleet_info;
//   final bool allow_maintenance_request;
//   final bool allow_plan_trip;
//   final bool allow_plan_trip_waybill;
//   final bool allow_day_trip;
//   final bool allow_out_of_pocket;
//   final bool allow_travel_expense;
//   bool allow_employee_change = true;
//   final bool allow_purchase_order_approval;
//   final bool allow_employee_benefit;
//   Company branch_id;
//   Employee({
//     this.id,
//     this.name,
//     this.image_128,
//     this.job_title,
//     this.department_id,
//     this.job_id,
//     this.work_location,
//     this.mobile_phone,
//     this.work_email,
//     this.company_id,
//     this.parent_id,
//     this.ssb_no,
//     this.ssb_issue_date,
//     this.ssb_temporary_card,
//     this.ssb_temporary_card_no,
//     this.smart_card,
//     this.smart_card_issue_date,
//     this.smart_card_no,
//     this.fingerprint_id,
//     this.child_ids,
//     this.allow_leave_report,
//     this.allow_attendance_report,
//     this.allow_organization_chart,
//     this.allow_pms,
//     this.allow_payslip,
//     this.allow_loan,
//     this.allow_calendar,
//     this.allow_reward,
//     this.allow_warning,
//     this.allow_overtime,
//     this.allow_approval,
//     this.mobile_app_attendance,
//     this.allow_travel_request,
//     this.allow_insurance,
//     this.allow_expense_claim,
//     this.allow_expense_report,
//     this.allow_document,
//     this.allow_fleet_info,
//     this.allow_maintenance_request,
//     this.allow_plan_trip,
//     this.allow_plan_trip_waybill,
//     this.allow_day_trip,
//     this.allow_leave_request,
//     this.allow_out_of_pocket,
//     this.allow_travel_expense,
//     this.branch_id,this.allow_employee_change,
//     this.allow_purchase_order_approval,
//     this.allow_employee_benefit
//   });

//   Employee copyWith({
//     int id,
//     String name,
//     String image_128,
//     String job_title,
//     Department department_id,
//     Job job_id,
//     String work_location,
//     String mobile_phone,
//     String work_email,
//     Company company_id,
//     Partner parent_id,
//     String ssb_no,
//     String ssb_issue_date,
//     String ssb_temporary_card,
//     String ssb_temporary_card_no,
//     String smart_card,
//     String smart_card_issue_date,
//     String smart_card_no,
//     String fingerprint_id,
//     List<EmployeeID> child_ids,
//     bool allow_leave_report,
//     bool allow_attendance_report,
//     bool allow_organization_chart,
//     bool allow_pms,
//     bool allow_payslip,
//     bool allow_loan,
//     bool allow_calendar,
//     bool allow_reward,
//     bool allow_warning,
//     bool allow_overtime,
//     bool allow_approval,
//     bool mobile_app_attendance,
//     bool allow_travel_request,
//     bool allow_insurance,
//     bool allow_expense_claim,
//     bool allow_expense_report,
//     bool allow_document,
//     bool allow_fleet_info,
//     bool allow_maintenance_request,
//     bool allow_plan_trip,
//     bool allow_day_trip,
//     bool allow_out_of_pocket,
//     bool allow_travel_expense,
//     bool allow_purchase_order_approval,
//     bool allow_employee_benefit
//   }) {
//     return Employee(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       image_128: image_128 ?? this.image_128,
//       job_title: job_title ?? this.job_title,
//       department_id: department_id ?? this.department_id,
//       job_id: job_id ?? this.job_id,
//       work_location: work_location ?? this.work_location,
//       mobile_phone: mobile_phone ?? this.mobile_phone,
//       work_email: work_email ?? this.work_email,
//       company_id: company_id ?? this.company_id,
//       parent_id: parent_id ?? this.parent_id,
//       ssb_no: ssb_no ?? this.ssb_no,
//       ssb_issue_date: ssb_issue_date ?? this.ssb_issue_date,
//       ssb_temporary_card: ssb_temporary_card ?? this.ssb_temporary_card,
//       ssb_temporary_card_no:
//           ssb_temporary_card_no ?? this.ssb_temporary_card_no,
//       smart_card: smart_card ?? this.smart_card,
//       smart_card_issue_date:
//           smart_card_issue_date ?? this.smart_card_issue_date,
//       smart_card_no: smart_card_no ?? this.smart_card_no,
//       fingerprint_id: fingerprint_id ?? this.fingerprint_id,
//       child_ids: child_ids ?? this.child_ids,
//       allow_leave_report:
//           this.allow_leave_report == null ? false : allow_leave_report,
//       allow_leave_request:
//           this.allow_leave_request == null ? false : allow_leave_request,
//       allow_attendance_report: this.allow_attendance_report == null
//           ? false
//           : allow_attendance_report,
//       allow_organization_chart: this.allow_organization_chart == null
//           ? false
//           : allow_organization_chart,
//       allow_pms: this.allow_pms == null ? false : allow_pms,
//       allow_payslip: this.allow_payslip == null ? false : allow_payslip,
//       allow_loan: this.allow_loan == null ? false : allow_loan,
//       allow_calendar: this.allow_calendar == null ? false : allow_calendar,
//       allow_reward: this.allow_reward == null ? false : allow_reward,
//       allow_warning: this.allow_warning == null ? false : allow_warning,
//       allow_overtime: this.allow_overtime == null ? false : allow_overtime,
//       allow_approval: this.allow_approval == null ? false : allow_approval,
//       mobile_app_attendance:
//           this.mobile_app_attendance == null ? false : mobile_app_attendance,
//       allow_travel_request:
//           this.allow_travel_request == null ? false : allow_travel_request,
//       allow_insurance: this.allow_insurance == null ? false : allow_insurance,
//       allow_expense_claim:
//           this.allow_expense_claim == null ? false : allow_expense_claim,
//       allow_expense_report:
//           this.allow_expense_report == null ? false : allow_expense_report,
//       allow_document: this.allow_document == null ? false : allow_leave_report,
//       allow_fleet_info:
//           this.allow_fleet_info == null ? false : allow_fleet_info,
//       allow_maintenance_request: this.allow_maintenance_request == null
//           ? false
//           : allow_maintenance_request,
//       allow_plan_trip: this.allow_plan_trip == null ? false : allow_plan_trip,
//       allow_plan_trip_waybill: this.allow_plan_trip_waybill == null ? false : allow_plan_trip_waybill,
//       allow_day_trip: this.allow_day_trip == null ? false : allow_day_trip,
//       allow_out_of_pocket: this.allow_out_of_pocket == null ? false : allow_out_of_pocket,
//       allow_travel_expense: this.allow_travel_expense == null ? false : allow_travel_expense,
//       allow_purchase_order_approval: this.allow_purchase_order_approval == null ? false : allow_purchase_order_approval,
//       allow_employee_benefit: this.allow_employee_benefit == null ? false : allow_employee_benefit
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       // 'image_128': image_128,
//       // 'job_title': job_title,
//       // 'department_id': department_id?.toMap(),
//       // 'job_id': job_id?.toMap(),
//       // 'work_location': work_location,
//       // 'mobile_phone': mobile_phone,
//       // 'work_email': work_email,
//       // 'company_id': company_id?.toMap(),
//       // 'parent_id': parent_id?.toMap(),
//       // 'ssb_no': ssb_no,
//       // 'ssb_issue_date': ssb_issue_date,
//       // 'ssb_temporary_card': ssb_temporary_card,
//       // 'ssb_temporary_card_no': ssb_temporary_card_no,
//       // 'smart_card': smart_card,
//       // 'smart_card_issue_date': smart_card_issue_date,
//       // 'smart_card_no': smart_card_no,
//       // 'fingerprint_id': fingerprint_id,
//       // 'child_ids': child_ids?.map((x) => x?.toMap())?.toList(),
//       // "allow_attendance_report": allow_attendance_report,
//       // "allow_organization_chart": allow_organization_chart,
//       // "allow_pms": allow_pms,
//       // "allow_payslip": allow_payslip,
//       // "allow_loan": allow_loan,
//       // "allow_calendar": allow_calendar,
//       // "allow_reward": allow_reward,
//       // "allow_warning": allow_warning,
//       // "allow_overtime": allow_overtime,
//       // "allow_approval": allow_approval,
//       // "mobile_app_attendance": mobile_app_attendance,
//       // "allow_travel_request": allow_travel_request,
//       // "allow_insurance": allow_insurance,
//       // "allow_expense_claim": allow_expense_claim,
//       // "allow_expense_report": allow_expense_report,
//       // "allow_document": allow_document,
//       // "allow_fleet_info": allow_fleet_info,
//       // "allow_maintenance_request": allow_maintenance_request,
//       // "allow_plan_trip": allow_plan_trip,
//       // "allow_day_trip": allow_day_trip,
//       // "allow_leave_request": allow_leave_request,
//     };
//   }

//   factory Employee.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Employee(
//       id: map['id'],
//       name: map['name'],
//       image_128: map['image_128'] ?? "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",
//       job_title: map['job_title']??'',
//       department_id: Department.fromMap(map['department_id']),
//       job_id: Job.fromMap(map['job_id']),
//       work_location: map['work_location'],
//       mobile_phone: map['mobile_phone'],
//       work_email: map['work_email'],
//       company_id: Company.fromMap(map['company_id']),
//       parent_id: Partner.fromMap(map['parent_id']),
//       ssb_no: map['ssb_no'],
//       ssb_issue_date: map['ssb_issue_date'],
//       ssb_temporary_card: map['ssb_temporary_card'],
//       ssb_temporary_card_no: map['ssb_temporary_card_no'],
//       smart_card: map['smart_card'],
//       smart_card_issue_date: map['smart_card_issue_date'],
//       smart_card_no: map['smart_card_no'],
//       fingerprint_id: map['fingerprint_id'],
//       allow_leave_report: map['allow_leave_report'],
//       allow_leave_request: map['allow_leave_request'],
//       allow_attendance_report: map['allow_attendance_report'],
//       allow_organization_chart: map['allow_organization_chart'],
//       allow_pms: map['allow_pms'],
//       allow_payslip: map['allow_payslip'],
//       allow_loan: map['allow_loan'],
//       allow_calendar: map['allow_calendar'],
//       allow_reward: map['allow_reward'],
//       allow_warning: map['allow_warning'],
//       allow_overtime: map['allow_overtime'],
//       allow_approval: map['allow_approval'],
//       mobile_app_attendance: map['mobile_app_attendance'],
//       allow_travel_request: map['allow_travel_request'],
//       allow_insurance: map['allow_insurance'],
//       allow_expense_claim: map['allow_expense_claim'],
//       allow_expense_report: map['allow_expense_report'],
//       allow_document: map['allow_document'],
//       allow_fleet_info: map['allow_fleet_info'],
//       allow_maintenance_request: map['allow_maintenance_request'],
//       allow_plan_trip: map['allow_plan_trip'],
//       allow_plan_trip_waybill: map['allow_plan_trip_waybill'],
//       allow_day_trip: map['allow_day_trip'],
//       allow_out_of_pocket: map['allow_out_of_pocket'],
//       allow_travel_expense: map['allow_travel_expense'],
//       allow_employee_change: map['allow_employee_changes'],
//       child_ids: List<EmployeeID>.from(
//           map['child_ids']?.map((x) => EmployeeID.fromMap(x))) ?? [],
//       branch_id: Company.fromMap(map['branch_id']),
//       allow_purchase_order_approval: map['allow_purchase_order_approval'],
//       allow_employee_benefit: map['allow_employee_benefit']
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Employee.fromJson(String source) =>
//       Employee.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Employee(id: $id, name: $name, image_128: $image_128, job_title: $job_title, department_id: $department_id, job_id: $job_id, work_location: $work_location, mobile_phone: $mobile_phone, work_email: $work_email, company_id: $company_id, parent_id: $parent_id, ssb_no: $ssb_no, ssb_issue_date: $ssb_issue_date, ssb_temporary_card: $ssb_temporary_card, ssb_temporary_card_no: $ssb_temporary_card_no, smart_card: $smart_card, smart_card_issue_date: $smart_card_issue_date, smart_card_no: $smart_card_no, fingerprint_id: $fingerprint_id, child_ids: $child_ids,allow_employee_benefit: $allow_employee_benefit)';
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         image_128.hashCode ^
//         job_title.hashCode ^
//         department_id.hashCode ^
//         job_id.hashCode ^
//         work_location.hashCode ^
//         mobile_phone.hashCode ^
//         work_email.hashCode ^
//         company_id.hashCode ^
//         parent_id.hashCode ^
//         ssb_no.hashCode ^
//         ssb_issue_date.hashCode ^
//         ssb_temporary_card.hashCode ^
//         ssb_temporary_card_no.hashCode ^
//         smart_card.hashCode ^
//         smart_card_issue_date.hashCode ^
//         smart_card_no.hashCode ^
//         fingerprint_id.hashCode ^
//         child_ids.hashCode ^
//         allow_employee_benefit.hashCode;
//   }
// }
