

import 'dart:convert';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/approval_controller.dart';
import '../controllers/leave_list_controller.dart';
// import '../localization.dart';

import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../pages/maintenance_request.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovalTravelDetails extends StatefulWidget {
  @override
  _ApprovalTravelDetailsState createState() => _ApprovalTravelDetailsState();
}

class _ApprovalTravelDetailsState extends State<ApprovalTravelDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;

    return Scaffold(
        appBar: // appbar(context, "Travel Approve", image),
            AppBar(
          backgroundColor: backgroundIconColor,
          title: Text(
            labels!.travelApproval,
            style: appbarTextStyle(),
          ),
          iconTheme: drawerIconColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8.0),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color.fromRGBO(216, 181, 0, 1),
                    const Color.fromRGBO(231, 235, 235, 1)
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              controller.travel_approve_show.value = true;
              Get.back();
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.PROFILE_PAGE);
              },
              child: Container(
                padding: EdgeInsets.only(right: 5),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(50.0),
                    child: image != null && image != ""
                        ? new Image.memory(
                            base64Decode(image),
                            fit: BoxFit.cover,
                            scale: 0.1,
                            height: 40,
                            width: 40,
                          )
                        : new Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0,top:8),
                child: Text(
                  controller.travelApprovalList.value[index].name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              travelData(context),
              SizedBox(
                height: 15,
              ),
              travelTitleWidget(context),
              SizedBox(
                height: 15,
              ),
              travelWidget(context),
              SizedBox(
                height: 10,
              ),
              expenseTitleWidget(context),
              SizedBox(
                height: 20,
              ),
              controller.travelApprovalList.length != 0
                  ? expenseWidget(context)
                  : new Container(),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        '${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalAmount(index))}',
                        style:
                            TextStyle(fontSize: 20, color: Colors.deepPurple),
                      ))),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.travel_approve_show.value
                    ? approveButton(context)
                    : Container(),
              ),
            ],
          ),
        ));
  }

  Widget travelTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 80,
            child: Text(
              labels!.date,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 70,
            child: Text(
              labels.destination,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 70,
            child: Text(
              labels.purpose,
              style: subtitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget travelWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount:
            controller.travelApprovalList.value[index].travel_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          return Column(
            children: [
              Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: controller.travelApprovalList.value[index]
                                    .travel_line![ind].date !=
                                null
                            ? Text(AppUtils.changeDateFormat(controller.travelApprovalList.value[index]
                                .travel_line![ind].date))
                            : Text('  -'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: controller.travelApprovalList.value[index]
                                    .travel_line![ind].destination !=
                                null
                            ? Text(controller.travelApprovalList.value[index]
                                .travel_line![ind].destination)
                            : Text('  -'),
                      ),
                    ),
                    // SizedBox(width: 100),
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                          left: 60,
                        ),
                        child: controller.travelApprovalList.value[index]
                                    .travel_line![ind].purpose !=
                                null
                            ? Text(controller.travelApprovalList.value[index]
                                .travel_line![ind].purpose)
                            : Text('  -'),
                      ),
                    ),
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
      ),
    );
  }

  Widget travelData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.fromDate,
                  // ("From Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  AppUtils.changeDateFormat(controller
                      .travelApprovalList.value[index].start_date
                      .toString()),
                  style: subtitleStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels.toDate,
                  // ("To Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (AppUtils.changeDateFormat(controller
                      .travelApprovalList.value[index].end_date
                      .toString())),
                  style: subtitleStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  // ("From : "),
                  labels.from,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelApprovalList.value[index].city_from),
                  style: subtitleStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels.to,
                  // ("To : "),

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelApprovalList.value[index].city_to),
                  style: subtitleStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels.duration,
                  // ("Duration : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelApprovalList.value[index].duration
                          .toString() +
                      " Days"),
                  style: subtitleStyle(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget approveButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.approveTravel(
                    controller.travelApprovalList.value[index].id);
                print("Travel approved");
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.declinedTravel(
                    controller.travelApprovalList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels?.decline,
              textColor: textFieldTapColor,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                (labels!.expenseCategory),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                (labels.amount),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                (labels.remark),
                style: subtitleStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget expenseWidget(BuildContext context) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> remark_controllers;
    List<TextEditingController> total_amount_controllers;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => controller
                .travelApprovalList.value.length > 0 ?ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller
                .travelApprovalList.value[index].request_allowance_lines!.length,
            itemBuilder: (BuildContext context, int pos) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller
                                .travelApprovalList
                                .value[index]
                                .request_allowance_lines![pos]
                                .expense_categ_id!
                                .name
                                .toString()),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     padding: EdgeInsets.only(left: 5, right: 5),
                        //     width: MediaQuery.of(context).size.width / 3,
                        //     child: TextField(
                        //       enabled: false,
                        //       controller: total_amount_controllers[index],
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(),
                        //       ),
                        //       onChanged: (text) {},
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller
                                .travelApprovalList
                                .value[index]
                                .request_allowance_lines![pos]
                                .total_amount
                                .toString()),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     padding: EdgeInsets.only(left: 5, right: 5),
                        //     width: MediaQuery.of(context).size.width / 3,
                        //     child: TextField(
                        //       controller: remark_controllers[index],
                        //       enabled: true,
                        //       decoration: InputDecoration(
                        //         border: OutlineInputBorder(),
                        //       ),
                        //       onChanged: (text) {
                        //         //controller.updateTravelLinePurpose(index, text);
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller
                                .travelApprovalList
                                .value[index]
                                .request_allowance_lines![pos]
                                .remark
                                .toString()),
                          ),
                        ),
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
          ):SizedBox()),
    );
  }
}
