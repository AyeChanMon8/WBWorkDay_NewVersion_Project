import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../constants/globals.dart';
import '../controllers/attendance_request_controller.dart';
import '../controllers/user_profile_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AttendanceRequest extends GetWidget<AttendanceRequestController> {
  AttendanceRequestController _attendanceController =
      Get.put(AttendanceRequestController());
  final UserProfileController _userProfileController = Get.find();
  var box = GetStorage();
  String image = '';
  Location location = new Location();

  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  late LocationData? _locationData;
  @override
  Widget build(BuildContext context) {
    final attendance = box.read("mobile_app_attendance");
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    _checkPermission();

    String currentDate = AppUtils.formatter.format(DateTime.now());
    final tokenDate =
        AppUtils.formatter.format(DateTime.parse(box.read(Globals.tokenDate)));
    if (currentDate == tokenDate) {
      _attendanceController.check_in.value =
          box.read(Globals.check_in_or_not) ?? false;
    } else {
      _attendanceController.check_in.value = false;
    }
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    var now = new DateTime.now();
    var current_mon = now.month;
    var current_date = now.day.toString() +
        "/" +
        months[current_mon - 1] +
        "/" +
        now.year.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.attendanceRequest,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            margin: EdgeInsets.only(left: 20, top: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    current_date,
                    textAlign: TextAlign.center,
                    style: textfieldStyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '${now.hour} : ${now.minute}',
                    textAlign: TextAlign.center,
                    style: labelGreyHightlightTextStyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    labels.welcome,
                    textAlign: TextAlign.center,
                    style: labelPrimaryTitleBoldTextStyle(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: _userProfileController.empData.value.name != null
                      ? Text(
                          _userProfileController.empData.value.name,
                          textAlign: TextAlign.center,
                          style: labelPrimaryTitleBoldTextStyle(),
                        )
                      : Text(''),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    if (attendance != null) {
                      _getLocation().then((value) {
                        controller.makeAttendance(_userProfileController
                            .empData.value.fingerprint_id);
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Sorry...!"),
                              scrollable: true,
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                          "You are not available for this feature!")
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                      child: Text("Close"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromRGBO(60, 47, 126, 1),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        // controller.editPhoneNo();
                                      }),
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.white,
                    child: Card(
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      elevation: 5,
                      child: Obx(
                        () => controller.check_in.value
                            ? Container(
                                child: attendanceCheckOutIcon,
                              )
                            : Container(
                                child: attendanceCheckInIcon,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Container(
                    child: controller.check_in.value
                        ? Text(
                            labels.checkOut,
                            textAlign: TextAlign.center,
                            style: labelPrimaryTitleBoldTextStyle(),
                          )
                        : Text(
                            labels.checkIn1,
                            textAlign: TextAlign.center,
                            style: labelPrimaryTitleBoldTextStyle(),
                          ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.check_in.value
                          ? labels.records
                          : labels.checkOut,
                      style: labelPrimaryTitleTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Expanded(
                        flex: 2,
                        child: Text(
                          labels.checkIn2,
                          textAlign: TextAlign.center,
                          style: labelPrimaryHightlightTextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        flex: 2,
                        child: Text(
                          labels.checkOut,
                          textAlign: TextAlign.center,
                          style: labelPrimaryHightlightTextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        flex: 1,
                        child: Text(
                          labels.workHours,
                          textAlign: TextAlign.center,
                          style: labelPrimaryHightlightTextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.attendance_list.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        var check_in_date_time = AppUtils.changeDateTimeFormat(
                            controller.attendance_list.value[index].check_in);
                        var check_out_date_time = AppUtils.changeDateTimeFormat(
                            controller.attendance_list.value[index].check_out);
                        var utc_checkin_date = controller
                            .attendance_list[index].check_in
                            .toString();
                        var utc_checkout_date = controller
                            .attendance_list[index].check_out
                            .toString();
                        var check_in_value = '-----------';
                        if (utc_checkin_date.isNotEmpty) {
                          var checkIn = DateFormat("yyyy-MM-dd hh:mm:ss")
                              .parse(utc_checkin_date, true);
                          check_in_value =
                              checkIn.toLocal().toString().split(" ")[0] +
                                  " " +
                                  checkIn
                                      .toLocal()
                                      .toString()
                                      .split(" ")[1]
                                      .split(".000")[0];
                          check_in_value = DateFormat("dd/MM/yyyy HH:mm:ss")
                              .format(DateTime.parse(check_in_value));
                        }

                        var check_out_value = "------------";
                        if (utc_checkout_date.isNotEmpty) {
                          var checkOut = DateFormat("yyyy-MM-dd hh:mm:ss")
                              .parse(utc_checkout_date, true);
                          check_out_value =
                              checkOut.toLocal().toString().split(" ")[0] +
                                  " " +
                                  checkOut
                                      .toLocal()
                                      .toString()
                                      .split(" ")[1]
                                      .split(".000")[0];
                          check_out_value = DateFormat("dd/MM/yyyy HH:mm:ss")
                              .format(DateTime.parse(check_out_value));
                        }

                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Expanded(
                                  flex: 2,
                                  child: Text(
                                    check_in_date_time,
                                    textAlign: TextAlign.center,
                                    style: labelPrimaryHightlightTextStyle(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Expanded(
                                  flex: 2,
                                  child: Text(
                                    // controller
                                    //     .attendance_list.value[index].check_out,
                                    check_out_value,
                                    textAlign: TextAlign.center,
                                    style: labelPrimaryHightlightTextStyle(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Expanded(
                                  flex: 1,
                                  child: Text(
                                    NumberFormat("#.##").format(controller
                                        .attendance_list
                                        .value[index]
                                        .worked_hours),
                                    textAlign: TextAlign.center,
                                    style: labelPrimaryHightlightTextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myListview(BuildContext context) {
    // the Expanded widget lets the columns share the space
    Widget column = Expanded(
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Title',
            style: TextStyle(fontSize: 16),
          ),
          Text('subtitle'),
        ],
      ),
    );

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                column,
                column,
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getLocation() async {
    _locationData = await location.getLocation().then((value) {
      print('locationReceived');
      print(value.latitude);
      print(value.longitude);
      controller.user_latitude.value = value.latitude!;
      controller.user_longitude.value = value.longitude!;
    });
  }

  Future<void> _checkPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
