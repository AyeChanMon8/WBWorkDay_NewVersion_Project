import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:io' as Io;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../models/base_route.dart';
import '../models/employee_promotion.dart';
import '../models/expense_attachment.dart';
import '../models/loan.dart';
import '../models/outof_pocket_update.dart';
import '../models/resignation.dart';
import '../models/suspension.dart';
import '../models/travel_expense.dart';
import '../models/travel_expense/create/out_of_pocket_expnese_line.dart';
import '../models/travel_expense/create/travel_line_model.dart';
import '../models/travel_expense/edit_pocketModle.dart';
import '../models/travel_expense/list/EditTravelExpenseModel.dart';
import '../models/travel_expense/list/travel_line_list_model.dart';
import '../models/travel_expense/list/travel_list_model.dart';
import '../models/travel_expense/out_of_pocket_model.dart';
import '../models/travel_expense/out_of_pocket_response.dart';
import '../models/travel_expense/pocket_model.dart';
import '../models/travel_expense/travel_expense_list.dart';
import '../models/travel_expense/create/travel_expense_model.dart';
import '../models/travel_expense_category.dart';
import '../models/travel_expense_update.dart';
import '../models/travel_line.dart';
import '../models/travel_request.dart';
import '../models/travel_request_list_response.dart';
import '../models/trip_expense.dart';
import '../routes/app_pages.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';
import 'package:get/get.dart' hide Response;

class TravelRequestService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<TravelRequestService> init() async {
    print('TravelRequestService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<bool> submitTravelExpense(int id, List<TravelLineListModel> travelLine,
      int emp_id, String code) async {
    bool result = true;
    String url = Globals.baseURL +
        "/hr.travel.expense/" +
        id.toString() +
        "/action_submit";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
      travelLine.forEach((element) {
        if (element.vehicle_id != null && element.vehicle_id != 0) {
          create_vehicle_cost_history(
              element.vehicle_id.id,
              element.date,
              element.price_subtotal,
              element.description,
              code,
              element.price_unit,
              element.qty,
              emp_id,
              element.categ_id.id);
        }
      });
    }
    return result;
  }

  Future<bool> create_vehicle_cost_history(
      int vehicleID,
      String date,
      double amount,
      String desc,
      String code,
      double price,
      double qty,
      int empID,
      int categId) async {
    bool created = false;
    String url = Globals.baseURL + "/hr.employee/1/create_vehicle_cost_history";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          'vehicle_id': vehicleID,
          'date': date,
          'amount': amount,
          'description': desc,
          'code': code,
          'employee_id': empID,
          'price_unit': price,
          'qty': qty,
          'categ_id': categId
        }));
    created = response.data;
    return created;
  }

  Future<dynamic> approvalTravelExpenseApproval(int id) async {
    dynamic result = true;
    String url = Globals.baseURL +
        "/hr.travel.expense/" +
        id.toString() +
        "/action_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> declineTravelExpenseApproval(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/hr.travel.expense/" +
        id.toString() +
        "/action_reject";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> approvalOutofPocketApproval(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/hr.pocket.expense/" +
        id.toString() +
        "/action_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> approvalTripExpenseApproval(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/admin.trip.expense/" +
        id.toString() +
        "/action_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> declineOutofPocketApproval(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/hr.pocket.expense/" +
        id.toString() +
        "/action_reject";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<bool> declineTripExpenseApproval(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/admin.trip.expense/" +
        id.toString() +
        "/action_reject";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<int> travelRequest(TravelRequest travelRequest, int status) async {
    String url = Globals.baseURL + "/travel.request/1/create_travle_request";
    var employee_id = int.tryParse(box.read('emp_id'));
    if (status == 0) {
      for (var i = 0; i < travelRequest.travel_line!.length; i++) {
        travelRequest.travel_line![i].update_status = true;
        travelRequest.travel_line![i].employee_id = employee_id!;
      }
    }

    int travel_id = 0;
    print("travel url >>" + url);
    print(travelRequest.toJson());
    var travel = travelRequest.toJson();
    print("travelRequest >>" + travel);
    Response response = await dioClient.put(url, data: travel);
    if (response.statusCode == 200) {
      if (response.data != null) {
        travel_id = response.data[1][0];
      }
    } else {
      travel_id = 0;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return travel_id;
  }

  Future<int> travelRequestUpdate(
      TravelRequest travelRequest, int travelId) async {
    String url = Globals.baseURL + "/travel.request/$travelId";
    int travel_id = 0;
    print(travelRequest.toJson());
    var travel = travelRequest.toJson();
    Response response = await dioClient.put(url, data: travel);
    if (response.statusCode == 200) {
      if (response.data != null) {
        travel_id = response.data['id'];
      }
    } else {
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return travel_id;
  }

  Future<bool> deleteOutofPocket(int id) async {
    var result;
    String url = Globals.baseURL + "/hr.pocket.expense/" + id.toString();
    Response response = await dioClient.delete(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> deleteTravelExpense(int id) async {
    var result;
    String url = Globals.baseURL + "/hr.travel.expense/" + id.toString();
    Response response = await dioClient.delete(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> submitOutofPocketRequst(int id) async {
    bool result = true;
    String url = Globals.baseURL +
        "/hr.pocket.expense/" +
        id.toString() +
        "/action_submit";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      result = response.data;
    }
    return result;
  }

  Future<int> getOutOfPocketToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_out_of_pocket_expense_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<List<Expense_attachment>> getAttachment(int id, String type) async {
    String url = Globals.baseURL + "/hr.employee/2/get_expense_attachment_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({"parent_id": id, "expense": type}));
    List<Expense_attachment> attachment_list = <Expense_attachment>[];
    if (response.statusCode == 200) {
      print(response.toString());
      if (response.data != null) {
        response.data.forEach((v) {
          attachment_list.add(Expense_attachment.fromMap(v));
        });
      }
    }
    return attachment_list;
  }

  Future<int> getTripExpenseToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_trip_expense_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<int> getRouteToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_route_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<int> getLoanToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_loan_requests_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<int> getResignationToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_resignation_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<int> getSuspensionToApproveCount(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_suspension_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<int> getEmployeeChangesToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_employee_changes_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<List<OutofPocketResponse>> getOutOfPocketToApprove(
      String empID, String offset) async {
    List<dynamic> pocket_ids = await getOutOfPocketIDsList(empID);

    String url = Globals.baseURL +
        "/hr.pocket.expense?filters=[('id','in'," +
        pocket_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;

    Response response = await dioClient.get(url);
    List<OutofPocketResponse> pocket_list = <OutofPocketResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          pocket_list.add(OutofPocketResponse.fromMap(v));
        });
      }
    }
    return pocket_list;
  }

  Future<List<TripExpense>> getTripExpenseToApprove(
      String empID, String offset) async {
    List<dynamic> trip_expense_ids = await getTripExpenseIDsList(empID);
    String url = Globals.baseURL +
        "/admin.trip.expense?filters=[('id','in'," +
        trip_expense_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;

    Response response = await dioClient.get(url);
    List<TripExpense> pocket_list = <TripExpense>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          pocket_list.add(TripExpense.fromMap(v));
        });
      }
    }
    return pocket_list;
  }

  Future<List<TripExpense>> getTripExpenseApproved(
      String empID, String offset) async {
    List<dynamic> trip_expense_ids = await getTripExpenseApprovedIDsList(empID);

    String url = Globals.baseURL +
        "/admin.trip.expense?filters=[('id','in'," +
        trip_expense_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<TripExpense> pocket_list = <TripExpense>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          pocket_list.add(TripExpense.fromMap(v));
        });
      }
    }
    return pocket_list;
  }

  Future<List<OutofPocketResponse>> getOutOfPocketApproved(
      String empID, String offset) async {
    var employee_id = int.tryParse(empID);
    List<dynamic> pocket_ids = await getOutOfPocketApprovedIDsList(empID);
    String filter = "[('id','in'," + pocket_ids.toString() + ")]";
    String url = Globals.baseURL + "/hr.pocket.expense";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    // String url = Globals.baseURL + "/hr.pocket.expense";
    // String filter="['|',('employee_id.approve_manager','=',$empID),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','finance_approve','reconcile'])]&limit="+Globals.pag_limit.toString()+"&offset="+offset;
    // String url = Globals.baseURL + "/hr.pocket.expense?filters=['|',('employee_id.approve_manager','=',$employee_id),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','finance_approve','reconcile'])]&limit="+Globals.pag_limit.toString()+"&offset="+offset;
    List<OutofPocketResponse> pocket_list = <OutofPocketResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          pocket_list.add(OutofPocketResponse.fromMap(v));
        });
      }
    }
    return pocket_list;
  }

  Future<int> getTravelExpenseToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_travel_expense_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_id": int.tryParse(empID)}));
    return response.data;
  }

  Future<List<TravelExpenseList>> getTravelExpenseToApprove(
      String empID, String offset) async {
    List<dynamic> travel_expense_ids = await getTravelExpenseIDsList(empID);
    String filter = "[('id','in'," + travel_expense_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.travel.expense?filters=[('id','in'," +
        travel_expense_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<TravelExpenseList> travel_expense_list = <TravelExpenseList>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_expense_list.add(TravelExpenseList.fromMap(v));
        });
      }
    }
    return travel_expense_list;
  }

  Future<List<TravelExpenseList>> getTravelExpenseApproved(
      String empID, String offset) async {
    List<dynamic> travel_expense_ids =
        await getTravelExpenseApprovedIDsList(empID);
    String filter = "[('id','in'," + travel_expense_ids.toString() + ")]";
    String url = Globals.baseURL + "/hr.travel.expense";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    // String url = Globals.baseURL + "/hr.travel.expense?filters=['|',('employee_id.approve_manager','=',$empID),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','finance_approve','reconcile'])]&limit=5&offset="+offset;
    // String filter="['|',('employee_id.approve_manager','=',$empID),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','finance_approve','reconcile'])]";
    // Response response =
    // await dioClient.get(url);
    List<TravelExpenseList> travel_expense_list = <TravelExpenseList>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_expense_list.add(TravelExpenseList.fromMap(v));
        });
      }
    }
    return travel_expense_list;
  }

  Future<List<TravelExpenseListModel>> getExpenseListModel(String empID) async {
    String url = Globals.baseURL +
        "/hr.travel.expense?filters=[('employee_id','='," +
        empID +
        ")]";
    Response response = await dioClient.get(url);
    List<TravelExpenseListModel> travel_list = <TravelExpenseListModel>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_list.add(TravelExpenseListModel.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<OutofPocketResponse>> getOutofPocketModel(
      String empID, String offset) async {
    int employeeID = int.parse(empID);
    String datebefore = AppUtils.oneYearago();
    final box = GetStorage();
    var startDate = box.read('ficial_start_date');
    var endDate = box.read('ficial_end_date');
    String url = Globals.baseURL +
        "/hr.pocket.expense?filters=[('employee_id','=',$employeeID),('create_date','>=','$startDate'),('create_date','<=','$endDate')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<OutofPocketResponse> out_of_pocket = <OutofPocketResponse>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] != 0) {
        list.forEach((v) {
          out_of_pocket.add(OutofPocketResponse.fromMap(v));
        });
      }
    }
    return out_of_pocket;
  }

  Future<List<OutofPocketResponse>> getOutofPocketModelApproval(
      String empID) async {
    int employeeID = int.parse(empID);
    String url = Globals.baseURL +
        "/hr.pocket.expense?filters=[('employee_id','=',$employeeID),('state','=','submit')]";
    Response response = await dioClient.get(url);
    List<OutofPocketResponse> out_of_pocket = <OutofPocketResponse>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          out_of_pocket.add(OutofPocketResponse.fromMap(v));
        });
      }
    }
    return out_of_pocket;
  }

  Future<List<TravelExpenseList>> getExpenseTravelExpenseApprovalModel(
      String empID) async {
    int employeeID = int.parse(empID);
    String url = Globals.baseURL +
        "/hr.travel.expense?filters=[('employee_id','=',$employeeID),('state','=','submit')]";
    Response response = await dioClient.get(url);
    List<TravelExpenseList> travelExpense = <TravelExpenseList>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      // print("List");
      // print(list);
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travelExpense.add(TravelExpenseList.fromMap(v));
        });
      }
    }
    return travelExpense;
  }

  Future<List<TravelExpenseList>> getTravelExpenseModel(
      String empID, String offset) async {
    int employeeID = int.parse(empID);
    String datebefore = AppUtils.oneYearago();
    final box = GetStorage();
    var startDate = box.read('ficial_start_date');
    var endDate = box.read('ficial_end_date');
    // String url = Globals.baseURL +
    //     "/hr.travel.expense?filters=[('employee_id','=',$employeeID),('create_date','>=','$startDate'),('create_date','<=','$endDate')]&limit="+Globals.pag_limit.toString()+"&offset="+offset;
    String url = Globals.baseURL +
        "/hr.travel.expense?filters=[('employee_id','=',$employeeID)]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<TravelExpenseList> travelExpense = <TravelExpenseList>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travelExpense.add(TravelExpenseList.fromMap(v));
        });
      }
    }
    return travelExpense;
  }

  Future<bool> create_vehicle_cost(
      int vehicleID,
      String date,
      double amount,
      String desc,
      String code,
      double price,
      double qty,
      int empID,
      int categId) async {
    bool created = false;
    String url = Globals.baseURL + "/hr.employee/1/create_vehicle_cost";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          'vehicle_id': vehicleID,
          'date': date,
          'amount': amount,
          'description': desc,
          'code': code,
          'employee_id': empID,
          'price_unit': price,
          'qty': qty,
          'categ_id': categId
        }));
    created = response.data;
    return created;
  }

  Future<bool> travel_create_vehicle_cost(
      int vehicleID,
      String date,
      double amount,
      String desc,
      String code,
      double price,
      double qty,
      int empID,
      int categId) async {
    bool created = false;
    String url = Globals.baseURL + "/hr.employee/1/travel_create_vehicle_cost";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          'vehicle_id': vehicleID,
          'date': date,
          'amount': amount,
          'description': desc,
          'code': code,
          'employee_id': empID,
          'price_unit': price,
          'qty': qty,
          'categ_id': categId
        }));
    created = response.data;
    return created;
  }

  Future<int> updateOutOfPocket(
      int pID, OutofPocketUpdateModel outofPocket) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.employee/2/add_pocket_expense_lines";
    print('pocketlinesize');
    print(outofPocket.pocket_line!.length);
    print(outofPocket.pocket_line.toString());
    Response response = await dioClient.put(url, data: outofPocket.toJson());

    if (response.statusCode == 200) {
      created = 1;
    } else {
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return created;
  }

  Future<int> deleteExpenseLine(int line_id) async {
    var created = 0;
    String url =
        Globals.baseURL + "/hr.pocket.expense.line/" + line_id.toString();
    Response response = await dioClient.delete(url);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return created;
  }

  Future<int> deleteTravelExpenseLine(int line_id) async {
    var created = 0;
    String url =
        Globals.baseURL + "/hr.travel.expense.line/" + line_id.toString();
    Response response = await dioClient.delete(url);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }

    return created;
  }

  Future<int> deleteFleetVehicleLogFuelLine(int line_id) async {
    var created = 0;
    var id = 0;
    String url = Globals.baseURL +
        "/fleet.vehicle.log.fuel?filters=[('expense_id','=',${line_id})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response responseList = await dioClient.get(url);
    if (responseList.statusCode == 200) {
      if (responseList.data['count'] > 0) {
        var list = responseList.data['results'].first;
        id = list['id'];
        String url =
            Globals.baseURL + "/fleet.vehicle.log.fuel/" + id.toString();
        Response response = await dioClient.delete(url);
        if (response.statusCode == 200) {
          if (response.data != null) {
            created = 1;
          }
        }
      }
    }
    return created;
  }

  Future<int> createOutofPocket(OutofPocketModel outofPocket) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.pocket.expense";
    var travelList = outofPocket.toJson();
    Response response = await dioClient.post(url, data: travelList);
    if (response.statusCode == 200) {
      var code = "";
      if (response.data != null) {
        code = response.data['number'];
      }
      for (int i = 0; i < outofPocket.pocket_line!.length; i++) {
        if (outofPocket.pocket_line![i].vehicle_id != null &&
            outofPocket.pocket_line![i].vehicle_id != 0) {
          create_vehicle_cost(
              outofPocket.pocket_line![i].vehicle_id,
              outofPocket.pocket_line![i].date,
              outofPocket.pocket_line![i].price_subtotal,
              outofPocket.pocket_line![i].description,
              code,
              outofPocket.pocket_line![i].price_unit,
              outofPocket.pocket_line![i].qty,
              outofPocket.employee_id,
              outofPocket.pocket_line![i].categ_id);
        }
      }
      // outofPocket.pocket_line.forEach((element) {
      //   if(element.vehicle_id!=null&&element.vehicle_id!=0){
      //     create_vehicle_cost(element.vehicle_id,element.date,element.price_subtotal,element.description,code,element.price_unit,element.qty,outofPocket.employee_id,element.categ_id);
      //   }
      // });
      if (response.data != null) {
        if (response.data['id'] == null) {
        } else {
          created = 1;
        }
      }
    }
    return created;
  }

  Future<int> updateOutofPocketExpenseLine(
      EditPocketModel outofPocketExpenseLine, String expID) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.pocket.expense/" + expID;
    var travelList = outofPocketExpenseLine.toJson();
    Response response = await dioClient.put(url, data: travelList);
    if (response.statusCode == 200) {
      print(response.toString());
      created = 1;
      /* if (response.data != null) {
        print(response.data['id']);
        if (response.data['id'] == null) {
        } else {
          created = 1;
        }
      }*/
    }
    return created;
  }

  Future<int> updateTravelExpenseLine(
      EditTravelExpenseModel outofPocketExpenseLine,
      String expID,
      int empID) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.travel.expense/" + expID;
    var travelList = outofPocketExpenseLine.toJson();
    Response response = await dioClient.put(url, data: travelList);
    if (response.statusCode == 200) {
      print(response.toString());
      var code = "";
      if (response.data != null) {
        code = response.data['number'];
      }
      for (int i = 0; i < outofPocketExpenseLine.travel_line.length; i++) {
        if (outofPocketExpenseLine.travel_line[i].vehicle_id != null ||
            outofPocketExpenseLine.travel_line[i].vehicle_id != 0) {
          travel_create_vehicle_cost(
              outofPocketExpenseLine.travel_line[i].vehicle_id,
              outofPocketExpenseLine.travel_line[i].date,
              outofPocketExpenseLine.travel_line[i].price_subtotal,
              outofPocketExpenseLine.travel_line[i].description,
              code,
              outofPocketExpenseLine.travel_line[i].price_unit,
              outofPocketExpenseLine.travel_line[i].qty,
              empID,
              outofPocketExpenseLine.travel_line[i].categ_id);
        }
      }
      // outofPocketExpenseLine.travel_line.forEach((element) {
      //   if(element.vehicle_id!=null||element.vehicle_id!=0){
      //     travel_create_vehicle_cost(element.vehicle_id,element.date,element.price_subtotal,element.description,code,element.price_unit,element.qty,empID,element.categ_id);
      //   }
      // });
      created = 1;
      /* if (response.data != null) {
        print(response.data['id']);
        if (response.data['id'] == null) {
        } else {
          created = 1;
        }
      }*/
    }
    return created;
  }

  Future<int> createTravelRequest(TravelExpenseModel traveldata) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.travel.expense";
    print(traveldata.toJson());
    var leave = traveldata.toJson();
    String code = '';
    //Globals.ph_hardware_back.value = false;
    Response response = await dioClient.post(url, data: leave);
    if (response.statusCode == 200) {
      if (response.data != null) {
        code = response.data["number"];
      }
      for (int i = 0; i < traveldata.travel_line!.length; i++) {
        if (traveldata.travel_line![i].vehicle_id != null &&
            traveldata.travel_line![i].vehicle_id != 0) {
          travel_create_vehicle_cost(
              traveldata.travel_line![i].vehicle_id,
              traveldata.travel_line![i].date,
              traveldata.travel_line![i].price_subtotal,
              traveldata.travel_line![i].description,
              code,
              traveldata.travel_line![i].price_unit,
              traveldata.travel_line![i].qty,
              traveldata.employee_id,
              traveldata.travel_line![i].categ_id);
        }
      }
      // traveldata.travel_line.forEach((element) {
      //   if(element.vehicle_id!=null&&element.vehicle_id!=0){
      //     travel_create_vehicle_cost(element.vehicle_id, element.date, element.price_subtotal, element.description, code,element.price_unit,element.qty,traveldata.employee_id,element.categ_id);
      //   }
      // });
      if (response.data != null) {
        print(response.data[0]);
        if (response.data == null) {
        } else {
          created = 1;
        }
      }
      //Globals.ph_hardware_back.value = true;
    } else {
      //Globals.ph_hardware_back.value = true;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return created;
  }

  Future<int> updateTravelRequest(
      int pID, TravelExpenseUpdateModel traveldata) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.employee/2/add_travel_expense_lines";
    print('pocketlinesize');
    print(traveldata.travel_line!.length);
    //Globals.ph_hardware_back.value = false;
    Response response = await dioClient.put(url, data: traveldata.toJson());

    if (response.statusCode == 200) {
      //Globals.ph_hardware_back.value  = true;
      created = 1;
      // String code = traveldata.number;
      // if(traveldata.travel_line.length>0){
      //   traveldata.travel_line.forEach((element) {
      //     if(element.vehicle_id!=null) {
      //       if (element.vehicle_id != 0) {
      //         create_vehicle_cost(
      //             element.vehicle_id,
      //             element.date,
      //             element.price_subtotal,
      //             element.description,
      //             code,
      //             element.price_unit,
      //             element.qty,
      //             traveldata.employee_id);
      //       }else{
      //           created = 1;
      //       }
      //     }else{
      //         created = 1;
      //     }
      //   });
      // }else{
      //   created =1;
      // }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }

    return created;
  }

  Future<List<TravelRequestListResponse>> getTravelRequestListForManger(
      String empID) async {
    List<dynamic> empIds = await getEmployeeList(int.tryParse(empID)!);
    String filter = "[('employee_id','in'," +
        empIds.toString() +
        "),('state','!=','submit')]";
    String url = Globals.baseURL + "/travel.request";

    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<TravelRequestListResponse> travel_list = <TravelRequestListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          var travel_data = TravelRequestListResponse.fromMap(v);
          if (travel_data.employee_id!.id == empID) {
            travel_list.add(TravelRequestListResponse.fromMap(v));
          } else {
            if (travel_data.state != 'draft') {
              travel_list.add(TravelRequestListResponse.fromMap(v));
            }
          }
        });
      }
    }
    return travel_list;
  }

  Future<List<TravelRequestListResponse>> getTravelRequestListForEmp(
      String empID, String offset) async {
    final box = GetStorage();
    var startDate = box.read('ficial_start_date');
    var endDate = box.read('ficial_end_date');
    String url = Globals.baseURL +
        "/travel.request?filters=[('employee_id','='," +
        empID +
        "),('create_date','>=','$startDate'),('create_date','<=','$endDate')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);
    List<TravelRequestListResponse> travel_list = <TravelRequestListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }
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

  Future<bool> approveTravel(int id) async {
    var result;
    String url = Globals.baseURL +
        "/travel.request/" +
        id.toString() +
        "/button_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> approveRoute(int id) async {
    var result;
    String url =
        Globals.baseURL + "/route.plan/" + id.toString() + "/action_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> approveLoan(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.loan/" + id.toString() + "/action_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> approveEmployeeChange(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.promotion/" + id.toString() + "/button_approve";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> fistAapproveEmployeeChange(int id) async {
    var result;
    String url = Globals.baseURL +
        "/hr.promotion/" +
        id.toString() +
        "/button_first_approve"; //

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> approveResign(int id) async {
    var result;
    String url = Globals.baseURL +
        "/hr.resignation/" +
        id.toString() +
        "/approve_resignation";
    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<int> approveSuspension(int id, BuildContext context) async {
    var result = 0;
    String url = Globals.baseURL +
        "/hr.suspension/" +
        id.toString() +
        "/approve_suspension_mobile";
    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      if (response.data['status'] == 1) {
        result = 1;
        //  result = showConfirmSuspensionDialog(response.data['message'].toString(),response.statusCode.toString(), id,context);
      } else {
        result = 2;
      }
    } else {
      result = 0;
    }
    return result;
  }

  bool showConfirmSuspensionDialog(
      String title, String msg, int id, BuildContext context) {
    bool result = false;
    final box = GetStorage();
    Get.defaultDialog(
      barrierDismissible: false,
      content: Text(title),
      actions: [
        TextButton(
          child: Text('Yes', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
            Get.back();
            // confirmSuspensionDialog(id);
            result = true;
            // return result;
          },
        ),
        TextButton(
          child: Text('No', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
            // return result;
          },
        ),
      ],
    );
    return result;
  }

  Future<bool> confirmSuspension(int id, bool status) async {
    var result;
    String url = Globals.baseURL +
        "/hr.suspension/" +
        id.toString() +
        "/proceed_approve_suspension_mobile";
    Response response =
        await dioClient.put(url, data: jsonEncode({'compute_pay': status}));

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  //  void confirmSuspensionDialog(int id) async {
  //   var result;
  //   String url = Globals.baseURL +
  //       "/hr.suspension/"+id.toString()+"/proceed_approve_suspension";
  //   Response response = await dioClient.put(url);

  //   if (response.statusCode == 200) {
  //       AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
  //         Get.toNamed(Routes.APPROVAL_SUSPENSION_LIST);
  //         Get.back();
  //         Get.back();
  //       });
  //   }
  // }

  Future<bool> requestAdvanceTravel(int id) async {
    var result;
    String url = Globals.baseURL +
        "/travel.request/" +
        id.toString() +
        "/button_request_balance";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      // print(response.toString());
      result = true;
    } else {
      result = false;
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> deleteTravel(int id) async {
    var result;
    String url = Globals.baseURL + "/travel.request/" + id.toString();
    Response response = await dioClient.delete(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<dynamic> submitTravel(int id) async {
    var result;
    String url =
        Globals.baseURL + "/travel.request/" + id.toString() + "/button_submit";

    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      // print(response.toString());
      result = response.data;
    }
    return result;
  }

  Future<bool> cancelTravel(int id) async {
    var result;
    String url =
        Globals.baseURL + "/travel.request/" + id.toString() + "/button_cancel";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> cancelRoute(int id) async {
    var result;
    String url =
        Globals.baseURL + "/route.plan/" + id.toString() + "/action_decline";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> declineEmployeeChange(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.promotion/" + id.toString() + "/cancel_request";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> declineLoan(int id) async {
    var result;
    String url =
        Globals.baseURL + "/hr.loan/" + id.toString() + "/action_refuse";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<bool> declineResigantion(int id) async {
    var result;
    String url = Globals.baseURL +
        "/hr.resignation/" +
        id.toString() +
        "/reject_resignation";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return result;
  }

  Future<bool> declineSuspension(int id) async {
    var result;
    String url = Globals.baseURL +
        "/hr.suspension/" +
        id.toString() +
        "/reject_suspension";

    Response response = await dioClient.put(url);

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  Future<int> getTravelRequestToApproveCount(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_travel_requests_count";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID)}));
    return response.data;
  }

  Future<List<TravelRequestListResponse>> getTravelRequestToApprove(
      String empID, String offset) async {
    List<dynamic> travel_ids = await getTravelIDsList(empID);
    String filter = "[('id','in'," + travel_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/travel.request?filters=[('id','in'," +
        travel_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<TravelRequestListResponse> travel_list = <TravelRequestListResponse>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<Loan>> getLoanToApprove(String empID, String offset) async {
    List<dynamic> loan_ids = await getLoanIDsList(empID);
    String filter = "[('id','in'," + loan_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.loan?filters=[('id','in'," +
        loan_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=id desc";
    Response response = await dioClient.get(url);

    List<Loan> loan_list = <Loan>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Loan.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Loan>> getLoanApproved(String empID, String offset) async {
    List<dynamic> loan_ids = await getLoanApprovedIDsList(empID);
    String filter = "[('id','in'," + loan_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.loan?filters=[('id','in'," +
        loan_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=id desc";
    Response response = await dioClient.get(url);

    List<Loan> loan_list = <Loan>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Loan.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Resignation>> getResignationToApprove(
      String empID, String offset) async {
    List<dynamic> resignation_ids = await getResignationIDsList(empID);
    String filter = "[('id','in'," + resignation_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.resignation?filters=[('id','in'," +
        resignation_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<Resignation> loan_list = <Resignation>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Resignation.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Suspension>> getSuspensionToApprove(
      String empID, String offset) async {
    List<dynamic> suspension_ids = await getSuspensionIDsList(empID);
    String filter = "[('id','in'," + suspension_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.suspension?filters=[('id','in'," +
        suspension_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<Suspension> suspension_list = <Suspension>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          suspension_list.add(Suspension.fromMap(v));
        });
      }
    }
    return suspension_list;
  }

  Future<List<Resignation>> getResignationApproved(
      String empID, String offset) async {
    List<dynamic> resignation_ids = await getResignationApprovedIDsList(empID);
    String filter = "[('id','in'," + resignation_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.resignation?filters=[('id','in'," +
        resignation_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<Resignation> loan_list = <Resignation>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Resignation.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Suspension>> getSuspensionApproved(
      String empID, String offset) async {
    List<dynamic> suspension_ids = await getSuspensionApprovedIDsList(empID);
    String filter = "[('id','in'," + suspension_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.suspension?filters=[('id','in'," +
        suspension_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<Suspension> suspension_list = <Suspension>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          suspension_list.add(Suspension.fromMap(v));
        });
      }
    }
    return suspension_list;
  }

  Future<List<Employee_promotion>> getEmployeeChangesFirstToApprove(
      String empID, String offset) async {
    List<dynamic> employee_changes_ids =
        await getEmployeeChangesIDsfistApprovalList(empID);
    String filter = "[('id','in'," + employee_changes_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.promotion?filters=[('id','in'," +
        employee_changes_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset.toString() +
        "&order=date desc";
    print("employee url >>" + url);
    Response response = await dioClient.get(url);

    List<Employee_promotion> loan_list = <Employee_promotion>[];
    print("employee response >>" + response.toString());
    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Employee_promotion.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Employee_promotion>> getEmployeeChangesToApprove(
      String empID, String offset) async {
    List<dynamic> employee_changes_ids = await getEmployeeChangesIDsList(empID);
    String filter = "[('id','in'," + employee_changes_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.promotion?filters=[('id','in'," +
        employee_changes_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset.toString() +
        "&order=date desc";
    Response response = await dioClient.get(url);

    List<Employee_promotion> loan_list = <Employee_promotion>[];
    print("secondApproval $response");
    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          loan_list.add(Employee_promotion.fromMap(v));
        });
      }
    }
    return loan_list;
  }

  Future<List<Employee_promotion>> getEmployeeChangesApproved(
      String empID, String offset) async {
    List<dynamic> promotion_ids =
        await getEmployeeChangesApprovedIDsList(empID);
    String filter = "[('id','in'," + promotion_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/hr.promotion?filters=[('id','in'," +
        promotion_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=date desc";
    Response response = await dioClient.get(url);
    List<Employee_promotion> promo_list = <Employee_promotion>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          promo_list.add(Employee_promotion.fromMap(v));
        });
      }
    }
    return promo_list;
  }

  Future<List<BaseRoute>> getRoutesToApprove(
      String empID, String offset) async {
    List<dynamic> routes_ids = await getRouteIDsList(empID);
    String filter = "[('id','in'," + routes_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/route.plan?filters=[('id','in'," +
        routes_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<BaseRoute> travel_list = <BaseRoute>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          travel_list.add(BaseRoute.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<BaseRoute>> getRoutesApproved(String empID, String offset) async {
    List<dynamic> routes_ids = await getRouteApprovedIDsList(empID);
    String filter = "[('id','in'," + routes_ids.toString() + ")]";
    String url = Globals.baseURL +
        "/route.plan?filters=[('id','in'," +
        routes_ids.toString() +
        ")]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset;
    Response response = await dioClient.get(url);

    List<BaseRoute> travel_list = <BaseRoute>[];

    if (response.statusCode == 200) {
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          travel_list.add(BaseRoute.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<TravelRequestListResponse>> getTravelRequestApproved(
      String empID) async {
    List<dynamic> travel_ids = await getTravelIDsApprovedList(empID);
    String filter = "[('id','in'," + travel_ids.toString() + ")]";
    String url = Globals.baseURL + "/travel.request";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    // String url = Globals.baseURL + "/travel.request";
    // String filter="['|',('employee_id.approve_manager','=',$empID),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','advance_request','advance_withdraw','in_progress','done','verify'])]";
    // Response response =
    // await dioClient.get(url, queryParameters: {"filters": filter});
    List<TravelRequestListResponse> travel_list = <TravelRequestListResponse>[];

    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<TravelRequestListResponse>> getRouteApproved(String empID) async {
    /* List<dynamic> travel_ids = await getTravelIDsApprovedList(empID);
    String filter = "[('id','in'," + travel_ids.toString() + ")]";
    String url = Globals.baseURL + "/travel.request";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});*/
    String url = Globals.baseURL + "/travel.request";
    String filter =
        "['|',('employee_id.approve_manager','=',$empID),('employee_id.branch_id.manager_id','=',$empID),('state','in',['approve','advance_request','advance_withdraw','in_progress','done','verify'])]";
    Response response =
        await dioClient.get(url, queryParameters: {"filters": filter});
    List<TravelRequestListResponse> travel_list = <TravelRequestListResponse>[];

    if (response.statusCode == 200) {
      print(response.toString());
      var list = response.data['results'];

      if (response.data['count'] > 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }
    }
    return travel_list;
  }

  Future<List<TravelLine>> getTravelLine(TravelRequest travel) async {
    String url = Globals.baseURL + "/travel.request/1/compute_request_line";
    print(travel.toJson());
    Response response = await dioClient.put(url, data: travel.toJson());

    List<TravelLine> travel_line = <TravelLine>[];
    if (response.statusCode == 200) {
      if (response.data['status']) {
        var list = response.data['message'];
        list.forEach((v) {
          travel_line.add(TravelLine.fromMap(v));
        });
      } else {
        Get.back();
        AppUtils.showDialog('Warning', response.data['message']);
      }
    }
    return travel_line;
  }

  getTravelIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_travel_requests";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {'employee_id': int.tryParse(empID), 'state': "submit"}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getLoanIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approval_loan_requests";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getLoanApprovedIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approved_loan_requests";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getResignationIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approval_resignation";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getSuspensionIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approval_suspension";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> suspension_ids = response.data;
    return suspension_ids;
  }

  getResignationApprovedIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approved_resignation";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getSuspensionApprovedIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approved_suspension";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> suspension_ids = response.data;
    return suspension_ids;
  }

  getEmployeeChangesIDsfistApprovalList(String empID) async {
    var empid = int.tryParse(empID);
    String url =
        Globals.baseURL + "/hr.employee/2/first_approval_employee_changes";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getEmployeeChangesIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approval_employee_changes";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    print("ID>>> $empid //$travel_ids");
    return travel_ids;
  }

  getEmployeeChangesApprovedIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approved_employee_changes";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getRouteIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approval_routes";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getRouteApprovedIDsList(String empID) async {
    var empid = int.tryParse(empID);
    String url = Globals.baseURL + "/hr.employee/2/approved_routes";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empid}));
    List<dynamic> travel_ids = response.data;
    return travel_ids;
  }

  getOutOfPocketIDsList(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approval_out_of_pocket_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {'employee_id': int.tryParse(empID), 'state': "submit"}));
    List<dynamic> pocket_ids = response.data;
    return pocket_ids;
  }

  getTripExpenseIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_trip_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID.toString())}));
    List<dynamic> pocket_ids = response.data;
    return pocket_ids;
  }

  getTripExpenseApprovedIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approved_trip_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID.toString())}));
    List<dynamic> pocket_ids = response.data;
    print(response.data);
    return pocket_ids;
  }

  getOutOfPocketApprovedIDsList(String empID) async {
    String url =
        Globals.baseURL + "/hr.employee/2/approved_out_of_pocket_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> pocket_ids = response.data;
    print(response.data);
    return pocket_ids;
  }

  getTravelExpenseIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approval_travel_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {'employee_id': int.tryParse(empID), 'state': "submit"}));
    List<dynamic> travel_expense_ids = response.data;
    print(response.data);
    return travel_expense_ids;
  }

  getTravelExpenseApprovedIDsList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approved_travel_expense";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> travel_expense_ids = response.data;
    print(response.data);
    return travel_expense_ids;
  }

  getTravelIDsApprovedList(String empID) async {
    String url = Globals.baseURL + "/hr.employee/2/approved_travel_requests";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.tryParse(empID)}));
    List<dynamic> travel_ids = [];
    if (response.statusCode == 200) {
      travel_ids = response.data;
    } else {
      //Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return travel_ids;
  }

  Future<TravelLine> updateTravelLine(TravelLine data) async {
    String url = Globals.baseURL + "/travel.request.line/1/update_travel_line";
    Response response = await dioClient.put(url, data: data.toJson());
    TravelLine leave_line = TravelLine();
    //if (response.statusCode == 200) {
    // if(response.data['status']){
    //   leave_line = TravelLine.fromMap(response.data['message']);
    // }else{
    //   leave_line = data;
    // }
    if (response.statusCode == 200) {
      if (response.data['status'] == true) {
        leave_line = TravelLine.fromMap(response.data['message']);
      } else {
        Get.back();
      }
      //}
    }
    return leave_line;
  }

  Future<List<TravelExpenseCategory>> getExpenseCategory(int companyID) async {
    String url = Globals.baseURL +
        "/product.category?filters=[('travel_request','=',True),'|', ('company_id', '=', " +
        companyID.toString() +
        "), ('company_id', '=', False)]";
    Response response = await dioClient.get(url);
    List<TravelExpenseCategory> expense_category_list =
        <TravelExpenseCategory>[];
    print("getExpenseCategory");
    print(response.data.toString());
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          expense_category_list.add(TravelExpenseCategory.fromMap(v));
        });
      }
    }
    return expense_category_list;
  }

  Future<String> getTravelExpenseImage(int id) async {
    String url =
        Globals.baseURL + "/hr.employee/1/get_travel_expense_attachment";
    Response response =
        await dioClient.put(url, data: jsonEncode({"line_id": id}));
    if (response.statusCode == 200) {
      return response.data == false ? '' : response.data;
    }
    return '';
  }

  Future<int> addOutOfPocketExpense(PockectModel expense) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.pocket.expense.line";
    var expense_data = expense.toJson();
    Response response = await dioClient.post(url, data: expense_data);
    if (response.statusCode == 200) {
      print('addedOutofLine');
      print(response.data['id']);
      if (response.data != null) {
        created = response.data['id'];
      }
    }

    return created;
  }

  Future<int> addTravelExpense(TravelLineModel expense) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.travel.expense.line";
    var expense_data = expense.toJson();
    Response response = await dioClient.post(url, data: expense_data);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }

    return created;
  }
}
