import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:intl/intl.dart';
import '../controllers/maintenance_controller.dart';
// import '../localization.dart';
import '../models/fleet_model.dart';
import '../models/maintenance_product_category_model.dart';
import '../models/maintenance_request_model.dart';
import '../models/maintenance_team_list.dart';
import '../models/maintenance_workshop_list.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui/components/textbox.dart';
import '../utils/app_utils.dart';
import '../my_class/my_style.dart';
import 'leave_detail.dart';

class MaintenanceRequest extends StatefulWidget {
  static void showToast(String msg) {
    Get.snackbar('Warning', msg, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  _MaintenanceRequestState createState() => _MaintenanceRequestState();
}

class _MaintenanceRequestState extends State<MaintenanceRequest> {
  MaintenanceController controller = Get.find();

  late File imageFile;

  bool keyboardOpen = false;

  final picker = ImagePicker();

  late String img64;

  late Uint8List bytes;

  late File image;

  DateTime selectedDate = DateTime.now();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();

  DateTime selectedToDate = DateTime.now();

  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());

  final box = GetStorage();
  late String user_image;

  Future getImage(String from) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile?.path ?? "");
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);

    controller.setCameraImage(compressedFile, img64, from);
  }

  Widget dateTimeDialog(String from) {
    final labels = AppLocalizations.of(context);
    final format = DateFormat("yyyy-MM-dd HH:mm:ss");
    var date_controller;
    var hintText = "";
    if (from == 'from') {
      hintText = labels!.startdatetime;
      date_controller = controller.fromDateTimeTextController;
    } else {
      hintText = labels!.enddatetime;
      date_controller = controller.toDateTimeTextController;
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(children: <Widget>[
        // Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
          controller: date_controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2200));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );

              var date_time =
                  DateTimeField.combine(date, time).toString().split('.000')[0];
              String pick_date_time_str =
                  AppUtils.convertDT2String(DateTimeField.combine(date, time));
              if (from == 'from') {
                controller.fromDateTimeTextController.text = pick_date_time_str;
              } else {
                controller.toDateTimeTextController.text = pick_date_time_str;
              }

              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ]),
    );
  }

  nullPhoto() {}

  Future getCamera(String from) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64, from);
  }

  // Future<Null> _selectDate(BuildContext context, String from) async {
  //   final DateTime picked_date_time = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2018),
  //     lastDate: DateTime(2030),
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
  //   String date_time_str  = picked_date_time !=null? AppUtils.convertDT2String(picked_date_time)
  //   :AppUtils.convertDT2String(new DateTime.now());
  //   if(from=='from'){
  //
  //     controller.fromDateTimeTextController.text = date_time_str;
  //   }else{
  //     controller.toDateTimeTextController.text = date_time_str;
  //   }
  //
  // }
  showOptions(context, String from) {
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
                    getCamera(from);
                    Get.back();
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
                    getImage(from);
                    Get.back();
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

  // Widget productCategoryDropDown() {
  //   var labels = AppLocalizations.of(context);
  //   return Container(
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //             // color: Colors.white,
  //             // height: 50,
  //             // margin: EdgeInsets.only(right: 20),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(
  //                     color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
  //                 // Border.all(color: Colors.white, width: 2),
  //                 borderRadius: const BorderRadius.all(
  //                   const Radius.circular(1),
  //                 ),
  //               ),
  //               child: Theme(
  //                 data: new ThemeData(
  //                   primaryColor: Color.fromRGBO(60, 47, 126, 1),
  //                   primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
  //                 ),
  //                 child: DropdownButtonHideUnderline(
  //                     child: DropdownButton<Maintenance_product_category_model>(
  //                         hint: Container(
  //                             padding: EdgeInsets.only(left: 20),
  //                             child: Text(
  //                               labels?.selectProductCategory ?? "",
  //                               style: middleHintLabelStyle(),
  //                             )),
  //                         value: controller.selectedProductCategory.value,
  //                         icon: Icon(Icons.keyboard_arrow_down),
  //                         iconSize: 30,
  //                         isExpanded: true,
  //                         onChanged:
  //                             (Maintenance_product_category_model? value) {
  //                           print(value!.name);
  //                           print(value.id);
  //                           controller.onChangeProductCategoryDropdown(value);
  //                         },
  //                         items: controller.maintenanceProductCategorys
  //                             .map((Maintenance_product_category_model? model) {
  //                           return DropdownMenuItem<
  //                               Maintenance_product_category_model>(
  //                             value: model,
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(left: 10),
  //                               child: Text(
  //                                 model?.name ?? '',
  //                                 style: TextStyle(),
  //                               ),
  //                             ),
  //                           );
  //                         }).toList()),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget productCategoryDropDown() {
    var labels = AppLocalizations.of(context);
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
                  border: Border.all(color: Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Maintenance_product_category_model>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.selectProductCategory,style: middleHintLabelStyle(),
                              )),
                          value: controller.selectedProductCategory.value.id==0 ? null : controller.selectedProductCategory.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Maintenance_product_category_model? value) {
                            print(value!.name);
                            print(value.id);
                            controller.onChangeProductCategoryDropdown(value);
                          },
                          items:
                          controller.maintenanceProductCategorys.value.map((Maintenance_product_category_model model) {
                            return DropdownMenuItem<Maintenance_product_category_model>(
                              value: model,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  model.name,
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

  Widget productDropDown() {
    var labels = AppLocalizations.of(context);
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
                      child: DropdownButton<Product_id>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.selectProduct,
                                style: middleHintLabelStyle(),
                              )),
                          value: controller.selectedProduct.value.id==0 ?null : controller.selectedProduct.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Product_id? value) {
                            print(value!.name);
                            print(value!.id);
                            controller.onChangeProductDropdown(value);
                          },
                          items: controller.maintenanceProductList
                              .map((Product_id product_id) {
                            return DropdownMenuItem<Product_id>(
                              value: product_id,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  product_id.name,
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

  Widget productTypeDropDown() {
    final labels = AppLocalizations.of(context);
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
                      child: DropdownButton<String>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.vehicle,
                                style: middleLabelStyle(),
                              )),
                          value: controller.selectedProductType.value,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (String? value) {
                            controller.onChangeProductTypeDropdown(value!);
                          },
                          items: [
                            DropdownMenuItem<String>(
                              value: 'repair',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Repair',
                                  style: middleLabelStyle(),
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'new',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'New',
                                  style: middleLabelStyle(),
                                ),
                              ),
                            ),
                          ]),
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

  @override
  void initState() {
    super.initState();
    controller.getMaintenanceProductCategorys();
    //controller.getMaintenanceProductList();
    controller.maintenanceProductIdList.clear();
    controller.imageList.clear();
    controller.isShowAfterOne.value = false;
    controller.isShowAfterTwo.value = false;
    controller.isShowAfterThree.value = false;
    controller.isShowBeforeOne.value = false;
    controller.isShowBeforeTwo.value = false;
    controller.isShowBeforeThree.value = false;
    controller.before_img_one.value = File('');
    controller.before_img_two.value = File('');
    controller.before_img_three.value = File('');
    controller.after_img_one.value = File('');
    controller.after_img_two.value = File('');
    controller.after_img_threee.value = File('');
    controller.fromDateTimeTextController.text = "";
    controller.toDateTimeTextController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, labels!.maintenance, user_image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(child: dateTimeDialog('from')),
                ],
              ),
              dateTimeDialog('to'),
              SizedBox(
                height: 10,
              ),
              workShopSelectionDropDown(),

              vehicleDropDown(),
              controller.selectedWorkshopSelection.id=="undefined_workshop" ? SizedBox() : maintenanceTeamDropDown(),
              productCategoryDropDown(),
              SizedBox(
                height: 10,
              ),
              productDropDown(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: productTypeDropDown(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                        child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: TextField(
                        controller: controller.qtyTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: labels.quantity,
                          hintStyle: middleHintLabelStyle(),
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color:
                                      const Color.fromRGBO(250, 250, 250, 1))),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              // controller.selectedWorkshopSelection.id=="undefined_workshop" ? Container(
              //     child: Theme(
              //   data: new ThemeData(
              //     primaryColor: textFieldTapColor,
              //   ),
              //   child: TextField(
              //     maxLines: 3,
              //     controller: controller.remarkTextController,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.all(20.0),
              //       hintText: labels.remark,
              //       border: OutlineInputBorder(
              //           borderSide: new BorderSide(
              //               color: const Color.fromRGBO(250, 250, 250, 1))),
              //     ),
              //   ),
              // )) : SizedBox(),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: GFButton(
                  onPressed: () {
                    if (controller.selectedProduct.value != null &&
                        controller.selectedProductCategory.value != null) {
                      var product_ids = Maintenance_product_ids(
                          productId: controller.selectedProduct.value,
                          categoryId: Category_id(
                              id: controller.selectedProductCategory.value.id,
                              name: controller
                                  .selectedProductCategory.value.name),
                          type: controller.selectedProductType.value,
                          qty: double.parse(controller.qtyTextController.text??"00"));
                      controller.maintenanceProductIds =
                          controller.maintenanceProductIdList.value;
                      controller.addMaintenanceProductId(product_ids);
                      setState(() {});
                      controller.qtyTextController.text = "";
                      controller.selectedProductCategory.value = Maintenance_product_category_model();
                      controller.selectedProduct.value = Product_id();
                      controller.selectedDateTextController.text = "";
                    }
                  },
                  text: labels.addProductLine,
                  color: textFieldTapColor,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  shape: GFButtonShape.pills,
                  blockButton: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: AutoSizeText(
                        labels.productName,
                        style: maintitleStyle(),
                      )),
                  Expanded(
                      flex: 2,
                      child: AutoSizeText(labels.categoryName,
                          style: maintitleStyle())),
                  Expanded(
                      child:
                          AutoSizeText(labels.type, style: maintitleStyle())),
                  Expanded(
                      child: AutoSizeText(labels.quantity,
                          style: maintitleStyle())),
                  Expanded(child: AutoSizeText('')),
                ],
              ),
              controller.selectedWorkshopSelection.id=="undefined_workshop" ? Container(
                  child: Theme(
                data: new ThemeData(
                  primaryColor: textFieldTapColor,
                ),
                child: TextField(
                  maxLines: 3,
                  controller: controller.remarkTextController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: labels.remark,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(250, 250, 250, 1))),
                  ),
                ),
              )) : SizedBox(),
              SizedBox(height: 10,),
              Container(
                  child: Theme(
                data: new ThemeData(
                  primaryColor: textFieldTapColor,
                ),
                child: TextField(
                  maxLines: 3,
                  controller: controller.descriptionTextController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: labels.description,
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: const Color.fromRGBO(250, 250, 250, 1))),
                  ),
                ),
              )),
              // Divider(
              //   height: 2,
              //   indent: 10,
              //   thickness: 1,
              //   color: Colors.black,
              // ),
              Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.maintenanceProductIdList.value.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 3,
                              child: AutoSizeText(controller
                                  .maintenanceProductIdList[index]
                                  .productId!
                                  .name)),
                          Expanded(
                              flex: 2,
                              child: AutoSizeText(controller
                                  .maintenanceProductIdList[index]
                                  .categoryId!
                                  .name)),
                          Expanded(
                              child: AutoSizeText(controller
                                  .maintenanceProductIdList[index].type)),
                          Expanded(
                              child: AutoSizeText(
                                  '${controller.maintenanceProductIdList[index].qty}')),
                          Expanded(
                              child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                controller.removeMaintenanceProductId(
                                    controller.maintenanceProductIdList[index]);
                              });
                            },
                          )),
                        ],
                      ),
                    );
                  })),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    labels.priority + ' :',
                    style: middleLabelStyle(),
                  ),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemSize: 30,
                    itemCount: 3,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.priority = rating;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(labels.before),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowBeforeOne.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowBeforeOne.value =
                                            false;
                                        controller.before_img_one.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .before_img_one.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'before_one');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowBeforeOne.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.before_img_one.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.before1,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowBeforeTwo.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowBeforeTwo.value =
                                            false;
                                        controller.before_img_two.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .before_img_two.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'before_two');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowBeforeTwo.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.before_img_two.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.before2,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowBeforeThree.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowBeforeThree.value =
                                            false;
                                        controller.before_img_three.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .before_img_three.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'before_three');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowBeforeThree.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.before_img_three.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.before3,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(labels.after),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowAfterOne.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowAfterOne.value = false;
                                        controller.after_img_one.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .after_img_one.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'after_one');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowAfterOne.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.after_img_one.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.after1,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowAfterTwo.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowAfterTwo.value = false;
                                        controller.after_img_two.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .after_img_two.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'after_two');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowAfterTwo.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.after_img_two.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.after2,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.isShowAfterThree.value) {
                            Get.defaultDialog(
                                title: labels.information,
                                middleText: labels.wantDeletePhoto,
                                actions: [
                                  GFButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      labels.cancel,
                                      style: TextStyle(
                                          color: backgroundIconColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white,
                                  ),
                                  GFButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.isShowAfterThree.value =
                                            false;
                                        controller.after_img_threee.value =
                                            File('');
                                      });
                                      Get.back();
                                    },
                                    child: Text(labels.delete),
                                    color: Colors.red,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      Get.back();
                                      final bytesData = Io.File(controller
                                              .after_img_threee.value.path)
                                          .readAsBytesSync();
                                      await showDialog(
                                          context: context,
                                          builder: (_) => ImageDialog(
                                                bytes: bytesData,
                                              ));
                                    },
                                    child: Text(labels.view),
                                    color: backgroundIconColor,
                                  ),
                                ]);
                          } else {
                            showOptions(context, 'after_three');
                          }
                        },
                        child: Column(
                          children: [
                            controller.isShowAfterThree.value == false
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 80,
                                        height: 80,
                                        padding: EdgeInsets.all(10),
                                        decoration:
                                            BoxDecoration(color: Colors.grey),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  )
                                : Image.file(
                                    controller.after_img_threee.value,
                                    width: 100,
                                    height: 100,
                                  ),
                            Text(
                              labels.after3,
                              style: middleLabelStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // InkWell(
              //   onTap: (){
              //     showOptions(context);
              //   },
              //   child: Container(
              //       padding: EdgeInsets.all(10),
              //       decoration:
              //       BoxDecoration(color: textFieldTapColor),
              //       child: Icon(
              //         Icons.camera_alt,
              //         color: Colors.white,
              //         size: 30,
              //       )),
              // ),
              // GridView.builder(
              //     itemCount: controller.imageList.length,
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       childAspectRatio: 0.7,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 1,
              //       crossAxisCount: 4,
              //     ),
              //     itemBuilder: (context,index)=>InkWell(
              //       onTap: (){
              //         Get.defaultDialog(
              //           title: "Information",
              //           middleText: "Do you want to delete select photo?.",
              //          actions: [
              //            GFButton(onPressed: (){
              //              Get.back();
              //            },
              //              child: Text('Cancel',style: TextStyle(color: backgroundIconColor,fontWeight: FontWeight.bold),),
              //              color: Colors.white,
              //            ),
              //            GFButton(onPressed: (){
              //             setState(() {
              //               controller.imageList.removeAt(index);
              //             });
              //             Get.back();
              //            },
              //              child: Text('Delete'),
              //              color: Colors.red,
              //            ),
              //            GFButton(onPressed: () async{
              //              Get.back();
              //              await showDialog(
              //                  context: context,
              //                  builder: (_) => ImageDialog(
              //                bytes: controller.imageList[index],
              //              ));
              //            },
              //              child: Text('View'),
              //              color: backgroundIconColor,
              //            ),
              //          ]
              //         );
              //       },
              //       child: Image.memory(controller.imageList[index], width: 50, height: 50),
              //     )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: GFButton(
                  onPressed: () {
                    controller.createMaintenanceRequest();
                  },
                  color: backgroundIconColor,
                  size: GFSize.LARGE,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Text(
                      labels.save,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget vehicleDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              labels!.vehicle + ' : ',
              style: middleLabelStyle(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                                labels!.vehicle,
                                style: middleHintLabelStyle(),
                              )),
                          value: controller.selectedVehicle,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Fleet_model? value) {
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

  Widget workShopSelectionDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              'Workshop Selection' + ' : ',
              style: middleLabelStyle(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<MaintenanceWorkshopList>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Workshop Selection',
                                style: middleHintLabelStyle(),
                              )),
                          value: controller.selectedWorkshopSelection.id == "" ? null : controller.selectedWorkshopSelection,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (MaintenanceWorkshopList? value) {
                            print(value!.name);
                            print(value.id);
                            setState(() {
                              controller.onChangeWorkshopSelectionDropdown(value);
                            });
                            
                          },
                          items: controller.maintenanceWorkShopList
                              .map((MaintenanceWorkshopList workshop) {
                            return DropdownMenuItem<MaintenanceWorkshopList>(
                              value: workshop,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  workshop.name,
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

  Widget maintenanceTeamDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "Team" + ' : ',
              style: middleLabelStyle(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<MaintenanceTeamList>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                'Team',
                                style: middleHintLabelStyle(),
                              )),
                          value: controller.selectedTeamID.id==0 ? null : controller.selectedTeamID,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (MaintenanceTeamList? value) {
                            print(value!.name);
                            print(value.id);
                            controller.onChangeTeamDropdown(value);
                          },
                          items: controller.maintenanceTeamList
                              .map((MaintenanceTeamList vehicle) {
                            return DropdownMenuItem<MaintenanceTeamList>(
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
}
