import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../controllers/maintenance_controller.dart';
// import '../localization.dart';
import '../main.dart';
import '../models/maintenance_request_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApprovedMaintenanceListPage extends StatefulWidget {
  final String pageType;
  ApprovedMaintenanceListPage(this.pageType);
  @override
  _ApprovedMaintenanceListPageState createState() =>
      _ApprovedMaintenanceListPageState();
}

class _ApprovedMaintenanceListPageState
    extends State<ApprovedMaintenanceListPage> {
  MaintenanceController controller = Get.put(MaintenanceController());
  void initState() {
    super.initState();
    if (widget.pageType == 'planned') {
      controller.getMaintenanceList('planned');
    }
  }

  @override
  Widget build(BuildContext context) {
    var labels = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Obx(() => ListView.builder(
            itemCount: controller.maintenanceList.length,
            itemBuilder: (context, index) {
              var state = "";
              // state = controller.maintenanceList[index].maintenance_approve_state;
              // if(controller.maintenanceList[index].state=="reject"){
              //   state = "Rejected";
              // }else if(controller.maintenanceList[index].state=="approve"){
              //   state = "Approved Again";
              // }else if(controller.maintenanceList[index].state=="approved"){
              //   state = "Approved";
              // }else{
              //   state = controller.maintenanceList[index].state;
              // }
              if (controller.maintenanceList[index].state == "reject") {
                state = "Rejected";
              } else if (controller.maintenanceList[index].state ==
                      "approved" ||
                  controller.maintenanceList[index].state == "start" ||
                  controller.maintenanceList[index].state == "reproposed" ||
                  controller.maintenanceList[index].state == "resubmitted") {
                state = "Approved";
              } else if (controller.maintenanceList[index].state == "approve" ||
                  controller.maintenanceList[index].state == "qc" ||
                  controller.maintenanceList[index].state == "done") {
                state = "Approved Again";
              } else {
                state = controller.maintenanceList[index].state!;
              }
              Maintenance_request_model maintenanceModel =
                  controller.maintenanceList[index];
              var start_date = maintenanceModel.startDate!=null ? AppUtils.changeDateTimeFormat(
                  maintenanceModel.startDate ?? "") : "";
              var end_date = maintenanceModel.endDate !=null ?
                  AppUtils.changeDateTimeFormat(maintenanceModel.endDate ?? "") : "";
              return InkWell(
                onTap: () {
                  controller.current_page.value = widget.pageType;
                  controller.imageList.clear();
                  if (maintenanceModel.image != null &&
                      maintenanceModel.image!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image!));
                  if (maintenanceModel.image1 != null &&
                      maintenanceModel.image1!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image1!));
                  if (maintenanceModel.image2 != null &&
                      maintenanceModel.image2!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image2!));
                  if (maintenanceModel.image3 != null &&
                      maintenanceModel.image3!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image3!));
                  if (maintenanceModel.image4 != null &&
                      maintenanceModel.image4!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image4!));
                  if (maintenanceModel.image5 != null &&
                      maintenanceModel.image5!.isNotEmpty)
                    controller.imageList
                        .add(base64Decode(maintenanceModel.image5!));

                  controller.maintenanceProductIdList.value =
                      maintenanceModel.maintenanceProductIds!;

                  Get.toNamed(Routes.APPROVEDMAINTENANCEDETAILPAGE,
                      arguments: maintenanceModel);
                  //  }
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels!.fromDate + ' : ',
                              style: maintitleStyle(),
                            ),
                            AutoSizeText(
                              start_date ?? '',
                              style: maintitleStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels.toDate + ' : ',
                              style: maintitleStyle(),
                            ),
                            AutoSizeText(
                              end_date ?? '',
                              style: maintitleStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels.vehicle + ' : ',
                              style: maintitleStyle(),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                maintenanceModel.vehicleId!.name ?? '',
                                style: maintitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels.requestDate + ' : ',
                              style: maintitleStyle(),
                            ),
                            AutoSizeText(
                              AppUtils.changeDateFormat(
                                      maintenanceModel.requestDate!) ??
                                  '',
                              style: maintitleStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels.code + ' : ',
                              style: maintitleStyle(),
                            ),
                            AutoSizeText(
                              maintenanceModel.code ?? '',
                              style: maintitleStyle(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            AutoSizeText(
                              labels.priority + ' :',
                              style: maintitleStyle(),
                            ),
                            RatingBar.builder(
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                              initialRating: double.parse(
                                  maintenanceModel.priority ?? '0'),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemSize: 30,
                              itemCount: 3,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              state.toUpperCase(),
                              style: maintitleStyle(),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
