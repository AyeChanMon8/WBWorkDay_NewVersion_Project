import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/leave_list_response.dart';
import '../routes/app_pages.dart';
import '../services/leave_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LeaveListController extends GetxController {
  static LeaveListController to = Get.find();
  LeaveService? leaveService;
  var leaveList = <LeaveListResponse>[].obs;
  var leaveAcceptedList = <LeaveListResponse>[].obs;
  var leaveDeclinedList = <LeaveListResponse>[].obs;
  final box = GetStorage();
  var button_submit_show = false.obs;
  var button_approve_show = false.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var change_datetime_show = false.obs;
  @override
  void onReady()async{
    this.leaveService = await LeaveService().init();
    _getLeaveList();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void>_getLeaveList() async {
    // var role_category = box.read('role_category');
    // if (role_category == 'employee') {
    //   _getLeaveListForEmp();
    // } else {
    //   _getLeaveListForManager();
    // }
    _getLeaveListForEmp();
  }

 Future<void> _getLeaveListForEmp() async {
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
    await leaveService?.getLeaveList(employee_id,offset.toString()).then((data) {
      // data.sort((a, b) =>
      //     a.create_date.toString().compareTo(b.create_date.toString()));
      if(offset!=0){
        // update data and loading status
        isLoading.value = false;
        // data.forEach((element) {
        //   leaveList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          leaveList.add(data[i]);
        }
      }else{
        leaveList.value = data;
      }
      update();
      Get.back();
    });
  }
  _getLeaveListForManager() async {
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
    await leaveService?.getLeaveListForManager(int.tryParse(employee_id)!)
        .then((data) {
          leaveList.value = data;
          update();
          Get.back();
    });
  }

  approveLeave(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await leaveService?.approveLeave(id).then((data) {
      if(data){
        Get.back();
        button_approve_show.value = false;
        offset.value = 0;
        _getLeaveList();
        // AppUtils.showDialog('Information', 'Successfully Click Approve');
        Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
      }
    });
  }

  submitLeave(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await leaveService?.submitLeave(id).then((data) {
      Get.back();
      button_submit_show.value = false;
      if (data != '') {
        Get.defaultDialog(title:'Information',content: Text(data),confirmTextColor: Colors.white,onConfirm: (){
           Get.back();
           Get.back(result: true);
          });
        // AppUtils.showDialog('Information', 'Fail!');
      } else {
        // AppUtils.showConfirmDialog('Information', data,(){
        //   Get.back();
        //   Get.back(result: true);
        // });

        Get.defaultDialog(title:'Information',content: Text('Success!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          Get.back(result: true);
        });
      }

      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  editLeave(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
  }

  deleteLeave(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await leaveService?.deleteLeave(id).then((data) {
      if(data){
      Get.back();
      Get.back(result: true);
      }
    });
  }

  declinedLeave(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await leaveService?.cancelLeave(id).then((data) {
      if(data){
        Get.back();
        button_approve_show.value = false;
        offset.value = 0;
        _getLeaveList();
      }
      
      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }

  Future<void> getLeaveList() async {
    _getLeaveList();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
