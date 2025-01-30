
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/approval_controller.dart';
import '../models/warning.dart';
import '../models/warning_model.dart';
import '../pages/pdf_view.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/app_utils.dart';

class WarningController extends GetxController {
  static WarningController to = Get.find();
  EmployeeService? employeeService;
  /*var warnings = List<Warning>().obs;*/
  var warnings = <Warning_model>[].obs;
  var warning_approval_count = 0.obs;
  final box = GetStorage();
  var isLoading = false.obs;
  var offset = 0.obs;
  String flag = '';
  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onInit() async {
    super.onInit();
    this.employeeService = await EmployeeService().init();
    var employee_id = box.read('emp_id');
    warning_approval_count.value =
        await employeeService!.getWarningToApproveCount(employee_id);
  }
  void downloadWarning(Warning_model warning) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    File? file = await employeeService!.downloadWarning(warning.id, 'warning${warning.id}');
    // await requestManageExternalStoragePermission();
    await OpenFile.open(file!.path);
    Get.back();
    //Get.to(PdfView(file.path,'warning${warning.id}'));
    /*PDFDocument document= await PDFDocument.fromFile(file);
    print(document.count);
    Get.to(PdfView(document));*/

    //return PDFDocument.fromFile(file);
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

  getWarning() async {
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
    await employeeService?.warningList(employee_id,offset.toString()).then((data) {
      if (offset != 0) {
        isLoading.value = false;
        // data.forEach((element) {
        //   warnings.add(element);
        // });
        for(var i=0;i<data.length;i++){
          warnings.add(data[i]);
        }
      } else {
        warnings.value = data;
      }
      Get.back();
    });
  }

  Future<void> getWarningApproval() async {
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
    await employeeService?.warningApprovalList(employee_id, offset.toString()).then((data) {
      if (offset != 0) {
        isLoading.value = false;
        // data.forEach((element) {
        //   warnings.add(element);
        // });
        for(var i=0;i<data.length;i++){
          warnings.add(data[i]);
        }
      } else {
        warnings.value = data;
      }
      update();
      Get.back();
    });
  }

  Future<void> getWarningApprove() async {
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
    await employeeService?.warningApproveList(employee_id, offset.toString())
        .then((data) {
      if (offset != 0) {
        isLoading.value = false;
        //warnings.value.addAll(data);
        // data.forEach((element) {
        //   warnings.add(element);
        // });
        for(var i=0;i<data.length;i++){
          warnings.add(data[i]);
        }
      } else {
        if (data.length != 0) {
          warnings.value = data;
          // update();
        }else{
          warnings.value = [];
        }
      }
      update();
      Get.back();
    });
  }

  approveWarning(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await employeeService?.approveWarning(id).then((data) async {
      var employee_id = box.read('emp_id');
      warning_approval_count.value =
          await employeeService!.getWarningToApproveCount(employee_id);
      //travel_approve_show.value = false;
      Get.back();
      // AppUtils.showConfirmDialog('Information', 'Successfully Approved!', () {
      //   offset.value = 0;
      //   getWarningApproval();
      //   Get.back();
      //   Get.back();
      // });

      Get.defaultDialog(title:'Information',content: Text('Successfully Approved!'),confirmTextColor: Colors.white,onConfirm: () async{
         offset.value = 0;
        getWarningApproval();
        Get.back();
        Get.back();
        });
    });
  }

  declinedWarning(int id) async {
    await employeeService?.cancelWarning(id).then((data) {
      Get.defaultDialog(title:'Information',content: Text('Successfully Declined!'),confirmTextColor: Colors.white,onConfirm: () async{
          offset.value = 0;
        getWarningApproval();
        Get.back();
        Get.back();
        });

      // AppUtils.showConfirmDialog('Information', 'Successfully Declined!', () {
      //   offset.value = 0;
      //   getWarningApproval();
      //   Get.back();
      //   Get.back();
      // });
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
