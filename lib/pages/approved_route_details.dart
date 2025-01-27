

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovedRouteDetails extends StatefulWidget {
  @override
  _ApprovedRouteDetailsState createState() => _ApprovedRouteDetailsState();
}

class _ApprovedRouteDetailsState extends State<ApprovedRouteDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    print("**travelApprovedLis");
    print(controller.routeApprovedList[index].code);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, "Routed Approved", image)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  controller.routeApprovedList.value[index].code.toString() ==
                              "null" ||
                          controller.routeApprovedList.value[index].code
                                  .toString() ==
                              null
                      ? ""
                      : controller.routeApprovedList.value[index].code.toString(),
                  style: TextStyle(fontSize: 20),
                ),
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
              expenseWidget(context),
              SizedBox(
                height: 20,
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
        controller.routeApprovedList[index].fuel_liter.toString())!);
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
                  'From',
                  // ("From Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  controller.routeApprovedList[index].from_street,
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
                  'To',
                  // ("To Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.routeApprovedList[index].to_street),
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
                  (controller.routeApprovedList[index].duration_days
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
                ("Expense Name"),
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
                ("Amount"),
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
                ("Remark"),
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.routeApprovedList[index].expenseIds!.length,
        itemBuilder: (BuildContext context, int pos) {
          var amount = "";
          amount = AppUtils.removeNullString(controller
              .routeApprovedList[index].expenseIds![pos].amount
              .toString());
          if (amount.isNotEmpty) {
            amount = AppUtils.addThousnadSperator(double.tryParse(amount)!);
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
                        child: Text(controller
                            .routeApprovedList[index].expenseIds![pos].name
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller
                            .routeApprovedList[index].expenseIds![pos].remark
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
      ),
    );
  }
}
