import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../leave_detail.dart';

class OutOfPocketApprovedDetails extends StatefulWidget {
  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<OutOfPocketApprovedDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String? image;
  int? index;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachment(
        controller.outofpocketExpenseApprovedList.value[index ?? 0].id);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            labels!.outofpocketApproval,
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // leaveData(context),
                Text(
                  controller
                      .outofpocketExpenseApprovedList.value[index ?? 0].number,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                outOfPocketData(context),
                SizedBox(
                  height: 10,
                ),
                outOfPocketExpenseTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                outOfPocketExpenseLineWidget(context, index ?? 0),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          '${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalpocketExpenseApprovedAmount(index??0))}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => controller.outofpocketExpenseApprovedList.value[index??0]
                                  .state !=
                              'approve' &&
                          controller.outofpocketExpenseApprovedList.value[index??0]
                                  .state !=
                              'finance_approve' &&
                          controller.outofpocketExpenseApprovedList.value[index??0]
                                  .state !=
                              'reconcile'
                      ? approveButton(context)
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
                controller.approveOutofPocket(
                    controller.outofpocketExpenseApprovedList.value[index??0].id);
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
                controller.declineOutofPocket(
                    controller.outofpocketExpenseApprovedList.value[index??0].id);
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

  Widget leaveTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // width: 35,
            child: Text(
              labels!.date,
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

  Widget outOfPocketExpenseTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex:2,
            child: Container(
              // width: 35,
              child: Text(
                (labels!.date),
                style: maintitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex:2,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              // width: 80,
              child: Text(
                labels.title,
                style: maintitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex:2,
            child: Container(
              // width: 80,
              child: Text(
                labels.description,
                style: maintitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex:1,
            child: Container(
              // width: 50,
              child: Text(
               labels.amount,
                style: maintitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex:1,
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

  // Widget outOfPocketExpenseTitleWidget(BuildContext context, int index) {
  //   final labels = AppLocalizations.of(context);
  //   return Container(
  //     margin: EdgeInsets.only(left: 10, right: 10, top: 20),
  //     child: DataTable2(
  //         columnSpacing: 12,
  //         horizontalMargin: 1,
  //         minWidth: 300,
  //         columns: [
  //           DataColumn2(
  //             label: Text(
  //               labels!.date,
  //               style: maintitleStyle(),
  //             ),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(
  //               labels.title,
  //               style: maintitleStyle(),
  //             ),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(
  //               labels.description,
  //               style: maintitleStyle(),
  //             ),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(
  //               labels.amount,
  //               style: maintitleStyle(),
  //             ),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(''),
  //             size: ColumnSize.S,
  //           ),
  //         ],
  //         rows: [
  //           for (var i = 0;
  //               i <
  //                   controller.outofpocketExpenseApprovedList[index].pocket_line
  //                       .length;
  //               i++)
  //             DataRow(cells: [
  //               DataCell(Text(
  //                 AppUtils.changeDateFormat(controller
  //                     .outofpocketExpenseApprovedList[index].pocket_line[i].date
  //                     .toString()),
  //                 // DateTime.parse(controller
  //                 //   .outofpocketExpenseApprovedList[index].pocket_line[i].date)
  //                 //           .add(Duration(hours: 6, minutes: 30))
  //                 //           .toString()
  //                 //           .replaceAll('.000', ''),
  //                 //   style: datalistStyle(),
  //               )),
  //               DataCell(Text(
  //                 controller.outofpocketExpenseApprovedList[index]
  //                     .pocket_line[i].product_id.name
  //                     .toString(),
  //                 style: datalistStyle(),
  //               )),
  //               DataCell(
  //                 controller.outofpocketExpenseApprovedList[index]
  //                             .pocket_line[i].description !=
  //                         null
  //                     ? Text(
  //                         controller.outofpocketExpenseApprovedList[index]
  //                             .pocket_line[i].description
  //                             .toString(),
  //                         style: datalistStyle(),
  //                       )
  //                     : SizedBox(),
  //               ),
  //               DataCell(Text(
  //                 AppUtils.addThousnadSperator(double.parse(controller
  //                     .outofpocketExpenseApprovedList[index]
  //                     .pocket_line[i]
  //                     .price_subtotal
  //                     .toString())),
  //                 style: datalistStyle(),
  //               )),
  //               DataCell(
  //                 controller.outofpocketExpenseApprovedList[index]
  //                                 .pocket_line[i].attachment_include !=
  //                             null &&
  //                         controller.outofpocketExpenseApprovedList[index]
  //                             .pocket_line[i].attachment_include
  //                     ? IconButton(
  //                         icon: Icon(Icons.attach_file),
  //                         onPressed: () async {
  //                           var selected_image = "";
  //                           if (controller.attachment_list.length != 0) {
  //                             for (var element in controller.attachment_list) {
  //                               if (element.expenseLineId ==
  //                                   controller
  //                                       .outofpocketExpenseApprovedList[index]
  //                                       .pocket_line[i]
  //                                       .id) {
  //                                 print(element.attachments);
  //                                 if (element.attachments.length != 0) {
  //                                   selected_image = element.attachments[0];
  //                                 }
  //                                 ;
  //                                 break;
  //                               }
  //                             }
  //                           }
  //                           await showDialog(
  //                               context: context,
  //                               builder: (_) => Container(
  //                                     height: 200,
  //                                     child: ImageDialog(
  //                                       bytes: base64Decode(selected_image),
  //                                     ),
  //                                   ));
  //                         })
  //                     : SizedBox(),
  //               ),
  //             ])
  //         ]),
  //   );
  // }

  // Widget outOfPocketExpenseLineWidget(BuildContext context, int index) {
  //   // print("Testing");
  //   // print(controller.outofpocketExpenseApprovedList[index].pocket_line.length);
  //   return Container(
  //     margin: EdgeInsets.only(left: 10, right: 10, top: 20),

  //     // child:O bx(() => ListView.builder(
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       itemCount:
  //           controller.outofpocketExpenseApprovedList[index].pocket_line.length,
  //       itemBuilder: (BuildContext context, int ind) {
  //         return Column(
  //           children: [
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     flex: 2,
  //                     child: Container(
  //                       child: Text(AppUtils.changeDateFormat(controller
  //                           .outofpocketExpenseApprovedList[index]
  //                           .pocket_line[ind]
  //                           .date
  //                           .toString())),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text(
  //                       controller.outofpocketExpenseApprovedList[index]
  //                           .pocket_line[ind].product_id.name
  //                           .toString(),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 3,
  //                     child: controller.outofpocketExpenseApprovedList[index]
  //                                 .pocket_line[ind].description !=
  //                             null
  //                         ? Text(controller
  //                             .outofpocketExpenseApprovedList[index]
  //                             .pocket_line[ind]
  //                             .description
  //                             .toString())
  //                         : SizedBox(),
  //                   ),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text(controller
  //                         .outofpocketExpenseApprovedList[index]
  //                         .pocket_line[ind]
  //                         .price_subtotal
  //                         .toString()),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: controller.outofpocketExpenseApprovedList[index]
  //                                 .pocket_line[ind].attached_file !=
  //                             null
  //                         ? IconButton(
  //                             icon: Icon(Icons.attach_file),
  //                             onPressed: () async {
  //                               await showDialog(
  //                                   context: context,
  //                                   builder: (_) => ImageDialog(
  //                                         bytes: base64Decode(controller
  //                                             .outofpocketExpenseApprovedList[
  //                                                 index]
  //                                             .pocket_line[ind]
  //                                             .attached_file),
  //                                       ));
  //                             })
  //                         : SizedBox(),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Divider(
  //               thickness: 1,
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget outOfPocketExpenseLineWidget(BuildContext context, int index) {
    // print("Testing");
    // print(controller.outofpocketExpenseToApproveList[index].pocket_line.length);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller
            .outofpocketExpenseApprovedList[index].pocket_line.length,
        itemBuilder: (BuildContext context, int ind) {
          // controller.attach_exist(controller.outofpocketExpenseToApproveList.value[index]
          //     .pocket_line[ind].id,index,ind).then((value){
          //       print("attachment#");
          //       print(value);
          // });
          
          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        AppUtils.changeDateFormat(controller
                          .outofpocketExpenseApprovedList[index]
                          .pocket_line[ind]
                          .date),
                          style: datalistStyle(),),),
                        // DateTime.parse(controller
                        //   .outofpocketExpenseToApproveList[index]
                        //   .pocket_line[ind]
                        //   .date)
                        //     .add(Duration(hours: 6, minutes: 30))
                        //     .toString()
                        //     .replaceAll('.000', '')
                    Expanded(
                      flex: 2,
                      child: Text(
                        controller.outofpocketExpenseApprovedList[index]
                            .pocket_line[ind].product_id.name
                            .toString(),
                        textAlign: TextAlign.center,
                        style: datalistStyle(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.outofpocketExpenseApprovedList[index]
                                  .pocket_line[ind].description !=
                              null
                          ? Text(
                              controller.outofpocketExpenseApprovedList[index]
                                  .pocket_line[ind].description
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            style: datalistStyle(),
                            )
                          : SizedBox(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(NumberFormat("#,###").format(controller
                          .outofpocketExpenseApprovedList[index]
                          .pocket_line[ind]
                          .price_subtotal),
                      style: datalistStyle(),),

                    ),
                    controller
                        .outofpocketExpenseApprovedList[index]
                        .pocket_line[ind]
                        .attachment_include?
                    Expanded(
                            flex: 1,
                            child:  IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () async {
                                  controller.findExpenseImage(controller.outofpocketExpenseApprovedList.value[index]
                                      .pocket_line[ind].id).then((value) async{
                                        if(value.length>0){
                                          await showDialog(
                                              context: context,
                                              builder: (_) => ImageDialog(
                                                bytes: base64Decode(value[0]),
                                              ));
                                        }else{
                                          AppUtils.showToast("No Attachment");
                                        }
                    
                                  });
                    
                                })
                               ,
                    ):SizedBox(),
                    
                    // controller
                    //     .outofpocketExpenseToApproveList[index]
                    //     .pocket_line[ind]
                    //     .attachment_include!=null &&
                    //  controller
                    //     .outofpocketExpenseToApproveList[index]
                    //     .pocket_line[ind]
                    //     .attachment_include?
                    // Expanded(
                    //   flex: 1,
                    //   child:  IconButton(
                    //       icon: Icon(Icons.attach_file),
                    //       onPressed: () async {
                    //         controller.findExpenseImage(controller.outofpocketExpenseToApproveList[index]
                    //             .pocket_line[ind].id).then((value) async{
                    //           if(value.length>0){
                    //             await showDialog( 
                    //                 context: context,
                    //                 builder: (_) => ImageDialog(
                    //                   bytes: base64Decode(value[0]),
                    //                 ));
                    //           }else{
                    //             AppUtils.showToast("No Attachment");
                    //           }

                    //         });

                    //       })
                    //   ,
                    // ):SizedBox()

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

  Widget outOfPocketData(BuildContext context) {
    Uint8List bytes;
    // if (controller.outofpocketExpenseApprovedList.value[index].poc != null) {
    //   if (controller.outofpocketExpenseApprovedList.value[index].attached_file.isNotEmpty) {
    //     bytes = base64Decode(controller.outofpocketExpenseApprovedList.value[index].attachment);
    //     print(controller.outofpocketExpenseApprovedList.value[index].attachment);
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
                  labels!.name + " :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.outofpocketExpenseApprovedList.value[index??0]
                            .employee_id.name !=
                        null
                    ? Text(
                        controller.outofpocketExpenseApprovedList.value[index??0]
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
                  (labels!.date + " :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller
                            .outofpocketExpenseApprovedList.value[index??0].date !=
                        null
                    ? Text(
                        AppUtils.changeDateFormat(controller
                            .outofpocketExpenseApprovedList.value[index??0].date
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
                child: controller.outofpocketExpenseApprovedList.value[index??0]
                            .state !=
                        null
                    ? Text(
                        controller
                            .outofpocketExpenseApprovedList.value[index??0].state,
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
