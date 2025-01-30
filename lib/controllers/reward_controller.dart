
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/reward.dart';
import '../pages/pdf_view.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class RewardController extends GetxController {
  static RewardController to = Get.find();
  EmployeeService? employeeService;
  var rewards = <Reward>[].obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  var reward_approval_count = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // _getloanList();
    getRewards();
    var employee_id = box.read('emp_id');
    reward_approval_count.value = await employeeService!.getRewardsToApproveCount(employee_id);
  }

  @override
  void onInit() {
    super.onInit();
    // _getloanList();
  }

  getRewards() async {
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
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   rewards.add(element);
        // });
        for(var i=0;i<data.length;i++){
          rewards.add(data[i]);
        }
      }else{
        rewards.value = data;
      }

      Get.back();
    });
  }

  Future<void>getRewardsApproval() async {
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
        if(offset!=0){
          isLoading.value = false;
          //rewards.value.addAll(data);
          // data.forEach((element) {
          //   rewards.add(element);
          // });
          for(var i=0;i<data.length;i++){
            rewards.add(data[i]);
          }
        }else{
          rewards.value = data;
        }
        update();
      Get.back();
    });
  }

  Future<void> getRewardApprove() async {
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
         // rewards.value.addAll(data);
          
          for(var i=0;i<data.length;i++){
            rewards.add(data[i]);
          }
          update();
        }else{
          rewards.value = data;
          update();
        }
      }else{
        rewards.value = [];
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
      // AppUtils.showConfirmDialog('Information', 'Successfully Approved!',() async {
      //   var employee_id = box.read('emp_id');
      //   reward_approval_count.value = await employeeService!.getRewardsToApproveCount(employee_id);
      //   getRewardsApproval();
      //   Get.back();
      //   Get.back();
      // });

      Get.defaultDialog(title:'Information',content: Text('Successfully Approved!'),confirmTextColor: Colors.white,onConfirm: () async{
        var employee_id = box.read('emp_id');
        reward_approval_count.value = await employeeService!.getRewardsToApproveCount(employee_id);
        getRewardsApproval();
        Get.back();
        Get.back();
        });
    });
  }

  declinedReward(int id) async {
    await employeeService?.cancelReward(id).then((data) {
      Get.defaultDialog(title:'Information',content: Text('Successfully Declined!'),confirmTextColor: Colors.white,onConfirm: () async{
        getRewardsApproval();
        Get.back();
        Get.back();
        });
      
      // AppUtils.showConfirmDialog('Information', 'Successfully Declined!',(){
      //   getRewardsApproval();
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
    //  await requestManageExternalStoragePermission();
     await OpenFile.open(file!.path);
    Get.back();
    //Get.to(PdfView(file.path,'reward${reward.id}'));
  }

  Future<void> requestManageExternalStoragePermission() async {
    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      var status = await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        print("Permission granted.");
      } else {
        print("Permission denied.");
        // Redirect the user to app settings to enable the permission
        await openAppSettings();
      }
    }
}

  @override
  void onClose() {
    super.onClose();
  }
}
