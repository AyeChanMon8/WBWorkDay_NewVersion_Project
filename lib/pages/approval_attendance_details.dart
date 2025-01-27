

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import '../controllers/approval_controller.dart';
import '../controllers/leave_list_controller.dart';
import '../localization.dart';

import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../pages/maintenance_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovalAttendanceDetails extends StatefulWidget {
  @override
  _ApprovalAttendanceDetailsState createState() =>
      _ApprovalAttendanceDetailsState();
}

class _ApprovalAttendanceDetailsState extends State<ApprovalAttendanceDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;

    Uint8List bytes;
    if (controller.attendanceApprovalList.value[index].employee_id.image_128 !=
        null) {
      bytes = base64Decode(
          controller.attendanceApprovalList.value[index].employee_id.image_128);
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: appbar(context, "Attendance Approve Details", image)),
        body: SingleChildScrollView(
          child: Obx(()=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(labels!.name),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(controller.attendanceApprovalList
                              .value[index].employee_id.name),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(controller
                            .attendanceApprovalList.value[index].check_in +
                        " - " +
                        controller
                            .attendanceApprovalList.value[index].check_out),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(labels.workHours),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(
                            controller.attendanceApprovalList.value[index]
                                    .worked_hours
                                    .toString() +
                                " hours",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(labels.status),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(controller
                              .attendanceApprovalList.value[index].state
                              .toString()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(labels.overTime),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: Text(controller
                                  .attendanceApprovalList.value[index].ot_hour
                                  .toString() +
                              " hours"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Text(labels.late),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Text(controller.attendanceApprovalList
                                .value[index].late_minutes
                                .toString() +
                            " minutes"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Text(labels.early),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Text(controller.attendanceApprovalList
                            .value[index].early_out_minutes
                            .toString()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  submitButton(context),
                ],
              )
            ],
          ),)
        ));
  }

  Widget submitButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.attendanceApprove(index);
                // controller.submitLeave(
                //     controller.leaveApprovalList.value[index].id, context);
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
                Get.back();
              },
              type: GFButtonType.outline,
              text: labels?.cancel,
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
}
