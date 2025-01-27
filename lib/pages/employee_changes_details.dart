

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import '../controllers/approval_controller.dart';
import '../controllers/employee_change_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmployeeChangeDetails extends StatefulWidget {
  @override
  _EmployeeChangeDetailsState createState() => _EmployeeChangeDetailsState();
}

class _EmployeeChangeDetailsState extends State<EmployeeChangeDetails> {
  final EmployeeChangeController controller =
      Get.put(EmployeeChangeController());
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
        child: appbar(context, labels!.employeeChangeDetails, image)),
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
                  child: Text(
                    controller.empChangeList.value[index].name,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.status,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: Text(
                            AppUtils.removeNullString(
                                controller.empChangeList.value[index].state),
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          labels.employeeName,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: Text(
                            controller
                                .empChangeList.value[index].employeeId.name,
                            style: subtitleStyle(),
                          ),
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
                          labels.company,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.empChangeList.value[index].companyId
                                      .name !=
                                  null
                              ? Text(
                                  controller.empChangeList.value[index]
                                      .companyId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.branch,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.empChangeList.value[index].branchId
                                      .name !=
                                  null
                              ? Text(
                                  controller
                                      .empChangeList.value[index].branchId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.department,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.empChangeList.value[index]
                                      .departmentId.name !=
                                  null
                              ? Text(
                                  controller.empChangeList.value[index]
                                      .departmentId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.position,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller
                                      .empChangeList.value[index].jobId.name !=
                                  null
                              ? Text(
                                  controller
                                      .empChangeList.value[index].jobId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.jobGrade,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.empChangeList.value[index]
                                      .jobGradeId.name !=
                                  null
                              ? Text(
                                  controller.empChangeList.value[index]
                                      .jobGradeId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.salaryLevel,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.empChangeList.value[index]
                                      .salaryLevelId.name !=
                                  null
                              ? Text(
                                  controller.empChangeList.value[index]
                                      .salaryLevelId.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                          labels.wage,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child:
                              controller.empChangeList.value[index].wage != null
                                  ? Text(
                                      AppUtils.addThousnadSperator(controller
                                          .empChangeList.value[index].wage),
                                      style: subtitleStyle(),
                                    )
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.effectiveDate,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.changeDateFormat(
                              controller.empChangeList.value[index].date),
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
                          labels.newCompany,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller
                              .empChangeList.value[index].newCompanyId.name),
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
                          labels.newBranch,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller
                              .empChangeList.value[index].newBranchId.name),
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
                          labels.newDepartment,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller
                              .empChangeList.value[index].newDepartmentId.name),
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
                          labels.newJobPosition,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller
                              .empChangeList.value[index].newJobId.name),
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
                          labels.newJobGrade,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller
                              .empChangeList.value[index].newJobGradeId.name),
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
                          labels.newSalaryLevel,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.removeNullString(controller.empChangeList
                              .value[index].newSalaryLevelId.name),
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
                          labels.newWage,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          AppUtils.addThousnadSperator(
                              controller.empChangeList.value[index].newWage),
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            labels.note,
                            // ("position"),
                            style: datalistStyle(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            AppUtils.removeNullString(
                                controller.empChangeList.value[index].note),
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
                controller.empChangeList.value[index].state == 'draft'
                    ? GFButton(
                        color: textFieldTapColor,
                        onPressed: () {
                          controller.requestSend(
                              controller
                                  .empChangeList.value[index].employeeId.id,
                              controller.empChangeList.value[index].id);
                        },
                        text: "Request",
                        blockButton: true,
                        size: GFSize.LARGE,
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
