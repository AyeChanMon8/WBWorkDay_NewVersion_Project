
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../constants/globals.dart';
import '../models/attandanceuser.dart';
import '../models/attendance.dart';
import '../models/attendance_request.dart';
import '../models/employee.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';

class AttendanceService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<AttendanceService> init() async {
    dioClient = await client();
    return this;
  }

  Future<List<Attandanceuser>> getAttendanceInfo(
      int empId, String offset) async {
    String url =
        Globals.baseURL + "/hr.employee/${empId}/get_attendance_history";
    List<Attandanceuser> attendance_list = <Attandanceuser>[];
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      response.data.forEach((v) {
        attendance_list.add(Attandanceuser.fromMap(v));
      });
    }
    return attendance_list;
  }
  getSelfAttendanceIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_self_attendance";
    Response response = await dioClient.put(url,data: jsonEncode({'employee_id' : empID}));
    if (response.statusCode == 200) {
      if(response!=null){
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }
  Future<List<Attendance>> getOwnAtendance(int empID,String offset) async{
    List<Attendance> attendance_list = [];
    List<dynamic> idsList = await getSelfAttendanceIdsList(empID);
    //String url = Globals.baseURL + "/hr.attendance?filters=[('id','in',${idsList.toString()})]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=id desc";
    String url = Globals.baseURL + "/hr.attendance?filters=[('id','in',${idsList.toString()})]&order=check_in desc";
    Response response = await dioClient.get(url);
    if(response.statusCode==200){
      var list = response.data['results'];
      var count = response.data['count'];
      if(count!=0){
        list.forEach((v) {
          attendance_list.add(Attendance.fromMap(v));
        });
      }
    }
    return attendance_list;
  }
  // Future<List<Attendance>> getOwnAtendance(int empID, String offset) async {
  //   String date =
  //       DateTime(DateTime.now().year, DateTime.now().month, 1).toString();
  //   String datebefore = AppUtils.onemonthago();
  //   String url = Globals.baseURL +
  //       "/hr.attendance?filters=[('employee_id','='," +
  //       empID.toString() +
  //       "),('check_in','>=','$date'),('created_date','>=','$datebefore')]&limit=" +
  //       Globals.pag_limit.toString() +
  //       "&offset=" +
  //       offset.toString() +
  //       "&order=id desc";
  //
  //   List<Attendance> attendance_list = new List<Attendance>();
  //   Response response = await dioClient.get(url);
  //   if (response.statusCode == 200) {
  //     var count = response.data['count'];
  //     if (count != 0) {
  //       var response_data = response.data['results'];
  //       response_data.forEach((v) {
  //         attendance_list.add(Attendance.fromMap(v));
  //       });
  //     }
  //   }
  //   return attendance_list;
  // }
  Future<bool> createAttendanceCheckIn(
      AttendanceRequest attendanceRequest) async {
    String url = Globals.baseURL + "/hr.employee/1/check_in";
    var isCreated = false;
    Response response =
        await dioClient.put(url, data: attendanceRequest.toJson());
    if (response.statusCode == 200) {
      if(response.data){
        isCreated = response.data;
      }else{
        Get.back();
      }
    } else {
      // AppUtils.showDialog('Information', 'Duplicate Record Found!');
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return isCreated;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<List<dynamic>> getEmployeeListForApprovalManager(int empID) async {
    String url = Globals.baseURL +
        "/hr.employee?filters=['|',('approve_manager','='," +
        empID.toString() +
        "),('parent_id', '='," +
        empID.toString() +
        ")]";
    Response response = await dioClient.get(url);
    List<dynamic> emp_ids = <dynamic>[];
    if (response.data['count'] != 0) {
      var list = response.data['results'];
      list.forEach((v) {
        var employee = Employee.fromMap(v);
        emp_ids.add(employee.id);
      });
    }
    return emp_ids;
  }

  Future<List<Attendance>> getAttendanceToApproveList(int empID) async {
    List<dynamic> empIds = await getEmployeeList(empID);

    String filter = "[('employee_id','in'," +
        empIds.toString() +
        "),('state','=','draft'),'|','|','|',('is_absent','=','true'),('missed','=','true'),('late_minutes','>',0),('early_out_minutes','>',0)]";

    String url = Globals.baseURL + "/hr.attendance";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<Attendance> attendance_list = <Attendance>[];
    if (response.statusCode == 200) {
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          attendance_list.add(Attendance.fromMap(v));
        });
      }
    }
    return attendance_list;
  }

  /*Future<List<Attendance>> getAttendanceEmployeeHistoryList(int empID) async {
    List<dynamic> empIds = await getEmployeeListForApprovalManager(empID);
    List<Attendance> attendance_list = new List<Attendance>();
      // String filter = "[('employee_id','in'," +
      //     empIds.toString() +
      //     "),('state','!=','approve')]";
    if(empIds.length!=0){
      String filter = "[('employee_id','in'," +
          empIds.toString() +
          "),'|','|',('is_absent','=','true'),('late_minutes','>',0),('early_out_minutes','>',0)]";
      String url = Globals.baseURL +
          "/hr.attendance?filters=[('employee_id','in'," +
          empIds.toString() +")]";
      //String url = Globals.baseURL + "/hr.attendance";
      Response response =
      await dioClient.get(url);

      if (response.statusCode == 200) {
        if (response.data['count'] != 0) {
          var list = response.data['results'];
          list.forEach((v) {
            attendance_list.add(Attendance.fromMap(v));
          });
        }
      }
    }
      return attendance_list;
  }*/

  Future<List<Attendance>> getAttendanceEmployeeHistoryList(
      int empIds, String date) async {
    String datebefore = AppUtils.oneYearago();
    // List<dynamic> empIds = await getEmployeeListForApprovalManager(empID);
    List<Attendance> attendance_list = <Attendance>[];
    // String filter = "[('employee_id','in'," +
    //     empIds.toString() +
    //     "),('state','!=','approve')]";
    if (empIds != 0) {
      String url = Globals.baseURL +
          "/hr.attendance?filters=[('employee_id','='," +
          empIds.toString() +
          "),('check_in','>=','${date}')]";
      //String url = Globals.baseURL + "/hr.attendance";
      Response response = await dioClient.get(url);

      if (response.statusCode == 200) {
        if (response.data['count'] != 0) {
          var list = response.data['results'];
          list.forEach((v) {
            attendance_list.add(Attendance.fromMap(v));
          });
        }
      }
    }
    return attendance_list;
  }

  Future<List<Attendance>> getAttendanceLateReport(int empID) async {
    List<dynamic> empIds = await getEmployeeList(empID);
    if (empIds.length == 1) {
      return getOwnAtendance(empIds[0], 0.toString());
    } else {
      // String filter = "[('employee_id','in'," +
      //     empIds.toString() +
      //     "),('late_minutes','>',0)]";
      String filter = "[('employee_id','in'," +
          empIds.toString() +
          "),('state','!=','approve'),('late_minutes','>',0)]";
      String url = Globals.baseURL + "/hr.attendance";
      Response response =
          await dioClient.get(url, queryParameters: {"filters": filter});
      List<Attendance> attendace_list = <Attendance>[];
      if (response.statusCode == 200) {
        var list = response.data['results'];
        if (response.data['count'] != 0) {
          list.forEach((v) {
            attendace_list.add(Attendance.fromMap(v));
          });
        }
      }
      return attendace_list;
    }
  }

  Future<List<Attendance>> getAttendanceEarlyReport(int empID) async {
    List<dynamic> empIds = await getEmployeeList(empID);
    if (empIds.length == 1) {
      return getOwnAtendance(empIds[0], 0.toString());
    } else {
      String filter = "[('employee_id','in'," +
          empIds.toString() +
          "),('state','!=','approve'),('early_out_minutes','>',0)]";

      String url = Globals.baseURL + "/hr.attendance";
      Response response =
          await dioClient.get(url, queryParameters: {"filters": filter});
      List<Attendance> attendace_list = <Attendance>[];
      if (response.statusCode == 200) {
        if (response.data['count'] != 0) {
          var list = response.data['results'];
          list.forEach((v) {
            attendace_list.add(Attendance.fromMap(v));
          });
        }
      }
      return attendace_list;
    }
  }

  Future<List<Attendance>> getAttendanceApproveReport(int empID) async {
    List<dynamic> empIds = await getEmployeeList(empID);
    if (empIds.length == 1) {
      return getOwnAtendance(empIds[0], 0.toString());
    } else {
      String filter = "[('employee_id','in'," +
          empIds.toString() +
          "),('state','=','approve')]";
      String url = Globals.baseURL + "/hr.attendance";
      Response response =
          await dioClient.get(url, queryParameters: {"filters": filter});
      List<Attendance> attendace_list = <Attendance>[];
      if (response.statusCode == 200) {
        if (response.data['count'] != 0) {
          var list = response.data['results'];
          list.forEach((v) {
            attendace_list.add(Attendance.fromMap(v));
          });
        }
      }
      return attendace_list;
    }
  }

  //
  // Future<bool> approveAttendance(int attendanceID) async {
  //   bool result = false;
  //   String url = Globals.baseURL + "/hr.attendance/" + attendanceID.toString();
  //   print(url);
  //   Response response =
  //       await dioClient.put(url, data: jsonEncode({'state': 'approve'}));
  //   print("___response___");
  //   print(response);
  //   print(response.statusCode.toString());
  //   if (response.statusCode == 200) {
  //     print(response.toString());
  //     result = true;
  //   }
  //   return result;
  // }
  Future<bool> approveAttendance(int attendanceID) async {
    bool result = false;
    String url =
        Globals.baseURL + "/hr.employee/1/update_missed_in_out_attendances";
    print(url);
    Response response = await dioClient.put(url,
        data: jsonEncode({'attendance_id': attendanceID}));

    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }

  Future<bool> declineAttendance(int attendanceID) async {
    bool result = false;
    String url = Globals.baseURL + "/hr.attendance/" + attendanceID.toString();
    print(url);
    Response response =
        await dioClient.put(url, data: jsonEncode({'state': 'approve'}));

    if (response.statusCode == 200) {
      print(response.toString());
      result = true;
    }
    return result;
  }

  Future<List<Attendance>> getAttendanceRequestToApprove(
      String empID, String offset) async {
    String date =
        DateTime(DateTime.now().year, DateTime.now().month, 1).toString();
    List<Attendance> attendance_list = <Attendance>[];
    List<dynamic> attendance_ids = await getAttanIDsList(empID);
    if (attendance_ids != null) {
      String filter = "[('id','in'," +
          attendance_ids.toString() +
          "),('check_in','>=','$date')]";
      String url = Globals.baseURL +
          "/hr.attendance?filters=[('id','in'," +
          attendance_ids.toString() +
          "),('check_in','>=','$date')]&limit=" +
          Globals.pag_limit.toString() +
          "&offset=" +
          offset;
      print(date);
      Response response = await dioClient.get(url);
      if (response.statusCode == 200) {
        var list = response.data['results'];
        if (response.data['count'] > 0) {
          list.forEach((v) {
            attendance_list.add(Attendance.fromMap(v));
          });
        }
      }
    }
    /* String filter = "[('id','in'," +
        attendance_ids.toString() +
        "),('state','=','draft'),'|','|',('is_absent','=','true'),('late_minutes','>',0),('early_out_minutes','>',0),('check_in','>=','$date')]";*/

    return attendance_list;
  }

  getAttanIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_attendance";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {'employee_id': int.parse(empID.toString()), 'state': "draft"}));
    List<dynamic> attendance_ids = response.data;

    return attendance_ids;
  }
}
