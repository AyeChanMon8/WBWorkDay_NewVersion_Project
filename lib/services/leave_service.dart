
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../models/leave.dart';
import '../models/leave_line.dart';
import '../models/leave_list_response.dart';
import '../models/leave_report.dart';
import '../models/travel_expense/out_of_pocket_response.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';

class LeaveService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<LeaveService> init() async {
    print('LeaveService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<LeaveReport>> getLeaveReport(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_leave_report";

    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));

    List<LeaveReport> leave_reports = <LeaveReport>[];
    if (response.statusCode == 200) {
      List<dynamic> list = response.data;
      list.forEach((v) {
        leave_reports.add(LeaveReport.fromMap(v));
      });
    }
    return leave_reports;
  }

  Future<String> updateLeave(Leave leavedata, String id) async {
    var created = "0";
    String url = Globals.baseURL + "/summary.request/$id";
    print(leavedata.toJson());
    var leave = leavedata.toJson();

    try {
      Response response = await dioClient.put(url, data: leave);
      if (response.statusCode == 200) {
        if (response.data != null) {
          created = "1";
        }
      }
    } on DioError catch (e) {
      created = e.response!.data['error_descrip'].toString();
    }
    return created;
  }

  Future<String> checkValidLeave(Leave leavedata) async {
    var status = 'success';
    String url = Globals.baseURL + "/hr.employee/1/check_valid_leaves";
    print(leavedata.toJson());
    var leave = leavedata.toJson();
    print("Leave Leave $leave");
    try {
      Response response = await dioClient.put(url, data: leave);
      if (response.statusCode == 200) {
        if (response.data != null) {
          if (response.data['status'] == 'success')
            status = response.data['status'].toString();
          else
            status = response.data['message'].toString();
        }
      }
    } on DioError catch (e) {
      status = e.response!.data['message'].toString();
    }
    return status;
  }

  Future<String> createLeave(Leave leavedata, int status) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    if(status == 0){
      for(var i=0;i<leavedata.leave_line!.length;i++){
          leavedata.leave_line![i].update_status = true;
          leavedata.leave_line![i].employee_id = employee_id!;
        }
    }
    var created = "0";
    String url =
        Globals.baseURL + "/summary.request/1/create_leave_summary_request";
    print("leavedata.toJson() ${leavedata.toJson()}");
    var leave = leavedata.toJson();

    try {
      Response response = await dioClient.put(url, data: leave);
      if (response.statusCode == 200) {
        if (response.data != null) {
          created = "1";
        }
      }else{
        Get.back();
        AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
      }
    } on DioError catch (e) {
      created = e.response!.data['error_descrip'].toString();
    }
    return created;
  }

  Future<List<LeaveListResponse>> getLeaveList(
      String empID, String offset) async {
    final box = GetStorage();
    var startDate = box.read('ficial_start_date');
    var endDate = box.read('ficial_end_date');
    String datebefore = AppUtils.oneYearago();
    String url = Globals.baseURL +
        "/summary.request?filters=[('employee_id','='," +
        empID +
        "),('create_date','>=','$startDate'),('create_date','<=','$endDate')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset+"&order=start_date desc";
    Response response = await dioClient.get(url);
    List<LeaveListResponse> leave_list = <LeaveListResponse>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          leave_list.add(LeaveListResponse.fromMap(v));
        });
      }
    }
    return leave_list;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<List<LeaveListResponse>> getLeaveListForManager(int empID) async {
    List<dynamic> empIds = await getEmployeeList(empID);
    String filter = "[('employee_id','in'," +
        empIds.toString() +
        "),('state','!=','submit')]";
    String url = Globals.baseURL + "/summary.request";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<LeaveListResponse> leave_list = <LeaveListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      list.forEach((v) {
        var leave = LeaveListResponse.fromMap(v);
        if (leave.employee_id!.id == empID) {
          leave_list.add(LeaveListResponse.fromMap(v));
        } else {
          if (leave.state != 'draft') {
            leave_list.add(LeaveListResponse.fromMap(v));
          }
        }
      });
    }
    return leave_list;
  }

  Future<bool> approveLeave(int id) async {
    var result = false;
    String url = Globals.baseURL +
        "/summary.request/" +
        id.toString() +
        "/button_approve";
        print("leave approve >>"+url);

    Response response = await dioClient.put(url);
      if (response.statusCode == 200) {
      result = true;
    } else {
      Get.back();
      AppUtils.showDialog('Warning!', response.data['error_descrip']);
      result = false;
    }
    // Response response = await dioClient.put(url).onError((error, stackTrace) {
    //    print("button approve error");
    //    print(error.toString());
    // });

    // if (response.statusCode == 200) {
    //   result = true;
    // } else {
    //   Get.back();
    //   AppUtils.showDialog('Warning!', response.data['error_descrip']);
    //   result = false;
    // }


    return result;
  }

  Future<String> submitLeave(int id) async {
    var result = "";
    String url = Globals.baseURL +
        "/summary.request/" +
        id.toString() +
        "/button_submit";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      var res_status = response.data['status'];
      if (res_status != '') {
        result = response.data['message'].toString();
      }
    }
    return result;
  }

  Future<bool> secondApproveLeave(int id) async {
    var result;
    String url = Globals.baseURL +
        "/summary.request/" +
        id.toString() +
        "/button_approve";
    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      print("secondApproveLeave");
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> cancelLeave(int id) async {
    var result;
    String url = Globals.baseURL +
        "/summary.request/" +
        id.toString() +
        "/button_cancel";
    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> deleteLeave(int id) async {
    var result;
    String url = Globals.baseURL + "/summary.request/" + id.toString();
    Response response = await dioClient.delete(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
       Get.back();
    AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return result;
  }

  Future<List<LeaveLine>> getLeaveLine(Leave leave) async {
    String url = Globals.baseURL + "/summary.request/1/compute_request_line";
    print(leave.toJson());
    Response response = await dioClient.put(url, data: leave.toJson());

    List<LeaveLine> leave_line = <LeaveLine>[];
    if (response.statusCode == 200) {
      if (response.data['status'] == false) {
        print("falseexist");
        leave_line.add(LeaveLine(message: response.data['message']));
      } else {
        print("trueeexist");
        var list = response.data['message'];
        list.forEach((v) {
          leave_line.add(LeaveLine.fromMap(v));
        });
        print("leave_line.length");
        print(leave_line.length);
      }
    }else{
        Get.back();
        AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return leave_line;
  }

  Future<LeaveLine> updateLeaveLine(LeaveLine data) async {
    String url =
        Globals.baseURL + "/summary.request.line/1/update_request_line";
    print(data.toJson());
    Response response = await dioClient.put(url, data: data.toJson());
    LeaveLine leave_line = LeaveLine();
    if (response.statusCode == 200) {
      if(response.data['status']==true){
        leave_line = LeaveLine.fromMap(response.data['message']);
      }else{
        Get.back();
      }
    }
    return leave_line;
  }

  Future<int> getLeaveToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_summary_requests_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID)}));
    return response.data;
  }

  Future<List<LeaveListResponse>> getLeaveToApprove(
      String empID, String offset) async {
    List<dynamic> leave_ids = await getLeaveIDsList(empID);
    String filter = "[('id','in'," + leave_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/summary.request?filters=[('id','in'," +
        leave_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<LeaveListResponse> leave_list = <LeaveListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          leave_list.add(LeaveListResponse.fromMap(v));
        });
      }
    }
    return leave_list;
  }

  Future<List<LeaveListResponse>> getLeaveApproved(
      String empID, String offset) async {
    List<dynamic> leave_ids = await getLeaveIDsApprovedList(empID);
    String filter = "[('id','in'," + leave_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/summary.request?filters=[('id','in'," +
        leave_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<LeaveListResponse> leave_list = <LeaveListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          leave_list.add(LeaveListResponse.fromMap(v));
        });
      }
    }
    return leave_list;
  }

  getLeaveIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_summary_requests";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {'employee_id': int.parse(empID.toString()), 'state': "submit"}));
    List<dynamic> leave_ids = response.data;

    print(response.data);
    return leave_ids;
  }

  getLeaveIDsApprovedList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_summary_requests";
    Response response = await dioClient.put(url,
        data:
            jsonEncode({'employee_id': empID.toString(), 'state': "approve"}));
    List<dynamic> leave_ids = response.data;

    print(response.data);
    return leave_ids;
  }

  addAttachment(Leave leave, int leaveID) async {
    String url = Globals.baseURL + "/summary.request/" + leaveID.toString();
    Response response = await dioClient.put(url, data: leave.toJson());
    print("attachement");
    print(response.data);
  }
}
