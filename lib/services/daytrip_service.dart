
import 'dart:convert';

import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/advance_line.dart';
import '../models/day_trip_expense_line.dart';
import '../models/day_trip_model.dart';
import '../models/daytrip_advance_expense_category.dart';
import '../models/daytrip_fuel_consumption.dart';
import '../models/daytrip_expense.dart';
import '../models/fuelin_line.dart';
import '../models/stock_location.dart';
import '../services/odoo_service.dart';
import 'package:get/get.dart' hide Response;
import '../utils/app_utils.dart';
class DayTripServie extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<DayTripServie> init() async {
    dioClient = await client();
    return this;
  }

  Future<List<DayTripModel>> getDayTripList(
      int empID, String offset, String state) async {
    List<DayTripModel> dayTripList = [];
    List<dynamic> dayTripIdList = await getDayTripIdList(empID, state);
    if (dayTripIdList != null) {
      String url = Globals.baseURL +
          "/day.plan.trip?filters=[('id','in',${dayTripIdList.toString()})]&limit=" +
          Globals.pag_limit.toString() +
          "&offset=" +
          offset +
          "&order=create_date desc";
      Response response = await dioClient.get(url);
      if (response.statusCode == 200) {
        var list = response.data['results'];
        var count = response.data['count'];
        if (count != 0) {
          list.forEach((v) {
            dayTripList.add(DayTripModel.fromMap(v));
          });
        }
      }
    }
    return dayTripList;
  }

  getDayTripIdList(int empID, String state) async {
    String url = Globals.baseURL + "/hr.employee/1/get_day_trip_lists";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': empID, 'state': state}));
    List<dynamic> dayTripIds = response.data;
    return dayTripIds;
  }

  Future<List<Daytrip_expense>> getDayTripExpenseList(String companyID) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('product_tmpl_id.categ_id.day_trip','=',True),'|',('product_tmpl_id.company_id','='," +
        companyID.toString() +
        "),('product_tmpl_id.company_id','=','false')]";
    Response response = await dioClient.get(url);
    List<Daytrip_expense> expense_list = <Daytrip_expense>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var code = response.data['code'];
      if (code != 0) {
        list.forEach((v) {
          expense_list.add(Daytrip_expense.fromMap(v));
        });
      }
    }
    return expense_list;
  }

  Future<List<Stock_location>> getStockLocationList() async {
    String url = Globals.baseURL + "/stock.location";
    Response response = await dioClient.get(url);
    List<Stock_location> expense_list = <Stock_location>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        expense_list.add(Stock_location.fromMap(v));
      });
    }
    return expense_list;
  }

  Future<List<Daytrip_expense>> getDayTripProductListForProductTab(
      String companyID) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('product_tmpl_id.categ_id.delivery','=',True),'|',('product_tmpl_id.company_id','='," +
        companyID.toString() +
        "),('product_tmpl_id.company_id','=','false')]";
    Response response = await dioClient.get(url);
    List<Daytrip_expense> expense_list = <Daytrip_expense>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        expense_list.add(Daytrip_expense.fromMap(v));
      });
    }
    return expense_list;
  }

  Future<List<Daytrip_expense>> getDayTripProductListForFuelTab(
      String companyID) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('product_tmpl_id.categ_id','=',10),'|',('product_tmpl_id.company_id','='," +
        companyID.toString() +
        "),('product_tmpl_id.company_id','=','false')]";
    Response response = await dioClient.get(url);
    List<Daytrip_expense> expense_list = <Daytrip_expense>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        expense_list.add(Daytrip_expense.fromMap(v));
      });
    }
    return expense_list;
  }

  Future<int> addExpense(Expense expense, String id, int empID) async {
    var created = 0;
    String url = Globals.baseURL + "/day.trip.expense";
    var expense_data = expense.toJson();
    Response response = await dioClient.post(url, data: expense_data);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
        print("respomse##");
        print(response.data);
        var lineID = response.data['id'];
        saveEmployee(lineID, empID);
      }
    }

    return created;
  }

  void saveEmployee(int lineID, int empID) async {
    var url = Globals.baseURL + "/hr.employee/2/get_day_trip_expense_emp_id";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {"line_id": lineID, "employee_id": empID, "status": "create"}));
  }

  Future<int> addFuelIn(Fuelin_line fuel) async {
    var created = 0;
    //String url = Globals.baseURL + "/trip.fuel.in";
    String url = Globals.baseURL + "/hr.employee/2/add_fuel_in_line";
    var fuel_data = fuel.toJson();
    Response response = await dioClient.put(url, data: fuel_data);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = response.data['id'];
      }
    }else{
    Get.back();
    AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return created;
  }

  Future<int> addAdvance(Advance_line advance_line) async {
    var created = 0;
    String url = Globals.baseURL + "/travel.request.allowance";
    var advance_data = advance_line.toJson();
    Response response = await dioClient.post(url, data: advance_data);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = response.data['id'];
      }
    }

    return created;
  }

  Future<int> deleteAdvance(int advance_line_id) async {
    var created = 0;
    String url = Globals.baseURL +
        "/travel.request.allowance/" +
        advance_line_id.toString();
    Response response = await dioClient.delete(url);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }

    return created;
  }

  Future<int> deleteExpense(int advance_line_id) async {
    var created = 0;
    String url =
        Globals.baseURL + "/day.trip.expense/" + advance_line_id.toString();
    Response response = await dioClient.delete(url);
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }
    return created;
  }

  Future<int> deleteConsumptionLine(int advance_line_id,int trip_id) async {
    var created = 0;
    // String url = Globals.baseURL + "/day.plan.trip/1/delete_fuel_consumption_line";
    // Response response = await dioClient.put(url,data: jsonEncode({'trip_id':trip_id, 'line_id': advance_line_id}));
    String url = Globals.baseURL +
        "/trip.fuel.consumption/" +
        advance_line_id.toString();
    Response response = await dioClient.delete(url);
    if (response.statusCode == 200) {
      // if (response.data != null) {
      //   created = 1;
      // }
      created = 1;
    }
    return created;
  }

  Future<int> deleteFuelIn(int line_id) async {
    var created = 0;
    String url = Globals.baseURL + "/trip.fuel.in/" + line_id.toString();
    Response response = await dioClient.delete(url);
    // String url = Globals.baseURL + "/day.plan.trip/1/delete_fuel_in_line";
    // Response response = await dioClient.put(url,data: jsonEncode({'line_id': line_id}));
    if (response.statusCode == 200) {
      // if (response.data != null) {
      //   created = 1;
      // }
      created = 1;
    }
    return created;
  }

  Future<List<Daytrip_advance_expense_category>>
      getDayTripAdvanceExpenseCategory(int companyID) async {
    var created = 0;
    String url = Globals.baseURL +
        "/product.category?filters=[('day_trip', '=', True), '|', ('company_id', '=', " +
        companyID.toString() +
        "), ('company_id', '=', False)]";
    //String url = Globals.baseURL + "/product.category?filters=[('day_trip','=',True)]";
    Response response = await dioClient.get(url);
    List<Daytrip_advance_expense_category> expense_category_list =
        <Daytrip_advance_expense_category>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          expense_category_list
              .add(Daytrip_advance_expense_category.fromMap(v));
        });
      }
    }

    return expense_category_list;
  }

  Future<int> addDayTripFuelConsumption(Daytrip_fuel_consumption data) async {
    var created = 0;
    String url = Globals.baseURL + "/hr.employee/1/add_consumption_day_trip";
    var fuel_data = data.toJson();
    Response response = await dioClient.put(url, data: fuel_data);
    if (response.statusCode == 200) {
      created = 1;
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return created;
  }

  // Future<int> endDayTrip(String tripID) async {
  //   var created = 0;
  //   String url = Globals.baseURL + "/day.plan.trip/" + tripID + "/action_end";
  //   Response response = await dioClient.put(url);
  //   if (response.statusCode == 200) {
  //     if (response.data != null) {
  //       created = 1;
  //     }
  //   }
  //   return created;
  // }

  Future<int> updateQty(int pID, String qty) async {
    var created = 0;
    String url = Globals.baseURL + "/trip.product.line/" + pID.toString();
    Response response = await dioClient.put(url,
        data: jsonEncode({'quantity': int.tryParse(qty)}));
    if (response.statusCode == 200) {
      if (response.data != null) {
        created = 1;
      }
    }
    return created;
  }

  Future<List<DayTripModel>> getDayTripListToApprove(int empID) async {
    List<DayTripModel> dayTripList = [];
    String url = Globals.baseURL +
        "/day.plan.trip?filters=[('driver_id.branch_id.manager_id','='," +
        empID.toString() +
        "),('state','=','submit')]&order=create_date desc";
    Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          dayTripList.add(DayTripModel.fromJson(v));
        });
      }
    }
    return dayTripList;
  }

  Future<int> approveDayTip(int id) async {
    var created = 0;
    String url =
        Globals.baseURL + "/day.plan.trip/" + id.toString() + "/action_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      created = 1;
    }
    return created;
  }

  Future<int> declineDayTip(int id) async {
    var created = 0;
    String url =
        Globals.baseURL + "/day.plan.trip/" + id.toString() + "/action_decline";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      created = 1;
    }
    return created;
  }

  Future<String> fetchExpenseStatusDayTipPlantrip(
      int tripId, String state) async {
    var status = '';
    String url = Globals.baseURL + "/hr.employee/2/get_trip_expense_status";
    Response response = await dioClient.put(url,
        data: jsonEncode({'trip_id': tripId, 'status': state}));
    if (response.statusCode == 200) {
      if (response.data != null) {
        print("ResponseData##");
        print(response.data);
        status = response.data;
      }
    }
    return status;
  }

  Future<int> startDayTrip(String tripID) async {
    var created = 0;
    String url =
        Globals.baseURL + "/day.plan.trip/" + tripID + "/action_start";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      created = 1;
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return created;
  }

  Future<int> endDayTrip(String tripID) async {
    var created = 0;
    String url =
        Globals.baseURL + "/day.plan.trip/" + tripID + "/action_end";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      created = 1;
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return created;
  }
}
