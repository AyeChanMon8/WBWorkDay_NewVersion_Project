import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/leave_list_controller.dart';
import '../controllers/leave_request_controller.dart';
import '../controllers/leave_request_update_controller.dart';
import '../models/leave_list_response.dart';
import '../models/leave_type.dart';
import '../my_class/my_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_utils.dart';

class LeaveRequestUpdate extends StatefulWidget {
  static void showToast(String msg) {
    Get.snackbar('Warning', msg, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  _LeaveRequestUpdateState createState() => _LeaveRequestUpdateState();
}

class _LeaveRequestUpdateState extends State<LeaveRequestUpdate> {
  LeaveRequestUpdateController controller = Get.find();
  LeaveListController controllerList = Get.find();

  int _value = 1;

  late File imageFile;

  bool keyboardOpen = false;

  late String starttime;

  late String endtime;

  late DateTime starttimeDate;

  late DateTime endtimeDate;

  late String duration;

  final picker = ImagePicker();

  late String img64;

  late Uint8List bytes;

  late DateTime fromData;

  late File image;

  late LeaveListResponse leavelistreponse;

  DateTime selectedDate = DateTime.now();

  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _formKeyParent = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime selectedFromDate = DateTime.now();

  DateTime selectedToDate = DateTime.now();

  DateTime fromDate = DateTime.now();

  DateTime toDate = DateTime.now();

  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());

  final box = GetStorage();

  late String user_image;

  late LeaveType leaves;

  bool checkLeave = true;
  bool updateTime = true;
  late String idData;
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 1), () => clearData());
    super.initState();
  }

  nullPhoto() {
    controller.isShowImage.value = false;
    controller.selectedImage.value = null;
    leavelistreponse.attachment = null;
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64);
  }

  Widget dateWidget(BuildContext context, String date, String date_string) {
    var date_controller;
    if (date == 'Start Date') {
      if (date_string == null) {
        date_controller = controller.fromDateTextController;
      } else {
        controller.fromDateTextController.text = date_string;
        // fromData = DateTime.parse(date_string);

        date_controller = controller.fromDateTextController;
      }
    } else if (date == 'End Date') {
      if (date_string == null) {
        date_controller = controller.toDateTextController;
      } else {
        controller.toDateTextController.text = date_string;
        date_controller = controller.toDateTextController;
        // controller.fetchLeaveLine(fromData, toDate);
        // controller.calculateinterval(fromData, toDate);
      }

      // date_controller = controller.toDateTextController;
    }

    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  if (date == 'End Date') {
                    if (controller.fromDateTextController.text.isNotEmpty) {
                      _selectDate(context, date);
                    } else {
                      //showToast('Choose Start Date First!');
                      AppUtils.showToast('Choose Start Date First!');
                    }
                  } else if (date == 'Start Date') {
                    _selectDate(context, date);
                  }
                },
                child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.none,
                  controller: date_controller,
                  decoration: InputDecoration(
                    hintText: date,
                    border: OutlineInputBorder(),
                  ),
                   style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future<Null> _selectDate(BuildContext context, String date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date == 'Start Date' ? DateTime.now() : selectedFromDate,
      firstDate: date == 'Start Date' ? DateTime.now() : selectedFromDate,
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
    if (picked != null) {
      if (date == 'Start Date') {
        selectedFromDate = picked;
        controller.fromDateTextController.text =
            ("${selectedFromDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.fromDateTextController.text = formatter.format(picked);

        if (controller.toDateTextController.text.isNotEmpty) {
          controller.fetchLeaveLine(selectedFromDate, selectedToDate);
        }
      } else if (date == 'End Date') {
        selectedToDate = picked;
        controller.toDateTextController.text =
            ("${selectedToDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.toDateTextController.text = formatter.format(picked);
        controller.fetchLeaveLine(selectedFromDate, selectedToDate);
        controller.calculateinterval(selectedFromDate, selectedToDate);
      }
    }
  }

  Widget _decideImageView() {
    if (!controller.isShowImage.value) {
      return Expanded(flex: 1, child: Text('No Image Selected!'));
    } else {
      return leavelistreponse.attachment == null
          ? Container()
          : Container(
              width: 200,
              height: 200,
              child: Image.memory(
                  Base64Decoder().convert(leavelistreponse.attachment!)));
    }
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

  Widget leaveTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              ("Day/Date"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              ("Day off"),
              style: subtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveWidget(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.leavelLineList.value.length,
          itemBuilder: (BuildContext context, int index) {
            var start_date =
                controller.leavelLineList.value[index].start_date.toString();
            var sDateLeave;
            if (updateTime) {
              if (controller.change_date.value) {
                if (start_date.isNotEmpty) {
                  var startDateLeave =
                      DateFormat("yyyy-MM-dd HH:mm:ss").parse(start_date, true);
                  sDateLeave =
                      startDateLeave.toLocal().toString().split(" ")[0] +
                          " " +
                          startDateLeave
                              .toLocal()
                              .toString()
                              .split(" ")[1]
                              .split(".000")[0];
                }
              } else {
                sDateLeave = controller.leavelLineList.value[index].start_date
                    .toString();
              }
            } else {
              if (controller.leavelLineList.value[index].update_status ==
                  false) {
                var startDateLeave =
                    DateFormat("yyyy-MM-dd HH:mm:ss").parse(start_date, true);
                sDateLeave = startDateLeave.toLocal().toString().split(" ")[0] +
                    " " +
                    startDateLeave
                        .toLocal()
                        .toString()
                        .split(" ")[1]
                        .split(".000")[0];
              } else {
                sDateLeave = controller.leavelLineList.value[index].start_date
                    .toString();
              }
            }

            return Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(sDateLeave),
                            // children Text(controller.leavelLineList.value[index].day),
                            // Text(controller
                            //     .leavelLineList.value[index].start_date),
                          ],
                        ),
                      ),
                      Container(
                        child: Obx(
                          () => DropdownButton(
                              value: controller.leavelLineList.value[index].full
                                  ? 1
                                  : controller.leavelLineList.value[index].first
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
                                    child: Text("Second-Half"), value: 3),
                                //DropdownMenuItem(child: Text("None"), value: 4),
                              ],
                              onChanged: (value) {
                                updateTime = false;
                                controller.updateLeaveInterval(index, value!);
                              }),
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
        ),
      ),
    );
  }

  Widget leaveRequestDateAdjustWidget(BuildContext context) {
    return Container();
  }

  Widget leaveTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
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
                      child: DropdownButton<LeaveType>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Leave Type",
                              )),
                          value: controller.selectedLeaveType,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (LeaveType? value) {
                            print(value!.name);
                            print(value!.id);
                            controller.onChangeLeaveTypeDropdown(value!);
                          },
                          items:
                              controller.leavetype_list.map((LeaveType leave) {
                            return DropdownMenuItem<LeaveType>(
                              value: leave,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  leave.name,
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

  @override
  Widget build(BuildContext context) {
    leavelistreponse = Get.arguments;
    if (leavelistreponse == null) {
    } else {
      starttime = leavelistreponse.start_date.toString();
      endtime = leavelistreponse.end_date.toString();
      starttimeDate = DateTime.parse(leavelistreponse.start_date.toString());

      endtimeDate = DateTime.parse(leavelistreponse.end_date.toString());
      controller.durationController.text = leavelistreponse.duration.toString();
      controller.descriptionController.text =
          leavelistreponse.description.toString();
      idData = leavelistreponse.holiday_status_id!.name.toString();
      //
      /*Future.delayed(Duration(seconds: 3), () {
        controller.fetchLeaveLine(starttimeDate, endtimeDate);
        // controller.calculateinterval(starttimeDate, starttimeDate);
        // controller.updateLeaveInterval(index, 3);
      });*/
      controller.is_add_leavelist.value = true;
      // controllerList.leaveList.value[index].leave_line;
      controller.leavelLineList.value = leavelistreponse.leave_line!;

      selectedFromDate = DateTime.parse(leavelistreponse.start_date.toString());
      selectedToDate = DateTime.parse(leavelistreponse.end_date.toString());
      if (leavelistreponse.attachment!.isNotEmpty)
        controller.isShowImage.value = true;
      print('image : ${leavelistreponse}');
      controller.image_base64 = leavelistreponse.attachment!;
      controller.selectedLeaveType = LeaveType(
          id: leavelistreponse.holiday_status_id!.id,
          name: leavelistreponse.holiday_status_id!.name,
          show_in_mobile_app: false);
    }
    user_image = box.read('emp_image');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leave Request Edit",
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              if (checkLeave)
                if (leavelistreponse != null)
                  InkWell(
                    onTap: () {
                      setState(() {
                        checkLeave = false;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, // set border color
                              width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(
                              0.0)), // set rounded corner radius
                        ),
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        height: 50,
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(idData.toString()),
                          ),
                        )),
                  ),
              if (checkLeave == false) leaveTypeDropDown(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context, "Start Date", starttime),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context, "End Date", endtime),
                        )),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      enabled: false,
                      controller: controller.durationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Days")),
                      ),
                      onChanged: (text) {},
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     hintText: ("Description"),
                    //   ),
                    //   onChanged: (text) {},
                    // ),
                    child: TextField(
                      maxLines: 5,
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        hintText: "Description",
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: const Color.fromRGBO(250, 250, 250, 1))),
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showOptions(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              child: controller.isShowImage.value == false
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: textFieldTapColor),
                                      height: 45,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 30,
                                      ))
                                  : controller
                                                .selectedImage.value!=null && controller
                                                .selectedImage.value!= "" && controller
                                                .selectedImage.value!.path!="" ? Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Image.file(controller
                                                .selectedImage.value!)),
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
                                    ): SizedBox(),
                            ),
                          ),
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       print("View Payment Click");
                        //       _showChoiceDialog(context);
                        //     },
                        //     child: Icon(Icons.camera_alt)),
                        _decideImageView(),
                      ],
                    )),
              ),
              SizedBox(height: 20),
              // Obx(() => controller.is_add_leavelist.value
              //     ? leaveTitleWidget(context)
              //     : new Container()),
              // SizedBox(
              //   height: 10,
              // ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => controller.is_add_leavelist.value
                  ? leaveWidget(context)
                  : new Container()),
              Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: GFButton(
                    color: textFieldTapColor,
                    onPressed: () {
                      controller.requestUpdateLeave(
                          controller.durationController.text,
                          leavelistreponse.id.toString());
                    },
                    text: "Update",
                    blockButton: true,
                    size: GFSize.LARGE,
                  )),
              leaveRequestDateAdjustWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(compressedFile, img64);
  }

  clearData() {
    controller.fromDateTextController.text = "";
    controller.toDateTextController.text = "";
    controller.descriptionController.text = "";
    controller.durationController.text = "";
    controller.leavelLineList.clear();
  }
}
