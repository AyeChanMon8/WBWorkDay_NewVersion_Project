

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/travel_list_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TravelListPage extends StatefulWidget {
  @override
  _TravelListPage createState() => _TravelListPage();
}

class _TravelListPage extends State<TravelListPage> {
  final TravelListController controller = Get.put(TravelListController());
  Future _loadData() async {
    controller.getTravelList();
  }

  @override
  void initState() {
    controller.offset.value = 0;
    controller.getTravelList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    final labels = AppLocalizations.of(context);
    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTravelList,
          child: NotificationListener<ScrollNotification>(
              // ignore: missing_return
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoading.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  if (controller.travelLineList.length >= Globals.pag_limit) {
                    controller.offset.value += limit;
                    controller.isLoading.value = true;
                    _loadData();
                  }
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.travelLineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => TravelRequest()));

                        Get.toNamed(Routes.TRAVEL_DETAILS, arguments: index)?.then((value) {
                          if (value != null) {
                            controller.offset.value = 0;
                            controller.getTravelList();
                          }
                        });
                      },
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, top: 10),
                              child: controller
                                          .travelLineList.value[index].state !=
                                      'draft'
                                  ? Text(
                                      controller
                                          .travelLineList.value[index].name
                                          .toUpperCase(),
                                      style: datalistStyle(),
                                    )
                                  : Text(''),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 10, top: 10),
                                  child: Text(
                                    controller.travelLineList.value[index]
                                            .city_from
                                            .toUpperCase() +
                                        "-" +
                                        controller
                                            .travelLineList.value[index].city_to
                                            .toUpperCase(),
                                    style: maintitleStyle(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 10, top: 10, right: 20),
                                  child: Text(
                                    controller.travelLineList.value[index]
                                            .duration
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
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 10, top: 5),
                                  child: Text(
                                    AppUtils.changeDateFormat(controller
                                            .travelLineList
                                            .value[index]
                                            .start_date) +
                                        "-" +
                                        AppUtils.changeDateFormat(controller
                                            .travelLineList
                                            .value[index]
                                            .end_date),
                                    style: subtitleStyle(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, bottom: 20, top: 5),
                                    child: controller
                                                .travelLineList
                                                .value[index]
                                                .travel_line!
                                                .length >
                                            0
                                        ? Text(
                                            controller
                                                        .travelLineList
                                                        .value[index]
                                                        .travel_line![0]
                                                        .purpose !=
                                                    null
                                                ? controller
                                                    .travelLineList
                                                    .value[index]
                                                    .travel_line![0]
                                                    .purpose
                                                : '',
                                            style: datalistStyle(),
                                          )
                                        : Text(''),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        bottom: 20,
                                        top: 5,
                                        right: 20),
                                    child: controller.travelLineList
                                                .value[index].state !=
                                            null
                                        ? controller.travelLineList.value[index]
                                                    .state
                                                    .toUpperCase() ==
                                                "APPROVED"
                                            ? Text(
                                                "APPROVED",
                                                style: subtitleStyle(),
                                                textAlign: TextAlign.right,
                                              )
                                            : controller.travelLineList
                                                        .value[index].state
                                                        .toUpperCase() ==
                                                    "IN_PROGRESS"
                                                ? Text(
                                                    labels!.inProgress,
                                                    style: subtitleStyle(),
                                                    textAlign: TextAlign.right,
                                                  )
                                                : Text(
                                                    controller.travelLineList
                                                        .value[index].state
                                                        .toUpperCase(),
                                                    style: subtitleStyle(),
                                                    textAlign: TextAlign.right,
                                                  )
                                        : Text(''),
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
              )),
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
            //     MaterialPageRoute(builder: (context) => TravelRequest()));

            Get.toNamed(Routes.TRAVEL_REQUEST);
          }),
    );
  }
}


/*
body: Obx(
        () =>  controller.travelLineList.length == 0?
            Center(
              child: RaisedButton(
                onPressed: (){
                  controller.getTravelList();
                },
                child: Text('Refresh'),
              ),
            )
            :
            ListView.builder(
          shrinkWrap: true,
          itemCount: controller.travelLineList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => TravelRequest()));

                  Get.toNamed(Routes.TRAVEL_DETAILS, arguments: index);
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
                              controller.travelLineList.value[index].city_from +
                                  "-" +
                                  controller
                                      .travelLineList.value[index].city_to,
                              style: maintitleStyle(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, bottom: 10, top: 20, right: 20),
                            child: Text(
                              controller.travelLineList.value[index].duration
                                      .toString() +
                                  "Days",
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
                              controller
                                      .travelLineList.value[index].start_date +
                                  "/" +
                                  controller
                                      .travelLineList.value[index].end_date,
                              style: subtitleStyle(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 20, top: 5),
                            child: controller.travelLineList.value[index].travel_line.length > 0
                                ? Text(
                                    controller.travelLineList.value[index]
                                                .travel_line[0].purpose !=
                                            null
                                        ? controller.travelLineList.value[index]
                                            .travel_line[0].purpose
                                        : '',
                                    style: datalistStyle(),
                                  )
                                : Text(''),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, bottom: 20, top: 5, right: 20),
                            child:controller.travelLineList.value[index].state!=null?
                            Text(
                              controller.travelLineList.value[index].state,
                              style: subtitleStyle(),
                            ):Text(''),
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
 */