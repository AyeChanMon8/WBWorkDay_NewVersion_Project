import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';

import '../../controllers/approval_controller.dart';
import '../../models/plan_trip_product.dart';
import '../../my_class/my_style.dart';
import '../../utils/app_utils.dart';
import '../leave_detail.dart';

class PlanTripProductRouteApproval extends StatefulWidget {
  const PlanTripProductRouteApproval({super.key});

  @override
  State<PlanTripProductRouteApproval> createState() =>
      _PlanTripProductRouteApprovalState();
}

class _PlanTripProductRouteApprovalState
    extends State<PlanTripProductRouteApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    var spare_one = controller.ptpRouteApprovalList.value[index].spare1Id!.name!=null ? AppUtils.removeNullString(
        controller.ptpRouteApprovalList.value[index].spare1Id!.name):"";
    var spare_two = controller.ptpRouteApprovalList.value[index].spare2Id!.name!=null ? AppUtils.removeNullString(
        controller.ptpRouteApprovalList.value[index].spare2Id!.name) : "";
    var from_date = controller.ptpRouteApprovalList.value[index].fromDatetime!=null ?AppUtils.changeDateAndTimeFormat(controller.ptpRouteApprovalList.value[index].fromDatetime):"";
    //var to_date = AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_product_list[arg_index].toDatetime);
    var to_date = controller.ptpRouteApprovalList.value[index].toDatetime!=null? AppUtils.changeDateAndTimeFormat(
        controller.ptpRouteApprovalList.value[index].toDatetime):"";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.ptpRouteApproval,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Column(children: [
            Container(
              // height: 250,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 65),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => controller.showDetails.value
                            ? Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  labels.viewDetailsClose,
                                  style: maintitlenoBoldStyle(),
                                ),
                              )
                            : Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  labels.viewDetails,
                                  style: maintitlenoBoldStyle(),
                                ),
                              )),
                        Obx(() => controller.showDetails.value
                            ? Expanded(
                                flex: 1,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_circle_up_sharp),
                                  onPressed: () {
                                    controller.showDetails.value = false;
                                  },
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_circle_down_sharp),
                                  onPressed: () {
                                    controller.showDetails.value = true;
                                  },
                                ),
                              ))
                      ],
                    ),
                  ),
                  Obx(() => controller.showDetails.value
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 65),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    labels.code,
                                    style: maintitlenoBoldStyle(),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  controller.ptpRouteApprovalList.value.length >
                                          0
                                      ? AutoSizeText(
                                          '${controller.ptpRouteApprovalList.value[index].code}',
                                          style: maintitleStyle(),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.fromDate,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${from_date}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.toDate,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.ptpRouteApprovalList.value
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            AppUtils.changeDateAndTimeFormat(controller.ptpRouteApprovalList
                                                .value[index].toDatetime),
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.vehicle,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.ptpRouteApprovalList.value
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${controller.ptpRouteApprovalList.value[index].vehicleId!.name}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.driver,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.ptpRouteApprovalList.value
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${controller.ptpRouteApprovalList.value[index].driverId!.name}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.spare1,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${spare_one}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.spare2,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${spare_two}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.advanceAmount + ':',
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.ptpRouteApprovalList.value
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${AppUtils.addThousnadSperator(controller.ptpRouteApprovalList.value[index].totalAdvance)}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.expenseStatus + ' :',
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            //Divider(thickness: 1,),
                            SizedBox(height: 15),
                          ],
                        )
                      : SizedBox()),
                ],
              ),
            ),
            controller.ptpRouteApprovalList.value!=null && controller.ptpRouteApprovalList.value.length > 0 && controller.ptpRouteApprovalList.value[index].routePlanIds != null &&
                    controller.ptpRouteApprovalList.value[index].routePlanIds!
                            .length >
                        0
                ? tripRouteTitleWidget(context) : SizedBox(),
            SizedBox(
              height: 10,
            ),
            controller.ptpRouteApprovalList.value!=null && controller.ptpRouteApprovalList.value.length > 0 && controller.ptpRouteApprovalList.value[index].routePlanIds != null &&
                    controller.ptpRouteApprovalList.value[index].routePlanIds!
                            .length >
                        0
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: tripRouteListWidget(context),
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            controller.ptpRouteApprovalList.value[index].state == 'running'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            onPressed: () {
                              // controller.approvePTPRoute(controller
                              //     .insuranceApprovalList.value[index].id);
                              controller.clickProductRouteApproveLine(
                                  false,
                                  controller
                                      .ptpRouteApprovalList.value[index].id,
                                  controller.ptpRouteApprovalList.value[index]
                                      .routePlanIds![0].id,
                                  0,
                                  0,
                                  '0',
                                  '');
                            },
                            text: labels?.approve,
                            blockButton: true,
                            size: GFSize.LARGE,
                            color: textFieldTapColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
          ])),
    );
  }

  Widget tripRouteTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              // width: 35,
              child: Text(
                (labels!.route),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Text(
                labels.startDate,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  labels.endDate,
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Fuel Balance (L)",
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Consumed Fuel (L)",
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  labels.status,
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 50,
              child: Text(
                "",
                style: subtitleStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tripRouteListWidget(BuildContext context) {
    int fields;
    return Container(
      child: Obx(() {
        return controller.ptpRouteApprovalList.value.length > 0 ? ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              controller.ptpRouteApprovalList.value[index].routePlanIds!.length,
          itemBuilder: (BuildContext context, int index1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 80,
                          child: Text("["+controller.ptpRouteApprovalList
                              .value[index].routePlanIds![index1].routeId.code.toString()+"] "+ controller.ptpRouteApprovalList
                              .value[index].routePlanIds![index1].routeId.name
                              .toString()),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: textFieldTapColor,
                              ),
                              child: controller
                                          .ptpRouteApprovalList
                                          .value[index]
                                          .routePlanIds![index1]
                                          .startActualDate !=
                                      null
                                  ? Text(AppUtils.changeDateAndTimeFormat(
                                      controller
                                          .ptpRouteApprovalList
                                          .value[index]
                                          .routePlanIds![index1]
                                          .startActualDate))
                                  : SizedBox(),
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Theme(
                                data: new ThemeData(
                                  primaryColor: textFieldTapColor,
                                ),
                                child: controller
                                            .ptpRouteApprovalList
                                            .value[index]
                                            .routePlanIds![index1]
                                            .endActualDate !=
                                        null
                                    ? Text(AppUtils.changeDateAndTimeFormat(
                                        controller
                                            .ptpRouteApprovalList
                                            .value[index]
                                            .routePlanIds![index1]
                                            .endActualDate))
                                    : SizedBox())),
                      ),
                      controller.ptpRouteApprovalList.value[index]
                                  .routePlanIds![index1].fuelBalInputByDriver !=
                              null
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(controller
                                    .ptpRouteApprovalList
                                    .value[index]
                                    .routePlanIds![index1]
                                    .fuelBalInputByDriver
                                    .toString()),
                              ),
                            )
                          : SizedBox(),
                      controller.ptpRouteApprovalList.value[index]
                                  .routePlanIds![index1].routeConsumedFuel !=
                              null
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(controller
                                    .ptpRouteApprovalList
                                    .value[index]
                                    .routePlanIds![index1]
                                    .routeConsumedFuel.toStringAsFixed(2)
                                    .toString()),
                              ),
                            )
                          : SizedBox(),
                      
                      controller.ptpRouteApprovalList.value[index]
                                  .routePlanIds![index1].status !=
                              null
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].status == 'to_approve' ? Text('To Approve') : controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].status == 'running' ? Text('Running') : controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].status == 'done' ? Text('Done') : Text(controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].status),
                              ),
                            )
                          : SizedBox(),
                      controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].attachment_ids!=null && controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].attachment_ids.length> 0
                              ? IconButton(
                                  icon: Icon(Icons.attach_file_outlined),
                                  onPressed: () {
                                    attachmentBottomSheetImage(
                                            context, controller.ptpRouteApprovalList
                                    .value[index].routePlanIds![index1].attachment_ids);
                                  },
                                )
                              : SizedBox()
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
        ) : SizedBox();
      }),
    );
  }


  dynamic attachmentBottomSheetImage(BuildContext context, List<RouteAttach> value) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.close_outlined),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        attachmentGridViewImage(value, context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget attachmentGridViewImage(List<RouteAttach> value, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(value.length, (index) {
        Uint8List ? bytes1;
        if (value[index] != null) {
          bytes1 = base64Decode(value[index].datas);
        }
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Align(
            child: InkWell(
              onTap: () async {
                print("bytes11 >>" + bytes1.toString());
                await showDialog(
                    context: context,
                    builder: (_) => Container(
                          height: 200,
                          child: ImageDialog(
                            bytes: bytes1,
                          ),
                        ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: new Image.memory(
                  base64Decode(value[index].datas),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
