

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/travel_list_controller.dart';
import '../models/travel_expense.dart';
import '../models/travel_expense_category.dart';
import '../models/travel_line.dart';
import '../models/travel_request.dart';
import '../models/travel_type.dart';
import '../routes/app_pages.dart';
import '../services/master_service.dart';
import '../services/travel_request_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TravelRequestController extends GetxController {
  TravelRequestService? _travelRequestService;
  MasterService? masterService;
  TextEditingController fromDateTextController = TextEditingController();
  TextEditingController toDateTextController = TextEditingController();
  TextEditingController traveldateController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  TextEditingController purposeTextController = TextEditingController();
  TextEditingController fromPlaceTextController = TextEditingController();
  TextEditingController toPlaceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  var traveltype_list = <TravelType>[].obs;
  final TravelListController travelListController = Get.find();
  Rx<TravelType> _selectedTravelType = TravelType().obs;
  TravelType get selectedTravelType => _selectedTravelType.value;
  set selectedTravelType(TravelType type) => _selectedTravelType.value = type;
  var totalAmount = 0.0.obs;
  var travelLineList = <TravelLine>[].obs;

  final RxString duration = "".obs;
  final is_add_travel = false.obs;
  final is_show_auto_generate = false.obs;
  final is_show_expense = true.obs;
  final box = GetStorage();
  final RxBool save_btn_show = true.obs;
  final RxBool submit_btn_show = false.obs;
  var amount = 0;
  Rx<TravelExpenseCategory> _selectedExpenseType = TravelExpenseCategory().obs;
  TravelExpenseCategory get selectedExpenseType => _selectedExpenseType.value;
  set selectedExpenseType(TravelExpenseCategory type) =>
      _selectedExpenseType.value = type;

  List<TravelExpense> expenseList = <TravelExpense>[].obs;
  var expenseCategoryList = <TravelExpenseCategory>[].obs;
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkTextController = TextEditingController();
  @override
  void onInit() {
    fromDateTextController = TextEditingController();
    toDateTextController = TextEditingController();
    fromPlaceTextController = TextEditingController();
    toPlaceController = TextEditingController();
    destinationTextController = TextEditingController();
    purposeTextController = TextEditingController();
    traveldateController = TextEditingController();
    durationController = TextEditingController();
    destinationController = TextEditingController();

    quantityTextController = TextEditingController(text: '1');
    unitPriceController = TextEditingController();
    amountController = TextEditingController();
    remarkTextController = TextEditingController();
    super.onInit();
  }
  clearTravelRequest(){
fromDateTextController.clear();
toDateTextController.clear();
fromPlaceTextController.clear();
toPlaceController.clear();
destinationController.clear();
purposeTextController.clear();
traveldateController.clear();
durationController.clear();
destinationTextController.clear();
quantityTextController.text = '1';
unitPriceController.clear();
amountController.clear();
remarkTextController.clear();
save_btn_show.value = true;
expenseList.clear();
clearTravelLine();
  }
  @override
  void onReady() async {
    this._travelRequestService = await TravelRequestService().init();
    this.masterService = await MasterService().init();
    getExpenseCategory();
    // getTravelType();
  }

  void onChangeExpenseDropdown(TravelExpenseCategory expense) async {
    this.selectedExpenseType = expense;
    update();
  }

  void onChangeTravelTypeDropdown(TravelType travelType) async {
    this.selectedTravelType = travelType;
    update();
  }

  getExpenseCategory() async {
    var company_id = box.read('emp_company');
    await _travelRequestService?.getExpenseCategory(int.tryParse(company_id)!).then((data) {
      this.selectedExpenseType = data[0];
      expenseCategoryList.value = data;
    });
  }

  getTotalAmount(){
    totalAmount.value= 0.0;
   expenseList.forEach((element) {
     totalAmount.value += element.total_amount;
   });
  }
  // updateTravelType(TravelType value) {
  //   // leaveTypeObj.update((val) {
  //   //   val.id = value.id;
  //   //   val.name =value.name;
  //   // });
  // }

  // getTravelType() async {
  //   await masterService.getTravelType().then((data) {
  //     this.selectedTravelType = data[0];
  //     traveltype_list.value = data;
  //   });
  // }

  addTravelLine(TravelLine travelLine) {
    travelLineList.add(travelLine);
  }

  addExpenseLine() {
    var expense = TravelExpense(
        expense_name: selectedExpenseType.display_name,
        expense_categ_id: selectedExpenseType.id,
        total_amount: double.tryParse(amount.toString())!,
        quantity: int.tryParse(quantityTextController.text)!,
        amount: int.tryParse(unitPriceController.text)!,
        remark: remarkTextController.text);
    expenseList.add(expense);
    getTotalAmount();
  }

  deleteExpenseLine(TravelExpense expense){
    expenseList.remove(expense);
    getTotalAmount();
  }
  updateLineData() {
    //MyController.value = TextEditingValue(text: "ANY TEXT");
  }
  clearTravelLine() {
    travelLineList.clear();
  }

  requestTravelRequest(String duration) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    var from_date = fromDateTextController.text;
    var to_date = toDateTextController.text;
    // var duration = int.tryParse(durationController.text);
    double durationValue=double.parse(duration.toString());
    var from_des = fromPlaceTextController.text;
    var to_des = toPlaceController.text;
    if (from_date.isNotEmpty &&
        to_date.isNotEmpty &&
        !durationValue.isNull &&
        from_des.isNotEmpty &&
        to_des.isNotEmpty &&
        travelLineList.length != 0) {
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      TravelRequest travelRequest = TravelRequest(
          employee_id: employee_id!,
          start_date: from_date,
          end_date: to_date,
          city_from: from_des,
          city_to: to_des,
          duration: durationValue,
          travel_line: travelLineList,
          request_allowance_lines: expenseList);

      await _travelRequestService?.travelRequest(travelRequest,0).then((value) {
        if (value != 0) {
          Get.back();
          save_btn_show.value = false;
          //submit_btn_show.value = true;
          Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
            clearTravelRequest();
            Get.back();
          //  Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR,arguments: 'travel');
            travelListController.offset.value = 0;
            travelListController.getTravelList();
            Get.back(result: true);
          });
        }
      });
    } else {
      AppUtils.showDialog('Warning!', "Fill Required Data!");
    }
  }

  updateTravelRequest(String duration,int id) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    var from_date = fromDateTextController.text;
    var to_date = toDateTextController.text;
    // var duration = int.tryParse(durationController.text);
    double durationValue=double.parse(duration.toString());
    var from_des = fromPlaceTextController.text;
    var to_des = toPlaceController.text;
    if (from_date.isNotEmpty &&
        to_date.isNotEmpty &&
        !durationValue.isNull &&
        from_des.isNotEmpty &&
        to_des.isNotEmpty &&
        travelLineList.length != 0) {
      Future.delayed(
          Duration.zero,
              () => Get.dialog(
              Center(
                  child: SpinKitWave(
                    color: Color.fromRGBO(63, 51, 128, 1),
                    size: 30.0,
                  )),
              barrierDismissible: false));
      TravelRequest travelRequest = TravelRequest(
          employee_id: employee_id!,
          start_date: from_date,
          end_date: to_date,
          city_from: from_des,
          city_to: to_des,
          duration: durationValue,
          travel_line: travelLineList,
          request_allowance_lines: expenseList);
      await _travelRequestService?.travelRequestUpdate(travelRequest,id).then((value) {
        //Get.back();
        if (value != 0) {
          save_btn_show.value = false;
          //submit_btn_show.value = true;
          travelListController.getTravelList();
          // Get.back();
          Get.defaultDialog(title:'Information',content: Text('Successfully Updated!'),confirmTextColor: Colors.white,onConfirm: (){
            clearTravelRequest();
            Get.back();
            Get.back(result: true);
          });
        } 
        // else {
        //   AppUtils.showDialog('Information', 'Saving Failed!');
        // }
      });
    } else {
      AppUtils.showDialog('Warning!', "Fill Required Data!");
    }
  }

  @override
  void onClose() {
    // fromDateTextController?.dispose();
    // toDateTextController?.dispose();
    // destinationTextController?.dispose();
    // purposeTextController?.dispose();
    // traveldateController?.dispose();
    // fromPlaceTextController?.dispose();
    // toPlaceController?.dispose();
    // durationController?.dispose();
    duration.value = "";
    clearTravelLine();
    is_show_auto_generate.value = false;
    is_add_travel.value = false;
    super.onClose();
  }

  void calculateinterval(DateTime selectedFromDate, DateTime selectedToDate) {
    final fromdatetime = DateTime(
        selectedFromDate.year, selectedFromDate.month, selectedFromDate.day);
    final todatetime =
        DateTime(selectedToDate.year, selectedToDate.month, selectedToDate.day);
    final difference = todatetime.difference(fromdatetime).inDays + 1;
    // durationController.value = TextEditingValue(text: difference.toString());
  }

  void updateTravelineDestination() {
    //is_show_auto_generate.value = true;
   /* travelLineList.update((val) {
      val.forEach((element) {
        element.destination =
            fromPlaceTextController.text + "-" + toPlaceController.text;
        print(element);
      });
    });*/

    dynamic travelLineListUpdate = <TravelLine>[];

    travelLineList.forEach((val){
      val.destination =
          fromPlaceTextController.text + "-" + toPlaceController.text;
      travelLineListUpdate.add(val);

    });

    travelLineList.value = travelLineListUpdate;

  }

  void updateAddTravelLineButtonState() {
    is_add_travel.value = true;
  }

  void updateTravelLineDestination(int index, String dest) {
    travelLineList.value[index].destination = dest;
  }

  void updateTravelLinePurpose(int index, String purpose) {
    travelLineList.value[index].purpose = purpose;
  }

  fetchTravelLine(DateTime formdate, DateTime endDate) async {
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
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedFromDate = formatter.format(formdate);
    String formattedToDate = formatter.format(endDate);
    TravelRequest travel = TravelRequest(
      employee_id: employee_id!,
      start_date: formattedFromDate,
      end_date: formattedToDate,
    );

    await _travelRequestService?.getTravelLine(travel).then((value) {
      travelLineList.value = value;
      var num = 0;
      double days = 0;

      for (var i = num; i < travelLineList.length; i++) {
        if (travelLineList[i].full == true) {
          days++;
        }
        if (travelLineList[i].first == true) {
          days = days + 0.5;
        }
        if (travelLineList[i].second == true) {
          days = days + 0.5;
        }
      }
      durationController.text = days.toString();
      // durationController.value = TextEditingValue(text: days.toString());

      Get.back();
    });
  }

  void updateTravelInterval(int index, int value) async {

    if (value == 1) {
      if (travelLineList.value[index].allow_full_edit) {
        travelLineList.value[index].full = true;
        travelLineList.value[index].first = false;
        travelLineList.value[index].second = false;
      } else {
        AppUtils.showDialog('Warning!', "Invalid");
      }
    } else if (value == 2) {
      if (travelLineList.value[index].allow_first_edit) {
        travelLineList.value[index].full = false;
        travelLineList.value[index].first = true;
        travelLineList.value[index].second = false;
      } else {
        AppUtils.showDialog('Warning!', "Invalid");
      }
    } else {
      if (travelLineList.value[index].allow_second_edit) {
        travelLineList.value[index].full = false;
        travelLineList.value[index].first = false;
        travelLineList.value[index].second = true;
      } else {
        AppUtils.showDialog('Warning!', "Invalid");
      }
    }
    travelLineList.refresh();

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
    travelLineList.value[index].employee_id = employee_id!;
    await _travelRequestService?.updateTravelLine(travelLineList.value[index])
        .then((value) {
      travelLineList.removeAt(index);
      travelLineList.insert(index, value as TravelLine);
      var num = 0;
      double days = 0;

      for (var i = num; i < travelLineList.length; i++) {
        if (travelLineList[i].full == true) {
          days++;
        }
        if (travelLineList[i].first == true) {
          days = days + 0.5;
        }
        if (travelLineList[i].second == true) {
          days = days + 0.5;
        }
        var employee_id = int.tryParse(box.read('emp_id'));
          if(i==index){
            travelLineList[i].update_status = true;
          }else{
            travelLineList[i].update_status = false;
          }
      }
      durationController.text = days.toString();
      Get.back();
    });
  }


  bool checkIsNotEmptyPurpose(){
    List<TravelLine> travelline = travelLineList.value;
    if(travelline.where((element) => element.purpose.isEmpty).toList().length>0)
      return false;

    return true;
  }
  bool checkIsNotEmptyDestination(){
    List<TravelLine> travelline = travelLineList.value;
    if(travelline.where((element) => element.destination.isEmpty).toList().length>0)
      return false;

    return true;
  }

  void calculateAmount() {
    var qty = quantityTextController.text;
    var unit_price = unitPriceController.text;
    amount = int.tryParse(qty)! * int.tryParse(unit_price)!;
    amountController.text = NumberFormat.currency(name:'',decimalDigits: 0).format(amount);
   // amountController.text = amount.toString();
  }
}
