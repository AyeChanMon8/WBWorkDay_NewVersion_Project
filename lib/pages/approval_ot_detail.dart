

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/approval_controller.dart';
import '../controllers/overtime_response_controller.dart';
import '../controllers/overtime_response_list_controller.dart';
// import '../localization.dart';
import '../models/employee_id.dart';
import '../my_class/my_app_bar.dart';
import '../routes/app_pages.dart';
import '../controllers/overtime_list_controller.dart';
import '../my_class/my_style.dart';
import 'package:get/get.dart';

import 'pre_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OvertimeApprovalDetail extends StatelessWidget {
  ApprovalController controller =
      Get.put(ApprovalController());
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var index = Get.arguments;
    final box = GetStorage();
    var role = box.read('role_category');
    String user_image = box.read('emp_image');

    if (role == 'manager') {
      controller.button_show = false;
    } else {
      if (controller.otcList.value[index].state.toString() == 'draft') {
        controller.button_show = true;
      } else {
        controller.button_show = false;
      }
    }
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60.0),child: appbar(context, labels!.overtimeDetails,user_image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            overtimeData(context, index),
            SizedBox(
              height: 15,
            ),
            if (controller.button_show == true) overtimeButton(context, index),
          ],
        ),
      ),
    );
  }

  Widget overtimeData(BuildContext context, index) {
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
                  labels!.name,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Obx(
                () => Container(
                  child: controller.otcList.value[index].employee_id!.name
                              .toString() !=
                          null
                      ? Text(
                          controller.otcList.value[index].employee_id!.name
                              .toString(),
                          style: subtitleStyle())
                      : Text('-'),
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
                  labels.title,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otcList.value[index].name.toString() != null
                    ? Text(controller.otcList.value[index].name.toString(),
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
                child: controller.otcList.value[index].start_date.toString() !=
                        null
                    ? Text(
                        controller.otcList.value[index].start_date.toString(),
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
                child: controller.otcList.value[index].end_date.toString() !=
                        null
                    ? Text(controller.otcList.value[index].end_date.toString(),
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
                child:
                    controller.otcList.value[index].duration.toString() != null
                        ? Text(
                            controller.otcList.value[index].duration.toString(),
                            style: subtitleStyle(),
                          )
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

  Widget overtimeButton(BuildContext context, int index) {
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
                    controller.approveOvertime(controller.otcList[index].id);
                  },
                  child: Text(
                    labels!.accept,
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
                    Get.toNamed(Routes.OVERTIME_DECLINE, arguments: index);

                    // controller.approveTravel(
                    //     controller.travelLineList.value[index].id);
                  },
                  child: Text(
                    labels.decline,
                    style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget? confirmDialog(BuildContext context, int index) {
    final labels = AppLocalizations.of(context);

    //   AlertDialog(
    //     title: Text('AlertDialog Title'),
    //     content: SingleChildScrollView(
    //       child: ListBody(
    //         children: <Widget>[
    //           Text('This is a demo alert dialog.'),
    //           Text('Would you like to approve of this message?'),
    //         ],
    //       ),
    //     ),
    //   );
    //   actions:
    //   <Widget>[
    //     RaisedButton(
    //       color: white,
    //       onPressed: () {
    //         // controller.approveTravel(
    //         //     controller.travelLineList.value[index].id);
    //       },
    //       child: Text(
    //         labels?.accept,
    //         style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
    //       ),
    //     ),
    //   ];
  }
}
