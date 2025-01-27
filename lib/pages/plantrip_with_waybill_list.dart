

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/plan_trip_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantripWithWayBillListPage extends StatefulWidget {
  final String pageType;

  PlantripWithWayBillListPage(this.pageType);
  @override
  _PlantripWithWayBillListPage createState() => _PlantripWithWayBillListPage();
}

class _PlantripWithWayBillListPage extends State<PlantripWithWayBillListPage> {
  final PlanTripController controller = Get.find();
  var box = GetStorage();
  var emp_id = 0;
  Future _loadData() async {
    controller.getPlantripWithWayBillList(widget.pageType);
  }

  @override
  void initState() {
    emp_id = int.tryParse(box.read('emp_id').toString())!;
    if (widget.pageType == 'open') {
      controller.getPlantripWithWayBillList('open');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    var role_category = box.read('role_category');
    return Scaffold(
      body: GetBuilder<PlanTripController>(
        init: PlanTripController(),
        builder: (controller) => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            print("limit : ${controller.waybill_offset.value}");
            print("limit : ${controller.plantrip_with_waybill_list.length}");
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              if (controller.plantrip_with_waybill_list.length >= 3) {
                // start loading data
                controller.waybill_offset.value += limit;
                controller.waybill_isLoading.value = true;
                _loadData();
              }
            }
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.plantrip_with_waybill_list.length,
            //controller.plantrip_with_waybill_list.length,
            itemBuilder: (BuildContext context, int index) {
              print(
                  "Name: ${controller.plantrip_with_waybill_list[index].spareId!.name}");
              print(
                  "WayLegth : ${controller.plantrip_with_waybill_list.length}");
              // var from_date = AppUtils.changeDefaultDateTimeFormat(controller
              //     .plantrip_with_waybill_list.value[index].fromDatetime);
              var from_date = AppUtils.changeDefaultDateTimeFormat(DateTime.parse(controller.plantrip_with_waybill_list.value[index].fromDatetime)
                                                .add(Duration(hours: 6, minutes: 30))
                                                .toString()
                                                .replaceAll('.000', ''));
              // var to_date = AppUtils.changeDefaultDateTimeFormat(controller
              //     .plantrip_with_waybill_list.value[index].toDatetime);
              var to_date = AppUtils.changeDefaultDateTimeFormat(DateTime.parse(controller.plantrip_with_waybill_list.value[index].toDatetime)
                                                .add(Duration(hours: 6, minutes: 30))
                                                .toString()
                                                .replaceAll('.000', ''));

              var routes = "";
              var route_names = [];
              if (controller.plantrip_with_waybill_list.value[index]
                      .routePlanIds!.length !=
                  0) {
                controller.plantrip_with_waybill_list.value[index].routePlanIds!
                    .forEach((element) {
                  route_names.add(element.routeId!.name);
                });
              }

              routes = route_names.join(",");
              return Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    // Get.toNamed(Routes.PLANTRIP_WAYBILL_DETAILS, arguments: controller.plantrip_with_waybill_list.value[index]).then((value) {
                    //   if(value!=null){
                    //     controller.waybill_offset.value = 0;
                    //     controller.getPlantripWithWayBillList(widget.pageType);
                    //   }
                    // } );
                    controller.current_page.value = widget.pageType;
                    Get.toNamed(Routes.PLANTRIP_WAYBILL_DETAILS,
                            arguments: index)?.then((value) {
                      if (value != null) {
                        controller.waybill_offset.value = 0;
                        controller.getPlantripWithWayBillList(widget.pageType);
                      }
                    });
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
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 20),
                              child: Text(
                                controller.plantrip_with_waybill_list
                                    .value[index].code,
                                style: subtitleStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 20, right: 20),
                              child: Text(
                                controller.plantrip_with_waybill_list
                                        .value[index].duration
                                        .toString() +
                                    " Days " +
                                    controller.plantrip_with_waybill_list
                                        .value[index].duration_hours
                                        .toStringAsFixed(2)
                                        .toString() +
                                    " Hrs",
                                style: maintitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            routes,
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                labels!.fromDate + '  ',
                                style: datalistStyle(),
                              ),
                              AutoSizeText(
                                '${from_date}',
                                style: maintitleStyle(),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                labels.toDate + '  ',
                                style: datalistStyle(),
                              ),
                              AutoSizeText(
                                '${to_date}',
                                style: maintitleStyle(),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                labels.driver + '  ',
                                style: datalistStyle(),
                              ),
                              AutoSizeText(
                                '${controller.plantrip_with_waybill_list[index].driverId!.name}',
                                style: maintitleStyle(),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 20, right: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: AutoSizeText(
                                      labels.spare + ' :',
                                      style: datalistStyle(),
                                    )),
                                    Expanded(
                                        flex: 3,
                                        child: controller
                                                        .plantrip_with_waybill_list[
                                                            index]
                                                        .spareId!
                                                        .name ==
                                                    "null" ||
                                                controller
                                                        .plantrip_with_waybill_list[
                                                            index]
                                                        .spareId!
                                                        .name ==
                                                    null
                                            ? Text("-")
                                            : AutoSizeText(
                                                '(${controller.plantrip_with_waybill_list[index].spareId!.name})',
                                                style: datalistStyle(),
                                              ))
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: controller.plantrip_with_waybill_list
                                            .value[index].state ==
                                        'open'
                                    ? controller.plantrip_with_waybill_list
                                                .value[index].driverId!.id ==
                                            emp_id
                                        ? Text(
                                            controller
                                                .plantrip_with_waybill_list
                                                .value[index]
                                                .state
                                                .toUpperCase(),
                                            style: maintitleStyle(),
                                            textAlign: TextAlign.right,
                                          )
                                        : Text('approved'.toUpperCase(),
                                            style: maintitleStyle(),
                                            textAlign: TextAlign.right)
                                    : Text(
                                        controller.plantrip_with_waybill_list
                                            .value[index].state
                                            .toUpperCase(),
                                        style: maintitleStyle(),
                                        textAlign: TextAlign.right,
                                      ),
                              ),
                            ],
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
    );
  }
}
