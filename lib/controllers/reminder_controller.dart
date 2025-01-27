
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import '../models/reward.dart';
import '../pages/pdf_view.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ReminderController extends GetxController {
  static ReminderController to = Get.find();
  EmployeeService? employeeService;
  var reminders = <Reward>[].obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // _getloanList();
    _getRewards();
  }

  @override
  void onInit() {
    super.onInit();
    // _getloanList();
  }

  _getRewards() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var employee_id = box.read('emp_id');
    await employeeService?.rewardList(employee_id,offset.toString()).then((data) {
      if(data.length!=0){
        reminders.value = data;
      }
      Get.back();
    });
  }

  Future<void>getReminderApproval() async {
    this.employeeService = await EmployeeService().init();
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var employee_id = box.read('emp_id');
    await employeeService?.rewardApprovalList(employee_id,offset.toString()).then((data) {
      if(data.length!=0){
        if(offset!=0){
          isLoading.value = false;
          //reminders.value.addAll(data);
          // data.forEach((element) {
          //   reminders.add(element);
          // });
          for(int i=0;i<data.length;i++){
            reminders.add(data[i]);
          }
        }else{
          reminders.value = data;
        }
        update();
      }
      Get.back();
    });
  }

  Future<void> getReminderApprove() async {
    this.employeeService = await EmployeeService().init();
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var employee_id = box.read('emp_id');
    await employeeService?.rewardApproveList(employee_id,offset.toString()).then((data) {
      if(data.length!=0){
        if(offset != 0){
          isLoading.value = false;
          //reminders.value.addAll(data);
          // data.forEach((element) {
          //   reminders.add(element);
          // });
          for(int i=0;i<data.length;i++){
            reminders.add(data[i]);
          }
        }else{
          reminders.value = data;
        }
        update();
      }
      Get.back();
    });
  }
  approveReward(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService?.approveReward(id).then((data) {
      //travel_approve_show.value = false;
      Get.back();

      Get.defaultDialog(title:'Information',content: Text('Successfully Approved!'),confirmTextColor: Colors.white,onConfirm: () async{
        getReminderApproval();
        Get.back();
        Get.back();
        });
    });
  }

  declinedReward(int id) async {
    await employeeService?.cancelReward(id).then((data) {
      Get.defaultDialog(title:'Information',content: Text('Successfully Declined!'),confirmTextColor: Colors.white,onConfirm: () async{
        getReminderApproval();
        Get.back();
        Get.back();
        });

      // AppUtils.showConfirmDialog('Information', 'Successfully Declined!',(){
      //   getReminderApproval();
      //   Get.back();
      //   Get.back();
      // });
    });
  }
  void downloadReward(Reward reward) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    File? file = await employeeService!.downloadReward(reward.id, 'reward${reward.id}');
     await OpenFile.open(file!.path);
    Get.back();
    //Get.to(PdfView(file.path,'reward${reward.id}'));
  }
  @override
  void onClose() {
    super.onClose();
  }
}
