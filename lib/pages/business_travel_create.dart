import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winbrother_hr_app/controllers/busiess_travel_controller.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class BusinessTravelCreate extends StatefulWidget {
  @override
  _BusinessTravelCreateState createState() => _BusinessTravelCreateState();
}

class _BusinessTravelCreateState extends State<BusinessTravelCreate> {
  final BusinessTravelController controller =
      Get.put(BusinessTravelController());
  ExpensetravelListController controllerList = Get.find();
  var box = GetStorage();
  bool selectCamera = false;
  String image = "";
  dynamic index = 0;
  String img64 = "";
  List<TravelLineListModel> datalist = [];
  DateTime selectedFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File? imageFile;
  String expenseValue = "";
  List expenseData = ["Breakfast", "Lunch", "Dinner"];
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List image_64 = [];
  TextEditingController expenseUpdateDateController = TextEditingController();
  DateTime selectedUpdateFromDate = DateTime.now();
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

  Widget buildGridView() {
    return Obx(() => new Card(
          elevation: 10,
          child: new Container(
            // child: *Image list as child*, but don't know about the list datatype hence not created it!
            alignment: Alignment.center,
            child: GridView.builder(
                itemCount: controller.encoded_list.value.length,
                gridDelegate:
                    // crossAxisCount stands for number of columns you want for displaying
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  Uint8List bytes =
                      base64.decode(controller.encoded_list.value[index]);
                  // return your grid widget here, like how your images will be displayed
                  return Image.memory(bytes);
                }),
          ),
        ));
  }
  // Future<void> getImage() async {
  //   FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   List<String> files_encoded;
  //   if(result != null) {
  //     List<File> files = result.paths.map((path) => File(path)).toList();
  //     files.map((data) async {
  //       File compressedFile =  await AppUtils.reduceImageFileSize(data);
  //       final bytes = Io.File(compressedFile.path).readAsBytesSync();
  //       img64 = base64Encode(bytes);
  //       files_encoded.add(img64);
  //     });
  //     controller.setGalleryImage(files_encoded);
  //   } else {
  //     // User canceled the picker
  //   }
  // }
  /* Widget _decideImageView() {
    if (!controller.isShowImage.value) {
      return Expanded(flex: 1, child: Text('No Image Selected!'));
    } else {
      return Image.file(imageFile, width: 50, height: 50);
    }
  }*/

  nullPhoto() {
    setState(() {
      controller.isShowImage.value = false;
      controller.selectedImage.value = File("");
    });
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
                    // getImage();
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

  /*Widget expenseTypeDropDown() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[350], width: 2),
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
                  onChanged: (String newValue) {
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
  }*/

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
                          // onChanged: controller.travelLineModel.length > 0 ? null :(TravelRequestListResponse value) {
                          //   controller
                          //       .onChangeTravelExpenseApproveDropdown(value);
                          // },
                          onChanged: controller.travelLineModel.length > 0
                              ? null
                              : (TravelRequestListResponse? value) {},
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
                          onChanged: (TravelExpenseCategory? value) {
                            // print(value.display_name);
                            // print(value.id);
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
                          onChanged: (TravelExpenseProduct? value) {
                            // print(value.name);
                            // print(value.id);
                            controller.onChangeExpenseProductDropdown(value!);
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
  //   BuildContext context,
  // ) {
  //   var labels = AppLocalizations.of(context);
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
  //                       hintText: labels?.expenseDate,
  //                       border: OutlineInputBorder()),
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
  //   date_controller = controller.expenseDateController;
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
  //                 initialDate: DateTime.parse(controller.from_travel_date.value),
  //                 firstDate: DateTime.parse(controller.from_travel_date.value),
  //                 lastDate: DateTime.parse(controller.to_travel_date.value),
  //               );
  //           if (date != null) {
  //             final time = await showTimePicker(
  //               context: context,
  //               initialTime:
  //                   TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
  //             );
  //             var date_time =
  //                 DateTimeField.combine(date, time).toString().split('.000')[0];
  //             selectedFromDate = DateTime.parse(date_time);
  //             controller.expenseDateController.text = date_time.toString();

  //             return DateTimeField.combine(date, time);
  //           } else {
  //             return currentValue;
  //           }
  //         },
  //       ),
  //     ]),
  //   );
  // }
  Widget dateWidget(
    BuildContext context,
  ) {
    var labels = AppLocalizations.of(context);
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
                        hintText: labels?.expenseDate,
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

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
                          flex: 3,
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
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.parse(controller.from_travel_date.value),
  //     firstDate: DateTime.parse(controller.from_travel_date.value),
  //     lastDate: DateTime.parse(controller.to_travel_date.value),
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
  //     controller.expenseDateController.text =
  //         ("${selectedFromDate.toLocal()}".split(' ')[0]);
  //     var formatter = new DateFormat('yyyy-MM-dd');
  //     controller.expenseDateController.text = formatter.format(picked);
  //   }
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(controller.from_travel_date.value),
      firstDate: DateTime.parse(controller.from_travel_date.value),
      lastDate: DateTime.parse(controller.to_travel_date.value),
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
      controller.expenseDateController.text =
          ("${selectedFromDate.toLocal()}".split(' ')[0]);
      var formatter = new DateFormat('yyyy-MM-dd');
      controller.expenseDateController.text = formatter.format(picked);
    }
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
      print("IMage 64 Image 64 $image_64");
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    
    //Globals.ph_hardware_back.value = true;
    if (index == null) {
    } else {
      print("TRUE");
      print(controllerList.travelExpenseList.value[index].id.toString());
      datalist = controllerList.travelExpenseList.value[index].travel_line;
    }
    image = box.read('emp_image');
    //return WillPopScope(
    // onWillPop: () async{
    //   if(Globals.ph_hardware_back.value){
    //     return Future.value(true);
    //   }else{
    //     return Future.value(false);
    //   }
    // },
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(context, labels!.travelExpense, image),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: travelApproveDropdown()),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: controller.totalAdvanceAmount.value != null
                            ? controller.totalAdvanceAmount.value > 0.0
                                ? Text(
                                    '${labels?.total} ${labels?.travelExpense} ${labels?.actualAmt} : ${NumberFormat('#,###').format(controller.totalAdvanceAmount.value!)}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.deepPurple),
                                  )
                                : SizedBox()
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
              SizedBox(
                height: 10,
              ),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                print("Image File");
                                // loadAssets();
                                showOptions(context);
                              });
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
                  ],
                ),
              ),
              Container(
                child: controller.selectedImage.value != null &&
                        selectCamera == true
                    ? Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Image.file(controller.selectedImage.value,
                                  width: 150, height: 150)),
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
                            //print("selectedDate");
                            if (controller.expenseDateController.text
                                .toString()
                                .isEmpty) {
                              AppUtils.showDialog(
                                  labels.warning, labels.chooseDate);
                            } else {
                              controller.addTravelLine(image_64);
                              setState(() {
                                selectCamera = false;
                                controller.selectedImage.value = File('');
                                images.clear();
                                image_64.clear();
                              });
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
                () => controller.travelLineModel.length > 0
                    ? expenseTitleWidget(context)
                    : new Container(),
              ),
              SizedBox(
                height: 10,
              ),
              index == null ? Container() : expenseListWidget(context),
              Obx(
                () => controller.travelLineModel.length > 0
                    ? expenseWidget(context)
                    : new Container(),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: controller.totalAmountForExpense.value > 0.0
                            ? Text(
                                '${labels?.total} Amount : ${NumberFormat('#,###').format(controller.totalAmountForExpense.value)}',
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: textFieldTapColor),
                    onPressed: () {
                      if (index == null) {
                        if (controller.travelLineModel.length > 0)
                          controller.createTravel(context);
                        else
                          AppUtils.showDialog(
                              labels.warning, labels.addExpenseLine);
                      } else {
                        controller.updateTravelLineExpense(
                            controllerList.travelExpenseList.value[index].id
                                .toString(),
                            context);
                      }
                    },
                    child: index == null
                        ? Text(
                            (labels.save),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        : Text(
                            (labels.update),
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

  Widget expenseTitleWidget(BuildContext context) {
    var labels = AppLocalizations.of(context);

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
                (labels!.date),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // width: 80,
              child: Text(
                (labels.expenseTitle),
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
                (labels.amount),
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

  Widget expenseWidget(BuildContext context) {
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
                        child: Text(controller.travelLineModel[index].date
                            .toString()
                            .substring(5)),
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
                              controller.removeRow(index);
                            },
                          ),
                          controller.travelLineModel[index].attached_file
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
    );
  }

  Widget vehicleDropDown() {
    var labels = AppLocalizations.of(context);
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
                                labels!.vehicle,
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

  Widget _travelExpenseLineEdit(
      BuildContext context, int index, TravelLineModel travelLine) {
    final labels = AppLocalizations.of(context);
    return AlertDialog(
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          child: new ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
              onPressed: () {
                controller.updateExpenseLine(index, travelLine);
                Navigator.of(context).pop();
              },
              //textColor: Theme.of(context).primaryColor,
              child: Text((labels!.update),
                  style: TextStyle(fontSize: 20, color: Colors.white))),
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
                          onChanged: (Fleet_model ? value) {
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
                          onChanged: (TravelExpenseProduct ? value) {
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

// Widget dateWidgetEdit(
//       BuildContext context,TravelLineModel travelLine
//       ) {
//     var date_controller;
//     date_controller = controller.expenseUpdateDateController;
//     return Container(
//       child: Column(children: <Widget>[
//         Row(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: InkWell(
//                 onTap: () {
//                   _selectDateEdit(context,index);
//                 },
//                 child: Container(
//                   height: 50,
//                   child: TextField(
//                     enabled: false,
//                     keyboardType: TextInputType.visiblePassword,
//                     textInputAction: TextInputAction.none,
//                     controller: date_controller,
//                     decoration: InputDecoration(
//                         hintText: "Expense Date", border: OutlineInputBorder()),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ]),
//     );
//   }

  Widget dateWidgetEdit(BuildContext context, TravelLineModel travelLine) {
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
                  _selectDateEdit(context, index);
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

  // Future<Null> _selectDateEdit(BuildContext context,int index) async {
  //   controller.getOneTravelApprove(controllerList.travelExpenseList.value[index].travel_id.id).then((value) async{
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
  //       selectedUpdateFromDate = picked;
  //       controller.expenseUpdateDateController.text =
  //       ("${selectedUpdateFromDate.toLocal()}".split(' ')[0]);
  //       var formatter = new DateFormat('yyyy-MM-dd');
  //       controller.expenseUpdateDateController.text = formatter.format(picked);
  //       //controller.travelLineModel[index].date = formatter.format(picked);
  //     }
  //   }
  //   );
  // }

  Future<Null> _selectDateEdit(BuildContext context, int index) async {
    controller
        .getOneTravelApprove(
            controllerList.travelExpenseList.value[index].travel_id.id)
        .then((value) async {
      final DateTime ?picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(controller.from_travel_date.value),
        firstDate: DateTime.parse(controller.from_travel_date.value),
        lastDate: DateTime.parse(controller.to_travel_date.value),
        builder: (BuildContext context, Widget  ?child) {
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
    });
  }
}
