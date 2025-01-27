

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
import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FirstApprovalEmployeeChangeDetails extends StatefulWidget {
  @override
  _FirstApprovalEmployeeChangeDetailsState createState() => _FirstApprovalEmployeeChangeDetailsState();
}

class _FirstApprovalEmployeeChangeDetailsState extends State<FirstApprovalEmployeeChangeDetails> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.employeeChangeDetails,image)),
      body: Scrollbar(
        // isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: controller.employeeChangesFirstApprovalList.value.length>0 ? Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    controller.employeeChangesFirstApprovalList.value[index].name,
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
                      ),Container(
                          child: Text(
                            controller.employeeChangesFirstApprovalList.value[index].employeeId.name,
                            style: subtitleStyle(),
                          ),
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
                          'Company',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].companyId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].companyId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          'Branch',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].branchId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].branchId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          'Department',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].departmentId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].departmentId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          labels.position,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].jobId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].jobId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          'Job Grade',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].jobGradeId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].jobGradeId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          'Salary Level',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].salaryLevelId.name !=
                              null
                              ? Text(
                            controller.employeeChangesFirstApprovalList.value[index].salaryLevelId.name,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                          'Wage',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                          child: controller.employeeChangesFirstApprovalList.value[index].wage!=
                              null
                              ? Text(AppUtils.addThousnadSperator(controller.employeeChangesFirstApprovalList.value[index].wage)
                            ,
                            style: subtitleStyle(),
                          )
                              : Text('-'),
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
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Effective Date',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.changeDateFormat(controller.employeeChangesFirstApprovalList.value[index].date),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '${labels.newCompany}',
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newCompanyId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Branch',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newBranchId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Department',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newDepartmentId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Job Position',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newJobId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Job Grade',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newJobGradeId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Salary Level',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].newSalaryLevelId.name),
                          style: subtitleStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'New Wage',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.addThousnadSperator(controller.employeeChangesFirstApprovalList.value[index].newWage),
                          style: subtitleStyle(),
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Note',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Text(
                            AppUtils.removeNullString(controller.employeeChangesFirstApprovalList.value[index].note),
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                approveButton(context)
              ],
            ),
          ):Container(),
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
                    .firstApproveEmployeeChange(controller.employeeChangesFirstApprovalList.value[index].id);
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
                controller.declinedEmployeeChange(
                    controller.employeeChangesFirstApprovalList.value[index].id);
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
