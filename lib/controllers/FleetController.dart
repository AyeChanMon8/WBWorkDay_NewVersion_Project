import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/fleet_insurance.dart';
import '../models/fleet_model.dart';
import '../models/fuel_log_model.dart';
import '../models/fuel_tank.dart';
import '../models/fuel_tank.dart';
import '../models/maintenance_request_model.dart';
import '../services/fleet_service.dart';
import '../services/maintenance_service.dart';
import '../utils/app_utils.dart';

class FleetController extends GetxController{
  FleetService? fleetService;
  MaintenanceService? maintenanceService;

  var fleetList = <Fleet_model>[].obs;
  var fleetInsuranceList = <Fleet_insurance>[].obs;
  var fuelLogList = <Fuel_log_model>[].obs;
  var fueComsumptionList = <ConsumptionAverageHistory>[].obs;
  var tiredList = <TypredHistory>[].obs;
  var maintenanceList = <Maintenance_request_model>[].obs;
  var fuelTankList = <Fuel_History>[].obs;
  var fleetModel = Fleet_model().obs;
  var box = GetStorage();
  var totalFuelAmount = 0.0.obs;
  var totalLiter = 0.0.obs;
  var totalUnitPrice = 0.0.obs;
  var totalFuelConsumptionLiter = 0.0.obs;
  var consumptionRate = 0.0.obs;
  var trace_url ="".obs;
  @override
  void onInit() async{
    fleetService = await FleetService().init();
    this.maintenanceService = await MaintenanceService().init();
    super.onInit();
  }

  @override
  void onReady() async {
    var empId = box.read('emp_id');
    getFleetList(empId);
    super.onReady();
  }


  getMaintenanceList(var vehicleId) async {
    await maintenanceService?.getMaintenanceRequestModelWithVehicle(vehicleId).then((data) {
      maintenanceList.value = data;
    });
  }

  getFleetList(var empId) async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
   await fleetService!.getFleetList(empId,false,false,false,false,false,true).then((value){
      fleetList.value = value;
      if(value.length!=0){
        fueComsumptionList.value =  value[0].consumption_average_history!;
        tiredList.value = value[0].tire_history!;
      }
    });
    Get.back();
  }
  Future<String> getVehicleTraceUrl(int vehicleID) async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    trace_url.value = await fleetService!.show_current_localize(vehicleID);
    Get.back();
    return trace_url.value;
  }

  getOneFleet(var index)async{
    if(fleetList.value.length>0){
      fleetModel.value = fleetList[index];
      var total_odoometer = 0.0;
      var total_liters = 0.0;
      fleetList[index].consumption_average_history?.forEach((element) {
        total_liters+=element.consumption_liter;
        total_odoometer+=element.odometer;
      });
      print('total_liters');
      print(total_liters);
      totalFuelConsumptionLiter.value = total_liters;
      if(total_odoometer!=0.0&&total_liters!=0.0){
        consumptionRate.value = total_odoometer/total_liters;
      }
      getFleetInsuranceList(fleetList[index].id);
      getMaintenanceList(fleetList[index].id);
      getFuelLogList(fleetList[index].id);

      if(fleetList[index].fuelTank!.id!=null){
        getFuelTankList(fleetList[index].fuelTank!.id);
      }

    }
  }

  getFleetInsuranceList(var vehicleid) async{
    fleetInsuranceList.value = await fleetService!.getFleetInsuranceList(vehicleid);
  }
  getFuelLogList(var vehicleid) async{
    fuelLogList.value = await fleetService!.getFuelLogList(vehicleid);
  }
  getFuelTankList(int fueltank_id) async{
    await fleetService?.getFuelTankList(fueltank_id.toString()).then((value){
      var totalLit = 0.0;
      var totalAmt = 0.0;
      var totalPrice = 0.0;
      // value[0].fuel_history.sort((a,b) {
      //   return a.filling_date.compareTo(b.filling_date);
      // });
      value[0].fuleFillingHistoryIds?.forEach((element) {
        String datebefore = AppUtils.onemonthago();
        if(element.filling_date!=null){
          if(element.filling_date.compareTo(datebefore)>0){
            fuelTankList.value.add(element);
            var amount = element.price_per_liter*element.fuel_liter;
            totalAmt+=amount;
            totalLit+=element.fuel_liter;
            totalPrice+= element.price_per_liter;
          }
        }else{
          // fuelTankList.value.add(element);
          // var amount = element.price_per_liter*element.fuel_liter;
          // totalAmt+=amount;
          // totalLit+=element.fuel_liter;
        }

      });
      fuelTankList.value.sort((a,b) {
        if(b.filling_date!=null&&b.filling_date!=null){
          return b.filling_date.compareTo(a.filling_date);
        }else{
          return -1;
        }

      });
      totalLiter.value= totalLit;
      totalFuelAmount.value = totalAmt;
      totalUnitPrice.value = totalPrice;
      print('totalLiter');
      print(totalLiter);
    });
  }
}