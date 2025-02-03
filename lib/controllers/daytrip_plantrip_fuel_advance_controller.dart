import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/advance_line.dart';
import '../models/day_trip_model.dart';
import '../models/daytrip_advance_expense_category.dart';
import '../models/daytrip_expense.dart';
import '../models/fuelin_line.dart';
import '../models/plantrip_product_adavance_line.dart';
import '../models/plantrip_waybilll_advance_line.dart';
import '../models/stock_location.dart';
import '../models/travel_expense/travel_expense_product.dart';
import '../services/daytrip_service.dart';
import '../services/plan_trip_service.dart';
import '../utils/app_utils.dart';

class DayTripPlanTripGeneralController extends GetxController {
  var formatter = new NumberFormat("###,###", "en_US");
  DayTripServie? dayTripServie;
  PlanTripServie? planTripServie;
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
  TextEditingController remarkTextController = TextEditingController();

  var expense_category_list = <Daytrip_expense>[].obs;
  TextEditingController expenseDateController = TextEditingController();
  final Rx<File?> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  final RxBool save_btn_show = true.obs;
  var totalAdvanceAmount = 0.0.obs;
  var amount = 0.0.obs;
  final is_show_expense = true.obs;
  var daytrip_id = 0;
  DayTripModel? dayTripModel;
  var selectedProductId = 0;
  var selectedLocationId = 0;
  final RxBool isAdvanceButton = false.obs;

  Rx<Daytrip_expense> _selectedExpenseType = Daytrip_expense().obs;
  Daytrip_expense get selectedExpenseType => _selectedExpenseType.value;
  set selectedExpenseType(Daytrip_expense type) =>
      _selectedExpenseType.value = type;

  Rx<TravelExpenseProduct> _selectedExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedExpenseProduct =>
      _selectedExpenseProduct.value;
  set selectedExpenseProduct(TravelExpenseProduct type) =>
      _selectedExpenseProduct.value = type;

  var totalAmountForExpense = 0.0.obs;
  TextEditingController totalAmountController = TextEditingController();
  final box = GetStorage();
  String image_base64 = "";

  Rx<Stock_location> _selectedLocation = Stock_location().obs;
  Stock_location get selectedLocation => _selectedLocation.value;
  set selectedLocation(Stock_location? type) => _selectedLocation.value = type ?? Stock_location(completeName: '',name: '',id: 0);
  var location_list = <Stock_location>[].obs;

  Rx<Daytrip_expense> _selectedProduct = Daytrip_expense().obs;
  Daytrip_expense get selectedProduct => _selectedProduct.value;
  set selectedProduct(Daytrip_expense? type) =>
      _selectedProduct.value = type ?? Daytrip_expense(id: 0, name: '');
  var product_list = <Daytrip_expense>[].obs;

  //Expense Category Dropdown for Advance
  Rx<Daytrip_advance_expense_category> _selectedExpenseCategory =
      Daytrip_advance_expense_category().obs;
  Daytrip_advance_expense_category get selectedExpenseCategory =>
      _selectedExpenseCategory.value;
  set selectedExpenseCategory(Daytrip_advance_expense_category type) =>
      _selectedExpenseCategory.value = type;
  var exp_category_list = <Daytrip_advance_expense_category>[].obs;

  @override
  void onReady() async {
    super.onReady();
    this.dayTripServie = await DayTripServie().init();
    this.planTripServie = await PlanTripServie().init();
    getExpenseType();
    getAddFuelLocation();
    getProductForFuelTab();
    getAdvanceExpenseCategoryList();
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
    remarkTextController = TextEditingController();
  }

  void onChangeExpenseCategoryDropdown(Daytrip_expense daytrip_expense) async {
    this.selectedExpenseType = daytrip_expense;
    int id = selectedExpenseType.id;
    update();
  }

  void onChangeLocationDropdown(Stock_location location) async {
    this.selectedLocation = location;
    int id = selectedLocation.id;
    update();
  }

  void onChangeProductDropdown(Daytrip_expense product) async {
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
    await dayTripServie?.getDayTripExpenseList(company_id).then((data) {
      data.insert(0, Daytrip_expense(id: 0, name: 'Expense Type'));
      this.selectedExpenseType = data[0];
      expense_category_list.value = data;
    });
  }

  getAdvanceExpenseCategoryList() async {
    this.dayTripServie = await DayTripServie().init();
    var company_id = box.read('emp_company');
    await dayTripServie
        ?.getDayTripAdvanceExpenseCategory(int.tryParse(company_id)!)
        .then((data) {
      data.insert(
          0,
          Daytrip_advance_expense_category(
              id: 0, displayName: 'Expense Category Type'));
      this.selectedExpenseCategory = data[0];
      exp_category_list.value = data;
    });
  }

  getAddFuelLocation() async {
    await dayTripServie?.getStockLocationList().then((data) {
      data.insert(0, Stock_location(id: 0, name: 'Location'));
      //this.selectedLocation = data[0];
      location_list.value = data;
      if (selectedLocationId != 0) {
        for (var i = 0; i < location_list.length; i++) {
          if (selectedLocationId == location_list.value[i].id) {
            this.selectedLocation = location_list.value[i];
            break;
          }
        }
      } else {
        this.selectedLocation = data[0];
      }
    });
  }

  getAddFuelLocationID(int id) async {
    if (id != 0) {
      for (var i = 0; i < location_list.value.length; i++) {
        if (id == location_list.value[i].id) {
          this.selectedLocation = location_list.value[i];
          break;
        }
      }
    } else {
      this.selectedLocation = location_list[0];
    }
  }

  getProductForFuelTabId(int id) async {
    if (id != 0) {
      for (var i = 0; i < product_list.length; i++) {
        if (id == product_list.value[i].id) {
          this.selectedProduct = product_list.value[i];
          break;
        }
      }
    } else {
      this.selectedProduct = product_list.value[0];
    }
  }

  getProductForFuelTab() async {
    var company_id = box.read('emp_company');
    await dayTripServie
        ?.getDayTripProductListForFuelTab(company_id)
        .then((data) {
      data.insert(0, Daytrip_expense(id: 0, name: 'Product'));

      product_list.value = data;
      if (selectedProductId != 0) {
        for (var i = 0; i < product_list.length; i++) {
          if (selectedProductId == product_list.value[i].id) {
            this.selectedProduct = product_list.value[i];
            break;
          }
        }
      } else {
        this.selectedProduct = data[0];
      }
    });
  }

  void calculateAmount() {
    var qty = qtyController.text ?? "1";
    // if(priceController.text.isEmpty)
    //   priceController.text = '0';
    var unit_price = priceController.text ?? "0";
    amount.value = double.tryParse(qty)! * double.tryParse(unit_price)!.round();
    // totalAmountController.text = formatter.format(amoun.value);
    var amt = amount.value.toStringAsFixed(1);
    totalFuelInAmtController.text =
        NumberFormat('###.##').format(double.tryParse(amt)!.round());
    update();
  }

  void calculateAdvanceAmount() {
    var qty = quantityTextController.text ?? "1";
    // if(amountTextController.text.isEmpty)
    //   amountTextController.text = '0';
    var unit_price = amountTextController.text ?? "0";
    amount.value = double.tryParse(qty)! * double.tryParse(unit_price)!;
    var amt = amount.value.toStringAsFixed(1);
    totalAmountController.text =
        NumberFormat('###.##').format(double.tryParse(amt)!.round());
    update();
  }

  void calculatePriceUnit() {
    var qty = qtyController.text;
    // if(totalFuelInAmtController.text.isEmpty)
    //   totalFuelInAmtController.text = '0';
    var unit_price = totalFuelInAmtController.text ?? "0";
    amount.value = double.tryParse(unit_price)! / double.tryParse(qty)!;
    var amt = amount.value.toStringAsFixed(1);
    priceController.text =
        NumberFormat('###.##').format(double.tryParse(amt)!.round());

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
    selectedImage.value = image;
  }

  Future<bool> validateData() async {
    bool valid = false;
    if (dateTextController.text.isEmpty ||
        totalFuelInAmtController.text.isEmpty ||
        priceController.text.isEmpty) {
      valid = false;
      //Get.snackbar('Warning', "Fill Required Data!", snackPosition: SnackPosition.BOTTOM);
    } else if (shopNameTextController.text.isEmpty) {
      if (this.selectedLocation.id != 0) {
        valid = true;
      } else {
        valid = false;
        //Get.snackbar('Warning', "Fill Shop or Location!", snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      valid = true;
    }
    return valid;
  }

  addFuel(String arg, int trip_id, int line_id) async {
    print("addFuel#");
    print(qtyController.text);
    bool valid = false;
    if (dateTextController.text.isEmpty ||
        totalFuelInAmtController.text.isEmpty ||
        priceController.text.isEmpty) {
      valid = false;
      Get.snackbar('Warning', "Fill Required Data!",
          snackPosition: SnackPosition.BOTTOM);
    } else if (priceController.text == '0' ||
        totalFuelInAmtController.text == '0') {
      AppUtils.showToast('Can not add zero value');
      valid = false;
    } else if (shopNameTextController.text.isEmpty) {
      if (this.selectedLocation.id != 0) {
        valid = true;
      } else {
        valid = false;
        Get.snackbar('Warning', "Fill Shop or Location!",
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      valid = true;
    }
    if (valid) {
      AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
        Future.delayed(
            Duration.zero,
            () => Get.dialog(
                Center(
                    child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
                barrierDismissible: false));
        var location_id = null;
        var product_id = null;
        if (this.selectedLocation != null && this.selectedLocation.id != 0) {
          location_id = this.selectedLocation.id;
        }
        if (this.selectedProduct != null && this.selectedProduct.id != 0) {
          product_id = this.selectedProduct.id;
        }
        var fuelin;
        var employee_id = box.read('emp_id');
        if (arg == "DayTrip") {
          fuelin = Fuelin_line(
              date: dateTextController.text,
              shop: shopNameTextController.text,
              productId: product_id ?? 0,
              locationId: location_id ?? 0,
              slipNo: slipNoTextController.text,
              liter: double.tryParse(qtyController.text)!,
              priceUnit: double.tryParse(priceController.text)!,
              parentId: trip_id,
              status: 'day_trip',
              employeeId: int.parse(employee_id),
              lineId: line_id);
        } else if (arg == "PlanTripProduct") {
          fuelin = Fuelin_line(
              date: dateTextController.text,
              shop: shopNameTextController.text,
              productId: product_id ?? 0,
              locationId: location_id ?? 0,
              slipNo: slipNoTextController.text,
              liter: double.tryParse(qtyController.text)!,
              priceUnit: double.tryParse(priceController.text)!,
              parentId: trip_id,
              status: 'plantrip_product',
              employeeId: int.parse(employee_id),
              lineId: line_id);
        } else {
          fuelin = Fuelin_line(
              date: dateTextController.text,
              shop: shopNameTextController.text,
              productId: product_id ?? 0,
              locationId: location_id ?? 0,
              slipNo: slipNoTextController.text,
              liter: double.tryParse(qtyController.text)!,
              priceUnit: double.tryParse(priceController.text)!,
              parentId: trip_id,
              status: 'plantrip_waybill',
              employeeId: int.parse(employee_id),
              lineId: line_id);
        }
        await dayTripServie?.addFuelIn(fuelin).then((data) {
          //Get.back();
          if (data != 0) {
            Get.back();
            Get.defaultDialog(
                title: 'Information',
                content: Text('Successfully Saved!'),
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                  Get.back();
                  Get.back(result: data);
                });
          }
        });
        // if(arg=="DayTrip"){
        //   var location_id = 0;
        //   if(this.selectedLocation!=null){
        //     location_id = this.selectedLocation.id;
        //   }
        //   var fuelin  = Fuelin_line(date:dateTextController.text,shop:shopNameTextController.text,productId: this.selectedProduct.id,locationId: location_id,slipNo:slipNoTextController.text,liter:int.tryParse(qtyController.text),priceUnit:int.tryParse(priceController.text),dayTripId: trip_id,status: 'day_trip');
        //   await dayTripServie.addFuelIn(fuelin,'day_trip').then((data) {
        //     Get.back();
        //     if (data != 0) {
        //       Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
        //         Get.back();
        //         Get.back();
        //         Get.back(result: data);
        //       });
        //     }
        //   });
        // }
        // else if(arg=="PlanTripProduct"){
        //   print('qtytext');
        //   print(qtyController.text);
        //   var location_id = 0;
        //   if(this.selectedLocation!=null){
        //     location_id = this.selectedLocation.id;
        //   }
        //
        //   var plantrip_product_fuelin  = Palntrip_with_product_fuelin_line(tripProductId: trip_id,date:dateTextController.text,shop:shopNameTextController.text,productId: this.selectedProduct.id,locationId: location_id,slipNo:slipNoTextController.text,liter:double.tryParse(qtyController.text),priceUnit:int.tryParse(priceController.text),amount: double.tryParse(totalFuelInAmtController.text),status: 'plantrip_product');
        //   await planTripServie.addPlanTripProductFuelIn(plantrip_product_fuelin).then((data) {
        //     Get.back();
        //     if (data != 0) {
        //       Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
        //         Get.back();
        //         Get.back();
        //         Get.back(result: data);
        //       });
        //     }
        //   });
        // }
        // else{
        //   var location_id = 0;
        //   if(this.selectedLocation!=null){
        //     location_id = this.selectedLocation.id;
        //   }
        //   var fuelin  = Plantrip_waybill_fuelin_line(tripWaybillId: trip_id,date:dateTextController.text,shop:shopNameTextController.text,productId: this.selectedProduct.id,locationId: location_id,slipNo:slipNoTextController.text,liter:double.tryParse(qtyController.text),priceUnit:int.tryParse(priceController.text),amount: double.tryParse(totalFuelInAmtController.text));
        //   await planTripServie.addPlanTripWayBillFuelIn(fuelin).then((data) {
        //     Get.back();
        //     if (data != 0) {
        //       Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
        //         Get.back();
        //         Get.back();
        //         Get.back(result: data);
        //       });
        //     }
        //   });
        // }
      }, () async {});
    }
  }

  addAdvance(String arg, int tripID) async {
    bool valid = false;
    if (this.selectedExpenseCategory.id == 0 ||
        quantityTextController.text.isEmpty ||
        amountTextController.text.isEmpty) {
      valid = false;
      Get.snackbar('Warning', "Fill Required Data!",
          snackPosition: SnackPosition.BOTTOM);
    } else if (quantityTextController.text == '0' ||
        amountTextController.text == '0') {
      AppUtils.showToast('Can not add zero value');
      valid = false;
    } else {
      valid = true;
    }
    if (valid) {
      AppUtils.showConfirmCancelDialog('Warning', 'Are you sure?', () async {
        isAdvanceButton.value = true;
        if (arg == "DayTrip") {
          var advance = Advance_line(
              dayTripId: tripID,
              expenseCategId: this.selectedExpenseCategory.id,
              quantity: int.tryParse(quantityTextController.text)!,
              amount: int.tryParse(amountTextController.text)!,
              total_amount: int.tryParse(totalAmountController.text)!,
              remark: remarkTextController.text);
          await dayTripServie?.addAdvance(advance).then((data) async{
            isAdvanceButton.value = false;
            if (data != 0) {
              Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: () async{
                Get.back();
                Get.back();
                Get.back(result: data);
              });
              // Get.defaultDialog(
              //     title: 'Information',
              //     content: Text('Successfully Saved!'),
              //     confirmTextColor: Colors.white,
              //     onConfirm: () {
              //       Get.back();
              //       Get.back();
              //       Get.back(result: data);
              //     });
            }
          });
        } else if (arg == "PlanTripProduct") {
          var advance = Plantrip_product_adavance_line(
              tripProductId: tripID,
              expenseCategId: this.selectedExpenseCategory.id,
              quantity: int.tryParse(quantityTextController.text)!,
              amount: int.tryParse(amountTextController.text)!,
              total_amount: int.tryParse(totalAmountController.text)!,
              remark: remarkTextController.text);
          await planTripServie?.addPlanTripProductAdvance(advance).then((data) {
            isAdvanceButton.value = false;
            if (data != 0) {
              Get.defaultDialog(
                  title: 'Information',
                  content: Text('Successfully Saved!'),
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back();
                    Get.back();
                    Get.back(result: data);
                  });
            }
          });
        } else {
          var advance = Plantrip_waybilll_advance_line(
              tripWaybillId: tripID,
              expenseCategId: this.selectedExpenseCategory.id,
              quantity: int.tryParse(quantityTextController.text)!,
              amount: int.tryParse(amountTextController.text)!,
              total_amount: int.tryParse(totalAmountController.text)!,
              remark: remarkTextController.text);
          await planTripServie?.addPlanTripWaybillAdvance(advance).then((data) {
            isAdvanceButton.value = false;
            if (data != 0) {
              Get.defaultDialog(
                  title: 'Information',
                  content: Text('Successfully Saved!'),
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back();
                    Get.back();
                    Get.back(result: data);
                  });
            }
          });
        }
      }, () async {});
    }
  }

  void calculateAdvancePriceUnit() {
    var qty = quantityTextController.text ?? "1";
    // if(totalAmountController.text.isEmpty)
    //   totalAmountController.text = '0';
    var unit_price = totalAmountController.text ?? "0";
    amount.value = double.tryParse(unit_price)! / double.tryParse(qty)!;
    var amt = amount.value.toStringAsFixed(1);
    amountTextController.text =
        NumberFormat('###.##').format(double.tryParse(amt)!.round());

    update();
  }

  deleteAdvance(String arg, int tripID) async {
    if (arg == "DayTrip") {
      var advance = Advance_line(
          dayTripId: tripID,
          expenseCategId: this.selectedExpenseCategory.id,
          quantity: int.tryParse(quantityTextController.text)!,
          amount: int.tryParse(amountTextController.text)!,
          total_amount: int.tryParse(totalAmountController.text)!,
          remark: remarkTextController.text);
      await dayTripServie?.addAdvance(advance).then((data) {
        if (data != 0) {
          Get.defaultDialog(
              title: 'Information',
              content: Text('Successfully Saved!'),
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                Get.back(result: true);
              });
        }
      });
    } else if (arg == "PlanTripProduct") {
      var advance = Plantrip_product_adavance_line(
          tripProductId: tripID,
          expenseCategId: this.selectedExpenseCategory.id,
          quantity: int.tryParse(quantityTextController.text)!,
          amount: int.tryParse(amountTextController.text)!,
          total_amount: int.tryParse(totalAmountController.text)!,
          remark: remarkTextController.text);
      await planTripServie?.addPlanTripProductAdvance(advance).then((data) {
        if (data != 0) {
          Get.defaultDialog(
              title: 'Information',
              content: Text('Successfully Saved!'),
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                Get.back(result: true);
              });
        }
      });
    } else {
      var advance = Plantrip_waybilll_advance_line(
          tripWaybillId: tripID,
          expenseCategId: this.selectedExpenseCategory.id,
          quantity: int.tryParse(quantityTextController.text)!,
          amount: int.tryParse(amountTextController.text)!,
          total_amount: int.tryParse(totalAmountController.text)!,
          remark: remarkTextController.text);
      await planTripServie?.addPlanTripWaybillAdvance(advance).then((data) {
        if (data != 0) {
          Get.defaultDialog(
              title: 'Information',
              content: Text('Successfully Saved!'),
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
                Get.back(result: true);
              });
        }
      });
    }
  }
}
