
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/models/ptw_route_replacement.dart';
import '../constants/globals.dart';
import '../models/announcement.dart';
import '../models/announcement.dart';
import '../models/claiminsurancemodel.dart';
import '../models/company.dart';
import '../models/department.dart';
import '../models/emp_d.dart';
import '../models/emp_job.dart';
import '../models/employee.dart';
import '../models/employee_category.dart';
import '../models/employee_change_create.dart';
import '../models/employee_document.dart';
import '../models/employee_document_attachment.dart';
import '../models/employee_id.dart';
import '../models/employee_jobinfo.dart';
import '../models/employee_promotion.dart';
import '../models/insurance.dart';
import '../models/insurancemodel.dart';
import '../models/insurancetypemodel.dart';
import '../models/leave.dart';
import '../models/leave_list_response.dart';
import '../models/leave_report.dart';
import '../models/loan.dart';
import '../models/notification_msg.dart';
import '../models/payslip.dart';
import '../models/plan_trip_product.dart';
import '../models/plantrip_waybill.dart';
import '../models/ptp_route_replacement.dart';
import '../models/reminder.dart';
import '../models/resignation.dart';
import '../models/reward.dart';
import '../models/travel_request.dart';
import '../models/travel_request_list_response.dart';
import '../models/warning.dart';
import '../models/warning_model.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';
import 'package:get/get.dart' hide Response;
class EmployeeService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<EmployeeService> init() async {
    print('EmployeeService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<Employee> getEmployeeProfile(String empID) async {
    //var emp_id = int.tryParse(empID);
    String url =
        Globals.baseURL + "/hr.employee?filters=[('id','='," + empID.toString() + ")]";
    //String filter = "[['id', '=','" + empID + "']]";
    Response response = await dioClient.get(url);

    Employee empInfo = Employee();
    if (response.statusCode == 200) {
      var data = response.data['results'][0];
      empInfo = Employee.fromMap(data);
    }
    return empInfo;
  }

  Future<String> checkLogin(String barcode, String pin) async {
    dioClient = await client();
    String url = Globals.baseURL + "/hr.employee/1/sign_in";
    Response response = await dioClient.put(url,
        data: jsonEncode({"barcode": barcode, "pin": pin}));
    String empID = "";
    if (response.statusCode == 200) {
      if (response.data != null) {
        empID = response.data['employee_id'].toString();
      }
    } else {
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
      print('login info status${response.statusCode}');
    }

    return empID;
  }

  Future<int> travelRequest(TravelRequest travelRequest) async {
    String url = Globals.baseURL + "/travel.request";
    int travel_id = 0;
    print(travelRequest.toJson());
    var travel = travelRequest.toJson();
    Response response = await dioClient.post(url, data: travel);
    if (response.statusCode == 200) {
      if (response.data != null) {
        travel_id = response.data['id'];
      }
    }

    return travel_id;
  }

  Future<String> forgetPassword(String barcode) async {
    String url = Globals.baseURL + "/hr.employee/1/forget_password";
    Response response =
        await dioClient.put(url, data: jsonEncode({"barcode": barcode}));
    var pinCode = '';
    if (response.statusCode == 200) {
      pinCode = response.data;
    }else{
      print("errrorCode >>"+response.statusCode.toString());
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return pinCode;
  }

  Future<List<TravelRequestListResponse>> getTravelRequestListForManger(
      String empID) async {
    List<dynamic> empIds = await getEmployeeList(int.tryParse(empID)!);

    String filter = "[('employee_id','in'," +
        empIds.toString() +
        "),('state','!=','draft')]";
    String url = Globals.baseURL + "/travel.request";

    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<TravelRequestListResponse> travel_list =
        <TravelRequestListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      list.forEach((v) {
        travel_list.add(TravelRequestListResponse.fromMap(v));
      });
    }
    return travel_list;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<String> checkRole(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/check_employee_role";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));

    if (response.statusCode == 200) {
      print(response.toString());
    }
    return response.toString();
  }

  Future<List<Loan>> fetchLoan(String empID, String offset) async {
    List<dynamic> empIds = await getEmployeeList(int.tryParse(empID)!);
    var dateBefore = AppUtils.threemonthago();
    // String url = Globals.baseURL +
    //     "/hr.loan?filters=[('employee_id','in'," + empIds.toString() + "),('create_date','>=','$dateBefore')]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=name desc";
     String url = Globals.baseURL +
        "/hr.loan?filters=[('employee_id','in'," + empIds.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=payment_date desc";
    // String url = Globals.baseURL +
    //     "/hr.loan?filters=[('employee_id','in'," +
    //     empIds.toString() +
    //     ")]";
    Response response = await dioClient.get(url);
    List<Loan> loan_list = <Loan>[];
    if (response.statusCode == 200) {
      print(response.toString());
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          loan_list.add(Loan.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<PaySlips>> fetchPayslip(String empID, String offset) async {
    String datebefore = AppUtils.threemonthago();
    String filter =
        "[('employee_id','in',[" + empID + "]),('state','=','done')]";
    print(filter);

    String url = Globals.baseURL +
        "/hr.employee/"+empID+"/get_employee_payslip";
    print("payslipsUrl:"+url);
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<PaySlips> payslip_list = <PaySlips>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['data'];

      if (list!=null) {
        list.forEach((v) {
          payslip_list.add(PaySlips.fromMap(v));
        });
      }
    }
    return payslip_list;
  }
  Future<List<Branch_id>> fetchHrRule() async {

    String url = Globals.baseURL +
        "/hr.salary.rule.category";

    Response response = await dioClient.get(url);
    List<Branch_id> rule_list = <Branch_id>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];

      if (response.data['count'] != 0) {
        list.forEach((v) {
          rule_list.add(Branch_id.fromMap(v));
        });
      }
    }
    return rule_list;
  }
  Future<List<Insurancemodel>> insuranceList(String id) async {
    String url = Globals.baseURL +
        "/hr.insurance?filters=[('employee_id','='," +
        id +
        ")]";

    Response response = await dioClient.get(url);
    List<Insurancemodel> insurance_list = <Insurancemodel>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          insurance_list.add(Insurancemodel.fromMap(v));
        });
      }
    }
    return insurance_list;
  }

  Future<List<Claiminsurancemodel>> claimInsuranceList(String id) async {
    String url =
        Globals.baseURL + "/hr.claims?filters=[('employee_id','='," + id + ")]";
    Response response = await dioClient.get(url);
    List<Claiminsurancemodel> claim_insurance_list =
        <Claiminsurancemodel>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          claim_insurance_list.add(Claiminsurancemodel.fromMap(v));
        });
      }
    }
    return claim_insurance_list;
  }

  Future<List<Insurancetypemodel>> insuranceTypeList() async {
    String url = Globals.baseURL + "/insurance.type";
    Response response = await dioClient.get(url);
    List<Insurancetypemodel> insurance_type_list =
        <Insurancetypemodel>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          insurance_type_list.add(Insurancetypemodel.fromMap(v));
        });
      }
    }
    return insurance_type_list;
  }

  Future<List<Claiminsurancemodel>> createClaimInsurance(
      Insurancemodel insurancemodel,
      int claimAmount,
      String description,
      String attach_file,
      String date,
      List<Emp_ID> refList) async {
    String url = Globals.baseURL + "/hr.claims";
    var list = refList?.map((x) => x?.toMap())?.toList();
    List<Claiminsurancemodel> claim_insurance_list =
        <Claiminsurancemodel>[];
    Response response = await dioClient.post(url,
        data: jsonEncode({
          "insurance_type_id": insurancemodel.insuranceTypeId!.id,
          "employee_id": insurancemodel.employeeId!.id,
          "insurance_id": insurancemodel.id,
          'coverage_amount': insurancemodel.coverageAmount,
          "claim_amount": claimAmount,
          "description": description,
          'attached_file': attach_file,
          'date': date,
          'insurance_ids': list as List<Emp_ID>
        }));
    if (response.statusCode == 200) {
      String url = Globals.baseURL +
          "/hr.claims?filters=[('employee_id','='," +
          insurancemodel.employeeId!.id.toString() +
          ")]";
      Response response = await dioClient.get(url);
      if (response.statusCode == 200) {
        var data = response.data['results'];
        if (response.data['count'] != 0) {
          data.forEach((v) {
            claim_insurance_list.add(Claiminsurancemodel.fromMap(v));
          });
        }
      }
    }
    return claim_insurance_list;
  }

  Future<List<Insurancemodel>> createEmployeeInsurance(
      Insurancetypemodel insurancetypemodel,
      int employee_id,
      String employeename) async {
    List<Insurancemodel> insurance_list = <Insurancemodel>[];
    String url = Globals.baseURL + "/hr.insurance";
    Response response = await dioClient.post(url,
        data: jsonEncode({
          "insurance_type_id": insurancetypemodel.id,
          'name': employeename,
          "employee_id": employee_id
        }));
    if (response.statusCode == 200) {
      String url = Globals.baseURL +
          "/hr.insurance?filters=[('employee_id','='," +
          employee_id.toString() +
          ")]";
      Response response = await dioClient.get(url);
      if (response.statusCode == 200) {
        var data = response.data['results'];
        if (response.data['count'] != 0) {
          data.forEach((v) {
            insurance_list.add(Insurancemodel.fromMap(v));
          });
        }
      }
    }
    return insurance_list;
  }

  Future<bool> changePassword(String emp_id, String new_pwd) async {
    String login_emp_id = "";
    if(emp_id!=null && emp_id!=""){
      login_emp_id = emp_id;
    }else{
      login_emp_id = box.read('login_employee_id');
    }
    String url = Globals.baseURL + "/hr.employee/1/change_password";
    bool result = false;
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {"employee_id": login_emp_id, "new_pwd": new_pwd}));
    if (response.statusCode == 200) {
      print(response.data.toString());
      result = response.data;
    }else{
    Get.back();
    AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return result;
  }

  Future<List<Announcement>> getApprovalAnnouncement(
      String employee_id, String offset) async {
    List<dynamic> announcement_ids =
        await getApprovalAnnouncementIDsList(employee_id);
    String url = Globals.baseURL +
        "/hr.announcement?filters=[('id','in'," +
        announcement_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<Announcement> announcement_list = <Announcement>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      print("Announcement Type $data");
      if (response.data['count'] != 0) {
        data.forEach((v) {
          announcement_list.add(Announcement.fromMap(v));
        });
      }
    }
    return announcement_list;
  }

  Future<List<Announcement>> getApprovedAnnouncement(
      String employee_id, String offset) async {
    List<dynamic> announcement_ids =
        await getApprovedAnnouncementIDsList(employee_id);
    String url = Globals.baseURL +
        "/hr.announcement?filters=[('id','in'," +
        announcement_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<Announcement> announcement_list = <Announcement>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          announcement_list.add(Announcement.fromMap(v));
        });
      }
    }
    return announcement_list;
  }

  // Future<bool> approvalAnnouncementClick(int id) async {
  //   bool result = true;
  //   String url =
  //       Globals.baseURL + "/hr.announcement/" + id.toString() + "/approve?announcement_from_mobile=true";
  //   Response response = await dioClient.put(url);
  //   if (response.statusCode == 200) {
  //     result = response.data;
  //   }
  //   return result;
  // }
  Future<dynamic> approvalAnnouncementClick(int id) async {
    dynamic result = true;
    String url =
        Globals.baseURL + "/hr.announcement/" + id.toString() + "/approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> approvalAnnouncementNoti(int id) async {
    bool result = true;
    String url =
        Globals.baseURL + "/hr.announcement/" + id.toString() + "/process_announcement_mobile";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<dynamic> approvalInsuranceClick(int id) async {
    dynamic result = true;
    String url =
        Globals.baseURL + "/hr.insurance/" + id.toString() + "/action_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> clickProductRouteApproveLine(
      bool first_route,
      int tripID,
      int route_id,
      int next_route_id,
      int previous_route_id,
      String fuel_bal_input_by_driver,
      String endRouteDate) async {
    String process_datetime =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    String endRouteActualDate = '';
    if (endRouteDate != null && endRouteDate != "") {
      endRouteActualDate = DateTime.parse(endRouteDate)
          .subtract(Duration(hours: 6, minutes: 30))
          .toString()
          .replaceAll('.000', '');
    } else {
      endRouteActualDate = '';
    }
    dynamic result = true;
    String url = Globals.baseURL + "/plan.trip.product/1/update_route_status";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          'first_route': first_route,
          'trip_id': tripID,
          'route_id': route_id,
          'next_route_id': next_route_id,
          'process_datetime': process_datetime,
          'previous_route_id': previous_route_id,
          // 'fuel_bal_input_by_driver': double.parse(fuel_bal_input_by_driver),
          // 'end_actual_date': endRouteActualDate,
        }));
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }

  Future<bool> clickWaybillRouteApproveLine(
      bool first_route,
      int tripID,
      int route_id,
      int next_route_id,
      int previous_route_id,
      String fuel_bal_input_by_driver,
      String endRouteDate) async {
    String process_datetime =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    String endRouteActualDate = '';
    if (endRouteDate != null && endRouteDate != "") {
      endRouteActualDate = DateTime.parse(endRouteDate)
          .subtract(Duration(hours: 6, minutes: 30))
          .toString()
          .replaceAll('.000', '');
    } else {
      endRouteActualDate = '';
    }
    dynamic result = true;
    String url = Globals.baseURL + "/plan.trip.waybill/1/update_route_status";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          'first_route': first_route,
          'trip_id': tripID,
          'route_id': route_id,
          'next_route_id': next_route_id,
          'process_datetime': process_datetime,
          'previous_route_id': previous_route_id,
          // 'fuel_bal_input_by_driver': double.parse(fuel_bal_input_by_driver),
          // 'end_actual_date': endRouteActualDate,
        }));
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }
  Future<bool> clickPTPRouteReplacement(
      int routeID) async {
    dynamic result = true;
     String url =
        Globals.baseURL + "/route.replacement/" + routeID.toString() + "/action_approve";

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }
  Future<bool> clickPTPRouteReplacementReject(
      int routeID) async {
    dynamic result = true;
     String url =
        Globals.baseURL + "/route.replacement/" + routeID.toString() + "/action_reject";

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }

  Future<bool> clickPTWRouteReplacement(
      int routeID) async {
    dynamic result = true;
     String url =
        Globals.baseURL + "/route.replacement/" + routeID.toString() + "/action_approve";

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }

  Future<bool> clickPTWRouteReplacementReject(
      int routeID) async {
    dynamic result = true;
     String url =
        Globals.baseURL + "/route.replacement/" + routeID.toString() + "/action_reject";

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = true;
    }else {
      Get.back();
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }

    return result;
  }

  Future<bool> rejectAnnouncementClick(int id) async {
    bool result = true;
    String url =
        Globals.baseURL + "/hr.announcement/" + id.toString() + "/reject";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> rejectInsuranceClick(int id) async {
    bool result = true;
    String url =
        Globals.baseURL + "/hr.insurance/" + id.toString() + "/action_refuse";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<List<Announcement>> announcement(String id, String offset) async {
    List<dynamic> announcement_ids = await getAnnouncementIDsList(id);
    String url = Globals.baseURL +
        "/hr.announcement?filters=[('id','in'," +
        announcement_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" + offset;
    ;
    Response response = await dioClient.get(url);
    List<Announcement> announcement_list = <Announcement>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          announcement_list.add(Announcement.fromMap(v));
        });
      }
    }
    return announcement_list;
  }

  Future<List<Reminder>> reminder(String id, String offset) async {
    String url = Globals.baseURL + "/hr.employee/1/get_reminder_ids";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(id)}));
    List<Reminder> reminderList = <Reminder>[];
    if (response.statusCode == 200) {
      var data = response.data;
      if (response.data.length != 0) {
        data.forEach((v) {
          reminderList.add(Reminder.fromMap(v));
        });
      }
    }
    return reminderList;
  }

  getAnnouncementIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_announcement_ids";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID)}));
    List<dynamic> announcement_ids = response.data;
    print('Announcement ID List${response.data}');
    return announcement_ids;
  }

  getReminderIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_reminder_ids";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID)}));
    List<dynamic> reminder_ids = response.data;
    print('Reminder ID List${response.data}');
    return reminder_ids;
  }

  getApprovalAnnouncementIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/1/approval_announcements";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID)}));
    List<dynamic> announcement_ids = response.data;
    print('Announcement ID List${response.data}');
    return announcement_ids;
  }

  getApprovedAnnouncementIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/1/approved_announcements";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID)}));
    List<dynamic> announcement_ids = response.data;
    print('Announcement ID List${response.data}');
    return announcement_ids;
  }

  Future<List<Reward>> rewardList(String id, String offset) async {
    String datebefore = AppUtils.threemonthago();

    String url = Globals.baseURL +
        "/hr.reward?filters=[('state','=','approve'),('employee_id','='," +
        id +
        "),('create_date','>=','$datebefore')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;

    Response response = await dioClient.get(url);
    List<Reward> rewards_list = <Reward>[];
    Reward result;
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          rewards_list.add(Reward.fromMap(v));
        });
      }
    }
    return rewards_list;
  }

  Future<List<Reward>> rewardApprovalList(String id, String offset) async {
    //branch_id.manager_id.id
    // String url = Globals.baseURL +
    //     "/hr.reward?filters=[('state','=','submit'),('employee_id.branch_id.manager_id.id','='," +
    //     id +
    //     ")]&limit=" +
    //     Globals.pag_limit.toString() +
    //     "&offset=" +
    //     offset;
    var empID = box.read('emp_id');
    List<dynamic> reward_ids = await getRewardIDsList(empID);
    String filter = "[('id','in'," + reward_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.reward?filters=[('id','in'," +
        reward_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<Reward> rewards_list = <Reward>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          rewards_list.add(Reward.fromMap(v));
        });
      }
    }
    return rewards_list;
  }

  getRewardIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_reward";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> reward_ids = response.data;
    print(response.data);
    return reward_ids;
  }

  Future<List<Reward>> rewardApproveList(String id, String offset) async {
    //branch_id.manager_id.id
    var empID = box.read('emp_id');
    List<dynamic> leave_ids = await getRewardApproveIDsList(empID);
    String filter = "[('id','in'," + leave_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.reward?filters=[('id','in'," +
        leave_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    // String url = Globals.baseURL +
    //     "/hr.reward?filters=[('state','=','approve'),('employee_id.branch_id.manager_id.id','='," +
    //     id +
    //     ")]&limit=" +
    //     Globals.pag_limit.toString() +
    //     "&offset=" +
    //     offset;
    Response response = await dioClient.get(url);
    List<Reward> rewards_list = <Reward>[];
    Warning_model result;
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          rewards_list.add(Reward.fromMap(v));
        });
      }
    }
    return rewards_list;
  }

  Future<bool> approveReward(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.reward/" + id.toString() + "/action_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> cancelReward(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.reward/" + id.toString() + "/action_decline";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<File?> downloadReward(int id, String name) async {
    String retrieve_url = Globals.baseURL + "/report/get_pdf";
    Response response = await dioClient.get(retrieve_url, queryParameters: {
      'report_name': "hr_reward.report_reward_letter",
      'ids': id
    });
    if (response.statusCode == 200) {
      String pdfString = response.data;
      return AppUtils.createPDF(pdfString, "$name.pdf", "$name.pdf");
    }
  }

  Future<File?> downloadWarning(int id, String name) async {
    String retrieve_url = Globals.baseURL + "/report/get_pdf";
    Response response = await dioClient.get(retrieve_url, queryParameters: {
      'report_name': "hr_warning.report_warning_letter",
      'ids': id
    });
    if (response.statusCode == 200) {
      String pdfString = response.data;
      return AppUtils.createPDF(pdfString, "$name.pdf","$name.pdf");
    }
  }

  Future<List<Warning_model>> warningList(String id,String offset) async {
    String datebefore = AppUtils.threemonthago();

    String url = Globals.baseURL +
        "/hr.warning?filters=[('state','=','approve'),('employee_id','='," +
        id +
        "),('create_date','>=','$datebefore')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<Warning_model> warnings_list = <Warning_model>[];
    Warning_model result;
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          warnings_list.add(Warning_model.fromMap(v));
        });
      }
    }
    return warnings_list;
  }

  Future<List<Warning_model>> warningApprovalList(
      String id, String offset) async {
    //branch_id.manager_id.id
    var empID = box.read('emp_id');
    List<dynamic> warning_ids = await getWarningIDsList(empID);
    String filter = "[('id','in'," + warning_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.warning?filters=[('id','in'," +
        warning_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    // String url = Globals.baseURL +
    //     "/hr.warning?filters=[('state','=','submit'),('employee_id.branch_id.manager_id.id','='," +
    //     id +
    //     ")]&limit=" +
    //     Globals.pag_limit.toString() +
    //     "&offset=" +
    //     offset;

    Response response = await dioClient.get(url);
    debugPrint("URL: $url");
    List<Warning_model> warnings_list = <Warning_model>[];
    //Warning_model result;
    if (response.statusCode == 200) {
      var data = response.data['results'];
      debugPrint("Count: ${data.length}");
      if (response.data['count'] != 0) {
        data.forEach((v) {
          warnings_list.add(Warning_model.fromMap(v));
        });
      }
    }
    return warnings_list;
  }

  Future<List<Warning_model>> warningApproveList(
      String id, String offset) async {
    //branch_id.manager_id.id
    var empID = box.read('emp_id');
    List<dynamic> warning_ids = await getWarningApproveIDsList(empID);
    String filter = "[('id','in'," + warning_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.warning?filters=[('id','in'," +
        warning_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    // String url = Globals.baseURL +
    //     "/hr.warning?filters=[('state','=','approve'),('employee_id.branch_id.manager_id.id','='," +
    //     id +
    //     ")]&limit=" +
    //     Globals.pag_limit.toString() +
    //     "&offset=" +
    //     offset;
    Response response = await dioClient.get(url);
    List<Warning_model> warnings_list = <Warning_model>[];
    Warning_model result;
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          warnings_list.add(Warning_model.fromMap(v));
        });
      }
    }
    return warnings_list;
  }

  Future<bool> approveWarning(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.warning/" + id.toString() + "/action_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> cancelWarning(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.warning/" + id.toString() + "/action_decline";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<int> getWarningToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_warning_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID.toString())}));
    return response.data;
  }

  Future<int> getAnnouncementToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_announcements_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<int> getInsuranceToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_insurance_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }
  
  Future<int> getPTPRouteToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_route_end_plan_trip_product_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<int> getRouteReplacementPTPApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_route_replacement_ptp_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<int> getRouteReplacementPTWApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_route_replacement_ptw_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<int> getPTWRouteToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/1/approval_route_end_plan_trip_waybill_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<int> getRewardsToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/1/approval_reward_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<bool> updateEmployeePhone(String emp_id, String phone) async {
    String url = Globals.baseURL + "/hr.employee/" + emp_id.toString();
    Response response =
        await dioClient.put(url, data: jsonEncode({"mobile_phone": phone}));
    var result = false;
    if (response.statusCode == 200) {
      print("UpdateMobileResponse");
      print(response.toString());
      result = true;
    }

    return result;
  }

  Future<bool> updateEmployeeEmail(String emp_id, String email) async {
    String url = Globals.baseURL + "/hr.employee/" + emp_id.toString();
    var result = false;
    Response response =
        await dioClient.put(url, data: jsonEncode({"work_email": email}));
    if (response.statusCode == 200) {
      print("UpdateEmailResponse");
      print(response.toString());
      result = true;
    }

    return result;
  }

  Future<bool> updateEmployeeImage(String emp_id, String image) async {
    String url = Globals.baseURL + "/hr.employee/" + emp_id.toString();
    var result = false;
    Response response =
        await dioClient.put(url, data: jsonEncode({"image_128": image}));
    if (response.statusCode == 200) {
      print("UpdateImageResponse");
      print(response.toString());
      result = true;
    }
    return result;
  }
  Future<String> fetchFiscialYearData(int company_id) async{
    String url = Globals.baseURL + "/hr.employee/2/get_fiscal_year";
    var result = '';
    Response response =
        await dioClient.put(url, data: jsonEncode({"company_id": company_id}));
    if (response.statusCode == 200) {
      print("fetchFiscialYearData");
      print(response.data.toString());
      if(response.data!=null&&response.data.length>0){
        result = response.data[0]+","+response.data[1];
      }
    }
    return result;

  }

  Future<List<Emp_job>> getAllEmployeeList(int companyID, int branchId, int deptID) async {
    String url = Globals.baseURL + "/hr.employee/2/get_employee_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'company_id': companyID, 'branch_id': branchId, 'department_id': deptID, 'keyword': ""}));
   // List<dynamic> emp_ids = await getEmployeeIdsList(companyID,branchId,deptID);
    // String url = Globals.baseURL +
    //     "/hr.employee?filters=[('company_id', '=', "+companyID.toString()+"), ('branch_id', '=', "+branchId.toString()+"), ('department_id', '=', "+deptID.toString()+")]";
    // ;
    // String url = Globals.baseURL +
    //     "/hr.employee?filters=[('id','in'," +
    //     emp_ids.toString() +
    //     ")]";
    // Response response = await dioClient.get(url);
    List<Emp_job> emp_list = <Emp_job>[];
    if (response.statusCode == 200) {
      var data = response.data;
      if (response.data != null) {
        data.forEach((v) {
          emp_list.add(Emp_job.fromMap(v));
        });
        print("empList##");
        print(emp_list.length);
      }
    }
    return emp_list;
  }
  Future<List<Emp_job>> getManagerEmployeeList(int companyID, int branchId,int deptID) async {
   // List<dynamic> emp_ids = await getApproveManagerIdsList(companyID,branchId);
    String url = Globals.baseURL + "/hr.employee/2/get_approve_manager_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'company_id':companyID,'branch_id':branchId,'keyword': "",'department_id':deptID}));
    // String url = Globals.baseURL +
    //     "/hr.employee?filters=[('id','in'," +
    //     emp_ids.toString() +
    //     ")]";
    // String url = Globals.baseURL +
    //     "/hr.employee?filters=[('company_id', '=', "+companyID.toString()+"), ('branch_id', '=', "+branchId.toString()+")]";
    // ;
    // Response response = await dioClient.get(url);
    List<Emp_job> emp_list = <Emp_job>[];
    if (response.statusCode == 200) {
      var data = response.data;
      if (response.data != null) {
        data.forEach((v) {
          emp_list.add(Emp_job.fromMap(v));
        });
      }
    }
    return emp_list;
  }
  Future<List<Department>> getAllDepartmentList(int branchId) async {

    String url = Globals.baseURL +
        "/hr.department?filters=['|', ('branch_id', '=', "+branchId.toString()+"),('branch_id', '=', False)]";
    Response response = await dioClient.get(url);
    List<Department> dept_list = <Department>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          dept_list.add(Department.fromMap(v));
        });
      }
    }
    return dept_list;
  }
  Future<List<Company>> getAllBranchList(int companyId) async {

    String url = Globals.baseURL +
        "/res.branch?filters=['|', ('company_id', '=', "+companyId.toString()+"),('company_id', '=', False)]";
    Response response = await dioClient.get(url);
    List<Company> branch_list = <Company>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          branch_list.add(Company.fromMap(v));
        });
      }
    }
    return branch_list;
  }
  Future<List<Company_id>> getAllCompanyList() async {
    String url = Globals.baseURL +
        "/res.company";
    Response response = await dioClient.get(url);
    List<Company_id> company_list = <Company_id>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          company_list.add(Company_id.fromMap(v));
        });
      }
    }
    return company_list;
  }
  // Future<List<Branch_id>> getBranchList(int companyID) async {
  //   String url = Globals.baseURL +
  //       "/res.branch?filters=['|', ('company_id', '=',"+companyID.toString()+"),('company_id', '=', False)]";
  //   Response response = await dioClient.get(url);
  //   List<Branch_id> company_list = new List<Branch_id>();
  //   if (response.statusCode == 200) {
  //     var data = response.data['results'];
  //     if (response.data['count'] != 0) {
  //       data.forEach((v) {
  //         print("vjson#");
  //         print(v);
  //         company_list.add(Branch_id.fromJson(v));
  //       });
  //     }
  //   }
  //   return company_list;
  // }
  Future<List<Company>> getJobList(int branchId) async {

    // String url = Globals.baseURL +
    //     "/hr.job";
    List<dynamic> jobgrade_ids = await getJobPositionIdsList();
    String url = Globals.baseURL +
        "/hr.job?filters=[('id','in'," +
        jobgrade_ids.toString() +
        ")]";

    Response response = await dioClient.get(url);
    List<Company> job_list = <Company>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          job_list.add(Company.fromMap(v));
        });
      }
    }
    return job_list;
  }
  Future<List<Company>> getJobGradeList() async {
    List<dynamic> jobgrade_ids = await getJobGradeIdsList();
    String url = Globals.baseURL +
        "/job.grade?filters=[('id','in'," +
        jobgrade_ids.toString() +
        ")]";

    Response response = await dioClient.get(url);
    List<Company> job_grade_list = <Company>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          job_grade_list.add(Company.fromMap(v));
        });
      }
    }
    return job_grade_list;
  }
  Future<List<Company>> getSalaryLevelList() async {
    // String url = Globals.baseURL +
    //     "/salary.level";
    List<dynamic> salary_ids = await getSalaryIdsList();
    String url = Globals.baseURL +
        "/salary.level?filters=[('id','in'," +
        salary_ids.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<Company> salary_level_list = <Company>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          salary_level_list.add(Company.fromMap(v));
        });
      }
    }
    return salary_level_list;
  }
  Future<Employee_jobinfo> getEmployeeJobInfo(int empID) async {

    String url = Globals.baseURL +
        "/hr.employee/2/get_employee_job_grade";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': empID.toString()}));
    Employee_jobinfo emp_job_info = new Employee_jobinfo();
    if (response.statusCode == 200) {
      emp_job_info = Employee_jobinfo.fromMap(response.data);
    }
    return emp_job_info;
  }
  Future<double> getEmployeeNewWage(int jobgrade,int salaryLevel) async {
    double new_wage = 0.0;
    String url = Globals.baseURL +
        "/hr.employee/2/get_employee_new_wage";
    Response response = await dioClient.put(url,data: jsonEncode({'new_job_grade_id': jobgrade,'new_salary_level_id': salaryLevel}));
    if (response.statusCode == 200) {
      print(response.data);
      new_wage = response.data;
    }
    return new_wage;
  }
  Future<List<Employee_promotion>> getEmployeeChangeList(int id, String offset) async {
    List<dynamic> emo_change_ids = await getEmployeeChangeIdsList(id);
    String url = Globals.baseURL +
        "/hr.promotion?filters=[('id','in'," +
        emo_change_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset+"&order=date desc";
    print("employee url >>"+url);
    Response response = await dioClient.get(url);
    List<Employee_promotion> promotion_list = <Employee_promotion>[];
    print("employee change response >>"+response.toString());
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          promotion_list.add(Employee_promotion.fromMap(v));
        });
      }
    }
    return promotion_list;
  }
  Future<List<Employee_document>> getEmployeeDocList(int id, String offset) async {
    List<dynamic> doc_ids = await getEmployeeDocumentIdsList(id);
    String url = Globals.baseURL +
        "/hr.employee.document?filters=[('id','in'," +
        doc_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<Employee_document> doc_list = <Employee_document>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          doc_list.add(Employee_document.fromMap(v));
        });
      }
    }
    return doc_list;
  }
  Future<List<Attachment>> getAttachementByDocID(int id) async {
    String url = Globals.baseURL +
        "/hr.employee/2/get_emp_document_attachments";
    Response response = await dioClient.put(url,data:jsonEncode({'doc_id': id}));
    List<Attachment> attachment_list = <Attachment>[];
    if (response.statusCode == 200) {
      print(response.data);
       var data = response.data['attachment'];
      if (data!= null) {
        data.forEach((v) {
          attachment_list.add(Attachment.fromMap(v));
        });
      }
      print("attachemntLength");
      print(attachment_list.length);
    }
    return attachment_list;
  }
  getEmployeeChangeIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/2/get_employee_changes_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getEmployeeDocumentIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/2/get_employee_documents_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getEmployeeIdsList(int companyID, int branchId,int department) async {
    String url = Globals.baseURL + "/hr.employee/2/get_employee_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'company_id': companyID, 'branch_id': branchId, 'department_id': department, 'keyword': ""}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getJobPositionIdsList() async {
    String url = Globals.baseURL + "/hr.employee/2/get_job_position_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'keyword': ""}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getJobGradeIdsList() async {
    String url = Globals.baseURL + "/hr.employee/2/get_job_grade_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'keyword': ""}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getSalaryIdsList() async {
    String url = Globals.baseURL + "/hr.employee/2/get_salary_level_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'keyword': ""}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  getApproveManagerIdsList(int companyID, int branchId) async {
    String url = Globals.baseURL + "/hr.employee/2/get_approve_manager_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'company_id':companyID,'branch_id':branchId,'keyword': "",}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  Future<int> createEmployeeChange(Employee_change_create employee_change_create) async{
    var created = 0;
    String url = Globals.baseURL + "/hr.employee/2/create_employee_changes";
    print('createEmployeeChange');
    print(employee_change_create.toJson());
    Response response = await dioClient.put(url, data: employee_change_create.toJson());

    if (response.statusCode == 200) {
      created = 1;
    }
    return created;
  }

  Future<List<Company_id>> getCompanyList(String keyword) async {
    List<dynamic> company_ids = await getCompanyIdsList(keyword);
    String url = Globals.baseURL +
        "/res.company?filters=[('id','in'," +
        company_ids.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<Company_id> company_list = <Company_id>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          company_list.add(Company_id.fromMap(v));
        });
      }
    }
    return company_list;
  }
  getCompanyIdsList(String keyword) async {
    String url = Globals.baseURL + "/hr.employee/2/get_company_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'keyword': keyword}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }

  getInsuranceIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_insurance";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> insurance_ids = response.data;
    print(response.data);
    return insurance_ids;
  }

  getPTPRouteIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_route_end_plan_trip_product";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> ptpw_route_ids = response.data;
    print(response.data);
    return ptpw_route_ids;
  }

  getPTPRouteReplacementIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_route_replacement_ptp";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> ptpw_route_ids = response.data;
    print(response.data);
    return ptpw_route_ids;
  }

  getPTWRouteReplacementIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_route_replacement_ptw";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> ptw_route_ids = response.data;
    print(response.data);
    return ptw_route_ids;
  }

  getPTWRouteIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_route_end_plan_trip_waybill";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> ptw_route_ids = response.data;
    print(response.data);
    return ptw_route_ids;
  }
  

  getWarningIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_warning";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> warning_ids = response.data;
    print(response.data);
    return warning_ids;
  }

  getRewardApproveIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approve_reward";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> warning_ids = response.data;
    print(response.data);
    return warning_ids;
  }
  getWarningApproveIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approve_warning";
    Response response = await dioClient.put(url, data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> warning_ids = response.data;
    print(response.data);
    return warning_ids;
  }

  Future<List<Insurancemodel>> getInsuranceToApprove(
      String empID,String offset) async {
    List<dynamic> insurance_ids = await getInsuranceIDsList(empID);
    String filter = "[('id','in'," + insurance_ids.toString() + ")]";
    String url = Globals.baseURL + "/hr.insurance?filters=[('id','in'," + insurance_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=name desc";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<Insurancemodel> insurance_list = <Insurancemodel>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          insurance_list.add(Insurancemodel.fromMap(v));
        });
      }
    }
    return insurance_list;
  }

  Future<List<Plan_trip_product>> getPTPRouteToApprove(
      String empID,String offset) async {
    List<dynamic> ptp_route_ids = await getPTPRouteIDsList(empID);
    String filter = "[('id','in'," + ptp_route_ids.toString() + ")]";
    String url = Globals.baseURL + "/plan.trip.product?filters=[('id','in'," + ptp_route_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=code desc";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<Plan_trip_product> ptp_route_list = <Plan_trip_product>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          ptp_route_list.add(Plan_trip_product.fromMap(v));
        });
      }
    }
    return ptp_route_list;
  }

  Future<List<PTPRouteReplacemnt>> getPTPRouteReplacementToApprove(
      String empID,String offset) async {
    List<dynamic> ptp_route_ids = await getPTPRouteReplacementIDsList(empID);
    String filter = "[('id','in'," + ptp_route_ids.toString() + ")]";
    String url = Globals.baseURL + "/route.replacement?filters=[('id','in'," + ptp_route_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset;
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<PTPRouteReplacemnt> ptp_route_replacement_list = <PTPRouteReplacemnt>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          ptp_route_replacement_list.add(PTPRouteReplacemnt.fromMap(v));
        });
      }
    }
    return ptp_route_replacement_list;
  }

  Future<List<PTWRouteReplacemnt>> getPTWRouteReplacementToApprove(
      String empID,String offset) async {
    List<dynamic> ptp_route_ids = await getPTWRouteReplacementIDsList(empID);
    String filter = "[('id','in'," + ptp_route_ids.toString() + ")]";
    String url = Globals.baseURL + "/route.replacement?filters=[('id','in'," + ptp_route_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset;
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<PTWRouteReplacemnt> ptw_route_replacement_list = <PTWRouteReplacemnt>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          ptw_route_replacement_list.add(PTWRouteReplacemnt.fromMap(v));
        });
      }
    }
    return ptw_route_replacement_list;
  }

  

  Future<List<Plantrip_waybill>> getPTWRouteToApprove(
      String empID,String offset) async {
    List<dynamic> ptw_route_ids = await getPTWRouteIDsList(empID);
    String filter = "[('id','in'," + ptw_route_ids.toString() + ")]";
    String url = Globals.baseURL + "/plan.trip.waybill?filters=[('id','in'," + ptw_route_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=code desc";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<Plantrip_waybill> ptw_route_list = <Plantrip_waybill>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          ptw_route_list.add(Plantrip_waybill.fromMap(v));
        });
      }
    }
    return ptw_route_list;
  }
  

  Future<List<Branch_id>> getBranchList(int companyid,String keyword) async {
    List<dynamic> branch_ids = await getBranchIdsList(companyid,keyword);
    String url = Globals.baseURL +
        "/res.branch?filters=[('id','in'," +
        branch_ids.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<Branch_id> company_list = <Branch_id>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          company_list.add(Branch_id.fromMap(v));
        });
      }
    }
    return company_list;
  }
  getBranchIdsList(int companyID,String keyword) async {
    String url = Globals.baseURL + "/hr.employee/2/get_branch_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'company_id':companyID,'keyword': keyword}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }

  Future<List<Department>> getDepartmentList(int branchid,String keyword) async {
    List<dynamic> department_ids = await getDepartmentIdsList(branchid,keyword);
    String url = Globals.baseURL +
        "/hr.department?filters=[('id','in'," +
        department_ids.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<Department> company_list = <Department>[];
    if (response.statusCode == 200) {
      var data = response.data['results'];
      if (response.data['count'] != 0) {
        data.forEach((v) {
          company_list.add(Department.fromMap(v));
        });
      }
    }
    return company_list;
  }
  getDepartmentIdsList(int branchID,String keyword) async {
    String url = Globals.baseURL + "/hr.employee/2/get_department_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'branch_id':branchID,'keyword': keyword}));
    List<dynamic> emp_ids = response.data;
    print('emp_ids ID List${response.data}');
    return emp_ids;
  }
  Future<bool> sendRequest(int id,int recordID) async {
    bool result = true;
    String url =
        Globals.baseURL + "/hr.promotion/"+recordID.toString()+"/button_request";
    Response response = await dioClient.put(url,data:{'employee_id':id});
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> compareotpcode(String otp_code, String user_code) async {
    String url = Globals.baseURL + "/hr.employee/1/compare_sms_code";
    bool result = false;
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {"code": otp_code, "user_code": user_code}));
    if (response.statusCode == 200) {
      print(response.data.toString());
      result = response.data;
    }else{
    Get.back();
    AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return result;
  }

  Future<bool> suspensionEmployee() async{
    var employee_id = box.read('emp_id');
    String url = Globals.baseURL + "/hr.employee/1/suspension_employee";
    bool result = false;
    Response response =
        await dioClient.put(url, data: jsonEncode({"employee_id": int.parse(employee_id)}));
    if (response.statusCode == 200) {
      if(response.data['status']){
          Get.back();
          AppUtils.showSuspendDialog('Warning!',response.data['message'].toString());
      }else{
          result = response.data['status'];
      }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return result;

  }
  Future<List<Insurancemodel>> getInsuranceApproved(String empID,String offset) async {
   List<dynamic> insurance_ids =
        await getInsuranceApprovedIDsList(empID);
    String filter = "[('id','in'," + insurance_ids.toString() + ")]";
    // String url = Globals.baseURL + "/hr.insurance";
    // Response response =
    //     await dioClient.get(url, queryParameters: {"filters": filter});
    String url = Globals.baseURL + "/hr.insurance?filters=[('id','in'," + insurance_ids.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=name desc";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<Insurancemodel> insurance_list = <Insurancemodel>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          insurance_list.add(Insurancemodel.fromMap(v));
        });
      }
    }
    return insurance_list;
  }

  getInsuranceApprovedIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approved_insurance";
    Response response = await dioClient.put(url,
        data:
            jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> insurance_ids = response.data;
    print(response.data);
    return insurance_ids;
  }
}
