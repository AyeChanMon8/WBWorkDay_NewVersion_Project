import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/expense_travel_list/out_of_pocket_list.dart';
import 'package:winbrother_hr_app/controllers/out_of_pocket_controller.dart';
import 'package:winbrother_hr_app/models/fleet_model.dart';
import 'package:winbrother_hr_app/models/travel_expense/pocket_line.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_category.dart';
import 'package:winbrother_hr_app/models/travel_expense/travel_expense_product.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutOfPocketCreate extends StatefulWidget {
  static void showToast(String msg) {
    Get.snackbar('Warning', msg, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  _OutOfPocketCreateState createState() => _OutOfPocketCreateState();
}

class _OutOfPocketCreateState extends State<OutOfPocketCreate> {
  final OutOfPocketController controller = Get.put(OutOfPocketController());
  OutofPocketList controllerList = Get.find();

  int _value = 1;

  File? imageFile;

  bool keyboardOpen = false;

  final picker = ImagePicker();
  List<PocketLine> datalist = [];
  String img64 = "";
  int index = 0;
  Uint8List? bytes;

  File? image;
  var formatter = new NumberFormat("###,###", "en_US");
  DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _formKeyParent = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();

  DateTime selectedToDate = DateTime.now();

  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());

  final box = GetStorage();

  TextEditingController qtyController = TextEditingController(text: "1");

  String user_image = '';
  var price_value = 0.0;
  var amount_value = 0.0;
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64);
  }

  String expenseValue = "";
  List expenseData = ["Breakfast", "Lunch", "Dinner"];

  nullPhoto() {
    img64 = '';
    controller.isShowImage.value = false;
    controller.selectedImage.value = File('');
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);
    File rotatedImage =
        await FlutterExifRotation.rotateImage(path: pickedFile!.path);
    File image = File(rotatedImage.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64);
  }

  // Widget dateWidget(
  //   BuildContext context,
  // ) {
  //   var labels = AppLocalizations.of(context);

  //   var date_controller;
  //   date_controller = controller.fromDateTextController;
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
  //               child: TextField(
  //                 enabled: false,
  //                 keyboardType: TextInputType.visiblePassword,
  //                 textInputAction: TextInputAction.none,
  //                 controller: date_controller,
  //                 decoration: InputDecoration(
  //                   hintText: labels.expenseDate,
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ]),
  //   );
  // }

  // Widget dateWidget(BuildContext context) {
  //   var date_controller;
  //   date_controller = controller.fromDateTextController;
  //   final labels = AppLocalizations.of(context);
  //   final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  //   return Container(
  //     // margin: EdgeInsets.only(left: 10, right: 10, top: 10),
  //     child: Column(children: <Widget>[
  //       // Text('Basic date & time field (${format.pattern})'),
  //       DateTimeField(
  //         controller: date_controller,
  //         decoration: InputDecoration(
  //           hintText: labels.expenseDate,
  //           border: OutlineInputBorder(),
  //         ),
  //         format: format,
  //         onShowPicker: (context, currentValue) async {
  //           final date = await showDatePicker(
  //               context: context,
  //               // firstDate: DateTime.now(),
  //               // initialDate: currentValue ?? DateTime.now(),
  //               // lastDate: DateTime(2200)
  //                 initialDate: DateTime.now(),
  //                 firstDate: DateTime(1988),
  //                 lastDate: DateTime.now(),
  //               );
  //           if (date != null) {
  //             final time = await showTimePicker(
  //               context: context,
  //               initialTime:
  //                   TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //             );
  //             var date_time =
  //                 DateTimeField.combine(date, time).toString().split('.000')[0];

  //             controller.fromDateTextController.text = date_time.toString();
  //             selectedFromDate = DateTime.parse(date_time);

  //             return DateTimeField.combine(date, time);
  //           } else {
  //             return currentValue;
  //           }
  //         },
  //       ),
  //     ]),
  //   );
  // }

  // Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1988),
  //     lastDate: DateTime.now(),
  //     builder: (BuildContext context, Widget child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           dialogBackgroundColor: Colors.white,
  //           colorScheme: ColorScheme.light(
  //             primary: const Color.fromRGBO(60, 47, 126, 1),
  //           ),
  //           buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //           highlightColor: Colors.grey[400],
  //           textSelectionColor: Colors.grey,
  //         ),
  //         child: child,
  //       );
  //     },
  //   );
  //   if (picked != null) {
  //     selectedFromDate = picked;
  //     controller.fromDateTextController.text =
  //         ("${selectedFromDate.toLocal()}".split(' ')[0]);
  //     var formatter = new DateFormat('yyyy-MM-dd');
  //     controller.fromDateTextController.text = formatter.format(picked);
  //   }
  // }

  Widget dateWidget(
    BuildContext context,
  ) {
    var labels = AppLocalizations.of(context);

    var date_controller;
    date_controller = controller.fromDateTextController;
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
                child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.none,
                  controller: date_controller,
                  decoration: InputDecoration(
                    hintText: labels!.expenseDate,
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1988),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
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
      controller.fromDateTextController.text =
          ("${selectedFromDate.toLocal()}".split(' ')[0]);
      var formatter = new DateFormat('yyyy-MM-dd');
      controller.fromDateTextController.text = formatter.format(picked);
    }
  }

  Widget _decideImageView(BuildContext context) {
    var labels = AppLocalizations.of(context);
    if (!controller.isShowImage.value) {
      return Obx(() => !controller.isShowImage.value
          ? Expanded(flex: 1, child: Text(labels!.noImageSelected))
          : SizedBox());
    } else {
      return Image.file(imageFile!, width: 50, height: 50);
    }
  }

  Widget expenseCategoryDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          onChanged: (TravelExpenseCategory? value) {
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
                    getImage();
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

  Widget leaveRequestDateAdjustWidget(BuildContext context) {
    return Container();
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
                          onChanged: (controller.selectedExpenseCategory.fuel !=
                                      null &&
                                  controller.selectedExpenseCategory.fuel)
                              ? null
                              : (TravelExpenseProduct? value) {
                                  controller
                                      .onChangeExpenseProductDropdown(value!);
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
                          onChanged: (Fleet_model? value) {
                            controller.onChangeVehicleDropdown(value!);
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
                child: DropdownButton<String>(
                    hint: Text(
                      "",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: expenseValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        expenseValue = newValue!;
                      });
                    },
                    items: expenseData.map((value) {
                      expenseValue = value;
                      return DropdownMenuItem(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList())),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    index = Get.arguments ?? 0;
    var labels = AppLocalizations.of(context);
    if (index == null || index == 0) {
    } else {
      controller.fromDateTextController.text =
          controllerList.outofpocketExpenseList.value[index].date.toString();
      datalist = controllerList.outofpocketExpenseList.value[index].pocket_line;
    }
    user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(context, labels!.outOfPocket, user_image),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context),
                        )),
                  ),
                  // Expanded(child: expenseCategoryDropDown()),
                ],
              ),
              expenseCategoryDropDown(),
              Obx(() =>
                  controller.selectedExpenseCategory.is_vehicle_selected == true
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: vehicleDropDown())
                      : SizedBox()),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: expenseProductDropDown()),
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
                              hintText: labels.quantity,
                            ),
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
                              hintText: labels.unitPrice,
                            ),
                            onChanged: (unitPrice) {
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
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: labels.amount,
                      ),
                      controller: controller.totalAmountController,
                      onChanged: (unitPrice) {
                        controller.calculateUnitAmount();
                      },
                    )),
              ),
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
                        hintText: labels.description,
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
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showOptions(context);
                        },
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(),
                            child: controller.isShowImage.value == false
                                ? Container(
                                    decoration:
                                        BoxDecoration(color: textFieldTapColor),
                                    height: 45,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 30,
                                    ))
                                : Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Image.file(
                                              controller.selectedImage.value,
                                              width: 150,
                                              height: 150)),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                            onTap: () {
                                              nullPhoto();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            )),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    _decideImageView(context),
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
              Obx(
                () => controller.is_show_expense.value
                    ? Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: GFButton(
                          onPressed: () {
                            if (controller
                                .fromDateTextController.text.isEmpty) {
                              AppUtils.showDialog(
                                  labels.warning, labels.dateRequired);
                            } else if (controller.qtyController.text.isEmpty) {
                              AppUtils.showDialog(
                                  labels.warning, labels.qtyRequired);
                            } else if (controller.qtyController.text == '0') {
                              AppUtils.showDialog(
                                  labels.warning, labels.canNotAddZeroQty);
                            } else if (controller
                                .priceController.text.isEmpty) {
                              AppUtils.showDialog(
                                  labels.warning, labels.priceRequired);
                            } else if (controller.priceController.text == '0') {
                              AppUtils.showDialog(
                                  labels.warning, labels.canNotAddZeroPrice);
                            } else if (controller.image_base64 == null ||
                                controller.image_base64.isEmpty) {
                              AppUtils.showDialog(
                                  labels.warning, labels.addAttachment);
                            } else if (controller.selectedExpenseCategory
                                        .is_vehicle_selected !=
                                    null &&
                                controller.selectedExpenseCategory
                                    .is_vehicle_selected) {
                              if (controller.selectedVehicle.id == null) {
                                AppUtils.showDialog(
                                    labels.information, labels.chooseVehicle);
                              } else {
                                controller.addExpenseLine();
                                nullPhoto();
                              }
                            } else {
                              controller.addExpenseLine();
                              nullPhoto();
                            }
                          },
                          text: labels.addExpenseLine,
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
                () => controller.outofpocketList.length > 0
                    ? expenseTitleWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.outofpocketList.length > 0
                    ? expenseWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: Obx(() => Text(
                            labels.totalAmount +
                                ' : ${NumberFormat('#,###').format(controller.totalExpenseAmount.value)}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepPurple),
                          )))),
              Container(
                width: double.infinity,
                height: 45,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
                    onPressed: () {
                      if (controller.outofpocketList.length > 0)
                        controller.requestOutOfPocket();
                      else
                        AppUtils.showDialog(
                            labels.warning, labels.addExpenseLine);
                    },
                    child: Text(
                      (labels.save),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
              leaveRequestDateAdjustWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseTitleWidget(BuildContext context) {
    var labels = AppLocalizations.of(context);

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
                (labels!.expenseDate),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                (labels.expenseTitle),
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
                (labels.amount),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                // margin: EdgeInsets.only(left: 30),
                // width: 70,

                ),
          ),
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
            itemCount: controller.outofpocketList.length,
            itemBuilder: (BuildContext context, int index) {
              fields = controller.outofpocketList.length;
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
                          flex: 1,
                          child: Container(
                            // width: 80,
                            // child: Text(AppUtils.changeDateFormat(
                            //     controller.outofpocketList[index].date)),
                            child: Text(controller.outofpocketList[index].date),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller
                                .outofpocketList[index].expense_category
                                .toString()),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(formatter.format(double.parse(
                                  controller
                                      .outofpocketList[index].price_subtotal
                                      .toString()))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              // margin: EdgeInsets.only(left: 30),
                              // width: 70,
                              child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeRow(index);
                                },
                              ),
                              controller.outofpocketList[index].attached_file !=
                                      null
                                  ? IconButton(
                                      icon: Icon(Icons.attach_file_outlined),
                                      onPressed: () {},
                                    )
                                  : SizedBox(),
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
          )),
    );
  }
}
