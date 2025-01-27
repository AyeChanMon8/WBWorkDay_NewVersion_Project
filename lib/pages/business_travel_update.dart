
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//import 'package:easy_localization/easy_localization.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winbrother_hr_app/controllers/business_travel_update_controller.dart';
import 'package:winbrother_hr_app/controllers/expense_travel_list/expense_travel_list_controller.dart';
import 'package:winbrother_hr_app/models/fleet_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/create/travel_line_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_line_list_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_category.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_product.dart';
import 'package:winbrother_hr_app/models/travel_request_list_response.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'dart:io' as Io;
// import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'leave_detail.dart';

class BusinessTravelUpdate extends StatefulWidget {
  @override
  _BusinessTravelUpdateState createState() => _BusinessTravelUpdateState();
}

class _BusinessTravelUpdateState extends State<BusinessTravelUpdate> {
  @override
  void initState() {
    index = Get.arguments;
    controllerList.travelExpenseList.value[index].travel_line
        .forEach((element) {
      travelLine.add(TravelLineModel(
          id: element.id,
          date: element.date,
          categ_id: element.categ_id.id,
          expense_category: element.product_id.name,
          product_id: element.product_id.id,
          description: element.description,
          qty: element.qty,
          price_unit: element.price_unit,
          price_subtotal: element.price_subtotal,
          attached_file: element.attached_file,
          attached_filename: element.attachment_filename,
          vehicle_id: element.vehicle_id.id,
          image1: element.image1,
          image2: element.image2,
          image3: element.image3,
          image4: element.image4,
          image5: element.image5,
          image6: element.image6,
          image7: element.image7,
          image8: element.image8,
          image9: element.image9,
          attachment_include: element.attachment_include));
    });
    controller.travelLineModel.value = travelLine;
    image = box.read('emp_image');
    super.initState();
  }

  final BusinessTravelUpdateController controller = Get.find();
  ExpensetravelListController controllerList = Get.find();
  final ExpensetravelListController attachController =
      Get.put(ExpensetravelListController());
  var box = GetStorage();
  String image = "";
  int index = 0;
  String img64 = "";
  List<TravelLineListModel> datalist = [];
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedUpdateFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File ? imageFile;
  String expenseValue = "";
  List expenseData = ["Breakfast", "Lunch", "Dinner"];
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List image_64 = [];
  bool selectCamera = false;
  int imgIndex = 0;
  Future getCamera() async {
    image_64 = [];
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    image_64.add(img64);
    controller.setCameraImage(compressedFile, img64);
    setState(() {
      selectCamera = true;
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64);
  }

  Widget _decideImageView() {
    if (!controller.isShowImage.value) {
      return Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('No Image Selected!'),
          ));
    } else {
      return Image.file(imageFile!, width: 50, height: 50);
    }
  }

  nullPhoto() {
    controller.isShowImage.value = false;
    controller.selectedImage.value = File('');
  }

  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Camera")),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //getImage();
                    loadAssets();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Gallery")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget expenseTypeDropDown() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: const BorderRadius.all(
              const Radius.circular(1),
            ),
          ),
          child: Theme(
            data: new ThemeData(
              primaryColor: Color.fromRGBO(60, 47, 126, 1),
              primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
            ),
            child: DropdownButtonHideUnderline(
                child: InputDecorator(
              decoration: InputDecoration(
                labelText: expenseValue == null ? 'Where are you from' : 'From',
                errorText: expenseValue,
              ),
              isEmpty: expenseValue == null,
              child: DropdownButton<String>(
                  hint: Text(
                    "",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: expenseValue,
                  onChanged: (String ? newValue) {
                    // setState(() {
                    //   expenseValue = newValue;
                    // });
                  },
                  items: expenseData.map((value) {
                    expenseValue = value;
                    return DropdownMenuItem(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList()),
            )),
          ),
        ),
      ),
    );
  }

  Widget travelApproveDropdown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelRequestListResponse>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Approve Travel List",
                              )),
                          value: controller.selectedApproveList,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelRequestListResponse  ?value) {
                            controller
                                .onChangeTravelExpenseApproveDropdown(value!);
                          },
                          items: controller.travel_expense_approve_list
                              .map((TravelRequestListResponse travel) {
                            return DropdownMenuItem<TravelRequestListResponse>(
                              value: travel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  travel.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseCategoryDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseCategory>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedExpenseCategory,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseCategory ? value) {
                            controller.onChangeExpenseCategoryDropdown(value!);
                          },
                          items: controller.travel_expense_category_list
                              .map((TravelExpenseCategory travel) {
                            return DropdownMenuItem<TravelExpenseCategory>(
                              value: travel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  travel.display_name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseProductDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseProduct>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedExpenseProduct,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseProduct ? value) {
                            print(value!.name);
                            print(value.id);
                            controller.onChangeExpenseProductDropdown(value);
                          },
                          items: controller.travel_expense_product_list
                              .map((TravelExpenseProduct product) {
                            return DropdownMenuItem<TravelExpenseProduct>(
                              value: product,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  product.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget dateWidget(
  //     BuildContext context,
  //     ) {
  //   var date_controller;
  //   date_controller = controller.expenseDateController;
  //   return Container(
  //     child: Column(children: <Widget>[
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             flex: 3,
  //             child: InkWell(
  //               onTap: () {
  //                 _selectDate(context);
  //               },
  //               child: Container(
  //                 height: 50,
  //                 child: TextField(
  //                   enabled: false,
  //                   keyboardType: TextInputType.visiblePassword,
  //                   textInputAction: TextInputAction.none,
  //                   controller: date_controller,
  //                   decoration: InputDecoration(
  //                       hintText: "Expense Date", border: OutlineInputBorder()),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ]),
  //   );
  // }

  Widget dateWidget(
      BuildContext context,
      ) {
    var date_controller;
    date_controller = controller.expenseDateController;
    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  height: 50,
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.none,
                    controller: date_controller,
                    decoration: InputDecoration(
                        hintText: "Expense Date", border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  // Widget dateWidget(BuildContext context) {
  //   var date_controller;
  //   date_controller = controller.expenseDateController;
  //   final labels = AppLocalizations.of(context);
  //   final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  //   return Container(
  //     // margin: EdgeInsets.only(left: 10, right: 10, top: 10),
  //     child: Column(children: <Widget>[
  //       // Text('Basic date & time field (${format.pattern})'),
  //       DateTimeField(
  //           controller: date_controller,
  //           decoration: InputDecoration(
  //             hintText: labels.expenseDate,
  //             border: OutlineInputBorder(),
  //           ),
  //           format: format,
  //           onShowPicker: (context, currentValue) async {
  //             controller
  //                 .getOneTravelApprove(controllerList
  //                     .travelExpenseList.value[index].travel_id.id)
  //                 .then((value) async {
  //               final date = await showDatePicker(
  //                 context: context,
  //                 // firstDate: DateTime.now(),
  //                 // initialDate: currentValue ?? DateTime.now(),
  //                 // lastDate: DateTime(2200)
  //                 initialDate:
  //                     DateTime.parse(controller.from_travel_date.value),
  //                 firstDate: DateTime.parse(controller.from_travel_date.value),
  //                 lastDate: DateTime.parse(controller.to_travel_date.value),
  //               );
  //               if (date != null) {
  //                 final time = await showTimePicker(
  //                   context: context,
  //                   initialTime:
  //                       TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //                 );
  //                 var date_time = DateTimeField.combine(date, time)
  //                     .toString()
  //                     .split('.000')[0];
  //                 selectedFromDate = DateTime.parse(date_time);
  //                 controller.expenseDateController.text = date_time.toString();

  //                 return DateTimeField.combine(date, time);
  //               }
  //             });
  //           }),
  //     ]),
  //   );
  // }

  Widget expenseListWidget(BuildContext context) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> remark_controllers;
    List<TextEditingController> total_amount_controllers;
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controllerList
                .travelExpenseList.value[index].travel_line.length,
            itemBuilder: (BuildContext context, int pos) {
              fields = datalist.length;
              print("Out of pocket");
              print(datalist);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: 80,
                            child: Text(controllerList.travelExpenseList
                                .value[index].travel_line[pos].date
                                .toString()),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            // width: 80,
                            child: controllerList.travelExpenseList.value[index]
                                        .travel_line[pos].product_id.name
                                        .toString() ==
                                    ""
                                ? Text("TTTT")
                                : Text(
                                    controllerList
                                        .travelExpenseList
                                        .value[index]
                                        .travel_line[pos]
                                        .product_id
                                        .name
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            // width: 80,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(
                                    controllerList
                                        .travelExpenseList
                                        .value[index]
                                        .travel_line[pos]
                                        .price_subtotal
                                        .toString())),
                                textAlign: TextAlign.right),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              // margin: EdgeInsets.only(left: 30),
                              // width: 70,
                              child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  controllerList.travelExpenseList.value[index]
                                      .travel_line
                                      .removeAt(
                                          pos); //  controller.removeRow(index);
                                },
                              ),
                              controllerList.travelExpenseList.value[index]
                                      .travel_line[pos].product_id
                                      .toString()
                                      .isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.attachment),
                                      onPressed: () {},
                                    )
                                  : SizedBox()
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ));
  }

  // Future<Null> _selectDate(BuildContext context) async {
  //   // var start = controller.from_travel_date;
  //   // var end = controller.to_travel_date;
  //   // var start_year = int.tryParse(start.toString().split("-")[0]);
  //   // var start_month = int.tryParse(start.toString().split("-")[1]);
  //   // var start_day = int.tryParse(start.toString().split("-")[2]);

  //   // var end_year = int.tryParse(end.toString().split("-")[0]);
  //   // var end_month = int.tryParse(end.toString().split("-")[1]);
  //   // var end_day = int.tryParse(end.toString().split("-")[2]);
  //   controller
  //       .getOneTravelApprove(
  //           controllerList.travelExpenseList.value[index].travel_id.id)
  //       .then((value) async {
  //     final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.parse(controller.from_travel_date.value),
  //       firstDate: DateTime.parse(controller.from_travel_date.value),
  //       lastDate: DateTime.parse(controller.to_travel_date.value),
  //       builder: (BuildContext context, Widget child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //             dialogBackgroundColor: Colors.white,
  //             colorScheme: ColorScheme.light(
  //               primary: const Color.fromRGBO(60, 47, 126, 1),
  //             ),
  //             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //             highlightColor: Colors.grey[400],
  //             textSelectionColor: Colors.grey,
  //           ),
  //           child: child,
  //         );
  //       },
  //     );
  //     if (picked != null) {
  //       selectedFromDate = picked;
  //       controller.expenseDateController.text =
  //           ("${selectedFromDate.toLocal()}".split(' ')[0]);
  //       var formatter = new DateFormat('yyyy-MM-dd');
  //       controller.expenseDateController.text = formatter.format(picked);
  //     }
  //   });
  // }

   Future<Null> _selectDate(BuildContext context) async {
    // var start = controller.from_travel_date;
    // var end = controller.to_travel_date;
    // var start_year = int.tryParse(start.toString().split("-")[0]);
    // var start_month = int.tryParse(start.toString().split("-")[1]);
    // var start_day = int.tryParse(start.toString().split("-")[2]);

    // var end_year = int.tryParse(end.toString().split("-")[0]);
    // var end_month = int.tryParse(end.toString().split("-")[1]);
    // var end_day = int.tryParse(end.toString().split("-")[2]);
    controller.getOneTravelApprove(controllerList.travelExpenseList.value[index].travel_id.id).then((value) async{
      final DateTime ? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(controller.from_travel_date.value),
        firstDate: DateTime.parse(controller.from_travel_date.value),
        lastDate: DateTime.parse(controller.to_travel_date.value),
        builder: (BuildContext context, Widget ? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              dialogBackgroundColor: Colors.white,
              colorScheme: ColorScheme.light(
                primary: const Color.fromRGBO(60, 47, 126, 1),
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              highlightColor: Colors.grey[400],
              // textSelectionColor: Colors.grey,
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        selectedFromDate = picked;
        controller.expenseDateController.text =
        ("${selectedFromDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.expenseDateController.text = formatter.format(picked);
      }
    }
    );
  }

  List<TravelLineModel> travelLine = [];
  @override
  Widget build(BuildContext context) {
    if(Get.arguments== null){
      imgIndex = 0;
    }else{
      imgIndex = Get.arguments;
    }
    
    //Globals.ph_hardware_back.value = true;
    final labels = AppLocalizations.of(context);
    // index = Get.arguments;
    // controllerList.travelExpenseList.value[index].travel_line.forEach((element) {
    //   travelLine.add(TravelLineModel(id:element.id,date:element.date,categ_id: element.categ_id.id,expense_category: element.product_id.name,product_id: element.product_id.id,description: element.description,qty: element.qty,price_unit: element.price_unit,price_subtotal: element.price_subtotal,attached_file: element.attached_file,attached_filename: element.attachment_filename,vehicle_id: element.vehicle_id.id,
    //     image1: element.image1,image2: element.image2,image3: element.image3,image4: element.image4,image5: element.image5,image6: element.image6,image7: element.image7,image8: element.image8,image9: element.image9));
    // });
    // controller.travelLineModel.value = travelLine;
    // image = box.read('emp_image');
    //return new WillPopScope(
    // onWillPop: () async{
    //   if(Globals.ph_hardware_back.value){
    //     return Future.value(true);
    //   }else{
    //     return Future.value(false);
    //   }
    // },
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(preferredSize: Size.fromHeight(60), child: appbar(context, "Travel Expense Form", image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controllerList
                        .travelExpenseList.value[index].travel_id.name,
                    style: TextStyle(fontSize: 20),
                  )), // travelApproveDropdown()
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: controllerList.travelExpenseList.value[index]
                                    .payment_amount >
                                0.0
                            ? Text(
                                '${labels?.total} Actual Amount : ${NumberFormat('#,###').format(controllerList.travelExpenseList.value[index].payment_amount)}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.deepPurple),
                              )
                            : SizedBox()),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context),
                        )),
                  ),
                  // Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  //       child: expenseCategoryDropDown()),
                  // ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: expenseCategoryDropDown()),
              SizedBox(
                height: 10,
              ),
              expenseProductDropDown(),
              Obx(() =>
                  controller.selectedExpenseCategory.is_vehicle_selected == true
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: vehicleDropDown())
                      : SizedBox()),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            controller: controller.qtyController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: labels?.quantity),
                            onChanged: (text) {
                              controller.calculateAmount();
                            },
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            enabled: false,
                            controller: controller.priceController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: labels?.unitPrice,
                            ),
                            onChanged: (text) {
                              controller.calculateAmount();
                            },
                          ),
                        )),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      controller: controller.totalAmountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: labels?.amount,
                      ),
                      onChanged: (text) {
                        // setState(() {});
                        controller.calculateUnitAmount();
                      },
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: labels?.description,
                      ),
                      onChanged: (text) {
                        // setState(() {});
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print("Image File");
                          // loadAssets();
                          showOptions(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(),
                            child: Container(
                                decoration:
                                    BoxDecoration(color: textFieldTapColor),
                                height: 45,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30,
                                ))),
                      ),
                    ),
                    //_decideImageView(),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: controller.selectedImage.value != null &&
                        selectCamera == true
                    ?
                    // Row(
                    //   children: [
                    //     Expanded(
                    //         flex: 2,
                    //         child:Image.file(
                    //             controller.selectedImage.value,
                    //             width: 150,
                    //             height: 150)),
                    //     Expanded(
                    //       flex: 1,
                    //       child: InkWell(
                    //           onTap: () {
                    //             nullPhoto();
                    //           },
                    //           child: Icon(
                    //             Icons.close,
                    //             color: Colors.red,
                    //           )),
                    //     )
                    //   ],
                    // ):SizedBox.fromSize(),
                    Row(
                        children: [
                          Stack(
                            children: [
                              Image.file(controller.selectedImage.value,
                                  width: 150, height: 150),
                              Positioned(
                                top: 0,
                                right: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      nullPhoto();
                                    });
                                  },
                                  child: Icon(Icons.close, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox.fromSize(),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: imageGridView(),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.is_show_expense.value
                    ? Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: GFButton(
                          onPressed: () {
                            if (controller.expenseDateController.text
                                .toString()
                                .isEmpty) {
                              AppUtils.showDialog(
                                  'Warning!', 'Choose expense date!');
                            } else {
                              // if(DateTime.parse(controller.expenseDateController.text).isAfter(DateTime.now()))
                              // {
                              //   AppUtils.showDialog(
                              //       'Warning!', 'The selected expense date is greater than today');
                              //
                              // }
                              // else {
                              //   controller.addTravelLine();
                              //
                              // }
                              controller.addTravelLine(image_64);
                              setState(() {
                                selectCamera = false;
                                controller.selectedImage.value = File('');
                                images.clear();
                                image_64.clear();
                              });
                            }
                          },
                          text: "Add Expense Line",
                          color: textFieldTapColor,
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          shape: GFButtonShape.pills,
                          blockButton: true,
                        ),
                      )
                    : new Container(),
              ),
              Divider(
                thickness: 1,
              ),
              Obx(
                () => controller.travelLineModel.length > 0
                    ? expenseTitleWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.travelLineModel.length > 0
                    ? expenseWidget(context, imgIndex)
                    : new Container(),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: controller.totalAdvanceAmount.value > 0.0
                            ? Text(
                                '${labels?.total} Amount : ${NumberFormat('#,###').format(controller.totalAmountForExpense)}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.deepPurple),
                              )
                            : SizedBox()),
                  )),
              Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
                    onPressed: () {
                      controller.updateTravelLineExpense(
                          controllerList.travelExpenseList.value[index].id,
                          controllerList
                              .travelExpenseList.value[index].travel_id.id,
                          controllerList.travelExpenseList.value[index].number,
                          context);
                    },
                    child: Text(
                      ("Update"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
    //);
  }

  Widget attachmentGridView(TravelLineModel travelLineModel) {
    var image_array = [];
    print(controller.travelLineModel[index].image1);
    print(controller.travelLineModel[index].image2);
    if (travelLineModel.attached_file != null &&
        travelLineModel.attached_file.isNotEmpty) {
      image_array.add(travelLineModel.attached_file);
    }
    if (travelLineModel.image1 != null && travelLineModel.image1.isNotEmpty) {
      image_array.add(travelLineModel.image1);
    }
    if (travelLineModel.image2 != null && travelLineModel.image2.isNotEmpty) {
      image_array.add(travelLineModel.image2);
    }
    if (controller.travelLineModel[index].image3 != null &&
        travelLineModel.image3.isNotEmpty) {
      image_array.add(travelLineModel.image3);
    }
    if (travelLineModel.image4 != null && travelLineModel.image4.isNotEmpty) {
      image_array.add(travelLineModel.image4);
    }
    if (travelLineModel.image5 != null && travelLineModel.image5.isNotEmpty) {
      image_array.add(travelLineModel.image5);
    }
    if (travelLineModel.image6 != null && travelLineModel.image6.isNotEmpty) {
      image_array.add(travelLineModel.image6);
    }
    if (travelLineModel.image7 != null && travelLineModel.image7.isNotEmpty) {
      image_array.add(travelLineModel.image7);
    }
    if (travelLineModel.image8 != null && travelLineModel.image8.isNotEmpty) {
      image_array.add(travelLineModel.image8);
    }
    if (travelLineModel.image9 != null && travelLineModel.image9.isNotEmpty) {
      image_array.add(travelLineModel.image9);
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(image_array.length, (index) {
        Uint8List ?bytes1;
        if (image_array[index] != null) {
          bytes1 = base64Decode(image_array[index]);
        }
        var label = index + 1;
        return Column(
          children: [
            bytes1 == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 80,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
                : new Image.memory(
                    bytes1,
                    fit: BoxFit.fitWidth,
                    width: 100,
                    height: 100,
                  ),
            Text('Image ' + label.toString()),
          ],
        );
      }),
    );
  }

  Widget imageGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Stack(
          children: [
            AssetThumb(
              asset: asset,
              width: 200,
              height: 200,
            ),
            Positioned(
              top: 0,
              right: 5,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                      attachFilePath();
                    });
                  },
                  child: Icon(Icons.close, color: Colors.red)),
            ),
          ],
        );
      }),
    );
  }

  loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        // maxImages: 10,
        // enableCamera: true,
        selectedAssets: images,
        // cupertinoOptions: CupertinoOptions(
        //   takePhotoIcon: "chat",
        //   doneButtonTitle: "Fatto",
        // ),
        // materialOptions: MaterialOptions(
        //   actionBarColor: "#abcdef",
        //   actionBarTitle: "Example App",
        //   allViewTitle: "All Photos",
        //   useDetailsView: false,
        //   selectCircleStrokeColor: "#000000",
        // ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      controller.isShowImage.value = true;
      _error = error;
      attachFilePath();
    });
  }

  Widget expenseTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Text(
                ("Date"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // width: 80,
              child: Text(
                ("Expense Title"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                ("Amount"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                // margin: EdgeInsets.only(left: 30),
                // width: 70,

                ),
          ),
        ],
      ),
    );
  }

  Widget expenseWidget(BuildContext context, int imgIndex) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> remark_controllers;
    List<TextEditingController> total_amount_controllers;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.travelLineModel.length,
        itemBuilder: (BuildContext context, int index) {
          fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: controller.travelLineModel[index].date != null
                            ? Text(
                                controller.travelLineModel[index].date
                                  .toString()
                                  .substring(5))
                                // controller.travelLineModel[index].date.toString().substring(5).split(" ")[0])
                                // DateTime.parse(
                                //         controller.travelLineModel[index].date)
                                //     .add(Duration(hours: 6, minutes: 30))
                                //     .toString()
                                //     .replaceAll('.000', ''))
                            : Text(''),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        // width: 80,
                        child: Text(controller
                            .travelLineModel[index].expense_category
                            .toString()),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        // width: 80,
                        child: Text(controller
                            .travelLineModel[index].price_subtotal
                            .toString()),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                          // margin: EdgeInsets.only(left: 30),
                          // width: 70,
                          child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                controller.setEditExpenseLine(
                                    controller.travelLineModel[index]);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _travelExpenseLineEdit(context, index,
                                          controller.travelLineModel[index]),
                                );
                              }),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.removeRow(
                                  index, controller.travelLineModel[index].id);
                            },
                          ),
                          controller.travelLineModel[index]
                                          .attachment_include !=
                                      null &&
                                  controller
                                      .travelLineModel[index].attachment_include
                              ? IconButton(
                                  icon: Icon(Icons.attach_file_outlined),
                                  onPressed: () {
                                    attachController
                                        .findExpenseImage(attachController
                                            .travelExpenseList
                                            .value[imgIndex]
                                            .travel_line[index]
                                            .id)
                                        .then((value) async {
                                      if (value.length > 0) {
                                        attachmentBottomSheetImage(
                                            context, value);
                                      } else {
                                        AppUtils.showToast("No Attachment");
                                      }
                                    });
                                  },
                                )
                              : SizedBox()
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _travelExpenseLineEdit(
      BuildContext context, int index, TravelLineModel travelLine) {
    final labels = AppLocalizations.of(context);
    return new AlertDialog(
      title: const Text('Expense Line Form'),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 120,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[350]),
              child: Center(
                child: Text(
                  "Can update other fields except photo attachment. If you want to edit photo, you can delete travel expense line and then add again.",
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: dateWidgetEdit(context, travelLine),
                      )),
                ),
              ],
            ),
            controller.edit_travel_expense_category_list.length > 0
                ? Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: expenseEditCategoryDropDown())
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Obx(() =>
                controller.edit_travel_expense_product_list.value.length > 0
                    ? expenseEditProductDropDown()
                    : SizedBox()),
            Obx(() =>
                controller.selectedEditExpenseCategory.is_vehicle_selected ==
                        true
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        child: editVehicleDropDown())
                    : SizedBox()),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          controller: controller.editQtyController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: labels?.quantity),
                          onChanged: (text) {
                            controller.editCalculateAmount();
                          },
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          enabled: false,
                          controller: controller.editPriceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: labels?.unitPrice,
                          ),
                          onChanged: (text) {
                            controller.editCalculateAmount();
                          },
                        ),
                      )),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: textFieldTapColor,
                  ),
                  child: TextField(
                    controller: controller.editTotalAmountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: labels?.amount,
                    ),
                    onChanged: (text) {
                      // setState(() {});
                      controller.editCalculateUnitAmount();
                    },
                  ),
                )),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: textFieldTapColor,
                  ),
                  child: TextField(
                    controller: controller.editDescriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: labels?.description,
                    ),
                    onChanged: (text) {
                      // setState(() {});
                    },
                  ),
                )),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
            onPressed: () {
              if (imgIndex != null) {
                if (controller.travelLineModel[index].attachment_include !=
                        null &&
                    controller.travelLineModel[index].attachment_include) {
                  attachController
                      .findExpenseImage(attachController.travelExpenseList
                          .value[imgIndex].travel_line[index].id)
                      .then((value) async {
                    controller.updateExpenseLine(index, travelLine, value);
                    Navigator.of(context).pop();
                  });
                } else {
                  controller.updateExpenseLine1(index, travelLine);
                  Navigator.of(context).pop();
                }
              } else {
                controller.updateExpenseLine1(index, travelLine);
                Navigator.of(context).pop();
              }
            },
            child: Text(
              (labels!.update),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget editVehicleDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<Fleet_model>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Vehicle",
                              )),
                          value: controller.selectedEditVehicle,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Fleet_model ?value) {
                            print(value!.name);
                            print(value.id);
                            controller.onChangeEditVehicleDropdown(value);
                          },
                          items:
                              controller.fleetList.map((Fleet_model vehicle) {
                            return DropdownMenuItem<Fleet_model>(
                              value: vehicle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  vehicle.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseEditProductDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseProduct>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedEditExpenseProduct,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseProduct? value) {
                            print(value!.name);
                            print(value.id);
                            controller
                                .onChangeEditExpenseProductDropdown(value);
                          },
                          items: controller.edit_travel_expense_product_list
                              .map((TravelExpenseProduct product) {
                            return DropdownMenuItem<TravelExpenseProduct>(
                              value: product,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  product.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseEditCategoryDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseCategory>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedEditExpenseCategory,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseCategory ? value) {
                            controller
                                .onChangeEditExpenseCategoryDropdown(value!);
                          },
                          items: controller.edit_travel_expense_category_list
                              .map((TravelExpenseCategory travel) {
                            return DropdownMenuItem<TravelExpenseCategory>(
                              value: travel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  travel.display_name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget dateWidgetEdit(BuildContext context, TravelLineModel travelLine) {
  //   var date_controller;
  //   date_controller = controller.expenseUpdateDateController;
  //   return Container(
  //     child: Column(children: <Widget>[
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             flex: 3,
  //             child: InkWell(
  //               onTap: () {
  //                 _selectDateEdit(context, index);
  //               },
  //               child: Container(
  //                 height: 50,
  //                 child: TextField(
  //                   enabled: false,
  //                   keyboardType: TextInputType.visiblePassword,
  //                   textInputAction: TextInputAction.none,
  //                   controller: date_controller,
  //                   decoration: InputDecoration(
  //                       hintText: "Expense Date", border: OutlineInputBorder()),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ]),
  //   );
  // }

  Widget dateWidgetEdit(
      BuildContext context,TravelLineModel travelLine
      ) {
    var date_controller;
    date_controller = controller.expenseUpdateDateController;
    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  _selectDateEdit(context,index);
                },
                child: Container(
                  height: 50,
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.none,
                    controller: date_controller,
                    decoration: InputDecoration(
                        hintText: "Expense Date", border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  // Future<Null> _selectDateEdit(BuildContext context, int index) async {
  //   controller
  //       .getOneTravelApprove(
  //           controllerList.travelExpenseList.value[index].travel_id.id)
  //       .then((value) async {
  //     final date = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.parse(controller.from_travel_date.value),
  //       firstDate: DateTime.parse(controller.from_travel_date.value),
  //       lastDate: DateTime.parse(controller.to_travel_date.value),
  //     );
  //     if (date != null) {
  //       final time = await showTimePicker(
  //         context: context,
  //         initialTime:   TimeOfDay.fromDateTime(DateTime.now()),
  //       );
  //       var date_time =
  //           DateTimeField.combine(date, time).toString().split('.000')[0];
  //       selectedUpdateFromDate = DateTime.parse(date_time);
  //       controller.expenseDateController.text = date_time.toString();
  //       controller.expenseUpdateDateController.text = date_time.toString();

  //       return DateTimeField.combine(date, time);
  //     }
  //     // final DateTime picked = await showDatePicker(
  //     //   context: context,
  //     //   initialDate: DateTime.parse(controller.from_travel_date.value),
  //     //   firstDate: DateTime.parse(controller.from_travel_date.value),
  //     //   lastDate: DateTime.parse(controller.to_travel_date.value),
  //     //   builder: (BuildContext context, Widget child) {
  //     //     return Theme(
  //     //       data: ThemeData.light().copyWith(
  //     //         dialogBackgroundColor: Colors.white,
  //     //         colorScheme: ColorScheme.light(
  //     //           primary: const Color.fromRGBO(60, 47, 126, 1),
  //     //         ),
  //     //         buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //     //         highlightColor: Colors.grey[400],
  //     //         textSelectionColor: Colors.grey,
  //     //       ),
  //     //       child: child,
  //     //     );
  //     //   },
  //     // );
  //     // if (picked != null) {
  //     //   selectedUpdateFromDate = picked;
  //     //   controller.expenseUpdateDateController.text =
  //     //   ("${selectedUpdateFromDate.toLocal()}".split(' ')[0]);
  //     //   var formatter = new DateFormat('yyyy-MM-dd');
  //     //   controller.expenseUpdateDateController.text = formatter.format(picked);
  //     //   //controller.travelLineModel[index].date = formatter.format(picked);
  //     // }
  //   });
  // }

  Future<Null> _selectDateEdit(BuildContext context,int index) async {
    controller.getOneTravelApprove(controllerList.travelExpenseList.value[index].travel_id.id).then((value) async{
      final DateTime ? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(controller.from_travel_date.value),
        firstDate: DateTime.parse(controller.from_travel_date.value),
        lastDate: DateTime.parse(controller.to_travel_date.value),
        builder: (BuildContext context, Widget ?child) {
          return Theme(
            data: ThemeData.light().copyWith(
              dialogBackgroundColor: Colors.white,
              colorScheme: ColorScheme.light(
                primary: const Color.fromRGBO(60, 47, 126, 1),
              ),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              highlightColor: Colors.grey[400],
              // textSelectionColor: Colors.grey,
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        selectedUpdateFromDate = picked;
        controller.expenseUpdateDateController.text =
        ("${selectedUpdateFromDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.expenseUpdateDateController.text = formatter.format(picked);
        //controller.travelLineModel[index].date = formatter.format(picked);
      }
    }
    );
  }

  dynamic attachmentBottomSheet(
      BuildContext context, TravelLineModel travelLineModel) {
    dynamic attachmentBottomSheet(
        BuildContext context, TravelLineModel travelLineModel) {
      return showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Container(
                color: Color(0xff757575),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.close_outlined),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        attachmentGridView(travelLineModel),
                      ],
                    ),
                  ),
                ),
              ));
    }

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.close_outlined),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      attachmentGridView(travelLineModel),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget vehicleDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<Fleet_model>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Vehicle",
                              )),
                          value: controller.selectedVehicle,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Fleet_model ? value) {
                            print(value!.name);
                            print(value.id);
                            controller.onChangeVehicleDropdown(value);
                          },
                          items:
                              controller.fleetList.map((Fleet_model vehicle) {
                            return DropdownMenuItem<Fleet_model>(
                              value: vehicle,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  vehicle.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  attachFilePath() async {
    if (images.length > 0) {
      if (selectCamera == false) image_64.clear();
      for (var i = 0; i < images.length; i++) {
        final byteData = await images[i].getByteData();
        final tempFile =
            File("${(await getTemporaryDirectory()).path}/${images[i].name}");
        final file = await tempFile.writeAsBytes(
          byteData.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        );
        File compressedFile = await AppUtils.reduceImageFileSize(file);
        final bytes = Io.File(compressedFile.path).readAsBytesSync();
        String base64Encode(List<int> bytes) => base64.encode(bytes);
        String encoded_image = base64Encode(bytes);
        image_64.add(encoded_image);
      }
    }
  }

  dynamic attachmentBottomSheetImage(BuildContext context, List<String> value) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.close_outlined),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        attachmentGridViewImage(value, context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget attachmentGridViewImage(List<String> value, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(value.length, (index) {
        Uint8List ? bytes1;
        if (value[index] != null) {
          bytes1 = base64Decode(value[index]);
        }
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Align(
            child: InkWell(
              onTap: () async {
                print("bytes11 >>" + bytes1.toString());
                await showDialog(
                    context: context,
                    builder: (_) => Container(
                          height: 200,
                          child: ImageDialog(
                            bytes: bytes1,
                          ),
                        ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: new Image.memory(
                  base64Decode(value[index]),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
