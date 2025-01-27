
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/leave_list_response.dart';
import '../models/travel_expense/out_of_pocket_model.dart';
import '../models/travel_expense/out_of_pocket_response.dart';
import '../models/travel_expense/travel_expense_list.dart';
import '../models/travel_request_list_response.dart';
import '../routes/app_pages.dart';
import '../services/travel_request_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TravelListController extends GetxController {
  static TravelListController to = Get.find();
  TravelRequestService? _travelRequestService;
  var travelLineList = <TravelRequestListResponse>[].obs;
  var travelExpenseList = <TravelExpenseListModel>[].obs;
  var outofpocketExpenseList = <OutofPocketResponse>[].obs;
  final box = GetStorage();
  var button_submit_show = false.obs;
  var button_approve_show = false.obs;
  var button_advance_show = false.obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  //UserProfileController({@required this.employeeService}) : assert(employeeService != null);
  @override
  void onReady() async {
    //run every time auth state changes
    this._travelRequestService = await TravelRequestService().init();
    //getTravelList();
    //getExpenseProductForEmp();
    super.onReady();
    // getExpenseOutOfPocketForEmp();
  }

  // getExpenseProductForEmp() async {
  //   Future.delayed(
  //       Duration.zero,
  //       () => Get.dialog(
  //           Center(
  //               child: SpinKitWave(
  //             color: Color.fromRGBO(63, 51, 128, 1),
  //             size: 30.0,
  //           )),
  //           barrierDismissible: false));
  //   //fetch emp_id from GetX Storage
  //   var employee_id = box.read('emp_id');
  //   await _travelRequestService.getExpenseListModel(employee_id).then((data) {
  //     print("leavelistFinish");
  //     // data.sort((a, b) =>
  //     //     a.create_date.toString().compareTo(b.create_date.toString()));
  //     travelExpenseList.value = data;
  //     update();
  //     Get.back();
  //   });
  // }

  // getExpenseOutOfPocketForEmp() async {
  //   Future.delayed(
  //       Duration.zero,
  //       () => Get.dialog(
  //           Center(
  //               child: SpinKitWave(
  //             color: Color.fromRGBO(63, 51, 128, 1),
  //             size: 30.0,
  //           )),
  //           barrierDismissible: false));
  //   //fetch emp_id from GetX Storage
  //   var employee_id = box.read('emp_id');
  //   await _travelRequestService.getOutofPocketModel(employee_id).then((data) {
  //     outofpocketExpenseList.value = data;
  //     update();
  //     Get.back();
  //   });
  // }

  @override
  void onInit() {
    super.onInit();
  }

  deleteTravel(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await _travelRequestService?.deleteTravel(id).then((data) {
      button_approve_show.value = false;
      //getTravelList();
      Get.back();
      Get.back();
      Get.back(result: true);

    });
  }

  approveTravel(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await _travelRequestService?.approveTravel(id).then((data) {
      Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR,arguments: "travel");
      getTravelList();
      // AppUtils.showDialog('Result Box', 'Successfully Click Cancel');
    });
  }

    requestAdvance(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await _travelRequestService?.requestAdvanceTravel(id).then((data) {
      if(data){
        Get.back();
        Get.back(result: true);
      }
      // AppUtils.showDialog('Result Box', 'Successfully Click Cancel');
    });
  }

  submitTravel(int id) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await _travelRequestService?.submitTravel(id).then((data) {
      if(data.runtimeType == bool) {
       if(data)
         {
           Get.back();
           Get.back(result: true);
         }
       else{
         Get.back();
       }
      }
      else{
        Get.back();
        Get.defaultDialog(title:'Result Box',middleText: '${data['message']}',confirmTextColor: Colors.white,onConfirm: (){
          Get.back();
          Get.back(result: true);
        });
      }


      // AppUtils.showDialog('Result Box', 'Successfully Click Cancel');
    });
  }
  
  //total amount
  double getTotalAmount(int index){
    double totalAmount = 0.0;
    // travelLineList.value[index].request_allowance_lines.forEach((element) {
    //   totalAmount += element.total_amount;
    // });
    for(var i=0;i<travelLineList.value[index].request_allowance_lines!.length;i++){
      totalAmount += travelLineList.value[index].request_allowance_lines![i].total_amount;
    }
    return totalAmount;
  }

  declinedTravel(int id) async {
    await _travelRequestService?.cancelTravel(id).then((data) {

      Get.defaultDialog(title:'Result Box',content: Text('Successfully Click Cancel'),confirmTextColor: Colors.white,onConfirm: (){
        Get.back();
        Get.back(result: true);
      });
    });
  }

 Future<void> getTravelList() async {
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
   if(_travelRequestService !=null)
    await _travelRequestService?.getTravelRequestListForEmp(employee_id,offset.toString())
        .then((data) {
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   travelLineList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          travelLineList.add(data[i]);
        }
       // travelLineList.addAll(data);
      }else{
        travelLineList.value = data;
      }
      update();
      Get.back();
    });
    else{
      this._travelRequestService = await TravelRequestService().init();
      await _travelRequestService?.getTravelRequestListForEmp(employee_id,offset.toString())
          .then((data) {
        if(offset!=0){
          isLoading.value = false;
          // data.forEach((element) {
          //   travelLineList.add(element);
          // });
          for(var i=0;i<data.length;i++){
            travelLineList.add(data[i]);
          }
          //travelLineList.addAll(data);
        }else{
          travelLineList.value = data;
        }
        update();
        Get.back();
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
