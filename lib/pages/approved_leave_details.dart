import 'dart:convert';
import 'dart:typed_data';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import '../controllers/approval_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'leave_detail.dart';

class ApprovedLeaveDetails extends StatefulWidget {
  @override
  _ApprovedLeaveDetailsState createState() => _ApprovedLeaveDetailsState();
}

class _ApprovedLeaveDetailsState extends State<ApprovedLeaveDetails> {
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
          title: Text(
            labels!.approvedleaveDetails,
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Text(controller.leaveApprovedList.value[index].name,style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 15,
                ),
                leaveData(context),
                SizedBox(
                  height: 15,
                ),
                leaveTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                // leaveWidget(context),
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
                    controller.leaveApprovedList.value[index].id);
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
                    controller.leaveApprovedList.value[index].id);
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
      height: 500,
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 1,
          minWidth: 300,
          columns: [
            DataColumn2(
              label: Text(
                labels!.day,
                style: maintitleStyle(),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                labels.startDate,
                style: maintitleStyle(),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                labels.endDate,
                style: maintitleStyle(),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                labels.dayOff,
                style: maintitleStyle(),
              ),
              size: ColumnSize.L,
            ),
          ],
          rows: [
            for (var i = 0;
                i < controller.leaveApprovedList[index].leave_line!.length;
                i++)
              DataRow(cells: [
                DataCell(Text(
                  controller.leaveApprovedList[index].leave_line![i].dayofweek
                      .toString(),
                  style: maintitleStyle(),
                )),
                DataCell(controller.leaveApprovedList[index].leave_line![i].date
                            .toString() ==
                        "null"
                    ? Text("-")
                    : Text(
                        AppUtils.changeDateFormat(controller
                            .leaveApprovedList[index].leave_line![i].date
                            .toString()),
                        style: maintitleStyle(),
                      )),
                DataCell(
                  controller.leaveApprovedList[index].leave_line![i].end_date
                              .toString() !=
                          null
                      ? Text(
                          AppUtils.changeDateFormat(controller
                              .leaveApprovedList[index].leave_line![i].end_date
                              .toString()),
                          style: maintitleStyle(),
                        )
                      : SizedBox(),
                ),
                DataCell(controller.leaveApprovedList[index].leave_line![i].full
                    ? Text(
                        'Full',
                        style: maintitleStyle(),
                      )
                    : controller.leaveApprovedList[index].leave_line![i].first
                        ? Text('First Half')
                        : controller
                                .leaveApprovedList[index].leave_line![i].second
                            ? Text('Second Half')
                            : Text('None')),
              ])
          ]),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Container(
      //       // width: 35,
      //       child: Text(
      //         ("Day"),
      //         style: subtitleStyle(),
      //       ),
      //     ),
      //     Container(
      //       margin: EdgeInsets.only(left: 20),
      //       // width: 80,
      //       child: Text(
      //         labels?.startDate,
      //         style: subtitleStyle(),
      //       ),
      //     ),
      //     Container(
      //       // width: 80,
      //       child: Text(
      //         labels?.endDate,
      //         style: subtitleStyle(),
      //       ),
      //     ),
      //     Container(
      //       // width: 50,
      //       child: Text(
      //         labels?.dayOff,
      //         style: subtitleStyle(),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget leaveWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.leaveApprovedList[index].leave_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          var start_date =
              controller.leaveApprovedList[index].leave_line![ind].start_date;
          var startDate = AppUtils.changeDateFormat(start_date.split(' ')[0]);
          var end_date = controller.leaveApprovedList[index].end_date;
          var endDate = AppUtils.changeDateFormat(end_date.split(' ')[0]);
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expanded(
                    //   child: Container(
                    //     //margin: EdgeInsets.only(right: 30),
                    //     // color: Colors.yellow,
                    //     // width: 40,
                    //     child: Text(controller
                    //         .leaveApprovedList[index].leave_line[ind].day),
                    //   ),
                    // ),
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
                          child: controller.leaveApprovedList[index]
                                  .leave_line![ind].full
                              ? Text('Full')
                              : controller.leaveApprovedList[index]
                                      .leave_line![ind].first
                                  ? Text('First Half')
                                  : controller.leaveApprovedList[index]
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
    if (controller.leaveApprovedList.value[index].attachment != null) {
      if (controller.leaveApprovedList.value[index].attachment!.isNotEmpty) {
        bytes =
            base64Decode(controller.leaveApprovedList.value[index].attachment!);
      }
    }

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
                child: controller.leaveApprovedList.value[index]
                            .holiday_status_id!.name !=
                        null
                    ? Text(
                        controller.leaveApprovedList.value[index]
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
                child:
                    controller.leaveApprovedList.value[index].start_date != null
                        ? Text(
                            AppUtils.changeDateFormat(controller
                                .leaveApprovedList.value[index].start_date),
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
                child: controller.leaveApprovedList.value[index].end_date !=
                        null
                    ? Text(
                        AppUtils.changeDateFormat(
                            controller.leaveApprovedList.value[index].end_date),
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
                  (labels.days + ":"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child:
                    controller.leaveApprovedList.value[index].duration != null
                        ? Text(
                            controller.leaveApprovedList.value[index].duration
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
                child: Text(
                  (labels.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveApprovedList.value[index].description !=
                        null
                    ? Text(
                        controller.leaveApprovedList.value[index].description,
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
                child: controller.leaveApprovedList.value[index].state != null
                    ? Text(controller.leaveApprovedList.value[index].state,
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
                    controller.leaveApprovedList.value[index].attachment != null
                        ? InkWell(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => ImageDialog(
                                        bytes: bytes!,
                                      ));
                            },
                            child: Container(
                              width: 100,
                              child: bytes != null
                                  ? new Image.memory(
                                      bytes,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : new Container(),
                            ),
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
