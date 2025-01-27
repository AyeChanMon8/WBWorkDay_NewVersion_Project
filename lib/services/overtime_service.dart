

import 'dart:convert';
import 'package:dio/dio.dart';

import '../constants/globals.dart';
import '../models/employee.dart';
import '../models/overtime_request.dart';
import '../models/overtime_request_response.dart';
import '../models/overtime_response.dart';
import '../models/remark.dart';
import '../utils/app_utils.dart';
import 'odoo_service.dart';

class OvertimeService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<OvertimeService> init() async {
    print('OvertimeService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<OvertimeRequestResponse>> getOvertimeRequestList(
      String empID, String offset) async {
    String datebefore = AppUtils.threemonthago();

    String url = Globals.baseURL +
        "/ot.request?filters=[('requested_employee_id','='," +
        empID.toString() +
        "),('create_date','>=','$datebefore')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=create_date desc";
    Response response = await dioClient.get(url);
    List<OvertimeRequestResponse> ot_list = <OvertimeRequestResponse>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          ot_list.add(OvertimeRequestResponse.fromMap(v));
        });
      }
    }
    return ot_list;
  }

  Future<String> submitOvertime(int id) async {
    var result = "false";
    String url =
        Globals.baseURL + "/ot.request/" + id.toString() + "/button_confirm";

    try {
      Response response = await dioClient.put(url);
      if (response.statusCode == 200) {
        result = 'true';
      }
    } on DioError catch (e) {
      result = e.response!.data['error_descrip'].toString();
    }
    return result;
  }

  Future<String> cancelOvertime(int id) async {
    var result = "false";
    String url = Globals.baseURL + "/ot.request/" + id.toString();
    try {
      Response response = await dioClient.delete(url);
      if (response.statusCode == 200) {
        result = "true";
      }
    } on DioError catch (e) {
      result = e.response!.data['error_descrip'].toString();
    }
    return result;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<String> overtimeRequest(
      int empID, OvertimeRequest overtimeRequest) async {
    String url = Globals.baseURL + "/ot.request";
    String result = "0";
    var databody = overtimeRequest.toJson();
    try {
      Response response = await dioClient.post(url, data: databody);
      if (response.statusCode == 200) {
        print(response.data['id']);
        result = response.data['id'].toString();
      } else if (response.statusCode == 409) {
        print(response.data['error_descrip']);
        result = response.data['error_descrip'].toString();
      }
    } on DioError catch (e) {
      result = e.response!.data['error_descrip'].toString();
    }

    return result;
  }

  Future<List<Employee>> getEmployeeByDept(int deptId, int empID) async {
    String url = Globals.baseURL +
        "/hr.employee?filters=[('department_id','='," +
        deptId.toString() +
        "),('approve_manager','='," +
        empID.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<Employee> emp_list = <Employee>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          emp_list.add(Employee.fromMap(v));
        });
      }
    }
    return emp_list;
  }

  Future<String> overtimeAccept(int empID) async {
    String url = Globals.baseURL +
        "/ot.request.line/" +
        empID.toString() +
        "/button_accept";
    String result = "false";
    try {
      Response response = await dioClient.put(url);
      if (response.statusCode == 200) {
        result = "true";
      }
    } on DioError catch (e) {
      result = e.response!.data['error_descrip'].toString();
    }

    return result;
  }

  Future<bool> overtimeDecline(int empID, Remark remark) async {
    String url = Globals.baseURL + "/ot.request.line/" + empID.toString();
    bool result = false;
    Response response = await dioClient.put(url, data: remark.toJson());
    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<int> getEmployeeOverTimeResponseCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_overtime_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID.toString())}));
    return response.data;
  }

  Future<List<OvertimeResponse>> getEmployeeOvertimeResponseList(
      String empID) async {
    String url = Globals.baseURL +
        "/ot.request.line?filters=[('employee_id','='," +
        empID +
        ")]&order=id asc";
    Response response = await dioClient.get(url);
    List<OvertimeResponse> ot_list = <OvertimeResponse>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          ot_list.add(OvertimeResponse.fromMap(v));
        });
      }
    }
    return ot_list;
  }

  Future<List<OvertimeResponse>> getEmployeeOvertimeResponseAcceptList(
      String empID) async {
    String url = Globals.baseURL +
        "/ot.request.line?filters=[('employee_id','='," +
        empID +
        "),('state','=','accept')]&order=id asc";
    Response response = await dioClient.get(url);
    List<OvertimeResponse> ot_list = <OvertimeResponse>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          ot_list.add(OvertimeResponse.fromMap(v));
        });
      }
    }
    return ot_list;
  }

  Future<List<OvertimeResponse>> getEmployeeOvertimeResponseDeclineList(
      String empID) async {
    String url = Globals.baseURL +
        "/ot.request.line?filters=[('employee_id','='," +
        empID +
        "),('state','=','decline')]&order=id asc";
    Response response = await dioClient.get(url);
    List<OvertimeResponse> ot_list = <OvertimeResponse>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          ot_list.add(OvertimeResponse.fromMap(v));
        });
      }
    }
    return ot_list;
  }

  Future<List<OvertimeResponse>> getManagerOvertimeResponseList(
      String empID) async {
    String url = Globals.baseURL +
        "/ot.request.line?filters=[('requested_employee_id','='," +
        empID +
        "),('state','=','draft')]&order=id asc";
    Response response = await dioClient.get(url);
    List<OvertimeResponse> ot_list = <OvertimeResponse>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          ot_list.add(OvertimeResponse.fromMap(v));
        });
      }
    }
    return ot_list;
  }
}
