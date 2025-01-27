

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/expense_travel_list/expense_travel_list_controller.dart';
import '../controllers/travel_list_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/business_travel_create.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BusinessTravelList extends StatefulWidget {
  @override
  _BusinessTravelState createState() => _BusinessTravelState();
}

class _BusinessTravelState extends State<BusinessTravelList> {
  ExpensetravelListController controller =
      Get.put(ExpensetravelListController());

  Future _loadData() async {
    print("****load more****");
    controller.getExpenseListForEmp();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    return Scaffold(
      body: GetBuilder<ExpensetravelListController>(
        init: ExpensetravelListController(),
        initState: (_) => controller.getExpenseListForEmp(),
        builder: (controller) => RefreshIndicator(
          onRefresh: controller.getExpenseListForEmp,
          child: NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                print("*****BottomOfLeaveList*****");
                // start loading data
                controller.offset.value += limit;
                controller.isLoading.value = true;
                _loadData();
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.travelExpenseList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.EXPENSE_TRAVEL_DETAILS,
                          arguments: index);
                    },
                    child: Card(
                      elevation: 5,
                      shape:OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none),
                      surfaceTintColor: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 20, bottom: 5, top: 20),
                                child: Text(
                                  AppUtils.changeDateFormat(controller.travelExpenseList.value[index].date),
                                  style: subtitleStyle(),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(right: 20, bottom: 5, top: 10),
                                child: controller.travelExpenseList.value[index].travel_id!=null?Text(
                                  controller.travelExpenseList.value[index].travel_id.name
                                      .toString(),
                                  style: subtitleStyle(),
                                ):SizedBox(),
                              ),
                            ],
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 10),
                                child: Text(
                                  controller.travelExpenseList.value[index]
                                      .employee_id.name
                                      .toString(),
                                  style: subtitleStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 20, right: 20),
                                child: 
                                controller
                                      .travelExpenseList.value[index].state
                                      .toString()=="finance_approve"?
                                      Text("Finance approve",style: maintitleStyle(),):
                                Text(
                                  controller
                                      .travelExpenseList.value[index].state
                                      .toString().capitalize!,
                                  style: maintitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 5),
                            // child: controller
                            //             .travelExpenseList.value[index].state !=
                            //         'draft'
                            //     ? Text(
                            //         controller
                            //             .travelExpenseList.value[index].number
                            //             .toString(),
                            //         style: subtitleStyle(),
                            //       )
                            //     : SizedBox(),
                            child:Text(
                              controller
                                  .travelExpenseList.value[index].number
                                  .toString(),
                              style: subtitleStyle(),
                            ),
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
            List status = controller.travelExpenseList
                .where((value) => value.state == 'draft')
                .toList();
            if (status.length > 0) {
              AppUtils.showToast('Cannot Create!');
            } else {
              Get.toNamed(Routes.BUSINESS_TRAVEL_CREATE);
            }
          }),
    );
  }
}
