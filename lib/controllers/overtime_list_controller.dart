
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/overtime_request_response.dart';
import '../services/overtime_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/app_utils.dart';

class OverTimeListController extends GetxController {
  static OverTimeListController to = Get.find();
  OvertimeService? overtimeService;
  var otList = <OvertimeRequestResponse>[].obs;
  var otAcceptedList = <OvertimeRequestResponse>[].obs;
  var otDeclinedList = <OvertimeRequestResponse>[].obs;
  final box = GetStorage();
  var button_submit_show = true.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  @override
  void onReady() async {
    super.onReady();
    this.overtimeService = await OvertimeService().init();
    getOtList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getOtList() async {
    // print("OT list controller");
    var emp_id = box.read("emp_id");
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
    await overtimeService?.getOvertimeRequestList(emp_id.toString(),offset.toString()).then((data) {
      List<OvertimeRequestResponse> otData = data;
      otData.sort(
          (name1, name2) => name2.start_date.compareTo(name1.start_date));
      if(offset!=0){
        isLoading.value = false;
        //otList.addAll(data);
        // data.forEach((element) {
        //   otList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          otList.add(data[i]);
        }
      }else{
        otList.value = data;
      }

      Get.back();
    });
  }
  submitOvertime(int id) async {
    // print("OT list controller");
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await overtimeService?.submitOvertime(id).then((data) {
      Get.back();

      if (data == 'true') {
        button_submit_show.value = false;
        getOtList();
         Get.defaultDialog(title:'Information',content: Text('Successfully Submitted!'),confirmTextColor: Colors.white,onConfirm: (){
            Get.back();
            Get.back();
        });
        // AppUtils.showConfirmDialog('Information', "Successfully Submitted!",(){
        //   Get.back();
        //   Get.back();
        // });
      } else {
        AppUtils.showDialog('Information', data);
      }

      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  cancelOvertime(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await overtimeService?.cancelOvertime(id).then((data) {
      Get.back();
      if (data == 'true') {
        button_submit_show.value = true;
        getOtList();
        // AppUtils.showConfirmDialog('Information', 'Successfully Deleted!',(){
        //   Get.back();
        //   Get.back();
        // });
        Get.defaultDialog(title:'Information',content: Text('Successfully Deleted!'),confirmTextColor: Colors.white,onConfirm: (){
            Get.back();
            Get.back();
        });
      } else {
        AppUtils.showDialog('Information', data);
      }
      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
