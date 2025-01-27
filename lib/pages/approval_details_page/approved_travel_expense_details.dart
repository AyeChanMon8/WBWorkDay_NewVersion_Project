
import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../leave_detail.dart';

class TravelExpenseApprovedDetails extends StatefulWidget {
  @override
  _TravelExpenseDetailsState createState() => _TravelExpenseDetailsState();
}

class _TravelExpenseDetailsState extends State<TravelExpenseApprovedDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = "";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachmentTravel(controller.travelExpenseApprovedList.value[index].id);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            labels!.expenseTravelApprove,
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
                Container(margin: EdgeInsets.only(right: 65),
              child: Row(children: [
                 Obx(()=> controller.showDetails.value?
                  Expanded(
                    flex:2,
                    child: AutoSizeText(
                      labels.viewDetailsClose,
                      style: maintitlenoBoldStyle(),
                    ),
                  ):
                  Expanded(
                    flex:2,
                    child: AutoSizeText(
                      labels.viewDetails,
                      style: maintitlenoBoldStyle(),
                    ),
                  )),
                   Obx(()=> controller.showDetails.value?Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_circle_up_sharp),
                      onPressed: () {
                        controller.showDetails.value = false;
                      },
                    ),
                  ):
                  Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_circle_down_sharp),
                      onPressed: () {
                        controller.showDetails.value = true;
                      },
                    ),
                  )),
              ],),
              ),
              Obx(()=> controller.showDetails.value? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.travelExpenseApprovedList.value[index].number)),
                SizedBox(
                  height: 15,
                ),
                travelExpenseData(context),
                SizedBox(
                  height: 15,
                ),
              ]):SizedBox(),),
                travelExpenseTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                travelExpenseLineWidget(context, index),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:Text('${labels?.total} Advance Amount : ${NumberFormat('#,###.#').format(controller.getTotalApprovedExpenseTravelAdvanceAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:Text('${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalApprovedExpenseTravelAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                Divider(height: 2,color:textFieldTapColor,),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:controller.getApprovedTotalRemainingAmount(index)<0?Text('Surplus to be Returned : ${NumberFormat('#,###.#').format(controller.getTotalRemainingAmount(index).abs())}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),) :Text('Deficit for Reimbursement : ${NumberFormat('#,###.#').format(controller.getTotalApprovedRemainingAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                SizedBox(
                  height: 10,
                ),
                /*Obx(()=>controller.travelExpenseApprovedList.value[index].state.toUpperCase()!='approve'.toUpperCase()?
                approveButton(context) : new Container(),),*/
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
                controller.approveTravelExpense(
                    controller.travelExpenseApprovedList.value[index].id);
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
                controller.declineTravelExpense(
                    controller.travelExpenseApprovedList.value[index].id);
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

  // Widget travelExpenseTitleWidget(BuildContext context, int index) {
  //   final labels = AppLocalizations.of(context);
  //   return Container(
  //     margin: EdgeInsets.only(left: 10, right: 10, top: 20),
  //     child: 
  //     DataTable2(
  //         columnSpacing: 12,
  //         horizontalMargin: 1,
  //         minWidth: 300,
  //         columns: [
  //           DataColumn2(
  //             label: Text(labels!.date,style: maintitleStyle(),),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(labels.title,style: maintitleStyle(),),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(labels.description,style: maintitleStyle(),),
  //             size: ColumnSize.L,
  //           ),
  //           DataColumn2(
  //             label: Text(labels.amount,style: maintitleStyle(),),
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
  //                   controller.travelExpenseApprovedList[index].travel_line
  //                       .length;
  //               i++)
  //             DataRow(cells: [
  //               DataCell(
  //                 Text(
  //                   AppUtils.changeDateFormat(controller
  //                   .travelExpenseApprovedList[index].travel_line[i].date
  //                   .toString())
  //                   // DateTime.parse(controller
  //                   // .travelExpenseApprovedList[index].travel_line[i].date)
  //                   //         .add(Duration(hours: 6, minutes: 30))
  //                   //         .toString()
  //                   //         .replaceAll('.000', '')
  //                   )
  //                   ),
  //               DataCell(Text(
  //                 controller.travelExpenseApprovedList[index].travel_line[i]
  //                     .product_id.name
  //                     .toString(),
  //               )),
  //               DataCell(
  //                 controller.travelExpenseApprovedList[index].travel_line[i]
  //                             .description !=
  //                         null
  //                     ? Text(controller.travelExpenseApprovedList[index]
  //                         .travel_line[i].description
  //                         .toString())
  //                     : SizedBox(),
  //               ),
  //               DataCell(Text(AppUtils.addThousnadSperator(double.parse(
  //                   controller.travelExpenseApprovedList[index].travel_line[i]
  //                       .price_subtotal
  //                       .toString())))),
  //               DataCell(
  //                 controller.travelExpenseApprovedList[index].travel_line[i]
  //                             .attachment_include !=
  //                         null && controller.travelExpenseApprovedList[index].travel_line[i]
  //                             .attachment_include
  //                     ? IconButton(
  //                         icon: Icon(Icons.attach_file),
  //                         onPressed: () async {
  //                           // var selected_image ="";
  //                           // if(controller.attachment_list.length!=0){
  //                           //   for (var element in controller.attachment_list) {
  //                           //     if(element.expenseLineId==controller
  //                           //         .travelExpenseApprovedList[index].travel_line[i].id){
  //                           //       print(element.attachments);
  //                           //       if(element.attachments.length!=0){
  //                           //        selected_image = element.attachments[0];
  //                           //       };
  //                           //       break;
  //                           //     }
  //                           //   }
  //                           // }
  //                           // await showDialog(
  //                           //     context: context,
  //                           //     builder: (_) => Container(
  //                           //       height:200,
  //                           //       child: ImageDialog(
  //                           //         bytes: base64Decode(selected_image),
  //                           //       ),
  //                           //     ));
  //                                      controller.findExpenseImage(controller.travelExpenseApprovedList.value[index]
  //                                 .travel_line[i].id).then((value) async{
  //                               if(value.length>0){
  //                                 attachmentBottomSheet(context,value);
  //                               }else{
  //                                 AppUtils.showToast("No Attachment");
  //                               }

  //                             });
  //                         })
  //                         // onPressed: () async {
  //                         //   await showDialog(
  //                         //       context: context,
  //                         //       builder: (_) => ImageDialog(
  //                         //             bytes: base64Decode(controller
  //                         //                 .travelExpenseApprovedList[index]
  //                         //                 .travel_line[i]
  //                         //                 .attached_file),
  //                         //           ));
  //                         // }
  //                         //)
  //                     : SizedBox(),
  //               ),
  //             ])
  //         ]),
    
  //   );
  // }
  Widget travelExpenseTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // width: 35,
              child: Text(
                (labels!.date),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 0),
              // width: 80,
              child: Text(
                labels.title,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Text(
                labels.description,
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            // width: 50,
            child: Text(
              labels.amount,
              style: subtitleStyle(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // width: 50,
              child: Text(
                '',
                style: subtitleStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget travelExpenseLineWidget(BuildContext context, int index) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 10, right: 10, top: 20),

  //     // child:O bx(() => ListView.builder(
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: controller
  //           .travelExpenseApprovedList.value[index].travel_line.length,
  //       itemBuilder: (BuildContext context, int ind) {
  //         return Column(
  //           children: [
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text(AppUtils.changeDateFormat(controller.travelExpenseApprovedList
  //                         .value[index].travel_line[ind].date)
  //                         ),
  //                   ),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text(controller.travelExpenseApprovedList
  //                         .value[index].travel_line[ind].categ_id.name
  //                         .toString()),
  //                   ),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Text(controller.travelExpenseApprovedList
  //                         .value[index].travel_line[ind].description
  //                         .toString()),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text(controller.travelExpenseApprovedList
  //                         .value[index].travel_line[ind].price_subtotal
  //                         .toString()),
  //                   ),
  //                   Expanded(
  //                       flex: 1,
  //                       child: controller.travelExpenseApprovedList.value[index]
  //                                   .travel_line[ind].attachment_filename !=
  //                               null
  //                           ? IconButton(
  //                               icon: Icon(Icons.attach_file),
  //                               onPressed: () async {
  //                                 controller
  //                                     .getTravelExpenseImage(controller
  //                                         .travelExpenseApprovedList
  //                                         .value[index]
  //                                         .travel_line[ind]
  //                                         .id)
  //                                     .then((value) async {
  //                                   await showDialog(
  //                                       context: context,
  //                                       builder: (_) => ImageDialog(
  //                                           bytes: base64Decode(value)));
  //                                 });
  //                               })
  //                           : SizedBox()),
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
  Widget travelExpenseLineWidget(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.travelExpenseApprovedList.value[index].travel_line.length,
        itemBuilder: (BuildContext context, int ind) {

          return Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        AppUtils.changeDateFormat(controller.travelExpenseApprovedList.value[index].travel_line[ind].date
                          )
                        // DateTime.parse(controller.travelExpenseList.value[index].travel_line[ind].date)
                        //     .add(Duration(hours: 6, minutes: 30))
                        //     .toString()
                        //     .replaceAll('.000', '')
                          ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(controller.travelExpenseApprovedList.value[index]
                            .travel_line[ind].product_id.name
                            .toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.travelExpenseApprovedList.value[index]
                          .travel_line[ind].description !=null ?Text(controller.travelExpenseApprovedList.value[index]
                          .travel_line[ind].description
                          .toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ):SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(controller.travelExpenseApprovedList.value[index]
                          .travel_line[ind].price_subtotal
                          .toString()),
                    ),
                    // controller
                    //     .travelExpenseList[index]
                    //     .travel_line[ind]
                    //     .attachment_include?
                    // Expanded(
                    //     flex: 1,
                    //     child:Container(
                    //       child: IconButton(
                    //         onPressed: () async{
                    //           // controller.getTravelExpenseImage(controller.travelExpenseList.value[index]
                    //           //     .travel_line[ind].id).then((value) async{
                    //           //   print("fileData");
                    //           //   print(value);
                    //           //   await showDialog(
                    //           //       context: context,
                    //           //       builder: (_) => ImageDialog(bytes: base64Decode(value)));
                    //           // });
                    //
                    //           controller.findExpenseImage(controller.travelExpenseList.value[index]
                    //               .travel_line[ind].id).then((value) async{
                    //             if(value.length>0){
                    //               await showDialog(
                    //                   context: context,
                    //                   builder: (_) => Center(child: Container(width:300,height:300,color:Colors.white,child: imageGridView(value))));
                    //             }else{
                    //               AppUtils.showToast("No Attachment");
                    //             }
                    //
                    //           });
                    //         },
                    //         icon: Icon(Icons.attach_file),
                    //       ),
                    //     )
                    // ):SizedBox() ,
                    controller
                        .travelExpenseApprovedList[index].travel_line[ind].attachment_include!= null&& controller
                        .travelExpenseApprovedList[index].travel_line[ind].attachment_include?
                    Expanded(
                        flex: 1,
                        child:Container(
                          child: IconButton(
                            onPressed: () async{

                              controller.findExpenseImage(controller.travelExpenseApprovedList.value[index]
                                  .travel_line[ind].id).then((value) async{
                                if(value.length>0){
                                  attachmentBottomSheet(context,value);

                                }else{
                                  AppUtils.showToast("No Attachment");
                                }

                              });
                            },
                            icon: Icon(Icons.attach_file),
                          ),
                        )
                    ):Expanded(flex:1,child: Container()),
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

  Widget travelExpenseData(BuildContext context) {
    Uint8List bytes;
    // if (controller.travelExpenseApprovedList.value[index].poc != null) {
    //   if (controller.travelExpenseApprovedList.value[index].attached_file.isNotEmpty) {
    //     bytes = base64Decode(controller.travelExpenseApprovedList.value[index].attachment);
    //     print(controller.travelExpenseApprovedList.value[index].attachment);
    //   }
    // }

    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            controller.travelExpenseApprovedList.value[index].number,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  labels!.name+":",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.travelExpenseApprovedList.value[index]
                            .employee_id.name !=
                        null
                    ? Text(
                        controller.travelExpenseApprovedList.value[index]
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
                child: controller.travelExpenseApprovedList.value[index].date !=
                        null
                    ? Text(
                        AppUtils.changeDateFormat(controller
                            .travelExpenseApprovedList.value[index].date
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
                  ("${labels.status} :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller
                            .travelExpenseApprovedList.value[index].state !=
                        null
                    ? Text(
                        controller.travelExpenseApprovedList.value[index].state,
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
                    SizedBox(height: 10,),
                    attachmentGridView(value,context),
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
        Uint8List  ?bytes1;
        if(value[index]!=null){
          bytes1 = base64Decode(value[index]);
        }
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Align(
            child: InkWell(
                  onTap: () async{
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
