
import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants/globals.dart';
import '../controllers/attendance_report_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AttendanceReport extends StatelessWidget {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  DateTime selected_from_date = DateTime.now();
  DateTime selected_to_date = DateTime.now();
  bool isChecked = false;
  AttendanceReportController controller = AttendanceReportController();
  late Uint8List bytes;
  final box = GetStorage();
  String image = '';
  String role_category = '';
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AttendanceReportController());
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _getMoreData();
        print("_scrollController");
        controller.getOwnAttendance(controller.offest);
      }
    });*/
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    role_category = box.read('role_category');
    print("*role***");
    print(role_category);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            labels!.attendanceReport,
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
            child: DefaultTabController(
                length: role_category == 'manager' ? 3 : 1,
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: role_category == 'manager'
                        ? Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            height: 45,
                            child: ButtonsTabBar(
                                // controller: controller,
                                backgroundColor: Colors.deepPurple,
                                unselectedBackgroundColor: Colors.grey[300],
                                unselectedLabelStyle:
                                    TextStyle(color: Colors.black),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                tabs: [
                                  Tab(
                                    icon: Icon(Icons.history),
                                    text: labels.selfHistory,
                                  ),
                                  Tab(
                                    icon: Icon(Icons.check),
                                    text: labels.approvalList,
                                  ),
                                  Tab(
                                    icon: Icon(Icons.history),
                                    text: labels.employeeHistory,
                                  ),
                                  // Tab(
                                  //   icon: Icon(Icons.timer),
                                  //   text: labels?.late,
                                  // ),
                                  // Tab(
                                  //   icon: Icon(Icons.timer),
                                  //   text: labels?.early,
                                  // ),
                                  // Tab(
                                  //   icon: Icon(Icons.date_range),
                                  //   text: labels?.date,
                                  // ),
                                ]),
                          )
                        : TabBar(
                            // controller: ,
                            // backgroundColor: Colors.deepPurple,
                            // unselectedBackgroundColor: Colors.grey[300],
                            unselectedLabelStyle:
                                TextStyle(color: Colors.black),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            tabs: [
                                Tab(
                                  icon: Icon(Icons.history),
                                  text: labels.selfHistory,
                                ),
                                // Tab(
                                //   icon: Icon(Icons.check),
                                //   text: labels?.approve,
                                // ),
                                // Tab(
                                //   icon: Icon(Icons.timer),
                                //   text: labels?.late,
                                // ),
                                // Tab(
                                //   icon: Icon(Icons.timer),
                                //   text: labels?.early,
                                // ),
                                // Tab(
                                //   icon: Icon(Icons.date_range),
                                //   text: labels?.date,
                                // ),
                              ]),
                  ),
                  Expanded(
                      child: role_category == 'manager'
                          ? TabBarView(children: <Widget>[
                              employeeOwnHistory(context),
                              toApproveView(context),
                              employeeHistory(context),
                            ])
                          : TabBarView(children: <Widget>[
                              employeeOwnHistory(context),
                            ])),
                ]))));
  }

  Widget specialChar(String title) {
    return Container(
      child: ButtonTheme(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
          onPressed: () {},
          child: Text(
            title,
            style: labelGreyStyle(),
          ),
        ),
      ),
    );
  }

  Widget specialCharsPanel(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Material(
        elevation: 0.0,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            specialChar(labels!.name),
            specialChar(labels.late),
            specialChar(labels.early),
          ],
        ),
      ),
    );
  }

  Widget toApproveView(BuildContext context) {
    controller.check_select_all.value = false;
    controller.offset.value = 0;
    var limit = Globals.pag_limit;
    final labels = AppLocalizations.of(context);
    Future _loadData() async {
      controller.getAttendanceToApprove();
    }

    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              controller.check_select_show.value
                  ? Container(
                      padding: EdgeInsets.only(left: 10, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   "Choose Date : ",
                              //   style: datalistStyle(),
                              // ),
                              Obx(() =>
                                  controller.attendance_ids_list.length > 0
                                      ? GFButton(
                                          color: textFieldTapColor,
                                          onPressed: () {
                                            showAlertDialog(context, 0, 0, '0');
                                          },
                                          text: "Approve",
                                          size: GFSize.MEDIUM,
                                        )
                                      : new Container())

                              // Container(
                              //     // formatted.toString(),
                              //     // style: subTitleStyle(),
                              //     ),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              // Text(
                              //   "to " + formatted.toString(),
                              //   style: subTitleStyle(),
                              // ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  "Select All",
                                  style: datalistStyle(),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Obx(
                                () => GFCheckbox(
                                  size: GFSize.SMALL,
                                  activeBgColor: GFColors.DANGER,
                                  onChanged: (value) {
                                    print(value);
                                    controller.check_select_all.value = value;
                                    controller.updateCheckSelectALlForAllReport(
                                        value);
                                    if (value) {
                                      //showAlertDialog(context, 0, 0, "all");
                                    }
                                  },
                                  value: controller.check_select_all.value,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : new Container(),
              Container(
                child: Obx(
                  () => NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!controller.isLoading.value &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        if (controller.attendance_custom_report.length >=
                            Globals.pag_limit) {
                          controller.offset.value += limit;
                          controller.isLoading.value = true;
                          _loadData();
                        }
                      }
                      return true;
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.attendance_custom_report.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        var attendance_date = AppUtils.changeDateFormat(
                            controller.attendance_custom_report[index].date);

                        return Card(
                          elevation: 3,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, top: 10.0, bottom: 10.0, right: 10),
                            // leading: CircleAvatar(
                            //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                            //   child: ClipRRect(
                            //     borderRadius: new BorderRadius.circular(50.0),
                            //     child: bytes != null
                            //         ? new Image.memory(
                            //             bytes,
                            //             fit: BoxFit.fitWidth,
                            //           )
                            //         : new Container(),
                            //   ),
                            // ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      attendance_date,
                                      style: maintitleStyle(),
                                    ),
                                    // Obx(
                                    //   () => GFCheckbox(
                                    //     size: GFSize.SMALL,
                                    //     activeBgColor: GFColors.DANGER,
                                    //     onChanged: (value) {
                                    //       controller.updateCheck(
                                    //           index, value, 'all');
                                    //       if (value) {
                                    //         showAlertDialog(
                                    //             context, 'all', 'single', index);
                                    //       }
                                    //     },
                                    //     value: controller.attendance_toapprove_list
                                    //         .value[index].check,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: employeeListWidget(context, index),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget employeeListWidget(BuildContext context, int index) {
    final labels = AppLocalizations.of(context);

    return Obx(
      () => Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller
              .attendance_custom_report.value[index].attendance_list.length,
          itemBuilder: (BuildContext context, int position) {
            var utc_checkin_date = controller.attendance_custom_report
                .value[index].attendance_list[position].check_in
                .toString();
            var utc_checkout_date = controller.attendance_custom_report
                .value[index].attendance_list[position].check_out
                .toString();
            var check_in_date = '----------------';
            if (utc_checkin_date.isNotEmpty) {
              var checkIn = DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(utc_checkin_date, true);
              check_in_date =
                  checkIn.toLocal().toString().split(" ")[1].split(".000")[0];
            }
            var check_out_date = '---------------';
            if (utc_checkout_date.isNotEmpty) {
              var checkOut = DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(utc_checkout_date, true);
              check_out_date =
                  checkOut.toLocal().toString().split(" ")[1].split(".000")[0];
            }
            var num1 = controller.attendance_custom_report.value[index]
                .attendance_list[position].worked_hours;
            var work_hours = double.parse(num1.toStringAsFixed(2));
            var emp_name = controller.attendance_custom_report.value[index]
                .attendance_list[position].employee_id.name;
            return Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            emp_name,
                            textAlign: TextAlign.start,
                            style: datalistStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            check_in_date + " to " + check_out_date,
                            textAlign: TextAlign.center,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            work_hours.toString() + " Hr",
                            textAlign: TextAlign.end,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.all(5.0),
                          child: GFCheckbox(
                            size: GFSize.SMALL,
                            activeBgColor: GFColors.DANGER,
                            onChanged: (value) {
                              controller.updateSingleCheck(
                                  index, value, position);
                              if (value) {
                                // showAlertDialog(
                                //     context, index, position, 'single');
                              }
                            },
                            value: controller.attendance_custom_report
                                .value[index].attendance_list[position].check,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget employeeHistory(BuildContext context) {
    final labels = AppLocalizations.of(context);
    controller.offset.value = 0;
    var limit = Globals.pag_limit;
    Future _loadData() async {
      controller.getEmpHistory();
    }

    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!controller.isLoading.value &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    if (controller.attendance_employee_history.length >=
                        Globals.pag_limit) {
                      controller.offset.value += limit;
                      controller.isLoading.value = true;
                      _loadData();
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      controller.attendance_employee_history.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0, right: 10),
                        // leading: CircleAvatar(
                        //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                        //   child: ClipRRect(
                        //     borderRadius: new BorderRadius.circular(50.0),
                        //     child: bytes != null
                        //         ? new Image.memory(
                        //             bytes,
                        //             fit: BoxFit.fitWidth,
                        //           )
                        //         : new Container(),
                        //   ),
                        // ),
                        // title: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           "Hein Soe",
                        //           // "Attendance Regualarization",
                        //           style: maintitleStyle(),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 5,
                        //     )
                        //   ],
                        // ),
                        subtitle: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  controller.attendance_employee_history
                                      .value[index].employee_name,
                                  style: listTileStyle(),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      controller.attendance_employee_history
                                          .value[index].count
                                          .toString(),
                                      style: labelStyle(),
                                    ),
                                  ),
                                  IconButton(
                                    icon: arrowforwardIcon,
                                    onPressed: () {
                                      Get.toNamed(
                                          Routes.ATTENDANCE_APPROVAL_LIST,
                                          arguments: controller
                                              .attendance_employee_history
                                              .value[index]);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          // Get.toNamed(Routes.APPORVAL_OVERTIME_DETAILS,
                          //     arguments: index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget employeeOwnHistory(BuildContext context) {
    final labels = AppLocalizations.of(context);
    controller.offset.value = 0;
    var limit = Globals.pag_limit;

    Future _loadData() async {
      controller.getOwnAttendance();
    }

    return Obx(
      () => NotificationListener<ScrollNotification>(
        // ignore: missing_return
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            print("*****BottomOfTravelList*****");
            // start loading data
            controller.offset.value += limit;
            controller.isLoading.value = true;
            _loadData();
          }
          return true;
        },
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.attendance_own_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            var num1 = controller.attendance_own_list[index].worked_hours;
            var work_hours = double.parse(num1.toStringAsFixed(2));

            var utc_checkin_date =
                controller.attendance_own_list[index].check_in.toString();
            var utc_checkout_date =
                controller.attendance_own_list[index].check_out.toString();
            var check_in_value = '-----------';
            if (utc_checkin_date.isNotEmpty) {
              var checkIn = DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(utc_checkin_date, true);
              check_in_value =
                  checkIn.toLocal().toString().split(" ")[1].split(".000")[0];
              // check_in_value =
              //     checkIn.toString().split(" ")[1].split(".000")[0];
            }
            var check_out_value = "------------";
            if (utc_checkout_date.isNotEmpty) {
              var checkOut = DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(utc_checkout_date, true);
              check_out_value =
                  checkOut.toLocal().toString().split(" ")[1].split(".000")[0];
              // check_out_value =
              //     checkOut.toString().split(" ")[1].split(".000")[0];
            }

            // var attendance_date = AppUtils.changeDateFormat(controller
            //     .attendance_own_list[index].check_in
            //     .toString()
            //     .split(" ")[0]);
            var attendance_date = AppUtils.changeDateAndTimeFormat(
                controller.attendance_own_list[index].check_in);
            var status = controller.attendance_own_list[index].is_absent
                ? "Absent"
                : controller.attendance_own_list[index].missed
                    ? "Missed"
                    : controller.attendance_own_list[index].travel
                        ? "Travel"
                        : controller.attendance_own_list[index].leave
                            ? "Leave"
                            : controller
                                    .attendance_own_list[index].no_worked_day
                                ? "No Work Day Leave"
                                : controller
                                        .attendance_own_list[index].plan_trip
                                    ? "Plan Trip"
                                    : controller
                                            .attendance_own_list[index].day_trip
                                        ? "Day Trip"
                                        : "";

            return Card(
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 10.0, right: 10),
                // leading: CircleAvatar(
                //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                //   child: ClipRRect(
                //     borderRadius: new BorderRadius.circular(50.0),
                //     child: bytes != null
                //         ? new Image.memory(
                //       bytes,
                //       fit: BoxFit.fitWidth,
                //     )
                //         : new Container(),
                //   ),
                // ),
                // title: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           attendance_date,
                //           style: maintitleStyle(),
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 5,
                //     )
                //   ],
                // ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            attendance_date,
                            textAlign: TextAlign.start,
                            style: datalistStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            check_in_value + " to " + check_out_value,
                            textAlign: TextAlign.center,
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            work_hours.toString() + " Hr",
                            textAlign: TextAlign.end,
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Text(
                          status,
                          textAlign: TextAlign.end,
                          style: datalistStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          //controller: _scrollController,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Obx(() => new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: new Opacity(
              opacity: controller.isLoading.value ? 1.0 : 00,
              child: new CircularProgressIndicator(),
            ),
          ),
        ));
  }

  Widget dateWidget(BuildContext context, String date) {
    var date_controller;
    if (date == 'Start Date') {
      date_controller = controller.fromDateTextController;
    } else if (date == 'End Date') {
      date_controller = controller.toDateTextController;
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
                    if (controller.fromDateTextController!.text.isNotEmpty) {
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
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future<Null> _selectDate(BuildContext context, String date) async {
    // DateTime selectedFromDate = DateTime.now();
    // DateTime selectedToDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext? context, Widget? child) {
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
      if (date == 'Start Date') {
        selected_from_date = picked;

        controller.fromDateTextController!.text =
            ("${selected_from_date.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.fromDateTextController!.text = formatter.format(picked);
      } else {
        selected_to_date = picked;

        controller.toDateTextController!.text =
            ("${selected_to_date.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');

        controller.toDateTextController!.text = formatter.format(picked);
        controller.filterByDate(selected_from_date, selected_to_date);
      }
    }
  }

  showAlertDialog(
      BuildContext context, int parent_index, int child_index, String select) {
    var message = "";
    // if (select == 'single') {
    //   message = "Would you like to approve this attendance?";
    // } else {
    //   message = "Would you like to approve all attendance?";
    // }
    message = "Would you like to approve this attendance?";
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("On Duty"),
      onPressed: () {
        Navigator.of(context).pop();
        // if (select == 'single') {
        //   controller.approveOneAttendance(parent_index, child_index);
        // } else {
        //   controller.approveAllAttendance();
        // }

        controller.approveAllAttendance();
      },
    ); //
    Widget declineButton = TextButton(
      child: Text("Action"),
      onPressed: () {
        Navigator.of(context).pop();
        // if (select == 'single') {
        //   controller.declineOneAttendance(parent_index, child_index);
        // } else {
        //   print('decline all attendance');
        //   controller.declineAllAttendance();
        // }
        controller.declineAllAttendance();
      },
    ); //// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text(message),
      actions: [
        continueButton,
        declineButton,
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
}
