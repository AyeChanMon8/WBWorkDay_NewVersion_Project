import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/leave_list_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LeaveListPage extends StatefulWidget {

  @override
  _LeaveListPage createState() => _LeaveListPage();
}

class _LeaveListPage extends State<LeaveListPage>{
  final LeaveListController controller = Get.put(LeaveListController());
  var box = GetStorage();
  Future _loadData() async {
    controller.getLeaveList();
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    var role_category = box.read('role_category');
    return Scaffold(
      body: GetBuilder<LeaveListController>(
        init: LeaveListController(),
        builder:(controller) => RefreshIndicator(
          onRefresh: controller.getLeaveList,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if(controller.leaveList.length>=Globals.pag_limit){
                  controller.offset.value +=limit;
                  controller.isLoading.value = true;
                  _loadData();
                }

              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.leaveList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LEAVE_DETAILS, arguments: index)!.then((value) {
                        if(value!=null){
                          controller.offset.value =0;
                          controller.getLeaveList();
                        }
                      } );
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 20),
                                child: Text(
                                  controller.leaveList.value[index]
                                      .holiday_status_id!.name.toUpperCase(),
                                  style: subtitleStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 20, right: 20),
                                child: Text(
                                  controller.leaveList.value[index].duration
                                      .toString() +
                                      " Days",
                                  style: maintitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 5),
                                child: Text(
                                  AppUtils.changeDateFormat(controller.leaveList.value[index].start_date)
                                    +
                                      "-" +
                                  AppUtils.changeDateFormat(controller.leaveList.value[index].end_date),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin:
                                  EdgeInsets.only(left: 20, bottom: 20, top: 5),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                      style: datalistStyle(),
                                      text: controller
                                          .leaveList.value[index].description,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  controller.leaveList.value[index].state.toUpperCase(),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
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
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(
            FontAwesomeIcons.plus,
            color: barBackgroundColorStyle,
          ),
          backgroundColor: selectedItemBackgroundColorStyle,
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LeaveTripRequest()));
            Get.toNamed(Routes.LEAVE_REQUEST);
          }),
    );
  }
}
