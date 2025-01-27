

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'leave_detail.dart';

class ApprovalResignationDetails extends StatefulWidget {
  @override
  _ApprovalResignationDetailsState createState() => _ApprovalResignationDetailsState();
}

class _ApprovalResignationDetailsState extends State<ApprovalResignationDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.resignationDetails,image)),
      body: Scrollbar(
        // isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].name)
                    ,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.employeeName,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.resignationApprovalList.value.length > 0 ?Container(
                          child: Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].employeeId!.name),
                            style: subtitleStyle(),
                          ),
                        ):SizedBox(),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.employeeContract,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.resignationApprovalList.value.length > 0 ?Container(
                          child: controller.resignationApprovalList.value[index].employeeContract !=
                              null
                              ? Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].employeeContract)
                           ,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
                        ):SizedBox(),
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Department',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.resignationApprovalList.value.length > 0 ?Container(
                          child: controller.resignationApprovalList.value[index].departmentId !=
                              null
                              ? Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].departmentId!.name)
                            ,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
                        ):SizedBox(),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.company,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Branch"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.resignationApprovalList.value.length > 0 ?Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Container(
                            child: Text(
                              AppUtils.removeNullString(controller.resignationApprovalList.value[index].company_id!.name),
                              style: subtitleStyle(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Align(
                            alignment:Alignment.topRight,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left:50.0),
                                child: Text(
                                  AppUtils.removeNullString(controller.resignationApprovalList.value[index].branch_id!.name),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Join Date',
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Confirm Date"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.resignationApprovalList.value.length > 0 ?Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].joinedDate),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].confirm_date),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   child: Text(
                      //     'Last Day of Employee',
                      //     // ("loan_amount"),
                      //     style: datalistStyle(),
                      //   ),
                      // ),
                      Container(
                        child: Text(
                          'Approved Last Day Of Employee',
                          // ("no_of_installments"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => controller.resignationApprovalList.value.length > 0 ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   child: Text(
                        //     AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].expectedRevealingDate.toString()),
                        //     style: subtitleStyle(),
                        //   ),
                        // ),
                        Container(
                          child: Text(
                              AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].approvedRevealingDate.toString()),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox(),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Reason',
                            // ("position"),
                            style: datalistStyle(),
                          ),
                        ),
                      ),
                      Obx(
                            () => controller.resignationApprovalList.value.length > 0 ? Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                          child: controller.resignationApprovalList.value[index].reason !=
                                  null
                                  ? Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].reason)
                                ,
                                style: subtitleStyle(),
                          ),
                                  )
                                  : Text('-'),
                        ),
                              ),
                            ):SizedBox(),
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Type',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => controller.resignationApprovalList.value.length > 0 ?Container(
                          child: controller.resignationApprovalList.value[index].resignationType !=
                              null
                              ? Text(AppUtils.removeNullString(controller.resignationApprovalList.value[index].resignationType)
                            ,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
                        ):SizedBox(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                approveButton(context)
              ],
            ),
          ),
        ),
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
                    .approveResign(controller.resignationApprovalList.value[index].id);
                print("Loan approved");
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
                controller.declinedResignation(
                    controller.resignationApprovalList.value[index].id);
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

}
