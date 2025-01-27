
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovalRouteDetails extends StatefulWidget {
  @override
  _ApprovalRouteDetailsState createState() => _ApprovalRouteDetailsState();
}

class _ApprovalRouteDetailsState extends State<ApprovalRouteDetails> {
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
            "Route Approve",
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
                    child: image != null && image !=""
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
              //Text(controller.travelApprovalList.value[index].name,style: TextStyle(fontSize: 20),),
              // Text(
              //   controller.routeApprovedList.value[0].code.toString(),
              //   style: TextStyle(fontSize: 20),
              // ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 10,
              ),
              travelData(context),
              SizedBox(
                height: 15,
              ),
              expenseTitleWidget(context),
              SizedBox(
                height: 20,
              ),
              controller.routeApprovalList.length != 0
                  ? expenseWidget(context)
                  : new Container(),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => controller.route_approve_show.value
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

  Widget travelData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var fuel_liter = "";
    fuel_liter = AppUtils.addThousnadSperator(double.tryParse(
        controller.routeApprovalList.value[index].fuel_liter.toString())!);
    print("code##");
    print(controller.routeApprovalList.value[index].code);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child:   Text(
                  AppUtils.removeNullString(controller.routeApprovalList.value[index].code.toString()),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  controller.routeApprovalList.value[index].company_id!.name
                      .toString(),
                  // ("From Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.routeApprovalList.value[index].branch_id!.name
                      .toString(),
                  style: subtitleStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  'From ',
                  // ("From Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.routeApprovalList.value[index].from_street,
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
                  'To ',
                  // ("To Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.routeApprovalList.value[index].to_street),
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
                  'Fuel Liter',
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (fuel_liter),
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
                  labels!.duration,
                  // ("Duration : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.routeApprovalList.value[index].duration_days
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
                controller
                    .approveRoute(controller.routeApprovalList.value[index].id);
                print("Route approved");
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
                controller.declinedRoute(
                    controller.routeApprovalList.value[index].id);
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
                ("Expense"),
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
                ("Description"),
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
                ("Std Amount"),
                style: subtitleStyle(),
              ),
            ),
          ),
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
      child: Obx(() => controller.routeApprovalList.length>0 ?ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                controller.routeApprovalList.value[index].expenseIds!.length,
            itemBuilder: (BuildContext context, int pos) {
              var amt = AppUtils.removeNullString(controller
                  .routeApprovalList.value[index].expenseIds![pos].amount
                  .toString());
              var amount = '';
              if (amt.isNotEmpty) {
                amount = AppUtils.addThousnadSperator(controller
                    .routeApprovalList.value[index].expenseIds![pos].amount);
              }

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
                            child: Text(controller.routeApprovalList
                                .value[index].expenseIds![pos].name
                                .toString()),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(controller.routeApprovalList
                                .value[index].expenseIds![pos].remark
                                .toString()),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(amount),
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
          ) : SizedBox()),
    );
  }
}
