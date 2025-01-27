
import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/approval_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/leave_detail.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TripExpenseApproval extends StatefulWidget {
  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<TripExpenseApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  late String image;
  late int index;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachmentTrip(controller.tripExpenseToApproveList.value[index].id);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Trip Expense Approval",
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.tripExpenseToApproveList.value[index].number,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                tripExpenseData(context),
                SizedBox(
                  height: 10,
                ),
                tripExpenseTitleWidget(context, index),
                SizedBox(
                  height: 10,
                ),
                 tripExpenseLineWidget(context, index),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          '${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalTripExpenseAmount(index))}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => controller.tripExpenseToApproveList.value.length > 0
                      ? controller.tripExpenseToApproveList.value[index]
                                  .state !=
                              'approve'
                          ? approveButton(context)
                          : new Container()
                      : new Container(),
                ),
              ],
            ),
          ),
        ));
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
                controller.approveTripExpense(
                    controller.tripExpenseToApproveList.value[index].id);
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
                controller.declineTripExpense(
                    controller.tripExpenseToApproveList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels!.reject,//'Send Back'
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

  Widget leaveTitleWidget(BuildContext context) {
    //final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 35,
            child: Text(
              "Date",
              style: subtitleStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            // width: 80,
            child: Text(
              "Category Name",
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 80,
            child: Text(
              "Description",
              style: subtitleStyle(),
            ),
          ),
          Container(
            // width: 80,
            child: Text(
              "Amount",
              style: subtitleStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveWidget(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller
            .outofpocketExpenseToApproveList[index].pocket_line.length,
        itemBuilder: (BuildContext context, int ind) {
          var start_date = controller
              .outofpocketExpenseToApproveList[index].pocket_line[ind].date
              .toString();

          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 30),
                        // color: Colors.yellow,
                        // width: 40,
                        child: Text(controller
                            .outofpocketExpenseToApproveList[index]
                            .pocket_line[ind]
                            .date
                            .toString()),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 30),
                        // color: Colors.yellow,
                        // width: 40,
                        child: Text(controller
                            .outofpocketExpenseToApproveList[index]
                            .pocket_line[ind]
                            .categ_id
                            .name
                            .toString()),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 10),
                        // padding: EdgeInsets.only(left: 10),
                        // color: Colors.blue,
                        // width: 80,
                        child: Text(controller
                            .outofpocketExpenseToApproveList[index]
                            .pocket_line[ind]
                            .description),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.only(right: 10),
                        // padding: EdgeInsets.only(left: 10),
                        // color: Colors.blue,
                        // width: 80,
                        child: Text(controller
                            .outofpocketExpenseToApproveList[index]
                            .pocket_line[ind]
                            .price_subtotal
                            .toString()),
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

  Widget leaveData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      // margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Employe Name" + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: Text(
                    controller.outofpocketExpenseToApproveList.value[0]
                        .employee_id.name
                        .toString(),
                    style: subtitleStyle()),
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
                  "Date" + " :",
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.outofpocketExpenseToApproveList.value[index]
                            .date !=
                        null
                    ? Text(
                        controller
                            .outofpocketExpenseToApproveList.value[index].date,
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
                  (labels!.description + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.outofpocketExpenseToApproveList.value[index]
                            .state !=
                        null
                    ? Text(controller.leaveApprovalList.value[index].state,
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
                  (labels.status + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.outofpocketExpenseToApproveList.value[index]
                            .state !=
                        null
                    ? Text(
                        controller
                            .outofpocketExpenseToApproveList.value[index].state,
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

  Widget tripExpenseTitleWidget(BuildContext context, int index) {
    final labels = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text('Date', style: subtitleStyle(),),
              ),
              Expanded(
                flex: 1,
                child: Text('Title', style: subtitleStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child:Text('Desc', style: subtitleStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Expanded(
                flex: 1,
                child: Align(
                    alignment:Alignment.centerRight,child: Text('Amt', style: subtitleStyle())),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Align(
                      alignment:Alignment.centerRight,child: Text('Over Amt', style: subtitleStyle())),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text('Attach', style: subtitleStyle()),
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
    // return Container(
    //   margin: EdgeInsets.only(top: 20),
    //   child:
    //   DataTable2(
    //       columnSpacing: 1.0,
    //       horizontalMargin: 1,
    //       // minWidth: 300,
    //
    //       columns: [
    //         DataColumn2(
    //           label: Container(width:100,child: Text('Date')),
    //           size: ColumnSize.L,
    //         ),
    //         DataColumn2(
    //           label: Text('Title'),
    //           size: ColumnSize.L,
    //         ),
    //         DataColumn2(
    //           label: Text('Des'),
    //           size: ColumnSize.L,
    //         ),
    //         DataColumn2(
    //           label: Align(
    //               alignment:Alignment.centerRight,child: Text('Amt')),
    //           size: ColumnSize.L,
    //         ),
    //         DataColumn2(
    //           label: Align(
    //               alignment:Alignment.centerRight,child: Padding(
    //                 padding: const EdgeInsets.only(left:5.0),
    //                 child: Text('Over Amt'),
    //               )),
    //           size: ColumnSize.L,
    //         ),
    //         DataColumn2(
    //           label: Text(''),
    //           size: ColumnSize.S,
    //         ),
    //       ],
    //       rows: [
    //         for (var i = 0;
    //             i < controller.tripExpenseToApproveList[index]
    //                     .trip_expense_lines.length; i++)
    //           DataRow(
    //               // dataRowColor: MaterialStateColor.resolveWith((states) =>  controller.tripExpenseToApproveList[index]
    //               //     .trip_expense_lines[i].price_subtotal!=null?Colors.grey:Colors.white),
    //               cells: [
    //             DataCell(
    //                 Text(AppUtils.changeDateFormat(controller
    //                 .tripExpenseToApproveList[index].trip_expense_lines[i].date
    //                 .toString()),style: TextStyle(color:controller.tripExpenseToApproveList[index]
    //      .trip_expense_lines[i].over_amount!=null&&controller.tripExpenseToApproveList[index]
    //                 .trip_expense_lines[i].over_amount>0?Colors.red:Colors.black),)),
    //
    //                 DataCell(controller.tripExpenseToApproveList[index]
    //                         .trip_expense_lines[i].product_id.name
    //                         .toString() ==
    //                     "null"
    //                 ? Text("-")
    //                 : Text(
    //                     controller.tripExpenseToApproveList[index]
    //                         .trip_expense_lines[i].product_id.name
    //                         .toString(),style: TextStyle(color:controller.tripExpenseToApproveList[index]
    //                 .trip_expense_lines[i].over_amount!=null&&controller.tripExpenseToApproveList[index]
    //                 .trip_expense_lines[i].over_amount>0?Colors.red:Colors.black),
    //                   )),
    //             DataCell(
    //               controller.tripExpenseToApproveList[index]
    //                           .trip_expense_lines[i].description !=
    //                       null
    //                   ? Text(controller.tripExpenseToApproveList[index]
    //                       .trip_expense_lines[i].description
    //                       .toString(),style: TextStyle(color:controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount!=null&&controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount>0?Colors.red:Colors.black),)
    //                   : SizedBox(),
    //             ),
    //             DataCell(Align(
    //               alignment:Alignment.centerRight,
    //               child: Text(AppUtils.addThousnadSperator(double.parse(
    //                   controller.tripExpenseToApproveList[index]
    //                       .trip_expense_lines[i].price_subtotal
    //                       .toString())),style: TextStyle(color:controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount!=null&&controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount>0?Colors.red:Colors.black),),
    //             )),
    //             DataCell(Align(
    //               alignment:Alignment.centerRight,
    //               child: Text(AppUtils.addThousnadSperator(double.parse(
    //                   controller.tripExpenseToApproveList[index]
    //                       .trip_expense_lines[i].over_amount
    //                       .toString())),style: TextStyle(color:controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount!=null&&controller.tripExpenseToApproveList[index]
    //                   .trip_expense_lines[i].over_amount>0?Colors.red:Colors.black),),
    //             )),
    //             DataCell(
    //               controller.tripExpenseToApproveList[index]
    //                           .trip_expense_lines[i].attached_file !=
    //                       null
    //                   ? IconButton(
    //                       icon: Icon(Icons.attach_file),
    //                       onPressed: () async {
    //                         await showDialog(
    //                             context: context,
    //                             builder: (_) => ImageDialog(
    //                                   bytes: base64Decode(controller
    //                                       .tripExpenseToApproveList[index]
    //                                       .trip_expense_lines[i]
    //                                       .attached_file),
    //                                 ));
    //                       })
    //                   : SizedBox(),
    //             ),
    //           ])
    //       ]),
    //
    //
    // );
  }

  Widget tripExpenseLineWidget(BuildContext context, int index) {
    // print("Testing");
    // print(controller.outofpocketExpenseToApproveList[index].pocket_line.length);
    return Container(
      height: 250,
      margin: EdgeInsets.only(left: 10,  top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller
            .tripExpenseToApproveList[index].trip_expense_lines!.length,
        itemBuilder: (BuildContext context, int ind) {
          return Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(controller.tripExpenseToApproveList[index]
                          .trip_expense_lines![ind].date
                          .toString(),style: TextStyle(color: controller.tripExpenseToApproveList[index]
                                  .trip_expense_lines![ind].over_amount!=null&&controller.tripExpenseToApproveList[index]
                                  .trip_expense_lines![ind].over_amount>0?Colors.red:Colors.black),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        controller.tripExpenseToApproveList[index]
                            .trip_expense_lines![ind].product_id!.name
                            .toString(),style: TextStyle(color: controller.tripExpenseToApproveList[index]
                          .trip_expense_lines![ind].over_amount!=null&&controller.tripExpenseToApproveList[index]
                          .trip_expense_lines![ind].over_amount>0?Colors.red:Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: controller.tripExpenseToApproveList[index]
                                  .trip_expense_lines![ind].description !=
                              null
                          ? Text(
                              controller.tripExpenseToApproveList[index]
                                  .trip_expense_lines![ind].description
                                  .toString(),style: TextStyle(color: controller.tripExpenseToApproveList[index]
                          .trip_expense_lines![ind].over_amount!=null&&controller.tripExpenseToApproveList[index]
                          .trip_expense_lines![ind].over_amount>0?Colors.red:Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment:Alignment.centerRight,
                        child: Text(NumberFormat("#,###").format(controller
                            .tripExpenseToApproveList[index]
                            .trip_expense_lines![ind]
                            .price_subtotal),style: TextStyle(color: controller.tripExpenseToApproveList[index]
                            .trip_expense_lines![ind].over_amount!=null&&controller.tripExpenseToApproveList[index]
                            .trip_expense_lines![ind].over_amount>0?Colors.red:Colors.black),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment:Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text(NumberFormat("#,###").format(controller
                              .tripExpenseToApproveList[index]
                              .trip_expense_lines![ind]
                              .over_amount),style: TextStyle(color: controller.tripExpenseToApproveList[index]
                              .trip_expense_lines![ind].over_amount!=null&&controller.tripExpenseToApproveList[index]
                              .trip_expense_lines![ind].over_amount>0?Colors.red:Colors.black),),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child:  IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () async {
                            print(controller.tripExpenseToApproveList.value[index]
                                .trip_expense_lines![ind].id);
                            controller.findExpenseImage(controller.tripExpenseToApproveList.value[index]
                                .trip_expense_lines![ind].id).then((value) async{

                                  if(value.length>0){
                                    await showDialog(
                                        context: context,
                                        builder: (_) =>ImageDialog(
                                          bytes: base64Decode(value[0]),
                                        ));
                                  }else{
                                    AppUtils.showToast("No Attachment!");
                                  }

                            });

                          })
                      ,
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

  Widget tripExpenseData(BuildContext context) {
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
                  "Name" + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseToApproveList.value[index]
                            .employee_id!.name !=
                        null
                    ? Text(
                        controller.tripExpenseToApproveList.value[index]
                            .employee_id!.name,
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
                  "Source Doc" + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller
                            .tripExpenseToApproveList.value[index].source_doc !=
                        null
                    ? Text(
                        controller
                            .tripExpenseToApproveList.value[index].source_doc,
                        // ("Leave type : "),
                        style: subtitleStyle(),
                      )
                    : new SizedBox(),
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
                  (labels!.date + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseToApproveList.value[index].date !=
                        null
                    ? Text(
                        AppUtils.changeDateFormat(controller
                            .tripExpenseToApproveList.value[index].date
                            .toString()),
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
                  (labels!.status + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.tripExpenseToApproveList.value[index].state !=
                        null
                    ? Text(
                        controller.tripExpenseToApproveList.value[index].state,
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
}
