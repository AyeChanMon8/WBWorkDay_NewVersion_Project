import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/expense_travel_list/out_of_pocket_list.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/pages/pre_page.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import '../../my_class/my_style.dart';
import 'package:get/get.dart';

import '../leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutOfPocketDetails extends StatelessWidget {
  OutofPocketList controller = Get.put(OutofPocketList());
  int index = 0;
  String role_category = "";
  final box = GetStorage();
  String image = "";
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    role_category = box.read('role_category');
    controller.getAttachment(controller.outofpocketExpenseList.value[index].id);
    if (role_category == 'employee') {
      if (controller.outofpocketExpenseList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else {
        controller.button_submit_show.value = false;
      }
    } else {
      if (controller.outofpocketExpenseList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
      } else if (controller.outofpocketExpenseList.value[index].state ==
          'submit') {
        controller.button_submit_show.value = false;
        controller.button_approve_show.value = false;
      } else {
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(context, labels!.outofpocketDetails, image)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.outofpocketExpenseList.value[index].state != 'draft'
                ? Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      controller.outofpocketExpenseList.value[index].number,
                      // ("From Date : "),
                      style: labelPrimaryTitleBoldTextStyle(),
                    ),
                  )
                : SizedBox(),
            leaveData(context),
            SizedBox(
              height: 15,
            ),
            leaveTitleWidget(context),
            SizedBox(
              height: 10,
            ),
            leaveWidget(context, index),
            Align(
                alignment: Alignment.center,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      '${labels?.total} ${labels?.amount} : ${NumberFormat('#,###').format(controller.getTotalAmount(index))}',
                      style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                    ))),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.button_approve_show.value
                  ? leaveDetailsButton(context)
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
          Expanded(
            flex: 1,
            child: Container(
              // width: 35,
              child: Text(
                (labels!.date),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Text(
                labels.title,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  labels.description,
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     // width: 80,
          //     child: Text(
          //       "Qty",
          //       style: subtitleStyle(),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  labels.amount,
                  style: subtitleStyle(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 50,
              child: Text(
                "",
                style: subtitleStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveWidget(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
            controller.outofpocketExpenseList.value[index].pocket_line.length,
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
                            .outofpocketExpenseList
                            .value[index]
                            .pocket_line[ind]
                            .date)),
                        // child: Text(DateTime.parse(controller
                        //         .outofpocketExpenseList
                        //         .value[index]
                        //         .pocket_line[ind]
                        //         .date)
                        //     .add(Duration(hours: 6, minutes: 30))
                        //     .toString()
                        //     .replaceAll('.000', '')),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          controller.outofpocketExpenseList.value[index]
                              .pocket_line[ind].product_id.name
                              .toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: controller.outofpocketExpenseList.value[index]
                                    .pocket_line[ind].description !=
                                null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  controller.outofpocketExpenseList.value[index]
                                      .pocket_line[ind].description
                                      .toString(),
                                ),
                              )
                            : SizedBox(),
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     child: Text(controller.outofpocketExpenseList.value[index]
                    //         .pocket_line[ind].qty
                    //         .toString()),
                    //   ),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(NumberFormat('#,###')
                              .format(controller.outofpocketExpenseList
                                  .value[index].pocket_line[ind].price_subtotal)
                              .toString()),
                        ),
                      ),
                    ),
                    controller.outofpocketExpenseList[index].pocket_line[ind]
                                    .attachment_include !=
                                null &&
                            controller.outofpocketExpenseList[index]
                                .pocket_line[ind].attachment_include
                        ? Expanded(
                            flex: 1,
                            child: IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () async {
                                  var selected_image = "";
                                  if (controller.attachment_list.length != 0) {
                                    for (var element
                                        in controller.attachment_list) {
                                      if (element.expenseLineId ==
                                          controller
                                              .outofpocketExpenseList[index]
                                              .pocket_line[ind]
                                              .id) {
                                        print(element.attachments);
                                        if (element.attachments.length != 0) {
                                          selected_image =
                                              element.attachments[0];
                                        }
                                        ;
                                        break;
                                      }
                                    }
                                  }
                                  await showDialog(
                                      context: context,
                                      builder: (_) => Container(
                                            height: 200,
                                            child: ImageDialog(
                                              bytes:
                                                  base64Decode(selected_image),
                                            ),
                                          ));
                                }),
                          )
                        : SizedBox()
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
    Uint8List bytes;
    // if (controller.outofpocketExpenseList.value[index].poc != null) {
    //   if (controller.outofpocketExpenseList.value[index].attached_file.isNotEmpty) {
    //     bytes = base64Decode(controller.outofpocketExpenseList.value[index].attachment);
    //     print(controller.outofpocketExpenseList.value[index].attachment);
    //   }
    // }

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
                  "${labels!.name} :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.outofpocketExpenseList.value[index]
                            .employee_id.name !=
                        null
                    ? Text(
                        controller.outofpocketExpenseList.value[index]
                            .employee_id.name,
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
                child:
                    controller.outofpocketExpenseList.value[index].date != null
                        ? Text(
                            AppUtils.changeDateFormat(controller
                                .outofpocketExpenseList.value[index].date),
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
                child: controller.outofpocketExpenseList.value[index].state !=
                        null
                    ? controller.outofpocketExpenseList.value[index].state ==
                            "finance_approve"
                        ? Text(
                            "Finance approve",
                            style: subtitleStyle(),
                          )
                        : Text(
                            controller
                                .outofpocketExpenseList.value[index].state,
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
                //     controller.outofpocketExpenseList.value[index].id);
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
                //     controller.outofpocketExpenseList.value[index].id);
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
                    // controller.approveLeave(
                    //   controller.outofpocketExpenseList.value[index].id,
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                  ),
                  onPressed: () {
                    // controller.declinedLeave(
                    //     controller.outofpocketExpenseList.value[index].id);
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
                      if (controller
                              .outofpocketExpenseList.value[index].state ==
                          "draft") {
                        Get.toNamed(Routes.OUT_OF_POCKET_UPDATE, arguments: {
                          'value':
                              controller.outofpocketExpenseList.value[index],
                          'id': index
                        });
                      } else {
                        AppUtils.showToast('Cannot Edit!');
                      }
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
                        controller.outofpocketExpenseList.value[index].id,
                        context);
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
        controller.deleteOutofPocket(id, context);
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
                  style: ElevatedButton.styleFrom(backgroundColor: textFieldTapColor),
                    onPressed: () {
                      controller.submitRequest(
                          controller.outofpocketExpenseList.value[index].id,
                          context);
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
                    // controller.declinedLeave(
                    //     controller.outofpocketExpenseList.value[index].id);
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
