import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../controllers/overtime_response_list_controller.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OverTimeResponseListPage extends StatelessWidget {
  OverTimeResponseListController controller = Get.find();
  bool declined = true;
  bool accept = true;
  bool visiblebutton = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final formatTime = DateFormat("HH:mm:ss");
  final timeFormat = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
        body: SafeArea(
            child: DefaultTabController(
                length: 3,
                child: Column(children: <Widget>[
                  // Row(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(left: 15),
                  //       child: Text(
                  //         labels?.sortBy,
                  //         style: maintitleStyle(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                        // backgroundColor: Colors.deepPurple,
                        // unselectedBackgroundColor: Colors.grey[300],
                        unselectedLabelStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.check),
                            text: labels?.accept,
                          ),
                          Tab(
                            icon: Icon(Icons.cancel),
                            text: labels?.declined,
                          ),
                          Tab(
                            icon: Icon(Icons.timer),
                            text: labels?.draft,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GetBuilder<OverTimeResponseListController>(
                      init: OverTimeResponseListController(),
                      initState: (_) =>controller.getOtResponseList(),
                      builder:(controller)=>
                      Expanded(
                          child: TabBarView(children: <Widget>[
                            acceptResponseView(context),
                            declineResponseView(context),
                            draftResponseView(context),
                          ]))
                  ),

                ])
            )
        )
    );
  }


  Widget acceptResponseView(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Obx(
          () => ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.otAcceptedList.length,
        itemBuilder: (BuildContext context, int index) {
          var start_date_time = AppUtils.changeDateTimeFormat(controller
              .otAcceptedList.value[index].start_date);
          return Container(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.OVER_TIME_RESPONSE_DETAILS_PAGE,
                      arguments: index.toString()+"state_accept",
                    );
                  },
                  child: Card(
                    semanticContainer: true,
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                      // leading: CircleAvatar(
                      //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                      //   child: ClipRRect(
                      //     borderRadius: new BorderRadius.circular(50.0),
                      //     child: Image.network(
                      //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      title: Text(
                        controller.otAcceptedList.value[index].employee_id!.name
                            .toString(),
                        // "Attendance Regualarization",
                        style: maintitleStyle(),
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otAcceptedList.value[index].name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  controller.otAcceptedList.value[index].state
                                      .toString().toUpperCase(),
                                  style: subtitleStyle(),
                                ),
                              ]),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otAcceptedList.value[index]
                                      .requested_employee_id!.name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  start_date_time,
                                  style: subtitleStyle(),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )));
        },
      ),
    );
  }

  Widget declineResponseView(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Obx(
          () => ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.otDeclinedList.length,
        itemBuilder: (BuildContext context, int index) {
          var start_date_time = AppUtils.changeDateTimeFormat(controller
              .otDeclinedList.value[index].start_date);
          // var end_date_time = AppUtils.changeDateTimeFormat(controller
          //     .otDeclinedList.value[index].end_date);
          return Container(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.OVER_TIME_RESPONSE_DETAILS_PAGE,
                      arguments: index.toString()+"state_decline",
                    );
                  },
                  child: Card(
                    semanticContainer: true,
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                      // leading: CircleAvatar(
                      //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                      //   child: ClipRRect(
                      //     borderRadius: new BorderRadius.circular(50.0),
                      //     child: Image.network(
                      //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      title: Text(
                        controller.otDeclinedList.value[index].employee_id!.name
                            .toString(),
                        // "Attendance Regualarization",
                        style: maintitleStyle(),
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otDeclinedList.value[index].name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  controller.otDeclinedList.value[index].state
                                      .toString() == 'cancel' ? 'Declined' :   controller.otDeclinedList.value[index].state
                                      .toString().toUpperCase(),
                                  style: subtitleStyle(),
                                ),
                              ]),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otDeclinedList.value[index]
                                      .requested_employee_id!.name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  start_date_time,
                                  style: subtitleStyle(),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )));
        },
      ),
    );
  }

  Widget draftResponseView(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Obx(
          () => ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.otDraftList.length,
        itemBuilder: (BuildContext context, int index) {
          var start_date_time = AppUtils.changeDateTimeFormat(controller
              .otDraftList.value[index].start_date);
          return Container(
              child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.OVER_TIME_RESPONSE_DETAILS_PAGE,
                      arguments: index.toString()+"state_draft",
                    );
                  },
                  child: Card(
                    semanticContainer: true,
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                      title: Text(
                        controller.otDraftList.value[index].employee_id!.name
                            .toString(),
                        // "Attendance Regualarization",
                        style: maintitleStyle(),
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otDraftList.value[index].name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  controller.otDraftList.value[index].state
                                      .toString().toUpperCase(),
                                  style: subtitleStyle(),
                                ),
                              ]),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.otDraftList.value[index]
                                      .requested_employee_id!.name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                                Text(
                                  start_date_time,
                                  style: subtitleStyle(),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )));
        },
      ),
    );
  }
}