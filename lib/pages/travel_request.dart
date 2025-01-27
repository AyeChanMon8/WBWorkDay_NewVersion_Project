// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/travel_request_controller.dart';
// import '../localization.dart';
import '../models/travel_expense.dart';
import '../models/travel_expense_category.dart';
import '../models/travel_expense_response.dart';
import '../models/travel_line.dart';
import '../models/travel_request_list_response.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:getwidget/getwidget.dart';
import '../pages/pre_page.dart';
import 'package:intl/intl.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravelRequest extends StatelessWidget {
  final TravelRequestController controller = Get.put(TravelRequestController());
  final _formKey = GlobalKey<FormState>();
  final _formKeyParent = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());
  DateTime selectedDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final formatTime = DateFormat("HH:mm:ss");
  final timeFormat = TimeOfDay.now();
  var numberFormat = NumberFormat('#,###.#');
  final box = GetStorage();
  String purpose = '';
  String destination = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.travelRequest,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKeyParent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context, 'From Date'),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context, 'To Date'),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            controller: controller.fromPlaceTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: labels?.from,
                            ),
                            onChanged: (text) {
                              controller.updateTravelineDestination();
                            },
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            controller: controller.toPlaceController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: labels?.to,
                            ),
                            onChanged: (text) {
                              controller.updateTravelineDestination();
                            },
                          ),
                        )),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: textFieldTapColor,
                  ),
                  child: TextField(
                    enabled: false,
                    controller: controller.durationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: labels?.duration,
                    ),
                    onChanged: (text) {},
                  ),
                ),
              ),
              // travelTypeDropDown(),
              SizedBox(
                height: 20,
              ),

              //travelWidget(context),
              // Obx(() => controller.is_show_auto_generate.value
              //     ? GFButton(
              //         onPressed: () {
              //           if (selectedFromDate != null &&
              //               selectedToDate != null &&
              //               controller
              //                   .fromPlaceTextController.text.isNotEmpty &&
              //               controller.toPlaceController.text.isNotEmpty) {
              //             saveTraveLineData();
              //           } else {
              //             AppUtils.showToast('Please Fill All Required Data!');
              //           }
              //         },
              //         text: "Auto Generate Data",
              //         blockButton: true,
              //         size: GFSize.LARGE,
              //       )
              //     : new Container()),
              // SizedBox(
              //   height: 30,
              // ),
              Obx(
                () => controller.is_show_auto_generate.value
                    ? GFButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    // overflow: Overflow.visible,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              dateWidget(context, 'Date'),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: TextField(
                                                  controller: controller
                                                      .destinationTextController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        ((labels.description)),
                                                  ),
                                                  onChanged: (text) {},
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: TextField(
                                                  controller: controller
                                                      .purposeTextController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        ((labels.purpose)),
                                                  ),
                                                  onChanged: (text) {},
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14.0),
                                                child: GFButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                    saveTraveline();
                                                  },
                                                  text: "Add",
                                                  blockButton: true,
                                                  size: GFSize.LARGE,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        text: labels.addAdvanceLine,
                        color: textFieldTapColor,
                        icon: Icon(
                          Icons.add,
                          color: white,
                        ),
                        shape: GFButtonShape.pills,
                        blockButton: true,
                      )
                    : new Container(),
              ),

              Obx(
                () => controller.travelLineList.length > 0
                    ? travelTitleWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              // Divider(
              //   thickness: 1,
              // ),
              SizedBox(
                height: 10,
              ),
              travelWidget(context),
              SizedBox(
                height: 20,
              ),

              Obx(
                () => controller.is_show_expense.value
                    ? GFButton(
                        onPressed: () {
                          controller.quantityTextController.text = "1";
                          controller.unitPriceController.text = "";
                          controller.amountController.text = "";
                          controller.remarkTextController.text = "";
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    // overflow: Overflow.visible,
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Positioned(
                                        right: -40.0,
                                        top: -40.0,
                                        child: InkResponse(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              expenseCategoryDropDown(),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        child: Theme(
                                                          data: new ThemeData(
                                                            primaryColor:
                                                                textFieldTapColor,
                                                          ),
                                                          child: TextField(
                                                            controller: controller
                                                                .quantityTextController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText: labels
                                                                  ?.quantity,
                                                            ),
                                                            onChanged: (text) {
                                                              controller
                                                                  .calculateAmount();
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10, top: 10),
                                                        child: Theme(
                                                          data: new ThemeData(
                                                            primaryColor:
                                                                textFieldTapColor,
                                                          ),
                                                          child: TextField(
                                                            controller: controller
                                                                .unitPriceController,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText: labels
                                                                  ?.unitPrice,
                                                            ),
                                                            onChanged: (text) {
                                                              controller
                                                                  .calculateAmount();
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Theme(
                                                  data: new ThemeData(
                                                    primaryColor:
                                                        textFieldTapColor,
                                                  ),
                                                  child: TextField(
                                                    enabled: false,
                                                    controller: controller
                                                        .amountController,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: labels?.amount,
                                                    ),
                                                    onChanged: (text) {},
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Theme(
                                                    data: new ThemeData(
                                                      primaryColor:
                                                          textFieldTapColor,
                                                    ),
                                                    child: TextField(
                                                      controller: controller
                                                          .remarkTextController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText:
                                                            labels?.remark,
                                                      ),
                                                      onChanged: (text) {},
                                                    ),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14.0),
                                                child: GFButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                    Navigator.of(context).pop();
                                                    controller.addExpenseLine();
                                                  },
                                                  text: "Add",
                                                  blockButton: true,
                                                  size: GFSize.LARGE,
                                                  color: textFieldTapColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        text: labels.addAdvanceLine,
                        color: textFieldTapColor,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        shape: GFButtonShape.pills,
                        blockButton: true,
                      )
                    : new Container(),
              ),
              Divider(
                thickness: 1,
              ),
              Obx(
                () => controller.expenseList.length > 0
                    ? expenseTitleWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              expenseWidget(context),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: Obx(() => Text(
                            '${labels?.total} Amount : ${numberFormat.format(controller.totalAmount.value)}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepPurple),
                          )))),

              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: controller.save_btn_show.value
                        ? GFButton(
                            color: textFieldTapColor,
                            onPressed: () {
                              if (controller.checkIsNotEmptyDestination()) {
                                if (controller.checkIsNotEmptyPurpose()) {
                                  if (controller.expenseList.length == 0) {
                                    showAlertDialog(context);
                                  } else {
                                    if (_formKeyParent.currentState!
                                        .validate()) {
                                      controller.requestTravelRequest(
                                          controller.durationController.text);
                                    }
                                  }
                                } else {
                                  AppUtils.showDialog(
                                      'Warning!', 'Purpose is require.');
                                }
                              } else {
                                AppUtils.showDialog(
                                    'Warning!', 'Desination is require.');
                              }
                            },
                            text: labels.save,
                            blockButton: true,
                            size: GFSize.LARGE,
                          )
                        : new Container(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: controller.submit_btn_show.value
                        ? GFButton(
                            color: textFieldTapColor,
                            onPressed: () {},
                            text: "Submit",
                            blockButton: true,
                            size: GFSize.LARGE,
                          )
                        : new Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    var message = "Are you sure to save?There is no expense!";

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Save"),
      onPressed: () {
        Navigator.of(context).pop();
        controller.requestTravelRequest(controller.durationController.text);
      },
    ); //
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text(message),
      actions: [
        continueButton,
        cancelButton,
      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget expenseTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                ("Expense Category"),
                style: subtitleStyle(),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     child: Text(
          //       ("Quantity"),
          //       style: subtitleStyle(),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     // color: Colors.red,
          //     margin: EdgeInsets.only(left: 25),
          //     // width: 70,
          //     child: Text(
          //       ("Unit Price"),
          //       style: subtitleStyle(),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
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
            flex: 1,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                ("Remark"),
                style: subtitleStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget expenseWidget(BuildContext context) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> remark_controllers;
    List<TextEditingController> total_amount_controllers;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.expenseList.length,
            itemBuilder: (BuildContext context, int index) {
              fields = controller.expenseList.length;
              var f = new NumberFormat.currency(name: '', decimalDigits: 0);
              //create dynamic destination textfield controller
              remark_controllers = List.generate(
                  fields,
                  (index) => TextEditingController(
                      text: controller.expenseList[index].remark));

              total_amount_controllers = List.generate(
                  fields,
                  (index) => TextEditingController(
                      text:
                          '${f.format(controller.expenseList[index].total_amount)}'));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller
                                .expenseList[index].expense_name
                                .toString()),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextField(
                              enabled: false,
                              controller: total_amount_controllers[index],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextField(
                              controller: remark_controllers[index],
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                //controller.updateTravelLinePurpose(index, text);
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteExpenseLine(
                                controller.expenseList[index]);
                          },
                        )
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
          )),
    );
  }

  Widget travelTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: 30),
            // width: 80,
            child: Text(
              ("Date"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              ("Day off"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            // color: Colors.red,
            margin: EdgeInsets.only(left: 25),
            // width: 70,
            child: Text(
              ("Destination"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(left: 30),
            // width: 70,
            child: Text(
              ("Purpose"),
              style: subtitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget travelWidget(BuildContext context) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> destination_controllers;
    List<TextEditingController> purpose_controllers;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.travelLineList.length,
            itemBuilder: (BuildContext context, int index) {
              fields = controller.travelLineList.length;
              //create dynamic destination textfield controller
              destination_controllers = List.generate(
                  fields,
                  (index) => TextEditingController(
                      text: controller.travelLineList[index].destination));
              //create dynamic purpose textfield controller
              purpose_controllers = List.generate(
                  fields,
                  (index) => TextEditingController(
                      text: controller.travelLineList[index].purpose));
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
                            child: Text(controller.travelLineList[index].date),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                      isExpanded: true,
                                      value:
                                          controller.travelLineList[index].full
                                              ? 1
                                              : controller.travelLineList[index]
                                                      .first
                                                  ? 2
                                                  : 3,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Full-Day"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("First-Half"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                            child: Text("Second-Half"),
                                            value: 3),
                                      ],
                                      onChanged: (value) {
                                        controller.updateTravelInterval(
                                            index, value!);
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextField(
                              controller: destination_controllers[index],
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                controller.updateTravelLineDestination(
                                    index, text);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextField(
                              controller: purpose_controllers[index],
                              enabled: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                controller.updateTravelLinePurpose(index, text);
                              },
                            ),
                          ),
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
          )),
    );
  }

  Widget dateWidget(BuildContext context, String date) {
    var date_controller;
    var labels = AppLocalizations.of(context);
    var dateLbl = "";

    if (date == 'From Date') {
      dateLbl = labels!.fromDate;
      date_controller = controller.fromDateTextController;
    } else if (date == 'To Date') {
      dateLbl = labels!.toDate;
      date_controller = controller.toDateTextController;
    } else {
      date_controller = controller.traveldateController;
    }

    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  if (date == 'To Date') {
                    if (controller.fromDateTextController.text.isNotEmpty) {
                      _selectDate(context, date);
                    } else {
                      AppUtils.showToast('Choose From Date First!');
                    }
                  } else if (date == 'From Date') {
                    _selectDate(context, date);
                  } else {
                    _selectTravelListDate(context);
                  }
                },
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.none,
                  controller: date_controller,
                  decoration: InputDecoration(
                    hintText: dateLbl,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  // static void showToast(String msg) {
  //   GFToast(
  //     text: msg,
  //     autoDismiss: true,
  //   );
  // }

  Future<Null> _selectDate(BuildContext context, String date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date == 'From Date' ? DateTime.now() : selectedFromDate,
      firstDate: date == 'From Date' ? DateTime.now() : selectedFromDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Color.fromRGBO(60, 47, 126, 1),
            datePickerTheme: const DatePickerThemeData(
                headerForegroundColor: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none),
                headerBackgroundColor: Color.fromRGBO(60, 47, 126, 1)),
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
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //     dateController.text = ("${selectedDate.toLocal()}".split(' ')[0]);
    //     var formatter = new DateFormat('dd-MM-yyyy');
    //     dateController.text = formatter.format(picked);
    //     print(dateController.text);
    //   });
    if (picked != null) {
      if (date == 'From Date') {
        selectedFromDate = picked;
        controller.fromDateTextController.text =
            ("${selectedFromDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.fromDateTextController.text = formatter.format(picked);
        if (picked.isBefore(selectedToDate)) {
          if (controller.toDateTextController.text.isNotEmpty) {
            controller.fetchTravelLine(selectedFromDate, selectedToDate);
          }
        } else {
          controller.toDateTextController.text = "";
        }
      } else {
        selectedToDate = picked;
        controller.toDateTextController.text =
            ("${selectedToDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.toDateTextController.text = formatter.format(picked);
        controller.toDateTextController.text = formatter.format(picked);
        // var formatter = new DateFormat('yyyy-MM-dd HH:mm');
        controller.fetchTravelLine(selectedFromDate, selectedToDate);
        //controller.updateAddTravelLineButtonState();
        controller.calculateinterval(selectedFromDate, selectedToDate);
      }
    }
  }

  Future<Null> _selectTravelListDate(BuildContext context) async {
    var from_year = selectedFromDate.year;
    var from_month = selectedFromDate.month;
    var from_day = selectedFromDate.day;
    var to_year = selectedToDate.year;
    var to_month = selectedToDate.month;
    var to_day = selectedToDate.day;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(from_year, from_month, from_day),
      firstDate: DateTime(from_year, from_month, from_day),
      lastDate: DateTime(to_year, to_month, to_day),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Color.fromRGBO(60, 47, 126, 1),
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
    // if (picked != null && picked != selectedDate)
    //   setState(() {
    //     selectedDate = picked;
    //     dateController.text = ("${selectedDate.toLocal()}".split(' ')[0]);
    //     var formatter = new DateFormat('dd-MM-yyyy');
    //     dateController.text = formatter.format(picked);
    //     print(dateController.text);
    //   });
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      controller.traveldateController.text =
          ("${selectedDate.toLocal()}".split(' ')[0]);
      var formatter = new DateFormat('yyyy-MM-dd');
      controller.traveldateController.text = formatter.format(picked);
    }
  }

  void saveTraveLineData() {
    controller.clearTravelLine();
    var days = getDaysInBeteween(selectedFromDate, selectedToDate);
    for (int i = 0; i < days.length; i++) {
      var dateTime = days[i].toString();
      var datevalue = dateTime.split(' ')[0];

      var travelLine = TravelLine(
          date: datevalue,
          destination: controller.fromPlaceTextController.text +
              "-" +
              controller.toPlaceController.text,
          purpose: controller.purposeTextController.text);
      controller.addTravelLine(travelLine);
    }
  }

  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  void saveExpenseLine() {
    controller.addExpenseLine();
  }

  void saveTraveline() {
    var travelLine = TravelLine(
        date: controller.traveldateController.text,
        destination: controller.destinationTextController.text,
        purpose: controller.purposeTextController.text);
    controller.addTravelLine(travelLine);
  }

  Widget expenseCategoryDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  // Border.all(color: Colors.white, width: 2),
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
                                "Expense Category",
                              )),
                          value: controller.selectedExpenseType,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseCategory? value) {
                            controller.onChangeExpenseDropdown(value!);
                          },
                          items: controller.expenseCategoryList
                              .map((TravelExpenseCategory category) {
                            return DropdownMenuItem<TravelExpenseCategory>(
                              value: category,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  category.display_name,
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
}
