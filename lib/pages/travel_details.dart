

//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/travel_list_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../pages/pre_page.dart';
import '../pages/travel_request_update.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import '../my_class/my_style.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TravelDetails extends StatelessWidget {
  final TravelListController controller = Get.put(TravelListController());
  var format = NumberFormat('#,###.#');
  int index = 0;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    if(Get.arguments.runtimeType == int)
    index = Get.arguments;
    var role_category = box.read('role_category');
    String user_image = box.read('emp_image');

    if (role_category == 'employee') {
      if (controller.travelLineList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
        controller.button_advance_show.value = false;
        controller.button_approve_show.value = false;
      } else if (controller.travelLineList.value[index].state == 'approve') {
        if(controller.getTotalAmount(index) > 0)
        controller.button_advance_show.value = true;
        else
          controller.button_advance_show.value = false;
        controller.button_submit_show.value = false;
        controller.button_approve_show.value = false;
      } else if (controller.travelLineList.value[index].state == 'submit') {
        controller.button_approve_show.value = false;
        controller.button_advance_show.value = false;
        controller.button_submit_show.value = false;
      } else {
        controller.button_approve_show.value = false;
        controller.button_advance_show.value = false;
        controller.button_submit_show.value = false;
      }
    } else {
      if (controller.travelLineList.value[index].state == 'draft') {
        controller.button_submit_show.value = true;
        controller.button_approve_show.value = false;
        controller.button_advance_show.value = false;
      } else if (controller.travelLineList.value[index].state == 'submit') {
        controller.button_approve_show.value = false;
        controller.button_advance_show.value = false;
        controller.button_submit_show.value = false;
      } else if (controller.travelLineList.value[index].state == 'approve') {
        if(controller.getTotalAmount(index) > 0)
          controller.button_advance_show.value = true;
        else
          controller.button_advance_show.value = false;
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
      } else {
        controller.button_approve_show.value = false;
        controller.button_submit_show.value = false;
        controller.button_advance_show.value = false;
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels?.travelDetails, user_image)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.travelLineList.value[index].state != 'draft' ?
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  controller.travelLineList.value[index].name,
                  // ("From Date : "),
                  style: labelPrimaryTitleBoldTextStyle(),
                ),
              ):SizedBox(),
              travelData(context),
              SizedBox(
                height: 15,
              ),
              travelTitleWidget(context),
              SizedBox(
                height: 15,
              ),
              travelWidget(context),
              SizedBox(
                height: 10,
              ),
        if(controller.getTotalAmount(index) > 0)
              travelAdvacetitleWidget(context),
              SizedBox(
                height: 15,
              ),
              travelAdvanceWidget(context),
        if(controller.getTotalAmount(index) > 0)
             Align(
                 alignment: Alignment.center,
                 child: Container(
                   margin: EdgeInsets.symmetric(horizontal: 18),
                     child: Text('${labels?.total} Amount : ${format.format(controller.getTotalAmount(index))}',style: TextStyle(fontSize: 20,color: Colors.deepPurple),))),

              SizedBox(
                height: 20,
              ),
              controller.button_submit_show.value
                  ? actionsButton(context)
                  : new Container(),
              SizedBox(height: 10),
              controller.button_approve_show.value
                  ? travelDetailsButton(context)
                  : new Container(),
              controller.button_submit_show.value
                  ? travelSubmitButton(context)
                  : new Container(),
              controller.button_advance_show.value
                  ? travelAdvanceButton(context)
                  : new Container(),
            ],
          ),
        ),
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
                      Get.toNamed(Routes.TRAVEL_REQUEST_UPDATE,
                          arguments:controller.travelLineList.value[index]);
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
                        controller.travelLineList.value[index].id, context);
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
        controller.deleteTravel(id, context);
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

  Widget travelTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              // width: 80,
              child: Text(
                labels!.date,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
          child:Container(
            // width: 70,
            child: Text(
              labels.destination,
              style: subtitleStyle(),
            ),
          ),),
          Expanded(
          child:Container(
                  // width: 70,
                  child: Text(
                    labels.purpose,
                    style: subtitleStyle(),
                  ),
                ),)
        ],
      ),
    );
  }

  Widget travelAdvacetitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 40, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 80,
            child: Text(
              labels!.expense,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 70,
            child: Text(
              labels.amount,
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 70,
            child: Text(
              labels.remark,
              style: subtitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget travelAdvanceWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller
            .travelLineList.value[index].request_allowance_lines!.length,
        itemBuilder: (BuildContext context, int ind) {
          var list =
              controller.travelLineList.value[index].request_allowance_lines;
          return Column(
            children: [
              Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: list![ind].expense_categ_id != null
                            ? Text(list[ind].expense_categ_id!.name)
                            : Text('  -'),
                      ),
                    ),

                    // SizedBox(width: 100),

                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                          left: 30,
                        ),
                        child: list[ind].amount != null
                            ? Text(format.format(list[ind].total_amount))
                            : Text('  -'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                          left: 60,
                        ),
                        child: list[ind].remark != null
                            ? Text(list[ind].remark.toString())
                            : Text('  -'),
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

  Widget travelWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.travelLineList.value[index].travel_line!.length,
        itemBuilder: (BuildContext context, int ind) {
          return Column(
            children: [
              Container(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: controller.travelLineList.value[index]
                                    .travel_line![ind].date !=
                                null
                            ? Text(
                            AppUtils.changeDateFormat(controller.travelLineList.value[index]
                            .travel_line![ind].date)
                              )
                            : Text('  -'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: controller.travelLineList.value[index]
                                    .travel_line![ind].destination !=
                                null
                            ? Text(controller.travelLineList.value[index]
                                .travel_line![ind].destination)
                            : Text('  -'),
                      ),
                    ),
                    // SizedBox(width: 100),
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(
                         // left: 60,
                        ),
                        child: controller.travelLineList.value[index]
                                    .travel_line![ind].purpose !=
                                null
                            ? Text(controller.travelLineList.value[index]
                                .travel_line![ind].purpose)
                            : Text('  -'),
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

  Widget travelData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.fromDate,
                  // ("From Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  AppUtils.changeDateFormat(controller.travelLineList.value[index].start_date),
                  style: subtitleStyle(),
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
                  labels!.toDate,
                  // ("To Date : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (
                      AppUtils.changeDateFormat(controller.travelLineList.value[index].end_date)
                    ),
                  style: subtitleStyle(),
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
                  // ("From : "),
                  labels.from,
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelLineList.value[index].city_from),
                  style: subtitleStyle(),
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
                  labels.to,
                  // ("To : "),

                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelLineList.value[index].city_to),
                  style: subtitleStyle(),
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
                  labels.duration,
                  // ("Duration : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                  (controller.travelLineList.value[index].duration.toString() +
                      " Days"),
                  style: subtitleStyle(),
                ),
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
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller
                    .submitTravel(controller.travelLineList.value[index].id);
              },
              text: labels?.submit,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        /*  Expanded(
            child: GFButton(
              onPressed: () {
                controller
                    .declinedTravel(controller.travelLineList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels?.cancel,
              textColor: textFieldTapColor,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),*/
        ],
      ),
    );
  }

  Widget travelAdvanceButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller
                    .requestAdvance(controller.travelLineList.value[index].id);
              },
              text: "Request Advance",
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          // SizedBox(
          //   width: 10,
          // ),
          // Expanded(
          //   child: GFButton(
          //     onPressed: () {
          //       controller
          //           .declinedTravel(controller.travelLineList.value[index].id);
          //     },
          //     type: GFButtonType.outline,
          //     text: labels?.cancel,
          //     textColor: textFieldTapColor,
          //     blockButton: true,
          //     size: GFSize.LARGE,
          //     color: textFieldTapColor,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget travelDetailsButton(BuildContext context) {
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
                    controller.approveTravel(
                        controller.travelLineList.value[index].id);
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
                    controller.declinedTravel(
                        controller.travelLineList.value[index].id);
                    // .travel_line[ind].);
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
}
