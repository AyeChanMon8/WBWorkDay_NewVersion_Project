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
import 'package:winbrother_hr_app/models/travel_line.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/services/fleet_service.dart';
import 'package:winbrother_hr_app/services/leave_service.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/travel_request_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:path/path.dart';

class BusinessTravelController extends GetxController {
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
  final ExpensetravelListController travelExpenselistController = Get.find();
  var travel_expense_category_list = <TravelExpenseCategory>[].obs;
  var travel_expense_product_list = <TravelExpenseProduct>[].obs;
  var travel_expense_approve_list = <TravelRequestListResponse>[].obs;
  TextEditingController expenseDateController = TextEditingController();
  final is_add_leavelist = false.obs;
  final Rx<File> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  final RxBool save_btn_show = true.obs;
  var totalAdvanceAmount = 0.0.obs;
  var amount = 0.0.obs;
  Rx<Fleet_model> _selectedVehicle = Fleet_model().obs;
  Fleet_model get selectedVehicle => _selectedVehicle.value;
  set selectedVehicle(Fleet_model type) => _selectedVehicle.value = type;
  final is_show_expense = true.obs;
  Rx<TravelExpenseCategory> _selectedExpenseCategory =
      TravelExpenseCategory().obs;
  TravelExpenseCategory get selectedExpenseCategory =>
      _selectedExpenseCategory.value;
  set selectedExpenseCategory(TravelExpenseCategory type) =>
      _selectedExpenseCategory.value = type;

  Rx<TravelExpenseProduct> _selectedExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedExpenseProduct =>
      _selectedExpenseProduct.value;
  set selectedExpenseProduct(TravelExpenseProduct type) =>
      _selectedExpenseProduct.value = type;

   Rx<TravelExpenseCategory> _selectedEditExpenseCategory =
      TravelExpenseCategory().obs;
  TravelExpenseCategory get selectedEditExpenseCategory =>
      _selectedEditExpenseCategory.value;
   set selectedEditExpenseCategory(TravelExpenseCategory type) =>
      _selectedEditExpenseCategory.value = type;

  Rx<TravelRequestListResponse> _selectedExpenseApprovce =
      TravelRequestListResponse().obs;
  TravelRequestListResponse get selectedApproveList =>
      _selectedExpenseApprovce.value;
  set selectedApproveList(TravelRequestListResponse type) =>
      _selectedExpenseApprovce.value = type;
  var totalAmountForExpense = 0.0.obs;
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  List<TravelLineModel> travelLineModel = <TravelLineModel>[].obs;
  List<TravelLineModel> travelLineModelData = <TravelLineModel>[].obs;
  final box = GetStorage();
  final leaveInterval = 1.obs;
  String image_base64 = "";
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
  var encoded_list = <String>[].obs;
  List image_64 = [];
  // final plzAddTime = false.obs;
  TextEditingController expenseUpdateDateController = TextEditingController();
  Rx<Fleet_model> _selectedEditVehicle =
      Fleet_model().obs;
  Fleet_model get selectedEditVehicle =>
      _selectedEditVehicle.value;
  set selectedEditVehicle(Fleet_model type) =>
      _selectedEditVehicle.value = type;

  Rx<TravelExpenseProduct> _selectedEditExpenseProduct = TravelExpenseProduct().obs;
  TravelExpenseProduct get selectedEditExpenseProduct =>
      _selectedEditExpenseProduct.value;
  set selectedEditExpenseProduct(TravelExpenseProduct type) =>
      _selectedEditExpenseProduct.value = type;

  TextEditingController editQtyController = TextEditingController();
  TextEditingController editPriceController = TextEditingController();
  TextEditingController editTotalController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();
  TextEditingController editTotalAmountController= TextEditingController();
  var edit_travel_expense_product_list = <TravelExpenseProduct>[].obs;
  var edit_travel_expense_category_list = <TravelExpenseCategory>[].obs;
  @override
  void onReady() async {
    super.onReady();
    this.travelService = await TravelRequestService().init();
    this.masterService = await MasterService().init();
    fleetService = await FleetService().init();
    var empId = box.read('emp_id');
    getFleetList(empId);
    getTravelExpenseCategory();
    getTravelApproveList();
    // getTravelExpenseProduct();
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

  void onChangeTravelExpenseApproveDropdown(
      TravelRequestListResponse travelExpenseApproveModel) async {
    var totalamount = 0.0;
    from_travel_date.value = travelExpenseApproveModel.start_date;
    to_travel_date.value = travelExpenseApproveModel.end_date;
    this.selectedApproveList = travelExpenseApproveModel;
    if (travelExpenseApproveModel.request_allowance_lines != null) {
      travelExpenseApproveModel.request_allowance_lines!.forEach((element) {
        totalamount += element.total_amount;
      });
    }
    totalAdvanceAmount.value = travelExpenseApproveModel.payment_amount;
    update();
  }

  void onChangeExpenseProductDropdown(
      TravelExpenseProduct travelExpenseProduct) async {
    this.selectedExpenseProduct = travelExpenseProduct;
    update();
  }

  fetchLeaveLine(DateTime formdate, DateTime endDate) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    var formatter = new DateFormat('yyyy-MM-dd');
    var now = new DateTime.now();
    String formattedFromDate = formatter.format(formdate); //
    String formattedToDate = formatter.format(endDate);
    print(formattedToDate);
    Leave leave = Leave(
      employee_id: employee_id,
      start_date: formattedFromDate,
      end_date: formattedToDate,
    );
  }

  addTravelLine(List<dynamic> imageList) {
    print("imageList ${imageList.length}");
    var attachement_include =false;
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
    if(imageList.length!=0){
      if(imageList.length == 1){
        image1 = imageList[0].toString();
        attachement_include = true;
      }else if(imageList.length == 2){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
      }else if(imageList.length == 3){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
      }else if(imageList.length == 4){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
      }
      else if(imageList.length == 5){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
      }
      else if(imageList.length == 6){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
      }
      else if(imageList.length == 7){
        attachement_include = true;
        image1 = imageList[0].toString();
        image2 = imageList[1].toString();
        image3 = imageList[2].toString();
        image4 = imageList[3].toString();
        image5 = imageList[4].toString();
        image6 = imageList[5].toString();
        image7 = imageList[6].toString();
      }
      else if(imageList.length == 8){
        attachement_include = true;
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
        attachement_include = true;
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
        attachement_include = true;
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
      valid = false;
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
    String image_file = "";
    //print(selectedExpenseCategory.display_name);
    if (valid) {
      // if (selectedImage.value != null) {
      //   image_file = basename(selectedImage.value.path);
      // }

      var vehicleID = 0;
      selectedExpenseCategory.is_vehicle_selected != null
          ? vehicleID = selectedVehicle.id
          : vehicleID = 0;
      var travelExpense = TravelLineModel(
          date: expenseDateController.text,
          categ_id: selectedExpenseCategory.id,
          expense_category: selectedExpenseProduct.name,
          product_id: selectedExpenseProduct.id,
          description: descriptionController.text,
          qty: double.tryParse(qtyController.text)!,
          price_unit: double.tryParse(priceController.text)!,
          price_subtotal: double.tryParse(totalAmountController.text)!,
          attached_file: image1,
          image1: image2,
          image2: image3,
          image3: image4,
          image4: image5,
          image5: image6,
          image6: image7,
          image7: image8,
          image8: image9,
          image9: image10,
          attached_filename: image_file,
          vehicle_id: vehicleID,attachment_include: attachement_include);
      travelLineModel.add(travelExpense);
      // fromDateTextController.text = "";
      priceController.text = "";
      qtyController.text = "";
      totalAmountController.text = "";
      descriptionController.text = "";
      expenseCodeController.text = "";
      approvedTravelController.text = "";
      expenseDateController.text = "";
      image_base64 = "";
      isShowImage.value = false;
      selectedImage.value = File('');
      image_64 = [];
      // plzAddTime.value = false;
    }
    getTotalAmount();
  }

  updateTravelLineExpense(String id,BuildContext context) async {
    print('updateTravelLineExpense');
    var employee_id = box.read('emp_id');
    Future.delayed(
        Duration.zero,
        () => showDialog(
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
  },
    ),);

    EditTravelExpenseModel outRequest =
        EditTravelExpenseModel(travel_line: travelLineModel);
    await travelService!
        .updateTravelExpenseLine(outRequest, id, int.tryParse(employee_id)!)
        .then((data) {
      if (data != 0) {
        save_btn_show.value = false;
        AppUtils.showDialog('Information', 'Successfully Saved!');
        Get.offNamed(Routes.CREATE_EXPENSE, arguments: "travel_expense");
        travelExpenselistController.getExpenseListForEmp();
      } else {
        AppUtils.showDialog('Information', 'Saving Failed!');
      }
      //Get.back(result: 'success');
    });
  }

  createTravel(BuildContext context) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    var employee_company = box.read('emp_company');
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";
    bool valid = false;
    if (selectedApproveList.id == null) {
      valid = false;
      AppUtils.showDialog("Information!", "Approve Travel List is needed!");
    }
    else if (travelLineModel.length == 0) {
      valid = false;
      AppUtils.showDialog("Information!", "Add Expense Line!");
    }

    else {
      valid = true;
    }
    if (valid) {
      Future.delayed(
          Duration.zero,
          () => showDialog(
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
          )
      );
    //   travelLineModelData = travelLineModel;
    // for (var i = 0; i < travelLineModelData.length; i++) {
      
    //     travelLineModelData[i].date = DateTime.parse(travelLineModelData[i].date)
    //               .subtract(Duration(hours: 6, minutes: 30))
    //               .toString()
    //               .replaceAll('.000', '');
    // }

    // travelLineModelData = travelLineModel;
    // for (var i = 0; i < travelLineModelData.length; i++) {
    //   var date = DateTime.parse(travelLineModelData[i].date+" 00:00:00");
    //   var dateFormatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    //   String formattedDate = dateFormatter.format(date);
    //   travelLineModelData[i].date =formattedDate;
    // }
      
      TravelExpenseModel travelExpense = TravelExpenseModel(
          date: formattedDate,
          mobile_user_id: employee_id!,
          employee_id: employee_id,
          company_id: int.parse(employee_company.toString()),
          advanced_money: 100,
          travel_id: selectedApproveList.id,
          travel_line: travelLineModel);
      await travelService!.createTravelRequest(travelExpense).then((data) {
        
        if (data != 0) {
          // plzAddTime.value = false;
          Get.back(); 
          print(data);
          save_btn_show.value = false;
          // AppUtils.showConfirmDialog('Information', 'Successfully Saved!', () {
          //   travelExpenselistController.offset.value = 0;
          //   travelExpenselistController.getExpenseListForEmp();
          //   Get.back();
          //   Get.back();
          // });
             Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: () async{
              travelExpenselistController.offset.value = 0;
              travelExpenselistController.getExpenseListForEmp();
              Get.back();
              Get.back();
        });
        }else{
          // plzAddTime.value = true;
        }
        // else {
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
    await masterService!
        .getTravelExpenseCategory(int.tryParse(company_id)!)
        .then((data) {
      if (data.length != 0) {
        this.selectedExpenseCategory = data[0];
        travel_expense_category_list.value = data;
        edit_travel_expense_category_list.value = data;
        int id = selectedExpenseCategory.id;
        getTravelExpenseProduct(id);
      }
    });
  }

  void calculateAmount() {
    print("Calculate");
    // var qty = qtyController.text ?? "1";
    // var unit_price = priceController.text;
    if(qtyController.text.isNotEmpty&&priceController.text.isNotEmpty){
      amount.value = double.tryParse(qtyController.text)! * double.tryParse(priceController.text)!;
      totalAmount = totalAmountController;
      totalAmountController.text = amount.value.toString();
      update();
    }else if(qtyController.text.isNotEmpty&&totalAmountController.text.isNotEmpty){
      amount.value = double.tryParse(totalAmountController.text)! / double.tryParse(qtyController.text)!;
      priceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      priceController.text = "";
    }
  }

  void calculateUnitAmount() {
    // var qty = qtyController.text ?? "1";
    // var totalAmount = totalAmountController.text;
    if(qtyController.text.isNotEmpty&&totalAmountController.text.isNotEmpty){
      amount.value = double.tryParse(totalAmountController.text)! / double.tryParse(qtyController.text)!;
      priceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      priceController.text = "";
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
    await masterService!
        .getTravelExpenseProduct(id, company_id.toString())
        .then((data) {
      Get.back();
      if (data.length != 0) {
        this.selectedExpenseProduct = data[0];
        this.selectedEditExpenseProduct = data[0];
      }
      travel_expense_product_list.value = data;
      edit_travel_expense_product_list.value = data;
    });
  }

  getTravelApproveList() async {
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService!.getTravelApproveList(employee_id!).then((data) {
      if (data != null) {
        data.insert(
            0, TravelRequestListResponse(id: 0, name: 'Approve Travel List'));
        this.selectedApproveList = data[0];
        from_travel_date.value = data[0].start_date;
        to_travel_date.value = data[0].end_date;
        travel_expense_approve_list.value = data;
          if (travel_expense_approve_list.value.length > 0) {
          selectedApproveList = travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1];
          var totalamount = 0.0;
          from_travel_date.value = travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1].start_date;
          to_travel_date.value = travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1].end_date;
          if (travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1].request_allowance_lines != null) {
            travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1].request_allowance_lines!
                .forEach((element) {
              totalamount += element.total_amount;
            });
          }
          totalAdvanceAmount.value = travel_expense_approve_list
              .value[travel_expense_approve_list.value.length - 1].payment_amount;
          update();
        }
      }
    });
  }

  // void removeRow(int index) {
  //   print(index);
  //   travelLineModel.removeAt(index);
  //   if (plzAddTime.value) {
  //     for (var i = 0; i < travelLineModel.length; i++) {
  //       travelLineModel[i].date = DateTime.parse(travelLineModel[i].date)
  //           .add(Duration(hours: 6, minutes: 30))
  //           .toString()
  //           .replaceAll('.000', '');
  //     }
  //   }
  //   plzAddTime.value = false;
  //   getTotalAmount();
  // }

  void removeRow(int index) {
    print(index);
    travelLineModel.removeAt(index);
    getTotalAmount();
  }

  void editRemoveRow(int index,int line_id) {
    travelLineModel.removeAt(index);

    getTotalAmount();
    if(line_id!=null){
      travelService!.deleteTravelExpenseLine(line_id);
      travelService!.deleteFleetVehicleLogFuelLine(line_id);
    }

  }

  void getTotalAmount() {
    double amount = 0.0;
    travelLineModel.forEach((element) {
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

  void setGalleryImage(List<String> files_encoded) {
    encoded_list.value = files_encoded;
  }

  void onChangeVehicleDropdown(Fleet_model fleet_model) async {
    this.selectedVehicle = fleet_model;
    update();
  }

  getFleetList(var empId) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    await fleetService!.getFleetList(empId,false, true, false, false, false,false).then((data) {
      if (data.length > 0) {
        selectedVehicle = data[0];
        selectedEditVehicle = data[0];
        fleetList.value = data;
      }

      Get.back();
    });
  }

  setEditExpenseLine(TravelLineModel travelLine){
    expenseUpdateDateController.text = travelLine.date;
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

  updateExpenseLine(int index,TravelLineModel travelLine){
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
      editRemoveRow(index,travelLine.id);
      var vehicleID = 0;
      selectedEditExpenseCategory.is_vehicle_selected != null
          ? vehicleID = selectedEditVehicle.id
          : vehicleID = 0;
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

  void editCalculateUnitAmount() {
    if(editTotalAmountController.text.isNotEmpty&&editQtyController.text.isNotEmpty){
      amount.value = double.tryParse(editTotalAmountController.text)!/double.tryParse(editQtyController.text)!;
      editPriceController.text = amount.value.toStringAsFixed(2);
      update();
    }else{
      editPriceController.text = "";
    }
  }

  void onChangeEditVehicleDropdown(
      Fleet_model fleet_model) async {
    this.selectedEditVehicle = fleet_model;
    update();
  }

  void onChangeEditExpenseProductDropdown(
      TravelExpenseProduct travelExpenseProduct) async {
    this.selectedEditExpenseProduct = travelExpenseProduct;
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


  Future<void> getOneTravelApprove(int travel_id) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService!.getOneTravelApprove(employee_id!,travel_id).then((data) {
      if (data != null) {
        from_travel_date.value = data[0].start_date;
        to_travel_date.value = data[0].end_date;
      }
    });
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
}
