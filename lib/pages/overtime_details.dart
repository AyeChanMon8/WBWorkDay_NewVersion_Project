import 'dart:convert';
// import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../utils/app_utils.dart';
import '../controllers/overtime_list_controller.dart';
import '../my_class/my_style.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pre_page.dart';

class OvertimeDetails extends StatelessWidget {
  int index = 0;
  OverTimeListController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var arguments = Get.arguments.toString();
    var data = arguments.split(',');
    index = int.tryParse(data[0])!;
    final box = GetStorage();
    String user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, labels?.overtimeDetails, user_image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            overtimeData(context),
            SizedBox(
              height: 15,
            ),
            overtimeTitleWidget(context),
            SizedBox(
              height: 20,
            ),
            dataWidget(context),
            Obx(() => controller.otList.length > 0
                ? (controller.otList[index].state == 'draft'
                    ? overtimeSubmitButton(context)
                    : new Container())
                : SizedBox()),
            // if (controller.button_show == true) overtimeButton(context),
          ],
        ),
      ),
    );
  }

  Widget overtimeTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      //margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            // width: 80,
            child: Text(
              labels!.employeeName + "/" + labels.employeeMail,
              // labels?.startDate,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 80,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                labels.status,
                // labels?.endDate,
                style: subtitleStyle(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            // width: 50,
            child: Text(
              labels.reason,
              // labels?.dayOff,
              style: subtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget dataWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // itemCount: controller.travelLineList.length,
        itemCount: controller.otList[index].request_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          // var start_date =
          //     controller.otList[index].request_line[ind].start_date;
          // var startDate = start_date.split(' ')[0];
          // var end_date = controller.otList[index].end_date;
          // var endDate = end_date.split(' ')[0];
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        // color: Colors.yellow,
                        // width: 40,
                        child: Column(
                          children: [
                            Text(
                              controller.otList[index].request_line![ind]
                                  .employee_id!.name,
                              style: labelPrimaryHightlightTextStyle(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(controller.otList[index].request_line![ind]
                                        .email ==
                                    null
                                ? "-"
                                : controller
                                    .otList[index].request_line![ind].email)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        // padding: EdgeInsets.only(left: 5),
                        // color: Colors.red,
                        // width: 80,
                        child: Text(
                            controller.otList[index].request_line![ind].state ==
                                    'draft'
                                ? 'Waiting'
                                : controller.otList[index].request_line![ind]
                                            .state ==
                                        'cancel'
                                    ? 'declined'
                                    : controller.otList[index]
                                        .request_line![ind].state),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        // padding: EdgeInsets.only(left: 10),
                        // color: Colors.blue,
                        // width: 80,
                        child: controller.otList[index].reason != null
                            ? Text(controller.otList[index].reason)
                            : Text('-'),
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

  Widget overtimeData(BuildContext context) {
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
                  labels!.title,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otList.value[index].name != null
                    ? Text(controller.otList.value[index].name,
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
                  // "Start Date Time",
                  labels.startDate + " :",
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otList.value[index].start_date != null
                    ? Text(
                        AppUtils.changeDefaultDateTimeFormat(
                            controller.otList.value[index].start_date),
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
                  // "End Date Time",
                  (labels.endDate + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otList.value[index].end_date != null
                    ? Text(
                        AppUtils.changeDefaultDateTimeFormat(
                            controller.otList.value[index].end_date),
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
                  labels.duration,
                  // (labels?.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otList.value[index].duration != null
                    ? Text(
                        (controller.otList.value[index].duration).toString(),
                        style: subtitleStyle(),
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
                  labels.category,
                  // (labels?.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otList.value[index].categ_id!.category != null
                    ? Text(
                        (controller.otList.value[index].categ_id!.category)
                            .toString(),
                        style: subtitleStyle(),
                      )
                    : Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget overtimeSubmitButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
                // width: double.infinity,
                height: 45,
                margin: EdgeInsets.only(left: 20, right: 10, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textFieldTapColor,
                  ),
                  onPressed: () {
                    controller
                        .submitOvertime(controller.otList.value[index].id);
                  },
                  child: Text(
                    labels!.submit,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
          Expanded(
            child: Container(
                // width: double.infinity,
                // decoration: BoxDecoration(
                //     border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),
                  onPressed: () {
                    controller
                        .cancelOvertime(controller.otList.value[index].id);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
