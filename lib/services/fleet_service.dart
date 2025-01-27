

import 'dart:convert';

import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/fleet_insurance.dart';
import '../models/fleet_model.dart';
import '../models/fuel_log_model.dart';
import '../models/fuel_tank.dart';
import '../models/maintenance_team_list.dart';
import '../models/maintenance_workshop_list.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';

class FleetService extends OdooService{
  Dio dioClient = Dio();
  @override
  Future<FleetService> init() async {
    dioClient = await client();
    return this;
  }
  Future<List<Fleet_model>> getFleetList(var empId,bool outOfPocketAccess, bool travelExpenseAccess, bool dayTripAccess, bool planTripProduct, bool planTripWaybill,bool noCheck)async{
    List<Fleet_model> fleetList = [];
    String url = '';
    if(noCheck){
      url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId})]";
    }else if(outOfPocketAccess){
      url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId}),('out_of_pocket_access','=',True)]";
    }else if(travelExpenseAccess){
      url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId}),('travel_expense_access','=',True)]";
    }else{
      url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId})]";
    }
    // String url = Globals.baseURL+"/fleet.vehicle?filters=[('hr_driver_id','=',${empId})]";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fleetList.add(Fleet_model.fromMap(v));
        });
    }
    return fleetList;
  }

  Future<List<Fleet_insurance>> getFleetInsuranceList(var vehicleId)async{
    List<Fleet_insurance> fleetList = [];
    String url = Globals.baseURL+"/fleet.insurance?filters=[('vehicle_id','=',${vehicleId})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fleetList.add(Fleet_insurance.fromJson(v));
        });
    }
    return fleetList;
  }

  Future<List<Fuel_log_model>> getFuelLogList(var vehicleId)async{
    List<Fuel_log_model> fuelLogList = [];
    String url = Globals.baseURL+"/fleet.vehicle.log.fuel?filters=[('vehicle_id','=',${vehicleId})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fuelLogList.add(Fuel_log_model.fromMap(v));
        });
    }
    return fuelLogList;
  }

  Future<List<Fuel_tank>> getFuelTankList(String tankID)async{
    List<Fuel_tank> fuelLogList = [];
    String datebefore = AppUtils.onemonthago();
    String url = Globals.baseURL+"/fuel.tank?filters=[('id','=',${tankID})]";
    //String url = Globals.baseURL+"/fleet.insurance";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          fuelLogList.add(Fuel_tank.fromMap(v));
        });
    }
    return fuelLogList;
  }
  Future<String> show_current_localize(int vehicleId)async{
    var url_reponsne = "";
    String url = Globals.baseURL+"/fleet.vehicle/"+vehicleId.toString()+"/show_current_localize";

    Response response = await dioClient.put(url);
    if(response.statusCode == 200){
      url_reponsne = response.data['url'];
    }
    return url_reponsne;
  }

  Future<List<MaintenanceTeamList>> getMaintenanceTeamList(int vehicleID)async{
    List<MaintenanceTeamList> maintenanceTeamList = [];
    String url = Globals.baseURL+"/hr.employee/2/get_maintenance_team";
    Response response = await dioClient.put(url,data: jsonEncode({"vehicle_id": vehicleID}));
     
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          maintenanceTeamList.add(MaintenanceTeamList.fromMap(v));
        });
    }
    return maintenanceTeamList;
  }
  Future<List<MaintenanceWorkshopList>> getWorkShopSelectionList(var empID)async{
    List<MaintenanceWorkshopList> workShopSelectionList = [];
    String url = Globals.baseURL+"/hr.employee/1/get_workshop_selection_list";
    Response response = await dioClient.put(url);
    if(response.statusCode == 200){
      // MaintenanceWorkshopList data = new MaintenanceWorkshopList();
      // workShopSelectionList.add(MaintenanceWorkshopList.fromJson({'id': '0', 'value': ''}));
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          workShopSelectionList.add(MaintenanceWorkshopList.fromMap(v));
        });
    }
    return workShopSelectionList;
  }

}