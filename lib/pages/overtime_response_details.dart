

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/overtime_response_controller.dart';
import '../controllers/overtime_response_list_controller.dart';
// import '../localization.dart';
import '../models/employee_id.dart';
import '../models/overtime_response.dart';
import '../my_class/my_app_bar.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import '../controllers/overtime_list_controller.dart';
import '../my_class/my_style.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'pre_page.dart';

class OvertimeResponseDetails extends StatelessWidget {
  OverTimeResponseListController controller = Get.find();
  late int index;
  late String state;
  late var otcList = <OvertimeResponse>[];
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var arg = Get.arguments;
    index = int.tryParse(arg.toString().split("state_")[0])!;
    state = arg.toString().split("state_")[1];
    print("index$index");
    print("state$state");
    final box = GetStorage();
    var role = box.read('role_category');
    String user_image = box.read('emp_image');

   /* if (role == 'manager') {
      controller.button_show.value = false;
    } else {*/
      if (state == 'draft') {
        controller.button_show.value = true;
      } else {
        controller.button_show.value = false;
      }
   // }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels?.overtimeDetails,user_image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            state=='draft'?controller.otDraftList.length!=0?overtimeDraftData(context, index):new Container():state=='accept'?overtimeAcceptData(context, index):overtimeDeclinedData(context, index),
            SizedBox(
              height: 15,
            ),
            Obx(()=>controller.button_show.value?overtimeButton(context, index):new Container(),),
          ],
        ),
      ),
    );
  }

  Widget overtimeAcceptData(BuildContext context, index) {
    final labels = AppLocalizations.of(context);
    var startDate = controller.otAcceptedList.value[index].start_date!=null ? AppUtils.changeDateTimeFormat(controller.otAcceptedList.value[index].start_date) : "";
    var endDate = controller.otAcceptedList.value[index].end_date!=null ?AppUtils.changeDateTimeFormat(controller.otAcceptedList.value[index].end_date) : "";
    return Obx(()=>Container(
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
              Container(
                child: controller.otAcceptedList.value[index].employee_id!.name
                    .toString() !=
                    null
                    ? Text(
                    controller.otAcceptedList.value[index].employee_id!.name
                        .toString(),
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
                  labels.title,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otAcceptedList.value[index].name.toString() != null
                    ? Text(controller.otAcceptedList.value[index].name.toString(),
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
                  labels.category,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otAcceptedList.value[index].categ_id!.category != null
                    ? Text(controller.otAcceptedList.value[index].categ_id!.category.toString(),
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
                child: controller.otAcceptedList.value[index].start_date.toString() !=
                    null
                    ? Text(
                    startDate,
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
                child: controller.otAcceptedList.value[index].end_date.toString() !=
                    null
                    ? Text(endDate,
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
                controller.otAcceptedList.value[index].duration.toString() != null
                    ? Text(
                  controller.otAcceptedList.value[index].duration.toString(),
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
    ));
  }

  Widget overtimeDraftData(BuildContext context, index) {
    final labels = AppLocalizations.of(context);
    var startDate = controller.otDraftList.value[index].start_date!=null ? AppUtils.changeDateTimeFormat(controller.otDraftList.value[index].start_date) : "";
    var endDate = controller.otDraftList.value[index].end_date!=null ?AppUtils.changeDateTimeFormat(controller.otDraftList.value[index].end_date) : "";
    return Obx(()=>Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: controller.otDraftList.length!= 0 ?Column(
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
              Container(
                child: controller.otDraftList.value[index].employee_id!.name
                    .toString() !=
                    null
                    ? Text(
                    controller.otDraftList.value[index].employee_id!.name
                        .toString(),
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
                  labels.title,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otDraftList.value[index].name.toString() != null
                    ? Text(controller.otDraftList.value[index].name.toString(),
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
                  labels.category,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otDraftList.value[index].categ_id!.category != null
                    ? Text(controller.otDraftList.value[index].categ_id!.category.toString(),
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
                child: controller.otDraftList.value[index].start_date.toString() !=
                    null
                    ? Text(
                    startDate,
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
                child: controller.otDraftList.value[index].end_date.toString() !=
                    null
                    ? Text(endDate,
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
                controller.otDraftList.value[index].duration.toString() != null
                    ? Text(
                  controller.otDraftList.value[index].duration.toString(),
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
      ): Container(),
    ));
  }

  Widget overtimeDeclinedData(BuildContext context, index) {
    final labels = AppLocalizations.of(context);
    var startDate = controller.otDeclinedList.value[index].start_date!=null ? AppUtils.changeDateTimeFormat(controller.otDeclinedList.value[index].start_date) : "";
    var endDate = controller.otDeclinedList.value[index].end_date!=null ? AppUtils.changeDateTimeFormat(controller.otDeclinedList.value[index].end_date) : "";
    return Obx(()=>Container(
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
              Container(
                child: controller.otDeclinedList.value[index].employee_id!.name
                    .toString() !=
                    null
                    ? Text(
                    controller.otDeclinedList.value[index].employee_id!.name
                        .toString(),
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
                  labels.title,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otDeclinedList.value[index].name != null
                    ? Text(controller.otDeclinedList.value[index].name.toString(),
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
                  labels.category,
                  // labels?.leaveType + " :",

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.otDeclinedList.value[index].categ_id!.category.toString() != null
                    ? Text(controller.otDeclinedList.value[index].categ_id!.category.toString(),
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
                child: controller.otDeclinedList.value[index].start_date.toString() !=
                    null
                    ? Text(
                    startDate,
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
                child: controller.otDeclinedList.value[index].end_date.toString() !=
                    null
                    ? Text(endDate,
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
                controller.otDeclinedList.value[index].duration.toString() != null
                    ? Text(
                  controller.otDeclinedList.value[index].duration.toString(),
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
    ));
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
                    if(state=='draft'){
                      controller.approveOvertime(controller.otDraftList[index].id);
                    }
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
                // decoration: BoxDecoration(
                //     border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
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
