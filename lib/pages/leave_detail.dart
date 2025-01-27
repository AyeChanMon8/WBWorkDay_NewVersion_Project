
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import '../bindings/leave_request_update_bindings.dart';
import '../controllers/leave_list_controller.dart';
// import '../localization.dart';
import '../models/leave_line.dart';
import '../my_class/my_app_bar.dart';
import '../pages/leave_request_update.dart';
import '../pages/pre_page.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import '../my_class/my_style.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LeaveDetails extends StatelessWidget {
  LeaveListController controller = Get.find();
  int index = 0;
  String role_category = '';
  final box = GetStorage();
  String image = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    role_category = box.read('role_category');
    if (role_category == 'employee') {
      if (controller.leaveList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else {
        controller.button_submit_show.value = false;
      }
    } else {
      if (controller.leaveList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else if (controller.leaveList.value[index].state == 'submit') {
        controller.button_approve_show.value = false;
      } else {
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels?.leaveDetails, image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leaveData(context),
            SizedBox(
              height: 15,
            ),
            // leaveTitleWidget(context),
            SizedBox(
              height: 10,
            ),
            leaveWidget(context),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.button_approve_show.value
                  ? leaveDetailsButton(context)
                  : new Container(),
            ),
            Obx(
              () => controller.button_submit_show.value
                  ? actionsButton(context)
                  : new Container(),
            ),
            SizedBox(height: 10),
            Obx(
              () => controller.button_submit_show.value
                  ? leaveSubmitButton(context)
                  : new Container(),
            )
          ],
        ),
      ),
    );
  }

  Widget leaveTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
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
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.leaveList[index].leave_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          var start_date =
              controller.leaveList[index].leave_line![ind].date;
          var startDate = start_date.split(' ')[0];
          var end_date = controller.leaveList[index].leave_line![ind].end_date;
          var endDate = end_date.split(' ')[0];
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
                        child: Text(
                          AppUtils.changeDateFormat(startDate)
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(left: 16),
                        // padding: EdgeInsets.only(left: 5),
                        // color: Colors.red,
                        // width: 80,
                        child: Text(
                          AppUtils.changeDateFormat(endDate)
                          ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          //margin: EdgeInsets.only(left: 30),
                          padding: EdgeInsets.only(left: 20, right: 10),
                          // color: Colors.green,
                          child:
                              controller.leaveList[index].leave_line![ind].full
                                  ? Text('Full')
                                  : controller.leaveList[index].leave_line![ind]
                                          .first
                                      ? Text('First Half')
                                      : Text('Second Half')),
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
    if (controller.leaveList.value[index].attachment != null) {
      if (controller.leaveList.value[index].attachment!.isNotEmpty) {
        bytes = base64Decode(controller.leaveList.value[index].attachment!);
      }
    }

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
                  labels!.leaveType + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child:
                    controller.leaveList.value[index].holiday_status_id!.name !=
                            null
                        ? Text(
                            controller
                                .leaveList.value[index].holiday_status_id!.name,
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
                child: controller.leaveList.value[index].start_date != null
                    ? Text(
                      AppUtils.changeDateFormat(controller.leaveList.value[index].start_date)
                      ,
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
                child: controller.leaveList.value[index].end_date != null
                    ? Text(
                    AppUtils.changeDateFormat(controller.leaveList.value[index].end_date)
                    ,
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
                  ("Days : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveList.value[index].duration != null
                    ? Text(
                        controller.leaveList.value[index].duration.toString() +
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
                  ("Unpaid Days : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveList.value[index].duration_unpaid_leave != null
                    ? Text(
                    AppUtils.removeNullString(controller.leaveList.value[index].duration_unpaid_leave.toString()) +
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
                child: controller.leaveList.value[index].description != null
                    ? Flexible(
                      child: Text(controller.leaveList.value[index].description.capitalize!,
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
                child: controller.leaveList.value[index].state != null
                    ? Text(controller.leaveList.value[index].state.capitalize!,
                        style: subtitleStyle())
                    : Text('-'),
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
                child: Text(
                  labels.attachment + " : ",
                  // (labels?.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.leaveList.value[index].attachment != null
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

  Widget travelSubmitButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.approveLeave(controller.leaveList.value[index].id);
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
            ),
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.declinedLeave(controller.leaveList.value[index].id);
              },
              text: labels?.cancel,
              blockButton: true,
              size: GFSize.LARGE,
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveDetailsButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
                // width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textFieldTapColor,
                  ),
                  onPressed: () {
                    controller.approveLeave(
                      controller.leaveList.value[index].id,
                    );
                  },
                  child: Text(
                    labels!.approve,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Expanded(
            child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),
                  onPressed: () {
                    controller
                        .declinedLeave(controller.leaveList.value[index].id);
                  },
                  child: Text(
                    labels.cancel,
                    style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget actionsButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
                // width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     backgroundColor: textFieldTapColor,
                    ),
                    onPressed: () {
                      //Get.toNamed(Routes.LEAVE_REQUEST, arguments: index);
                      Get.toNamed(Routes.LEAVE_REQUEST_UPDATE,
                          arguments: controller.leaveList.value[index]);

                      // Get.toNamed(Routes.LEAVE_REQUEST,
                      //     arguments: controller.leaveList.value[index].id);
                    },
                    child: Text(
                      // labels?.edit,
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
          Expanded(
            child: Container(
                // width: double.infinity,
                // decoration: BoxDecoration(
                //     border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textFieldTapColor,
                  ),
                  onPressed: () {
                    confirmDialog(
                        controller.leaveList.value[index].id, context);
                  },
                  child: Text(
                    // labels?.delete,
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  confirmDialog(int id, BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Get.back();
        controller.deleteLeave(id, context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete Item"),
      content: Text("Do you want to delete it?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget leaveSubmitButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
                // width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: textFieldTapColor,
                    ),
                    onPressed: () {
                      controller.submitLeave(
                          controller.leaveList.value[index].id, context);
                  },
                    child: Text(
                      labels!.submit,
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
          /* Expanded(
            child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 20),
                child: RaisedButton(
                  color: white,
                  onPressed: () {
                    controller
                        .declinedLeave(controller.leaveList.value[index].id);
                  },
                  child: Text(
                    labels?.cancel,
                    style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
                  ),
                )),
          ),*/
        ],
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  Uint8List? bytes;
  ImageDialog({required this.bytes});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PhotoView(
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        imageProvider: Image.memory(
          bytes!,
        ).image,
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: bytes, fit: BoxFit.cover)),
      ),
    );
  }
}
