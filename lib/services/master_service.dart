

import 'dart:convert';

import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/assessment_structure.dart';
import '../models/base_route.dart';
import '../models/daytrip_expense.dart';
import '../models/depart_empids.dart';
import '../models/department.dart';
import '../models/employee_category.dart';
import '../models/force_manager_rating.dart';
import '../models/force_ranking_hod.dart';
import '../models/leave_type.dart';
import '../models/ot_department.dart';
import '../models/overtime_category.dart';
import '../models/rating_config.dart';
import '../models/stock_location.dart';
import '../models/travel_expense/list/travel_expense_approve_model.dart';
import '../models/travel_expense/travel_expense_category.dart';
import '../models/travel_expense/travel_expense_product.dart';
import '../models/travel_request_list_response.dart';
import '../services/odoo_service.dart';

class MasterService extends OdooService {
  Dio dioClient =  Dio();

  Future<MasterService> init() async {
    dioClient = await client();
    return this;
  }

  Future<List<dynamic>> getEmployeeList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_employees";
    Response response =
        await dioClient!.put(url, data: jsonEncode({'employee_id': empID}));
    List<dynamic> emp_ids = response.data;
    return emp_ids;
  }

  Future<List<LeaveType>> getLeaveType() async {
    String url = Globals.baseURL +
        "/hr.leave.type?filters=[('show_in_mobile_app','=','t')]&order=code";
    Response response = await dioClient!.get(url);
    List<LeaveType> states = <LeaveType>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(LeaveType.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseCategory>> getTravelExpenseCategory(int companyID) async {
    String url = Globals.baseURL +
        "/product.category?filters=[('travel_expense','=',True),'|',('company_id', '=', "+companyID.toString()+"), ('company_id', '=', False)]";
    Response response = await dioClient!.get(url);
    List<TravelExpenseCategory> states = <TravelExpenseCategory>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(TravelExpenseCategory.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseCategory>> getOutofPocketExpenseCategory(int companyID) async {
    String url = Globals.baseURL +
        "/product.category?filters=[('out_of_pocket_expense','=',True),'|', ('company_id', '=', "+companyID.toString()+"), ('company_id', '=', False)]";
    Response response = await dioClient!.get(url);
    List<TravelExpenseCategory> states = <TravelExpenseCategory>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        states.add(TravelExpenseCategory.fromMap(v));
      });
    }
    return states;
  }

  Future<List<TravelExpenseProduct>> getTravelExpenseProduct(int id,String companyID) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('product_tmpl_id.categ_id','=',$id),'|',('product_tmpl_id.company_id','=',"+companyID.toString()+"),('product_tmpl_id.company_id','=','false')]";

    Response response = await dioClient!.get(url);
    List<TravelExpenseProduct> states = <TravelExpenseProduct>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if(response.data['count']!=0){
        list.forEach((v) {
          states.add(TravelExpenseProduct.fromMap(v));
        });
      }
    }
    return states;
  }

  Future<int> getVehicleProduct(int vehicleID, int id,String companyID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_vehicle_product";
    Response response =
        await dioClient!.put(url, data: jsonEncode({'vehicle_id': vehicleID, 'id': id, 'company_id': companyID}));
    int product_id = 0;
    if (response.statusCode == 200) {
      product_id = response.data;
    }
    return product_id;
  }

  Future<List<TravelExpenseProduct>> getOutOfPocketExpenseProduct(int id) async {
    String url = Globals.baseURL +
        "/product.product?filters=[('id','=',$id)]";

    Response response = await dioClient!.get(url);
    List<TravelExpenseProduct> states = <TravelExpenseProduct>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if(response.data['count']!=0){
        list.forEach((v) {
          states.add(TravelExpenseProduct.fromMap(v));
        });
      }
    }
    return states;
  }

  Future<List<TravelRequestListResponse>> getTravelApproveList(
      int empID) async {
    http://54.254.62.118:8069/api/travel.request?filters=%5B('state','in',('approve',in_progress','advance_request','advance_withdraw')),('employee_id','=',6029)%5D
    //String url = "/travel.request?filters=[('state','not in',('draft','submit','cancel')),('employee_id',"=",6115)]";
    String url = Globals.baseURL+ "/travel.request?filters=[('state','in',('approve','advance_request','advance_withdraw')),('employee_id','=',"+empID.toString()+")]";
    Response response = await dioClient!.get(url);
    List<TravelRequestListResponse> travel_list =
        <TravelRequestListResponse>[];
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

  Future<List<TravelRequestListResponse>> getOneTravelApprove(
      int empID,int travel_id) async {
    http://54.254.62.118:8069/api/travel.request?filters=%5B('state','in',('approve','advance_request','advance_withdraw')),('employee_id','=',6029)%5D
    //String url = "/travel.request?filters=[('state','not in',('draft','submit','cancel')),('employee_id',"=",6115)]";
    String url = Globals.baseURL+ "/travel.request/"+travel_id.toString()+"?filters=[('employee_id','=',"+empID.toString()+")]";
    Response response = await dioClient!.get(url);
    List<TravelRequestListResponse> travel_list =
    <TravelRequestListResponse>[];
    if (response.statusCode == 200) {
      print(response.toString());
      travel_list.add(TravelRequestListResponse.fromMap(response.data));
      /*var list = response.data['results'];
      if (response.data['count'] != 0) {
        list.forEach((v) {
          travel_list.add(TravelRequestListResponse.fromMap(v));
        });
      }*/
    }
    return travel_list;
  }



  Future<List<EmployeeCategory>> getEmployeeCategoryList() async {
    String url = Globals.baseURL + "/hr.employee.category";
    Response response = await dioClient!.get(url);
    List<EmployeeCategory> category_list = <EmployeeCategory>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      list.forEach((v) {
        category_list.add(EmployeeCategory.fromMap(v));
      });
    }
    return category_list;
  }

  Future<List<OTDepartment>> getDepartmentList(int empID) async {
    String url = Globals.baseURL + "/ot.request/1/get_department_filter";
    Response response =
        await dioClient!.put(url, data: jsonEncode({'employee_id': empID}));
    List<OTDepartment> department_list = <OTDepartment>[];
    // List<DepartmentEmpIds> department_list = response.data;
    // print(department_list);
    // print("Test");
    if (response.statusCode == 200) {
      var list = response.data;
      list.forEach((v) {
        department_list.add(OTDepartment.fromMap(v));
      });
    }
    return department_list;
  }
  Future<List<OvertimeCategory>> getOvertimeCategoryList(int empID) async {
    String url = Globals.baseURL + "/ot.request/1/get_overtime_category";
    Response response =
        await dioClient!.put(url, data: jsonEncode({'employee_id': empID}));
    List<OvertimeCategory> category_list = <OvertimeCategory>[];
    // List<DepartmentEmpIds> department_list = response.data;
    // print(department_list);
    // print("Test");
    if (response.statusCode == 200) {
      var list = response.data;
      list.forEach((v) {
        category_list.add(OvertimeCategory.fromMap(v));
      });
    }
    return category_list;
  }
  
  getRouteIDsList(String trip_id,String tripType) async {
    String url = Globals.baseURL + "/hr.employee/2/get_route_list";
    Response response = await dioClient!.put(url, data: jsonEncode({'trip_id': int.tryParse(trip_id),'trip_type': tripType}));
    List<dynamic> travel_ids = response.data;
    print(response.data);
    return travel_ids;
  }
  Future<List<BaseRoute>> getRouteList(String tripID,String tripType) async {
    List<dynamic> route_ids = await getRouteIDsList(tripID,tripType);
    String url = Globals.baseURL + "/route.plan";
    String filter = "[('id','in'," + route_ids.toString() + ")]";
    Response response =
    await dioClient!.get(url, queryParameters: {"filters": filter});
    // String url = Globals.baseURL + "/route.plan?filters=[('state', 'in', ('approve', 'verify')), ('company_id', '=', "+companyID.toString()+"), ('branch_id', '=', "+branchID.toString()+")]";
    // Response response = await dioClient.get(url);
    List<BaseRoute> route_list = <BaseRoute>[];
    if (response.statusCode == 200) {
      var list = response.data['results'];
      if(response.data['count']!=0){
        list.forEach((v) {
          route_list.add(BaseRoute.fromMap(v));
        });
      }

    }
    return route_list;
  }

  Future<List<AssessmentStructure>> getRatingConfig() async {
    String url = Globals.baseURL +
        "/assessment.structure?filters=&order=point desc";
    Response response = await dioClient.get(url);
    List<AssessmentStructure> states = <AssessmentStructure>[];
    if (response.statusCode == 200) {
      if(response.data['results'].length > 0){
        var list = response.data['results'];
        list.forEach((v) {
          states.add(AssessmentStructure.fromMap(v));
        });
      }
    }
    return states;
  }

  Future<List<ForceRankingHOD>> getHODRatingConfig() async {
    String url = Globals.baseURL +
        "/force.ranking.hod.bell.curve?filters=&order=id asc";
    Response response = await dioClient.get(url);
    List<ForceRankingHOD> states = <ForceRankingHOD>[];
    // ForceRankingHOD force_rating_hod = new ForceRankingHOD();
    // force_rating_hod.id = '-';
    // force_rating_hod.name = '-';
    // force_rating_hod.percentage = 0;
    // force_rating_hod.managerRating = '';
    // states.add(force_rating_hod);
    if (response.statusCode == 200) {
      if(response.data['results'].length > 0){
        var list = response.data['results'];
        list.forEach((v) {
          states.add(ForceRankingHOD.fromMap(v));
        });
      }
    }
    return states;
  }

   Future<List<ForceManagerRating>> getForceMangerRatingConfig() async {
    String url = Globals.baseURL + "/manager.force.ranking.template/1/get_manager_force_ranking_data";
    Response response = await dioClient.put(url);
    List<ForceManagerRating> forceRating = <ForceManagerRating>[];
    // ForceManagerRating force_rating = new ForceManagerRating();
    // force_rating.id = '-';
    // force_rating.value = '-';
    // forceRating.add(force_rating);
    if (response.statusCode == 200) {
      if(response.data['results'].length > 0){
        var list = response.data['results'];
        list.forEach((v) {
          forceRating.add(ForceManagerRating.fromMap(v));
        });
      }
    }
    return forceRating;
  }

}
