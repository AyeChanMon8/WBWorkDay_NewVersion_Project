import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/expense_travel_list/expense_travel_list_controller.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/pages/pre_page.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import '../../my_class/my_style.dart';
import 'package:get/get.dart';

import '../leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseTravelDetails extends StatelessWidget {
  final ExpensetravelListController controller =
      Get.put(ExpensetravelListController());
  int index = 0;
  String role_category = "";
  final box = GetStorage();
  String image = "";
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    controller
        .getAttachmentTravel(controller.travelExpenseList.value[index].id);
    image = box.read('emp_image');
    index = Get.arguments;
    role_category = box.read('role_category');
    if (role_category == 'employee') {
      if (controller.travelExpenseList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else {
        controller.button_submit_show.value = false;
      }
    } else {
      if (controller.travelExpenseList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else if (controller.travelExpenseList.value[index].state == 'submit') {
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
      } else {
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(context, "Travel Expense Details", image),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 65),
              child: Row(
                children: [
                  Obx(
                    () => controller.showDetails.value
                        ? Expanded(
                            flex: 2,
                            child: AutoSizeText(
                              labels!.viewDetailsClose,
                              style: maintitlenoBoldStyle(),
                            ),
                          )
                        : Expanded(
                            flex: 2,
                            child: AutoSizeText(
                              labels!.viewDetails,
                              style: maintitlenoBoldStyle(),
                            ),
                          ),
                  ),
                  Obx(
                    () => controller.showDetails.value
                        ? Expanded(
                            flex: 1,
                            child: IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.arrow_circle_up_sharp),
                              onPressed: () {
                                controller.showDetails.value = false;
                              },
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.arrow_circle_down_sharp),
                              onPressed: () {
                                controller.showDetails.value = true;
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.showDetails.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: controller
                                        .travelExpenseList.value[index].state !=
                                    'draft'
                                ? Text(
                                    controller
                                        .travelExpenseList.value[index].number,
                                    // ("From Date : "),
                                    style: labelPrimaryTitleBoldTextStyle(),
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          travelExpenseHeaderData(context),
                          SizedBox(
                            height: 15,
                          ),
                        ])
                  : SizedBox(),
            ),
            travelExpenseTitleWidget(context),
            SizedBox(
              height: 10,
            ),
            travelExpenseWidget(context, index),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      '${labels?.total} Advance Amount : ${NumberFormat('#,###').format(controller.getTotalAdvanceAmount(index))}',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    ))),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      '${labels?.total} Amount : ${NumberFormat('#,###').format(controller.getTotalAmount(index))}',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    ))),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  height: 1,
                  color: Colors.deepPurple,
                )),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: controller.getRemainingAmount(index) < 0
                        ? Text(
                            'Surplus to be Returned : ${NumberFormat('#,###').format(controller.getRemainingAmount(index).abs())}',
                            style: TextStyle(
                                fontSize: 16, color: Colors.deepPurple),
                          )
                        : Text(
                            'Deficit for Reimbursement : ${NumberFormat('#,###').format(controller.getRemainingAmount(index))}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.deepPurple),
                          ))),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.button_approve_show.value
                  ? travelExpenseDetailsButton(context)
                  : new Container(),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.button_submit_show.value
                  ? actionsButton(context)
                  : new Container(),
            ),
            SizedBox(height: 10),
            /* Obx(
              () => controller.button_submit_show.value
                  ? travelExpenseSubmitButton(context)
                  : new Container(),
            )*/
          ],
        ),
      ),
    );
  }

  Widget travelExpenseTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // width: 35,
              child: Text(
                (labels!.expenseDate),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                "Expense Title",
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                labels.description,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 50,
              child: Text(
                labels.amount,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Widget travelExpenseWidget(BuildContext context, int index) {
    return Container(
      //margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.travelExpenseList.value[index].travel_line.length,
        itemBuilder: (BuildContext context, int ind) {
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: Text(AppUtils.changeDateFormat(controller
                              .travelExpenseList
                              .value[index]
                              .travel_line[ind]
                              .date))
                          //   DateTime.parse(controller
                          //   .travelExpenseList.value[index].travel_line[ind].date)
                          //   .add(Duration(hours: 6, minutes: 30))
                          //   .toString()
                          //   .replaceAll('.000', '')
                          //  ),
                          ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                            controller.travelExpenseList.value[index]
                                .travel_line[ind].product_id.name
                                .toString(),
                            maxLines: 4),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: Get.width/4,
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          controller.travelExpenseList.value[index]
                                      .travel_line[ind].description ==
                                  null
                              ? ''
                              : controller.travelExpenseList.value[index]
                                  .travel_line[ind].description
                                  .toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                            NumberFormat("#,###", "en_US")
                                .format(double.tryParse(
                              controller.travelExpenseList.value[index]
                                  .travel_line[ind].price_subtotal
                                  .toString(),
                            )),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    controller.travelExpenseList[index].travel_line[ind]
                                    .attachment_include !=
                                null &&
                            controller.travelExpenseList[index].travel_line[ind]
                                .attachment_include
                        ? Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.attach_file),
                              onPressed: () async {
                                controller
                                    .findExpenseImage(controller
                                        .travelExpenseList
                                        .value[index]
                                        .travel_line[ind]
                                        .id)
                                    .then((value) async {
                                  print("value >>" + value.length.toString());
                                  if (value.length > 0) {
                                    attachmentBottomSheet(context, value);
                                  } else {
                                    AppUtils.showToast("No Attachment");
                                  }
                                });
                              },
                            ),
                          )
                        : Expanded(flex: 1, child: Container())
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

  Widget travelExpenseHeaderData(BuildContext context) {
    Uint8List bytes;
    // if (controller.travelExpenseList.value[index].poc != null) {
    //   if (controller.travelExpenseList.value[index].attached_file.isNotEmpty) {
    //     bytes = base64Decode(controller.travelExpenseList.value[index].attachment);
    //     print(controller.travelExpenseList.value[index].attachment);
    //   }
    // }

    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Text(
          //         "Travel Expense ID" + " :",
          //         // ("Leave type : "),
          //         style: datalistStyle(),
          //       ),
          //     ),
          //     Container(
          //       child: controller.travelExpenseList.value[index].id != null
          //           ? Text(
          //               controller.travelExpenseList.value[index].id.toString(),
          //               style: subtitleStyle())
          //           : Text('-'),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "${labels!.name} :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller
                            .travelExpenseList.value[index].employee_id.name !=
                        null
                    ? Text(
                        controller
                            .travelExpenseList.value[index].employee_id.name,
                        style: subtitleStyle())
                    : Text('-'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       child: Text(
          //         "Company Name" + " :",
          //         style: datalistStyle(),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  ("${labels.date} :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.travelExpenseList.value[index].date != null
                    ? Text(
                        AppUtils.changeDateFormat(
                            controller.travelExpenseList.value[index].date),
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
                  ("${labels.status} :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.travelExpenseList.value[index].state != null
                    ? Text(controller.travelExpenseList.value[index].state,
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
                  ("${labels.travelRequest} :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child:
                    controller.travelExpenseList.value[index].travel_id.name !=
                            null
                        ? Text(
                            controller
                                .travelExpenseList.value[index].travel_id.name,
                            style: subtitleStyle())
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

  Widget travelSubmitButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                // controller.approveLeave(
                //     controller.travelExpenseList.value[index].id);
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
            ),
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                // controller.declinedLeave(
                //     controller.travelExpenseList.value[index].id);
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

  Widget travelExpenseDetailsButton(BuildContext context) {
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
                    // controller.approveLeave(
                    //   controller.travelExpenseList.value[index].id,
                    // );
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
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    // controller.declinedLeave(
                    //     controller.travelExpenseList.value[index].id);
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
                    style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
                    onPressed: () {
                      Get.toNamed(Routes.EXPENSE_TRAVEL_UPDATE,
                          arguments: index);
                      // Get.toNamed(Routes.LEAVE_REQUEST,
                      //     arguments: controller.travelExpenseList.value[index].id);
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
                  style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
                    onPressed: () {
                      controller.submitTravelExpense(
                          controller.travelExpenseList.value[index].id,
                          context,
                          controller.travelExpenseList.value[index].travel_line,
                          controller
                              .travelExpenseList.value[index].employee_id.id,
                          controller.travelExpenseList.value[index].number);
                    },
                    child: Text(
                      labels!.submit,
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
  }

  confirmDialog(int id, BuildContext context) {
    Widget cancelButton = ElevatedButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        controller.deleteTravelExpense(id, context);
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

  // Widget travelExpenseSubmitButton(BuildContext context) {
  //   final labels = AppLocalizations.of(context);
  //   return Container(
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //               // width: double.infinity,
  //               height: 45,
  //               margin: EdgeInsets.only(left: 20, right: 10),
  //               child: RaisedButton(
  //                   color: textFieldTapColor,
  //                   onPressed: () {
  //                     controller.submitTravelExpense(
  //                         controller.travelExpenseList.value[index].id,
  //                         context);
  //                   },
  //                   child: Text(
  //                     labels?.submit,
  //                     style: TextStyle(color: Colors.white),
  //                   ))),
  //         ),
  //         /*Expanded(
  //           child: Container(
  //               // width: double.infinity,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
  //               height: 45,
  //               margin: EdgeInsets.only(left: 10, right: 20),
  //               child: RaisedButton(
  //                 color: white,
  //                 onPressed: () {
  //                   // controller.declinedLeave(
  //                   //     controller.travelExpenseList.value[index].id);
  //                 },
  //                 child: Text(
  //                   labels?.cancel,
  //                   style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
  //                 ),
  //               )),
  //         ),*/
  //       ],
  //     ),
  //   );
  // }
  dynamic attachmentBottomSheet(BuildContext context, List<String> value) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.close_outlined),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        attachmentGridView(value, context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget attachmentGridView(List<String> value, BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(value.length, (index) {
        Uint8List ?bytes1;
        if (value[index] != null) {
          bytes1 = base64Decode(value[index]);
        }
        var label = index + 1;
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Align(
            child: InkWell(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) => Container(
                          height: 200,
                          child: ImageDialog(
                            bytes: bytes1,
                          ),
                        ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: new Image.memory(
                  base64Decode(value[index]),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
