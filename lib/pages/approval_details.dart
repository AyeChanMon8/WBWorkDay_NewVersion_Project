
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import '../controllers/approval_controller.dart';
import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';

import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovalDetails extends StatefulWidget {
  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<ApprovalDetails> {
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
        appBar: AppBar(
          title: Text(labels!.leaveDetails,style: appbarTextStyle(),),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Text(controller.leaveApprovalList.value[index].name,style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 15,
                ),
                leaveData(context),
                SizedBox(
                  height: 15,
                ),
                //leaveTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                leaveWidget(context),
                SizedBox(
                  height: 10,
                ),
                Obx(() =>
                    controller.leave_approve_show.value? approveButton(context):Container(),
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
                controller.approvelLeave(
                    controller.leaveApprovalList.value[index].id);
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
                controller.declinedLeave(
                    controller.leaveApprovalList.value[index].id);
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

  Widget leaveTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 35,
            child: Text(
              ("Day"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            // width: 80,
            child: Text(
              labels!.startDate,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 80,
            child: Text(
              labels.endDate,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 50,
            child: Text(
              labels.dayOff,
              style: subtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.leaveApprovalList[index].leave_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          var start_date =
              controller.leaveApprovalList[index].leave_line![ind].start_date;
          var startDate = AppUtils.changeDateFormat(start_date.split(' ')[0]);
          var end_date = controller.leaveApprovalList[index].leave_line![ind].end_date;
          var endDate = AppUtils.changeDateFormat(end_date.split(' ')[0]);
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 10),
                        // padding: EdgeInsets.only(left: 10),
                        // color: Colors.blue,
                        // width: 80,
                        child: Text(startDate),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(left: 16),
                        // padding: EdgeInsets.only(left: 5),
                        // color: Colors.red,
                        // width: 80,
                        child: Text(endDate),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          //margin: EdgeInsets.only(left: 30),
                          padding: EdgeInsets.only(left: 20, right: 10),
                          // color: Colors.green,
                          child: controller
                                  .leaveApprovalList[index].leave_line![ind].full
                              ? Text('Full')
                              : controller.leaveApprovalList[index]
                                      .leave_line![ind].first
                                  ? Text('First Half')
                                  : controller.leaveApprovalList[index]
                                          .leave_line![ind].second
                                      ? Text('Second Half')
                                      : Text('None')),
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

  Widget leaveData(BuildContext context) {
     Uint8List? bytes;
    if (controller.leaveApprovalList.value[index].attachment != null) {
      if (controller.leaveApprovalList.value[index].attachment!.isNotEmpty) {
        bytes =
            base64Decode(controller.leaveApprovalList.value[index].attachment!);
      }
    }
     var start_date = AppUtils.changeDateFormat(controller.leaveApprovalList.value[index].start_date);
    var end_date = AppUtils.changeDateFormat(controller.leaveApprovalList.value[index].end_date);
    final labels = AppLocalizations.of(context);
    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.leaveType + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveApprovalList.value[index]
                            .holiday_status_id!.name !=
                        null
                    ? Text(
                        controller.leaveApprovalList.value[index]
                            .holiday_status_id!.name,
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
                  labels.fromDate + " :",
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveApprovalList.value[index].start_date !=
                        null
                    ? Text(start_date,
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
                  (labels.toDate + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveApprovalList.value[index].end_date !=
                        null
                    ? Text(end_date,
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
                  (labels.days+":"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child:
                    controller.leaveApprovalList.value[index].duration != null
                        ? Text(
                            controller.leaveApprovalList.value[index].duration
                                    .toString() +
                                " Days",
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
                child: Expanded(
                  child: Text(
                    (labels.description + " :"),
                    style: datalistStyle(),
                  ),
                ),
              ),
              Container(
                child: controller.leaveApprovalList.value[index].description !=
                        null
                    ? Expanded(
                      child: Text(
                          controller.leaveApprovalList.value[index].description,
                          style: subtitleStyle()),
                    )
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
                child: controller.leaveApprovalList.value[index].state != null
                    ? Text(controller.leaveApprovalList.value[index].state,
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
                  labels.attachment + " : ",
                  // (labels?.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child:
                    controller.leaveApprovalList.value[index].attachment != null
                        ? Column(
                            children: [
                              // Text(controller.leaveList.value[index].attachment,
                              //     style: subtitleStyle()),

                              Container(
                                width: 100,
                                // padding: EdgeInsets.only(
                                //   right: 5,
                                //   top: 70,
                                // ),
                                child: bytes != null
                                    ? InkWell(
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => ImageDialog(
                                          bytes: bytes,
                                        ));
                                  },
                                      child: new Image.memory(
                                          bytes,
                                          fit: BoxFit.fitWidth,
                                        ),
                                    )
                                    : new Container(),
                              ),
                            ],
                          )
                        : Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
