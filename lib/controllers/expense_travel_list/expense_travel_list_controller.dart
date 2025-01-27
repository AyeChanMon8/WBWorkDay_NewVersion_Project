import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/expense_attachment.dart';
import '../../models/travel_expense/list/travel_line_list_model.dart';
import '../../models/travel_expense/list/travel_list_model.dart';
import '../../services/travel_request_service.dart';
import '../../utils/app_utils.dart';

class ExpensetravelListController extends GetxController {
  final box = GetStorage();
  var button_submit_show = false.obs;
  var button_approve_show = false.obs;
  TravelRequestService? travelRequestService;
  var travelExpenseList = <TravelExpenseList>[].obs;
  var isLoading = false.obs;
  var offset = 0.obs;
  var attachment_list = <Expense_attachment>[].obs;
  var show_attachment = false.obs;
  var showDetails = true.obs;
  @override
  void onReady() async {
    super.onReady();
    this.travelRequestService = await TravelRequestService().init();
  //  getExpenseListForEmp();
  }

  @override
  void onInit() {
    super.onInit();
  }

  submitTravelExpense(int id, BuildContext context, List<TravelLineListModel> tLine, int employee_id, String code) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService?.submitTravelExpense(id, tLine, employee_id, code).then((data) {
      Get.back();
      button_submit_show.value = data;
      Get.defaultDialog(title:'Information',content: Text('Submitted!'),confirmTextColor: Colors.white,onConfirm: () async{
          offset.value=0;
        getExpenseListForEmp();
        Get.back();
        Get.back();
        });

      // AppUtils.showConfirmDialog('Information', "Submitted!",(){
      //   offset.value=0;
      //   getExpenseListForEmp();
      //   Get.back();
      //   Get.back();
      // });
    });
  }

  deleteTravelExpense(int id, BuildContext context) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await travelRequestService?.deleteTravelExpense(id).then((data) {
      Get.back();
      // Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
      button_approve_show.value = false;
      offset.value=0;
      getExpenseListForEmp();
      Get.back();
      Get.back();
    });
  }

 Future<void> getExpenseListForEmp() async {
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
    if(travelRequestService ==null)
      this.travelRequestService = await TravelRequestService().init();
    await travelRequestService?.getTravelExpenseModel(employee_id,offset.toString()).then((data) {
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   travelExpenseList.add(element);
        // });
        for(var j=0;j< data.length;j++){
          travelExpenseList.add(data[j]);
        }
      }else{
        travelExpenseList.value = data;
      }

      update();
      Get.back();
    });
  }


  double getTotalAmount(int index){
     return travelExpenseList.value[index].total_expense;
  }

  double getTotalAdvanceAmount(int index){
    return travelExpenseList.value[index].advanced_money;
  }

  double getRemainingAmount(int index){
   return getTotalAdvanceAmount(index)-getTotalAmount(index);
  }

  @override
  void onClose() {
    super.onClose();
  }
  Future<List<String>> findExpenseImage(int id) async {

    var attachmentList = <String>[].obs;
    // for(var i=0;i<attachment_list.length; i++){
    //   if(id == attachment_list[i].expenseLineId){
    //     attachmentList.value = attachment_list[i].attachments;
    //     break;
    //   }
    // }
    for (var element in attachment_list) {
      if(id==element.expenseLineId){
        attachmentList.value = element.attachments;
        break;
      }

    }
    return await attachmentList;
  }
  getAttachmentTravel(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await travelRequestService?.getAttachment(id,"travel").then((data) {
      Get.back();
      attachment_list.value = data;
      show_attachment.value =true;
      print("getAttachemnt#");
    });
  }
}
