

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/approval_controller.dart';
import '../controllers/reward_controller.dart';
import '../controllers/warning_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  final ApprovalController controller = Get.put(ApprovalController());
  final RewardController rewardController = Get.put(RewardController());
  final AnnouncementsController announcementsController = Get.put(AnnouncementsController());
  final WarningController warningController = Get.put(WarningController());
  final box = GetStorage();
  String image = '';

  @override
  Widget build(BuildContext context) {
    var role_category = box.read('role_category');
    return role_category == 'employee'
        ? employeeeApprove(context)
        : managerApprove(context);
  }

  @override
  Widget employeeeApprove(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.approval,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    controller.getOtResponse();
                  },
                  child: Text(
                    labels.overtimeResponse,
                    style: labelStyle(),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Obx(
                  () => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.otcList.value.length > 3
                          ? 3
                          : controller.otcList.value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.APPROVAL_OVERTIME_DETAILS,
                                arguments: index);
                          },
                          child: Card(
                            child: ListTile(
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //     "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                                //   ),
                                // ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        controller.otcList.value[index].name,
                                        style: listTileStyle(),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          controller
                                                  .otcList.value[index].duration
                                                  .toString() +
                                              " hours ",
                                          style: subtitleStyle(),
                                        )),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        controller.otcList.value[index]
                                            .requested_employee_id!.name,
                                        style: labelStyle(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        controller
                                            .otcList.value[index].start_date,
                                        style: subtitleStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: arrowforwardIcon),
                          ),
                        );
                      }),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.APPROVAL_OVERTIME_LIST);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.allRequests,
                          style: listTileStyle(),
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              child: Text(
                                controller.overtime_count.value.toString(),
                                style: countLabelStyle(),
                              ),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  )),
                            ),
                          ),
                          arrowforwardIcon,
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.APPROVAL_PTP_ROUTE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptpRouteApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .ptp_route_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            // Divider(
            //     color: Colors.grey,
            //   ),
              Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.APPROVAL_PTW_ROUTE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptwRouteApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .ptw_route_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget managerApprove(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.approval,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.leaveApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller.leave_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_TRAVEL_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.travelApproval,
                              // "all_requests",
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.travel_approval_count.value
                                        .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_OUTOFPOCKET_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.outofpocketApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .out_of_pocket_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_TRAVEL_EXPENSE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.travelExpenseApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .travel_expense_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_TRIPEXPENSE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.tripExpenseApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller.trip_expense_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.WARNING_APPROVE_TAB_PAGE);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.waningApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    warningController.warning_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.REWARD_APPROVE_TAB_PAGE);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.rewardApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    rewardController.reward_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Divider(
            //         color: Colors.grey,
            //       ),
            //       InkWell(
            //         onTap: (){
            //           Get.toNamed(Routes.REMINDER_APPROVE_TAB_PAGE);
            //         },
            //         child: Container(
            //           padding: EdgeInsets.only(left: 20, right: 20),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Container(
            //                 child: Text(
            //                   "Reminder Approval",
            //                   style: listTileStyle(),
            //                 ),
            //               ),
            //               Row(
            //                 children: [
            //                   Obx(
            //                         () => Container(
            //                       child: Text(
            //                         controller.reward_approval_count.value
            //                             .toString(),
            //                         style: countLabelStyle(),
            //                       ),
            //                       padding: EdgeInsets.all(5),
            //                       decoration: BoxDecoration(
            //                           color: Colors.red,
            //                           shape: BoxShape.circle,
            //                           border:Border.all(
            //                             color: Colors.white,
            //                             width: 2,
            //                           )
            //                       ),
            //                     ),
            //                   ),
            //                   arrowforwardIcon,
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Divider(
            //         color: Colors.grey,
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ANNOUNCEMENTS_APPROVAL_TAB_PAGE);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.announcementApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller.announcement_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_ROUTE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.routeApproval,
                              // "all_requests",
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.route_approval_count.value ==
                                            null
                                        ? '0'
                                        : controller.route_approval_count.value
                                            .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            

            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_RESIGNATION_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.resignationApproval,
                              // "all_requests",
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.resignation_approval_count.value ==
                                        null
                                        ? '0'
                                        : controller.resignation_approval_count.value
                                        .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_LOAN_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.loanApproval,
                              // "all_requests",
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.loan_approval_count.value ==
                                        null
                                        ? '0'
                                        : controller.loan_approval_count.value
                                        .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_EMPLOYEE_CHANGES_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.employeeChangesApproval,
                              // "all_requests",
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.employee_changes_approval_count.value ==
                                        null
                                        ? '0'
                                        : controller.employee_changes_approval_count.value
                                        .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_SUSPENSION_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.suspensionApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Container(
                                  // padding: EdgeInsets.only(),
                                  child: Text(
                                    controller.suspened_approval_count.value ==
                                        null
                                        ? '0'
                                        : controller.suspened_approval_count.value
                                        .toString(),
                                    // "2",
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.APPROVAL_INSURANCE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.insuranceApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .insurance_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.APPROVAL_PTP_ROUTE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptpRouteApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .ptp_route_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.APPROVAL_PTW_ROUTE_LIST);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptwRouteApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .ptw_route_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.PTP_ROUTE_APPROVAL_REPLACE_TABAR);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptpRouteReplacementApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .route_replace_ptp_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                       Get.toNamed(Routes.PTW_ROUTE_APPROVAL_REPLACE_TABAR);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              labels.ptwRouteReplacementApproval,
                              style: listTileStyle(),
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  child: Text(
                                    controller
                                        .route_replace_ptw_approval_count.value
                                        .toString(),
                                    style: countLabelStyle(),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )),
                                ),
                              ),
                              arrowforwardIcon,
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
