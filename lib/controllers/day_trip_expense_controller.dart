import 'dart:ffi';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/day_trip_expense_line.dart';
import '../models/day_trip_model.dart';
import '../models/daytrip_advance_expense_category.dart';
import '../models/daytrip_expense.dart';
import '../models/daytrip_fuel_consumption.dart';
import '../models/stock_location.dart';
import '../models/travel_expense/travel_expense_product.dart';
import '../services/daytrip_service.dart';
import '../utils/app_utils.dart';

class DayTripExpenseController extends GetxController{
  var formatter = new NumberFormat("###,###", "en_US");
  DayTripServie? dayTripServie;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController expenseCodeController = TextEditingController();
  TextEditingController approvedTravelController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalFuelInAmtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController shopNameTextController = TextEditingController();
  TextEditingController slipNoTextController = TextEditingController();
  TextEditingController quantityTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();
  TextEditingController totalAmountTextController = TextEditingController();
  TextEditingController remarkTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController actualFuelLiterTextController = TextEditingController();
  TextEditingController productQtyController = TextEditingController();

  var expense_category_list = <Daytrip_expense>[].obs;
  TextEditingController expenseDateController = TextEditingController();
  final Rx<File?> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  final RxBool save_btn_show = true.obs;
  var totalAdvanceAmount = 0.0.obs;
  var amount = 0.0.obs;
  final is_show_end_btn = true.obs;
  var daytrip_id = 0;
  DayTripModel? dayTripModel;
  var expense_list = <DayTrip_Expense_ids>[].obs;
  var fuel_list = <FuelIn_ids>[].obs;
  var product_ids_list = <Product_ids>[].obs;
  var advance_ids_list = <Advance_ids>[].obs;
  var consumption_ids_list = <Consumption_ids>[].obs;
  Rx<Daytrip_expense> _selectedExpenseType = Daytrip_expense().obs;
  Daytrip_expense get selectedExpenseType => _selectedExpenseType.value;
  set selectedExpenseType(Daytrip_expense type) =>
      _selectedExpenseType.value = type;

  Rx<TravelExpenseProduct> _selectedExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedExpenseProduct =>
      _selectedExpenseProduct.value;
  set selectedExpenseProduct(TravelExpenseProduct type) =>
      _selectedExpenseProduct.value = type;

  var totalAmountForExpense =0.0.obs;
  TextEditingController totalAmountController =  TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  final box = GetStorage();
  String image_base64 = "";
  var expense_status =''.obs;
  Rx<Stock_location> _selectedLocation = Stock_location().obs;
  Stock_location get selectedLocation => _selectedLocation.value;
  set selectedLocation(Stock_location type) =>
      _selectedLocation.value = type;
  var location_list = <Stock_location>[].obs;

  Rx<Daytrip_expense> _selectedProduct = Daytrip_expense().obs;
  Daytrip_expense get selectedProduct => _selectedProduct.value;
  set selectedProduct(Daytrip_expense type) =>
      _selectedProduct.value = type;
  var product_list = <Daytrip_expense>[].obs;

  //Expense Category Dropdown for Advance
  Rx<Daytrip_advance_expense_category> _selectedExpenseCategory = Daytrip_advance_expense_category().obs;
  Daytrip_advance_expense_category get selectedExpenseCategory => _selectedExpenseCategory.value;
  set selectedExpenseCategory(Daytrip_advance_expense_category type) =>
      _selectedExpenseCategory.value = type;
  var exp_category_list = <Daytrip_advance_expense_category>[].obs;
  var expenseStandardAmount = 0.0.obs;
  var expenseActualAmount = 0.0.obs;
  var expenseOverAmount = 0.0.obs;

  @override
  void onReady() async {
    super.onReady();
    this.dayTripServie = await DayTripServie().init();
     getExpenseType();
    // getAddFuelLocation();
    // getProductForFuelTab();
    // getAdvanceExpenseCategoryList();
  }

  @override
  void onInit() {
    super.onInit();
    dateTextController = TextEditingController();
    expenseDateController = TextEditingController();
    expenseCodeController = TextEditingController();
    approvedTravelController = TextEditingController();
    qtyController = TextEditingController(text: "1");
    priceController = TextEditingController();
    totalFuelInAmtController = TextEditingController();
    descriptionController = TextEditingController();
    totalAmountController = TextEditingController();
    shopNameTextController = TextEditingController();
    slipNoTextController = TextEditingController();
    quantityTextController = TextEditingController();
    amountTextController = TextEditingController();
    totalAmountTextController = TextEditingController();
    remarkTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    actualFuelLiterTextController = TextEditingController();
    productQtyController = TextEditingController();
  }
  void calculateTotalExpense(List<DayTrip_Expense_ids> expenseIds) {
    var standardAmount = 0.0;
    expenseIds.forEach((element) {
      standardAmount +=element.amount;
    });
    expenseStandardAmount.value = standardAmount;

  }
  void onChangeExpenseCategoryDropdown(
      Daytrip_expense daytrip_expense) async {
    this.selectedExpenseType = daytrip_expense;
    int id = selectedExpenseType.id;
    update();
  }
  void onChangeLocationDropdown(
      Stock_location location) async {
    this.selectedLocation = location;
    int id = selectedLocation.id;
    update();
  }
  void onChangeProductDropdown(
      Daytrip_expense product) async {
    this.selectedProduct = product;
    int id = selectedProduct.id;
    update();
  }
  void onChangeExpenseProductDropdown(
      TravelExpenseProduct travelExpenseProduct) async {
    this.selectedExpenseProduct = travelExpenseProduct;
    update();
  }
  void onChangeExpenseCategoryForAdvanceDropdown(
      Daytrip_advance_expense_category category) async {
    this.selectedExpenseCategory = category;
    int id = selectedExpenseCategory.id;
    update();
  }


  getExpenseType() async {
    var company_id = box.read('emp_company');
    await dayTripServie?.getDayTripExpenseList(company_id).then((data){
      data.insert(
          0, Daytrip_expense(id: 0, name: 'Expense Type'));
      this.selectedExpenseType = data[0];
      expense_category_list.value = data;
    });
  }

  getAddFuelLocation() async {
    await dayTripServie?.getStockLocationList().then((data){
      data.insert(
          0, Stock_location(id: 0, name: 'Location'));
      this.selectedLocation = data[0];
      location_list.value = data;
    });
  }
  fetchExpenseStatusData(int tripID) async {
    print('fetchExpenseStatusData');
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(
    //         Center(
    //             child: SpinKitWave(
    //               color: Color.fromRGBO(63, 51, 128, 1),
    //               size: 30.0,
    //             )),
    //         barrierDismissible: false));
    this.dayTripServie = await DayTripServie().init();
    await dayTripServie?.fetchExpenseStatusDayTipPlantrip(tripID,'daytrip').then((data){
      print("BackClose#");
      expense_status.value = data;
      //Get.back;
      // Get.back;
      // Get.back;
    });
  }

  getProductForFuelTab() async {
    var company_id = box.read('emp_company');
    await dayTripServie?.getDayTripProductListForFuelTab(company_id).then((data){
      data.insert(
          0, Daytrip_expense(id: 0, name: 'Product'));
      this.selectedProduct = data[0];
      product_list.value = data;
    });
  }

  void calculateAmount() {
    var qty = qtyController.text ?? "1";
    if(priceController.text.isEmpty)
      priceController.text = '0';
    var unit_price = priceController.text ?? "0";
    amount.value = double.tryParse(qty)! * double.tryParse(unit_price)!;
    // totalAmountController.text = formatter.format(amoun.value);
    totalFuelInAmtController.text = NumberFormat('###.##').format(amount.value);
    update();
  }
  void calculateAdvanceAmount() {
    var qty = quantityTextController.text ?? "1";
    if(amountTextController.text.isEmpty)
      amountTextController.text = '0';
    var unit_price = amountTextController.text ?? "0";
    amount.value = double.tryParse(qty)! * double.tryParse(unit_price)!;
    // totalAmountController.text = formatter.format(amoun.value);
    totalAmountController.text = NumberFormat('###.##',"en_US").format(amount.value);
    update();
  }

  @override
  void onClose() {
    // fromDateTextController?.dispose();
    // toDateTextController?.dispose();
    // purposeTextController?.dispose();
    // durationController?.dispose();
    // descriptionController?.dispose();
    isShowImage.value = false;
    super.onClose();
  }

  nullPhoto() {
    isShowImage.value = false;
    selectedImage.value = null;
  }

  void setCameraImage(File image, String image64) {
    image_base64 = image64;
    isShowImage.value = true;
  }

  addExpense() async {
    var employee_id = box.read('emp_id');
    if(this.selectedExpenseType.id==0 || totalAmountController.text.isEmpty){
      Get.snackbar('Warning', "Fill Required Data!", snackPosition: SnackPosition.BOTTOM);
    }else if(image_base64.isEmpty){
      Get.snackbar('Warning', "Image is required!", snackPosition: SnackPosition.BOTTOM);
    }
    else{
      AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
        var expense  = Expense(image:image_base64,productId: this.selectedExpenseType.id,name: descriptionController.text,amount:double.tryParse(totalAmountController.text)!,day_trip_id: daytrip_id);
        Future.delayed(
            Duration.zero,
                () => Get.dialog(
                Center(
                    child: SpinKitWave(
                      color: Color.fromRGBO(63, 51, 128, 1),
                      size: 30.0,
                    )),
                barrierDismissible: false));
        await dayTripServie?.addExpense(expense,daytrip_id.toString(),int.tryParse(employee_id)!).then((data) {
          image_base64 = "";
          // if (data != 0) {
          expense_list.add(DayTrip_Expense_ids(productId: DayTrip_Product_id(id:this.selectedExpenseType.id,name: this.selectedExpenseType.name),name: descriptionController.text,amount: double.tryParse(totalAmountController.text)!));

          Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
            Get.back();
            Get.back();
            Get.back();
            Get.back(result: true);
          });
          //}
        });
      },() async{

      });

    }

  }
  addFuelConsumption(DayTripModel dayTripModel,int lineId) async {
    if(actualFuelLiterTextController.text.isEmpty){
      Get.snackbar('Warning', "Fill Required Data!", snackPosition: SnackPosition.BOTTOM);
    }else{
      AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
        var employee_id = box.read('emp_id');
        var data  = Daytrip_fuel_consumption(dayTripId: daytrip_id,consumedLiter: double.parse(actualFuelLiterTextController.text),description:descriptionTextController.text,date: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),employeeId: int.parse(employee_id),lineId: lineId);
        await dayTripServie?.addDayTripFuelConsumption(data).then((data) {
          if (data != 0) {
            Get.back();
            Get.defaultDialog(title:'Information',content: Text('Successfully Added!'),confirmTextColor: Colors.white,onConfirm: () async{
          
              Get.back();
              /*  Get.back();*/
              Get.back(result: true);
            });

            // AppUtils.showConfirmDialog('Information', 'Successfully Added!',(){

            //   Get.back();
            //   /*  Get.back();*/
            //   Get.back(result: true);
            // });
          }
        });
      },() async{
      });

    }

  }
  endTrip(BuildContext context) async {
    showAlertDialog(context, "Warning!", "Are you sure to end trip?");
    // await dayTripServie.endDayTrip(daytrip_id.toString()).then((data) {
    //   if (data != 0) {
    //     AppUtils.showConfirmDialog('Information', 'Successfully Ended!',(){
    //       Get.back();
    //       Get.back();
    //       Get.back(result: true);
    //     });
    //   }
    // });
  }
  showAlertDialog(BuildContext context, String title, String name) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
        dayTripServie?.endDayTrip(daytrip_id.toString()).then((data) {
          if (data != 0) {
            Get.defaultDialog(title:'Information',content: Text('Successfully Ended!'),confirmTextColor: Colors.white,onConfirm: () async{
              Get.back();
              Get.back();
              Get.back(result: true);
            });

            // AppUtils.showConfirmDialog('Information', 'Successfully Ended!',(){
            //   Get.back();
            //   Get.back();
            //   Get.back(result: true);
            // });
          }
        });
      },
    );
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        "$title",
        style: TextStyle(color: Colors.red),
      ),
      content: Text("$name"),
      actions: [
        okButton,
        cancelButton
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void updateQty(int pID) async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.updateQty(pID,productQtyController.text.toString()).then((data) {
      if (data != 0) {
        Get.back();
        Get.defaultDialog(title:'Information',content: Text('Successfully Updated!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          //Get.back();
          Get.back(result: true);
        });

        // AppUtils.showConfirmDialog('Information', 'Successfully Updated!',(){
        //   Get.back();
        //   //Get.back();
        //   Get.back(result: true);

        // });
      }
    });
  }

  void approveDayTrip() async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.approveDayTip(daytrip_id).then((data) {
      Get.back();
      if (data != 0) {
        // AppUtils.showConfirmDialog('Information', 'Successfully Approved!',(){
        //   Get.back();
        //   Get.back(result: true);
        // });

        Get.defaultDialog(title:'Information',content: Text('Successfully Approved!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          //Get.back();
          Get.back(result: true);
        });
      }
    });
  }
  void declineDayTrip() async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await dayTripServie?.declineDayTip(daytrip_id).then((data) {
      Get.back();
      if (data != 0) {
        // AppUtils.showConfirmDialog('Information', 'Successfully Declined!',(){
        //   Get.back();
        //   Get.back(result: true);
        // });
        Get.defaultDialog(title:'Information',content: Text('Successfully Declined!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          //Get.back();
          Get.back(result: true);
        });
      }
    });
  }

  void clickstartDayTrip(int id) async{
    Future.delayed(
      Duration.zero,
          () => Get.dialog(
          Center(
              child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
          barrierDismissible: false));
  var employee_id = box.read('emp_id');
  await dayTripServie?.startDayTrip(id.toString())
        .then((data) {
      if (data != 0) {
        // AppUtils.showConfirmDialog('Information', 'Successfully Started!', () {
        //   Get.back();
        //   Get.back();
        //   Get.back(result: true);
        // });
        Get.defaultDialog(title:'Information',content: Text('Successfully Started!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          Get.back();
          Get.back(result: true);
        });
      }
    });
  }
  void clickendDayTrip(int id) async{
    Future.delayed(
      Duration.zero,
          () => Get.dialog(
          Center(
              child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
          barrierDismissible: false));
  var employee_id = box.read('emp_id');
  await dayTripServie?.endDayTrip(id.toString())
        .then((data) {
      if (data != 0) {
        Get.defaultDialog(title:'Information',content: Text('Successfully Ended!'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          Get.back();
          Get.back(result: true);
        });

        // AppUtils.showConfirmDialog('Information', 'Successfully Ended!', () {
        //   Get.back();
        //   Get.back();
        //   Get.back(result: true);
        // });
      }
    });
  }
  // getDayTripList(String pageType) async{
  //   this.dayTripServie = await DayTripServie().init();
  //   Future.delayed(
  //       Duration.zero,
  //           () => Get.dialog(
  //           Center(
  //               child: SpinKitWave(
  //                 color: Color.fromRGBO(63, 51, 128, 1),
  //                 size: 30.0,
  //               )),
  //           barrierDismissible: false));
  //   var employee_id = int.tryParse(box.read('emp_id'));
  //   dayTripServie.getDayTripList(employee_id,offset.toString(),pageType).then((data){
  //     if(offset!=0){
  //       // update data and loading status
  //       isLoading.value = false;
  //       dayTripList.addAll  (data);
  //     }else{
  //       dayTripList.value = data;
  //     }
  //
  //     print("daytripList##");
  //     Get.back();
  //   });
  // }

}