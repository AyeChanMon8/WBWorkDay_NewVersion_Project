

import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/approval_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/leave_detail.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class TripExpenseApprovedDetails extends StatefulWidget {
  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<TripExpenseApprovedDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  late String image;
  late int index;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Trip Expense Approval",
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // leaveData(context),
                Text(controller.tripExpenseApprovedList.value[index].number,style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 5,
                ),
                tripExpenseData(context),
                SizedBox(
                  height: 10,
                ),
                tripExpenseTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                tripExpenseLineWidget(context,index),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:Text('${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotaltripExpenseApprovedAmount(index))}',style: TextStyle(fontSize: 20,color: Colors.deepPurple),))),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ));
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
                controller.approveOutofPocket(
                    controller.tripExpenseApprovedList.value[index].id);
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
                controller.declineOutofPocket(
                    controller.tripExpenseApprovedList.value[index].id);
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

  Widget tripExpenseTitleWidget(BuildContext context) {
    //final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // width: 35,
            flex: 2,
            child: Text(
              ("Expense Date"),
              style: subtitleStyle(),
            ),
          ),
          Expanded(
            // width: 80,
            flex: 2,
            child: Text(
              "Expense Title",
              style: subtitleStyle(),
            ),
          ),
          Expanded(
            // width: 80,
            flex: 2,
            child: Text(
              "Description",
              style: subtitleStyle(),
            ),
          ),
          Expanded(
            // width: 50,
            flex: 2,
            child: Text(
              "Amount",
              style: subtitleStyle(),
            ),
          ),
          Expanded(
            // width: 50,
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget tripExpenseLineWidget(BuildContext context, int index) {
    // print("Testing");
    // print(controller.outofpocketExpenseApprovedList[index].pocket_line.length);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
        controller.tripExpenseApprovedList[index].trip_expense_lines!.length,
        itemBuilder: (BuildContext context, int ind) {
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(AppUtils.changeDateFormat(controller.tripExpenseApprovedList[index].trip_expense_lines![ind].date)
                            .toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(controller.tripExpenseApprovedList[index].trip_expense_lines![ind].product_id!.name
                          .toString(),textAlign: TextAlign.center,),
                    ),
                    Expanded(
                      flex: 2,
                      child:controller.tripExpenseApprovedList[index].trip_expense_lines![ind].description!=null?
                      Text(controller.tripExpenseApprovedList[index].trip_expense_lines![ind].description
                          .toString()):SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(controller.tripExpenseApprovedList[index].trip_expense_lines![ind].price_subtotal
                          .toString()),
                    ),
                    Expanded(
                      flex: 1,
                      child: controller.tripExpenseApprovedList[index].trip_expense_lines![ind].attached_file != null ? IconButton(icon: Icon(Icons.attach_file), onPressed: ()async{
                        await showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                              bytes: base64Decode(controller.tripExpenseApprovedList[index].trip_expense_lines![ind].attached_file),
                            ));
                      }):SizedBox(),
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

  Widget tripExpenseData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Name" + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseApprovedList.value[index]
                    .employee_id!.name !=
                    null
                    ? Text(
                    controller.tripExpenseApprovedList.value[index]
                        .employee_id!.name,
                    style: subtitleStyle())
                    : Text('-'),
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
                  "Source Doc" + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseApprovedList.value[index].source_doc!=null?Text(
                  controller.tripExpenseApprovedList.value[index].source_doc,
                  // ("Leave type : "),
                  style: subtitleStyle(),
                ):new SizedBox(),
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
                  (labels!.date + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseApprovedList.value[index].date !=
                    null
                    ? Text(AppUtils.changeDateFormat(controller.tripExpenseApprovedList.value[index].date),
                    style: subtitleStyle())
                    : Text('-'),
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
                  (labels.status + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseApprovedList.value[index].state !=
                    null
                    ? Text(controller.tripExpenseApprovedList.value[index].state,
                    style: subtitleStyle())
                    : Text('-'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
