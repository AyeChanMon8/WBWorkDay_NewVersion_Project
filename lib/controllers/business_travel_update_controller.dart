
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/expense_travel_list/expense_travel_list_controller.dart';
import 'package:winbrother_hr_app/models/fleet_model.dart';
import 'package:winbrother_hr_app/models/leave.dart';
import 'package:winbrother_hr_app/models/leave_type.dart';
import 'package:winbrother_hr_app/models/travel_expense/create/travel_line_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/edit_pocketModle.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/EditTravelExpenseModel.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_expense_approve_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/pocket_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_category.dart';
import 'package:winbrother_hr_app/models/travel_expense/create/travel_expense_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_product.dart';
import 'package:winbrother_hr_app/models/travel_expense_update.dart';
import 'package:winbrother_hr_app/models/travel_line.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/services/fleet_service.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:path/path.dart';

class BusinessTravelUpdateController extends GetxController {
  TravelRequestService? travelService;
  MasterService? masterService;
  FleetService? fleetService;
  TextEditingController dateTextController = TextEditingController();
  TextEditingController expenseCodeController = TextEditingController();
  TextEditingController approvedTravelController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController editQtyController = TextEditingController();
  TextEditingController editPriceController = TextEditingController();
  TextEditingController editTotalController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();
  final ExpensetravelListController travelExpenselistController = Get.find();
  var travel_expense_category_list = <TravelExpenseCategory>[].obs;
  var edit_travel_expense_category_list = <TravelExpenseCategory>[].obs;
  var travel_expense_product_list = <TravelExpenseProduct>[].obs;
  var edit_travel_expense_product_list = <TravelExpenseProduct>[].obs;
  var travel_expense_approve_list = <TravelRequestListResponse>[].obs;
  dynamic pocketList = <TravelLineModel>[].obs;
  TextEditingController expenseDateController = TextEditingController();
  TextEditingController expenseUpdateDateController = TextEditingController();
  final is_add_leavelist = false.obs;
  final Rx<File> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  final RxBool save_btn_show = true.obs;
  var totalAdvanceAmount = 0.0.obs;
  var amount = 0.0.obs;
  final is_show_expense = true.obs;
  Rx<Fleet_model> _selectedVehicle =
      Fleet_model().obs;
  Fleet_model get selectedVehicle =>
      _selectedVehicle.value;
  set selectedVehicle(Fleet_model type) =>
      _selectedVehicle.value = type;

  Rx<Fleet_model> _selectedEditVehicle =
      Fleet_model().obs;
  Fleet_model get selectedEditVehicle =>
      _selectedEditVehicle.value;
  set selectedEditVehicle(Fleet_model type) =>
      _selectedEditVehicle.value = type;

  Rx<TravelExpenseCategory> _selectedExpenseCategory =
      TravelExpenseCategory().obs;
  TravelExpenseCategory get selectedExpenseCategory =>
      _selectedExpenseCategory.value;
  Rx<TravelExpenseCategory> _selectedEditExpenseCategory =
      TravelExpenseCategory().obs;
  TravelExpenseCategory get selectedEditExpenseCategory =>
      _selectedEditExpenseCategory.value;
  set selectedExpenseCategory(TravelExpenseCategory type) =>
      _selectedExpenseCategory.value = type;
   set selectedEditExpenseCategory(TravelExpenseCategory type) =>
      _selectedEditExpenseCategory.value = type;

  Rx<TravelExpenseProduct> _selectedExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedExpenseProduct =>
      _selectedExpenseProduct.value;
  set selectedExpenseProduct(TravelExpenseProduct type) =>
      _selectedExpenseProduct.value = type;

  Rx<TravelExpenseProduct> _selectedEditExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedEditExpenseProduct =>
      _selectedEditExpenseProduct.value;
  set selectedEditExpenseProduct(TravelExpenseProduct type) =>
      _selectedEditExpenseProduct.value = type;

  Rx<TravelRequestListResponse> _selectedExpenseApprovce =
      TravelRequestListResponse().obs;
  TravelRequestListResponse get selectedApproveList =>
      _selectedExpenseApprovce.value;
  set selectedApproveList(TravelRequestListResponse type) =>
      _selectedExpenseApprovce.value = type;
  var totalAmountForExpense =0.0.obs;
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController editTotalAmountController = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  var travelLineModel = <TravelLineModel>[].obs;
  var travelLineModelData = <TravelLineModel>[].obs;
  final box = GetStorage();
  final leaveInterval = 1.obs;
  String image_base64 = '';
  var weekday_arr = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  var from_travel_date = "".obs;
  var to_travel_date = "".obs;
  var fleetList = <Fleet_model>[].obs;
  var fleetModel = Fleet_model().obs;
  var price_value = 0.0;
  var amount_value = 0.0;
  List image_64 = [];
  // final plzAddTime = false.obs;
  @override
  void onReady() async {
    super.onReady();
    this.travelService = await TravelRequestService().init();
    this.masterService = await MasterService().init();
    fleetService = await FleetService().init();
    var empId = box.read('emp_id');
    getFleetList(empId);
    getTravelExpenseCategory();
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
    totalController = TextEditingController();
    descriptionController = TextEditingController();
    totalAmountController = TextEditingController();
    expenseUpdateDateController = TextEditingController();
    editQtyController = TextEditingController(text: "1");
    editPriceController = TextEditingController();
    editTotalController = TextEditingController();
    editDescriptionController = TextEditingController();
    editTotalAmountController = TextEditingController();
  }

  void onChangeExpenseCategoryDropdown(
      TravelExpenseCategory travelExpenseCategory) async {
    this.selectedExpenseCategory = travelExpenseCategory;
    int id = selectedExpenseCategory.id;
    this.travel_expense_product_list.value.clear();
    getTravelExpenseProduct(id);
    update();
  }

  void onChangeEditExpenseCategoryDropdown(
      TravelExpenseCategory travelExpenseCategory) async {
    this.selectedEditExpenseCategory = travelExpenseCategory;
    int id = selectedEditExpenseCategory.id;
    this.edit_travel_expense_product_list.value.clear();
    getTravelExpenseProduct(id);
    update();
  }

  void onChangeTravelExpenseApproveDropdown(
      TravelRequestListResponse travelExpenseApproveModel) async {
    var totalamount = 0.0;
    from_travel_date.value = travelExpenseApproveModel.start_date;
    to_travel_date.value = travelExpenseApproveModel.end_date;
    this.selectedApproveList = travelExpenseApproveModel;
    travelExpenseApproveModel.request_allowance_lines!.forEach((element) {
      totalamount += element.total_amount;
    });
    totalAdvanceAmount.value = totalamount;
    update();
  }



  void onChangeExpenseProductDropdown(
      TravelExpenseProduct travelExpenseProduct) async {
    this.selectedExpenseProduct = travelExpenseProduct;
    update();
  }

  void onChangeEditExpenseProductDropdown(
      TravelExpenseProduct travelExpenseProduct) async {
    this.selectedEditExpenseProduct = travelExpenseProduct;
    update();
  }

  fetchLeaveLine(DateTime formdate, DateTime endDate) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    var formatter = new DateFormat('yyyy-MM-dd');
    var now = new DateTime.now();
    String formattedFromDate = formatter.format(formdate);
    print(formattedFromDate); //
    String formattedToDate = formatter.format(endDate);
    print(formattedToDate);
    Leave leave = Leave(
      employee_id: employee_id,
      start_date: formattedFromDate,
      end_date: formattedToDate,
    );
  }

  addTravelLine(List imageList) {
    var image1 = '';
    var image2 = '';
    var image3 = '';
    var image4 = '';
    var image5 = '';
    var image6 = '';
    var image7 = '';
    var image8 = '';
    var image9 = '';
    var image10 = '';
    var attach_include = false;
    if(imageList.length!=0){
      if(imageList.length == 1){
        attach_include = true;
        image1 = imageList[0].toString();
      }else if(imageList.length == 2){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
      }else if(imageList.length == 3){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
      }else if(imageList.length == 4){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
      }
      else if(imageList.length == 5){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
      }
      else if(imageList.length == 6){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
      }
      else if(imageList.length == 7){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
        image7 = imageList[6].toString();
      }
      else if(imageList.length == 8){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
        image7 = imageList[6].toString();
        image8 = imageList[7].toString();
      }
      else if(imageList.length == 9){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
        image7 = imageList[6].toString();
        image8 = imageList[7].toString();
        image9 = imageList[8].toString();
      }
      else if(imageList.length == 10){
        attach_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
        image7 = imageList[6].toString();
        image8 = imageList[7].toString();
        image9 = imageList[8].toString();
        image10 = imageList[9].toString();
      }
    }
    bool valid = false;
    if (expenseDateController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Date!");
    } else if (selectedExpenseCategory.id == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Type!");
    } else if (qtyController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Quantity!");
    } else if (priceController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Price!");
    }
    else if (selectedApproveList.id == 0) {
      AppUtils.showDialog("Information!", "Approve Travel List is needed!");
    }
    else if (selectedExpenseCategory.is_vehicle_selected != null&&selectedExpenseCategory.is_vehicle_selected) {
      if(selectedVehicle.id!=null){
        valid = true;
      }else{
        valid = false;
        AppUtils.showDialog("Information!", "Choose Vehicle!");
      }
    }
    else {
      valid = true;
    }
    //print(selectedExpenseCategory.display_name);
    if (valid) {
      var attach_name = "";
      if(selectedImage.value!=null){
        attach_name = basename(selectedImage.value.path);
      }
      var vehicleID = 0;
      selectedExpenseCategory.is_vehicle_selected!=null?vehicleID=selectedVehicle.id:vehicleID=0;

      var travelExpense = TravelLineModel(
          id: 0,
          // date: DateTime.parse(expenseDateController.text)
          //                   .subtract(Duration(hours: 6, minutes: 30))
          //                   .toString()
          //                   .replaceAll('.000', ''),
          date: expenseDateController.text,
          categ_id: selectedExpenseCategory.id,
          expense_category: selectedExpenseProduct.name,
          product_id: selectedExpenseProduct.id,
          description: descriptionController.text,
          qty: double.tryParse(qtyController.text)!,
          price_unit: double.tryParse(priceController.text)!,
          price_subtotal: double.tryParse(totalAmountController.text)!,
          attached_file: image1,
          attached_filename: attach_name,
          vehicle_id:vehicleID,
          image1: image2,
          image2: image3,
          image3: image4,
          image4: image5,
          image5: image6,
          image6: image7,
          image7: image8,
          image8: image9,
          image9: image10,attachment_include: attach_include
      );
      travelLineModel.add(travelExpense);
      // fromDateTextController.text = "";
      priceController.text = "";
      qtyController.text = "";
      totalAmountController.text = "";
      descriptionController.text = "";
      expenseCodeController.text = "";
      approvedTravelController.text = "";
      expenseDateController.text = "";
      image_base64 = '';
      isShowImage.value = false;
      selectedImage.value = File('');
      image_64 = [];
    }
    getTotalAmount();
  }

  updateTravelLineExpense(int id,int travel_id,String code,BuildContext context) async {

    var employee_id = int.tryParse(box.read('emp_id'));
    var employee_company = box.read('emp_company');
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";
    bool valid = false;
    if (travel_id == null) {
      valid = false;
      AppUtils.showDialog("Information!", "Approve Travel List is needed!");
    }
    else {
      valid = true;
    }
    if (valid) {

      Future.delayed(
          Duration.zero,
              () => 
              showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                    SpinKitWave(
                    color: Color.fromRGBO(63, 51, 128, 1),
                    size: 30.0,
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Please wait!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(63, 51, 128, 1),
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
          );
        }
              // Get.dialog(
              //   SpinKitWave(
              //       color: Color.fromRGBO(63, 51, 128, 1),
              //       size: 30.0,
              //       ),
              // barrierDismissible: false)
              )
      );
      
      // travelLineModelData.value = travelLineModel.value;
      // for (var i = 0; i < travelLineModelData.value.length; i++) {
      //   if(travelLineModelData.value[i].id != 0){
      //     travelLineModelData.value[i].date = DateTime.parse(travelLineModelData.value[i].date)
      //                 .subtract(Duration(hours: 6, minutes: 30))
      //                 .toString()
      //                 .replaceAll('.000', '');
        // }
      // }

      // travelLineModelData = travelLineModel;
    // for (var i = 0; i < travelLineModelData.length; i++) {
    //   var date = DateTime.parse(travelLineModelData[i].date+" 00:00:00");
    //   var dateFormatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    //   String formattedDate = dateFormatter.format(date);
    //   travelLineModelData[i].date =formattedDate;
    // }

      TravelExpenseUpdateModel travelExpense = TravelExpenseUpdateModel(
          id: id,
          travel_line: travelLineModel.value);
      await travelService!.updateTravelRequest(id,travelExpense).then((data) {
        
        if (data != 0) {
          // plzAddTime.value = false;
          Get.back();
          print(data);
          // save_btn_show.value = false;
          // AppUtils.showConfirmDialog('Information', 'Successfully Updated!',(){
          //   travelExpenselistController.offset.value = 0;
          //   travelExpenselistController.getExpenseListForEmp();
          //   Get.back();
          //   Get.back();
          //   Get.back();
          // });
          save_btn_show.value = false;
          Get.defaultDialog(title:'Information',content: Text('Successfully Updated!'),confirmTextColor: Colors.white,onConfirm: () async{
            travelExpenselistController.offset.value = 0;
            travelExpenselistController.getExpenseListForEmp();
            Get.back();
            Get.back();
            Get.back();
          });
        }
        // else{
        //   plzAddTime.value = true;
        // }
        //  else {
        //   AppUtils.showDialog('Information', 'Saving Failed!');
        // }
        //Get.back(result: 'success');
      });
    }
  }


  updateLeaveType(LeaveType value) {
    // leaveTypeObj.update((val) {
    //   val.id = value.id;
    //   val.name =value.name;
    // });
  }

  getTravelExpenseCategory() async {
    var company_id = box.read('emp_company');
    await masterService!.getTravelExpenseCategory(int.tryParse(company_id)!).then((data) {
      if(data.length!=0){
        this.selectedExpenseCategory = data[0];
        travel_expense_category_list.value = data;
        edit_travel_expense_category_list.value = data;
        int id = selectedExpenseCategory.id;
        getTravelExpenseProduct(id);
      }

    });
  }

  void calculateAmount() {
    if(priceController.text.isNotEmpty&&qtyController.text.isNotEmpty){
      amount.value = double.tryParse(qtyController.text)! * double.tryParse(priceController.text)!;
      totalAmount = totalAmountController;
      totalAmountController.text = amount.value.toString();
      update();
    }else if(totalAmountController.text.isNotEmpty&&qtyController.text.isNotEmpty){
      amount.value = double.tryParse(totalAmountController.text)!/double.tryParse(qtyController.text)!;
      priceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      priceController.text = "";
    }

  }

  void editCalculateAmount() {
    if(editPriceController.text.isNotEmpty&&editQtyController.text.isNotEmpty){
      amount.value = double.tryParse(editQtyController.text)! * double.tryParse(editPriceController.text)!;
      totalAmount = editTotalAmountController;
      editTotalAmountController.text = amount.value.toString();
      update();
    }else if(editTotalAmountController.text.isNotEmpty&&editQtyController.text.isNotEmpty){
      amount.value = double.tryParse(editTotalAmountController.text)!/double.tryParse(editQtyController.text)!;
      editPriceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      editPriceController.text = "";
    }

  }

  void calculateUnitAmount() {
    if(totalAmountController.text.isNotEmpty&&qtyController.text.isNotEmpty){
      amount.value = double.tryParse(totalAmountController.text)!/double.tryParse(qtyController.text)!;
      priceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      priceController.text = "";
    }
  }

  void editCalculateUnitAmount() {
    if(editTotalAmountController.text.isNotEmpty&&editQtyController.text.isNotEmpty){
      amount.value = double.tryParse(editTotalAmountController.text)!/double.tryParse(editQtyController.text)!;
      editPriceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      editPriceController.text = "";
    }
  }

  getTravelExpenseProduct(int id) async {
    var company_id = box.read('emp_company');
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await masterService!.getTravelExpenseProduct(id,company_id.toString()).then((data) {
      Get.back();
      if(data.length!=0){
        this.selectedExpenseProduct = data[0];
        this.selectedEditExpenseProduct = data[0];
      }
      travel_expense_product_list.value = data;
      edit_travel_expense_product_list.value = data;
    });
  }

  getEditTravelExpenseProduct(int id,int prod_id) async {
    var company_id = box.read('emp_company');
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await masterService!.getTravelExpenseProduct(id,company_id.toString()).then((data) {
      if(data.length!=0){
        edit_travel_expense_product_list.value = data;
        for(var i=0;i<data.length;i++){
          if(prod_id==data[i].id){
            this.selectedEditExpenseProduct = data[i];
            this.selectedEditExpenseProduct.id = data[i].id;
          }
        }
      }
      Get.back();
    });
  }

  /* getTravelApproveList() async {
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService.getTravelApproveList(employee_id).then((data) {
      if (data != null) {
        data.insert(
            0, TravelRequestListResponse(id: 0, name: 'Approve Travel List'));
        this.selectedApproveList = data[0];
        from_travel_date.value = data[0].start_date;
        to_travel_date.value = data[0].end_date;
        travel_expense_approve_list.value = data;
      }
    });
  }*/

  Future<void> getOneTravelApprove(int travel_id) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService!.getOneTravelApprove(employee_id!,travel_id).then((data) {
      if (data != null) {
        from_travel_date.value = data[0].start_date;
        to_travel_date.value = data[0].end_date;
      }
    });
  }

  setEditExpenseLine(TravelLineModel travelLine){
    expenseUpdateDateController.text = travelLine.date;

    // expenseUpdateDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(travelLine.date)).toString();
    // expenseUpdateDateController.text = DateTime.parse(travelLine.date)
    //                         .add(Duration(hours: 6, minutes: 30))
    //                         .toString()
    //                         .replaceAll('.000', '');
    if(travelLine.categ_id!=null){
      for(var i=0;i<this.edit_travel_expense_category_list.length;i++){
        if(travelLine.categ_id == this.edit_travel_expense_category_list[i].id){
          this.selectedEditExpenseCategory = this.edit_travel_expense_category_list[i];
          this.selectedEditExpenseCategory.id = this.edit_travel_expense_category_list[i].id;
          break;
        }
      }
    }
    //selectedEditExpenseProduct.id = travelLine.product_id;
    getEditTravelExpenseProduct(travelLine.categ_id,travelLine.product_id);
    editQtyController.text = travelLine.qty.toString();
    editPriceController.text = travelLine.price_unit.toString();
    editTotalAmountController.text = travelLine.price_subtotal.toString();
    editDescriptionController.text = travelLine.description;
    
  }

  // void removeRow(int index,int line_id) {
  //   travelLineModel.removeAt(index);

  //   getTotalAmount();
  //   if(line_id!=null){
  //     travelService.deleteTravelExpenseLine(line_id);
  //     travelService.deleteFleetVehicleLogFuelLine(line_id);
  //   }else{
  //     pocketList.removeAt(index);
  //   }

  //   if (plzAddTime.value) {
  //     for (var i = 0; i < travelLineModel.length; i++) {
  //       travelLineModel[i].date = DateTime.parse(travelLineModel[i].date)
  //           .add(Duration(hours: 6, minutes: 30))
  //           .toString()
  //           .replaceAll('.000', '');
  //     }
  //   }

  //   plzAddTime.value = false;

  // }

  void removeRow(int index,int line_id) {
    travelLineModel.removeAt(index);

    getTotalAmount();
    if(line_id!=null){
      travelService?.deleteTravelExpenseLine(line_id);
      travelService?.deleteFleetVehicleLogFuelLine(line_id);
    }else{
      pocketList.removeAt(index);
    }

  }

  void getTotalAmount (){

    double amount=0.0;
    travelLineModel.value.forEach((element) {
      amount += element.price_subtotal;
    });
    totalAmountForExpense.value = amount;
  }

  @override
  void onClose() {
    // fromDateTextController?.dispose();
    // toDateTextController?.dispose();
    // purposeTextController?.dispose();
    // durationController?.dispose();
    // descriptionController?.dispose();
    isShowImage.value = false;
    is_add_leavelist.value = false;
    leaveInterval.value = 1;
    super.onClose();
  }

  nullPhoto() {
    isShowImage.value = false;
    selectedImage.value = File('');
  }

  void updateState() {
    is_add_leavelist.value = true;
  }


  void setCameraImage(File image, String image64) {
    image_base64 = image64;
    isShowImage.value = true;
    selectedImage.value = image;
  }

  void onChangeVehicleDropdown(
      Fleet_model fleet_model) async {
    this.selectedVehicle = fleet_model;
    update();
  }

  void onChangeEditVehicleDropdown(
      Fleet_model fleet_model) async {
    this.selectedEditVehicle = fleet_model;
    update();
  }

  getFleetList(var empId) async{
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    fleetList.value = await fleetService!.getFleetList(empId,false, true, false, false, false,false);
    if(fleetList.value.length>0){
      selectedVehicle = fleetList[0];
      selectedEditVehicle = fleetList[0];

    }

    Get.back();
  }

  updateExpenseLine(int index,TravelLineModel travelLine,List<String> img){
    var image1 = '';
    var image2 = '';
    var image3 = '';
    var image4 = '';
    var image5 = '';
    var image6 = '';
    var image7 = '';
    var image8 = '';
    var image9 = '';
    var image10 = '';
    var attach_include = false;
    if(img.length!=0){
      if(img.length == 1){
        attach_include = true;
        image1 = img[0].toString();
      }else if(img.length == 2){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
      }else if(img.length == 3){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
      }else if(img.length == 4){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
      }
      else if(img.length == 5){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
      }
      else if(img.length == 6){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
        image6 = img[5].toString();
      }
      else if(img.length == 7){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
        image6 = img[5].toString();
        image7 = img[6].toString();
      }
      else if(img.length == 8){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
        image6 = img[5].toString();
        image7 = img[6].toString();
        image8 = img[7].toString();
      }
      else if(img.length == 9){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
        image6 = img[5].toString();
        image7 = img[6].toString();
        image8 = img[7].toString();
        image9 = img[8].toString();
      }
      else if(img.length == 10){
        attach_include = true;
        image1 = img[0].toString();
        image2 = img[1].toString();
        image3 = img[2].toString();
        image4 = img[3].toString();
        image5 = img[4].toString();
        image6 = img[5].toString();
        image7 = img[6].toString();
        image8 = img[7].toString();
        image9 = img[8].toString();
        image10 = img[9].toString();
      }
    }
    bool valid = false;
    if (expenseUpdateDateController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Date!");
    } else if (selectedEditExpenseCategory.id == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Type!");
    } else if (editQtyController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Quantity!");
    } else if (editPriceController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Price!");
    }
    else if (selectedApproveList.id == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Approve Travel List is needed!");
    }
    else if (selectedEditExpenseCategory.is_vehicle_selected != null&&selectedEditExpenseCategory.is_vehicle_selected) {
      if(selectedEditVehicle.id!=null){
        valid = true;
      }else{
        valid = false;
        AppUtils.showDialog("Information!", "Choose Vehicle!");
      }
    }
    else {
      valid = true;
    }
    if(valid){
    var vehicleID = 0;
    removeRow(index,travelLine.id);
    selectedEditExpenseCategory.is_vehicle_selected!=null?vehicleID=selectedEditVehicle.id:vehicleID=0;
    var travelExpense = TravelLineModel(
          id: 0,
          date: expenseUpdateDateController.text,
          // date: DateTime.parse(expenseUpdateDateController.text)
          // .subtract(Duration(hours: 6, minutes: 30))
          // .toString()
          // .replaceAll('.000', ''),
          categ_id: selectedEditExpenseCategory.id,
          expense_category: selectedEditExpenseProduct.name,
          product_id: selectedEditExpenseProduct.id,
          description: editDescriptionController.text,
          qty: double.tryParse(editQtyController.text)!,
          price_unit: double.tryParse(editPriceController.text)!,
          price_subtotal: double.tryParse(editTotalAmountController.text)!,
          attached_file: image1,
          attached_filename:travelLine.attached_filename,
          vehicle_id:vehicleID,
          image1: image2,
          image2: image3,
          image3: image4,
          image4: image5,
          image5: image6,
          image6: image7,
          image7: image8,
          image8: image9,
          image9: image10,
          attachment_include: travelLine.attachment_include
      );
      travelLineModel.add(travelExpense);
      editPriceController.text = "";
      editQtyController.text = "";
      editTotalAmountController.text = "";
      editDescriptionController.text = "";
      expenseUpdateDateController.text = "";
    }
    
  }

  updateExpenseLine1(int index,TravelLineModel travelLine){
    bool valid = false;
    if (expenseUpdateDateController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Date!");
    } else if (selectedEditExpenseCategory.id == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Choose Expense Type!");
    } else if (editQtyController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Quantity!");
    } else if (editPriceController.text.isEmpty) {
      valid = false;
      AppUtils.showDialog("Information!", "Type Price!");
    }
    else if (selectedApproveList.id == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Approve Travel List is needed!");
    }
    else if (selectedEditExpenseCategory.is_vehicle_selected != null&&selectedEditExpenseCategory.is_vehicle_selected) {
      if(selectedEditVehicle.id!=null){
        valid = true;
      }else{
        valid = false;
        AppUtils.showDialog("Information!", "Choose Vehicle!");
      }
    }
    else {
      valid = true;
    }
    if(valid){
    removeRow(index,travelLine.id);
    var vehicleID = 0;
    selectedEditExpenseCategory.is_vehicle_selected!=null?vehicleID=selectedEditVehicle.id:vehicleID=0;
    var travelExpense = TravelLineModel(
          id: 0,
          date: expenseUpdateDateController.text,
          categ_id: selectedEditExpenseCategory.id,
          expense_category: selectedEditExpenseProduct.name,
          product_id: selectedEditExpenseProduct.id,
          description: editDescriptionController.text,
          qty: double.tryParse(editQtyController.text)!,
          price_unit: double.tryParse(editPriceController.text)!,
          price_subtotal: double.tryParse(editTotalAmountController.text)!,
          attached_file: travelLine.attached_file,
          attached_filename:travelLine.attached_filename,
          vehicle_id:vehicleID,
          image1: travelLine.image1,
          image2: travelLine.image2,
          image3: travelLine.image3,
          image4: travelLine.image4,
          image5: travelLine.image5,
          image6: travelLine.image6,
          image7: travelLine.image7,
          image8: travelLine.image8,
          image9: travelLine.image9,
          attachment_include: travelLine.attachment_include
      );
      travelLineModel.add(travelExpense);
      editPriceController.text = "";
      editQtyController.text = "";
      editTotalAmountController.text = "";
      editDescriptionController.text = "";
      expenseUpdateDateController.text = "";
    }
    
  }
}