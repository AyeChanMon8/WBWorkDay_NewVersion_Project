import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/day_trip_model.dart';
import '../services/daytrip_service.dart';

class DayTripController extends GetxController{
  DayTripServie? dayTripServie;
  final box = GetStorage();
  var dayTripList = <DayTripModel>[].obs;
  var dayTripToApproveList = <DayTripModel>[].obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var current_page = 'open'.obs;
  var latest_page_image = 0;
  var showDetails = true.obs;

  void onInit() async{
    super.onInit();
    this.dayTripServie =await DayTripServie().init();
    // getDayTripList('open');
    // getDayTripList('running');
    // getDayTripList('close');
    //getDayTripToApproveList();
  }

  void getDayTripList(String? pageType) async{
    this.dayTripServie = await DayTripServie().init();
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    var employee_id = int.tryParse(box.read('emp_id'));
    dayTripServie?.getDayTripList(employee_id!,offset.toString(),pageType!).then((data){
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
       // dayTripList.addAll(data);
        // data.forEach((element) {
        //   dayTripList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          dayTripList.add(data[i]);
        }
      }else{
        dayTripList.value = data;
      }
      Get.back();
    });
  }
  getDayTripToApproveList(){
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    var employee_id = int.tryParse(box.read('emp_id'));
    dayTripServie?.getDayTripListToApprove(employee_id!).then((data){
      dayTripToApproveList.value = data;
      Get.back();
    });
  }

  deleteAdvanceLine(int lineID) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.deleteAdvance(lineID).then((data) {
      getDayTripList(current_page.value);
      Get.back();
      if (data != 0) {
        Get.defaultDialog(title:'Information',content: Text('Successfully Deleted!'),confirmTextColor: Colors.white,onConfirm: (){
          Get.back();

        });
      }
    });

  }
  deleteConsumptionLine(int lineID,int trip_id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.deleteConsumptionLine(lineID,trip_id).then((data) {
      getDayTripList(current_page.value);
      Get.back();
      if (data != 0) {
        Get.defaultDialog(title:'Information',content: Text('Successfully Deleted!'),confirmTextColor: Colors.white,onConfirm: (){
          Get.back();

        });
      }
    });

  }

  deleteExpenseLine(int lineID) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.deleteExpense(lineID).then((data) {
      getDayTripList(current_page.value);
      Get.back();
      if (data != 0) {
        Get.defaultDialog(title:'Information',content: Text('Successfully Deleted!'),confirmTextColor: Colors.white,onConfirm: (){
          Get.back();
        });
      }
    });

  }
  deleteFuelInLine(int lineID) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.deleteFuelIn(lineID).then((data) {
      getDayTripList(current_page.value);
      Get.back();
      if (data != 0) {
        Get.defaultDialog(title:'Information',content: Text('Successfully Deleted!'),confirmTextColor: Colors.white,onConfirm: (){
          Get.back();
        });
      }
    });

  }
}