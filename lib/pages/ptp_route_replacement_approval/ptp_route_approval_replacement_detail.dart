import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:getwidget/getwidget.dart';

import '../../constants/globals.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../utils/app_utils.dart';

class PTPRouteReplacementDetail extends StatefulWidget {
  const PTPRouteReplacementDetail({super.key});

  @override
  State<PTPRouteReplacementDetail> createState() =>
      _PTPRouteReplacementDetailState();
}

class _PTPRouteReplacementDetailState extends State<PTPRouteReplacementDetail> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    var from_date = AppUtils.changeDateAndTimeFormat(
        controller.ptpRouteReplacementApprovalList.value[index].fromDatetime);
    //var to_date = AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_product_list[arg_index].toDatetime);
    var to_date = AppUtils.changeDateAndTimeFormat(
        controller.ptpRouteReplacementApprovalList.value[index].fromDatetime);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            labels!.ptpRouteReplacementApproval,
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: controller.ptpRouteReplacementApprovalList.value.length>0 ?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                    controller.ptpRouteReplacementApprovalList
                                                .value.length >
                                            0
                                        ? AutoSizeText(
                                            '${controller.ptpRouteReplacementApprovalList.value[index].name}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        'Plan Trip',
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList.value.length > 0 ?AutoSizeText(
                                        '${controller.ptpRouteReplacementApprovalList.value[index].planTripProductId!.code}',
                                        style: maintitleStyle(),
                                      ): SizedBox()
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        'Company',
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList.value.length> 0 ?AutoSizeText(
                                        '${controller.ptpRouteReplacementApprovalList.value[index].companyID!.name}',
                                        style: maintitleStyle(),
                                      ): SizedBox()
                                    ],
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        'Branch',
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList
                                                  .value.length >
                                              0
                                          ? AutoSizeText(
                                              controller
                                                  .ptpRouteReplacementApprovalList
                                                  .value[index]
                                                  .branchID!
                                                  .name,
                                              style: maintitleStyle(),
                                            )
                                          : SizedBox()
                                    ],
                                  )),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //         child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         AutoSizeText(
                              //           'Vehicle',
                              //           style: maintitlenoBoldStyle(),
                              //         ),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         controller.ptpRouteReplacementApprovalList.value.length>0?AutoSizeText(
                              //           '${controller.ptpRouteReplacementApprovalList.value[index].vehicleId!.name}',
                              //           style: maintitleStyle(),
                              //         ): SizedBox()
                              //       ],
                              //     )),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Expanded(
                              //         child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         AutoSizeText(
                              //           'Driver',
                              //           style: maintitlenoBoldStyle(),
                              //         ),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         controller.ptpRouteReplacementApprovalList
                              //                     .value.length >
                              //                 0
                              //             ? AutoSizeText(
                              //                 controller
                              //                     .ptpRouteReplacementApprovalList
                              //                     .value[index]
                              //                     .driverId!
                              //                     .name,
                              //                 style: maintitleStyle(),
                              //               )
                              //             : SizedBox()
                              //       ],
                              //     )),
                              //   ],
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        labels.toDate,
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList
                                                  .value.length >
                                              0
                                          ? AutoSizeText(
                                              AppUtils.changeDateAndTimeFormat(
                                                  controller
                                                      .ptpRouteReplacementApprovalList
                                                      .value[index]
                                                      .toDatetime),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        labels.vehicle,
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList
                                                  .value.length >
                                              0
                                          ? AutoSizeText(
                                              '${controller.ptpRouteReplacementApprovalList.value[index].vehicleId!.name}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        labels.driver,
                                        style: maintitlenoBoldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      controller.ptpRouteReplacementApprovalList
                                                  .value.length >
                                              0
                                          ? AutoSizeText(
                                              '${controller.ptpRouteReplacementApprovalList.value[index].driverId!.name}',
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
                              SizedBox(height: 15),
                            ],
                          )
                        : SizedBox()),
                  ],
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Old Routes",
                     style: subtitleStyle()),
                    SizedBox(
                      height: 10,
                    ),
                    controller.ptpRouteReplacementApprovalList.value.length > 0
                        ? Text(controller.ptpRouteReplacementApprovalList
                            .value[index].replaceableOldRouteIdsTxt)
                        : SizedBox()
                  ],
                ),
              ),
              // controller.ptpRouteReplacementApprovalList.value != null &&
              //         controller.ptpRouteReplacementApprovalList.value.length >
              //             0 &&
              //         controller.ptpRouteReplacementApprovalList.value[index]
              //                 .newRouteIDs !=
              //             null &&
              //         controller.ptpRouteReplacementApprovalList.value[index]
              //                 .newRouteIDs!.length >
              //             0
              //     ? 
                  tripRouteTitleWidget(context),
                  // : SizedBox(),
              SizedBox(
                height: 10,
              ),
              controller.ptpRouteReplacementApprovalList.value != null &&
                      controller.ptpRouteReplacementApprovalList.value.length >
                          0 &&
                      controller.ptpRouteReplacementApprovalList.value[index]
                              .newRouteIDs !=
                          null &&
                      controller.ptpRouteReplacementApprovalList.value[index]
                              .newRouteIDs!.length >
                          0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: tripRouteListWidget(context),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              controller.ptpRouteReplacementApprovalList.value[index].state ==
                      'submit'
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GFButton(
                              onPressed: () {
                                controller.clickPTPRouteReplacementApprove(
                                    controller.ptpRouteReplacementApprovalList
                                        .value[index].id);
                              },
                              text: labels?.approve,
                              blockButton: true,
                              size: GFSize.LARGE,
                              color: textFieldTapColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GFButton(
                              type: GFButtonType.outline,
                              color: Globals.primaryColor,
                              onPressed: () {
                                controller.clickPTPRouteReplacementReject(controller
                                      .ptpRouteReplacementApprovalList.value[index].id);
                              },
                              child: Text('Reject'),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ]): SizedBox()));
  }

  Widget tripRouteListWidget(BuildContext context) {
    int fields;
    return Container(
      child: Obx(() {
        return controller.ptpRouteReplacementApprovalList.value.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.ptpRouteReplacementApprovalList
                    .value[index].newRouteIDs!.length,
                itemBuilder: (BuildContext context, int index1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text("[" +
                                controller
                                    .ptpRouteReplacementApprovalList
                                    .value[index]
                                    .newRouteIDs![index1]
                                    .routeId!
                                    .code
                                    .toString() +
                                "] " +
                                controller
                                    .ptpRouteReplacementApprovalList
                                    .value[index]
                                    .newRouteIDs![index1]
                                    .routeId!
                                    .name
                                    .toString()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                },
              )
            : SizedBox();
      }),
    );
  }

  Widget tripRouteTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // width: 35,
            child: Text(
              'New Routes',
              style: subtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
