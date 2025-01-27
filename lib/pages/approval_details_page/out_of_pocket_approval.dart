
import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:winbrother_hr_app/controllers/approval_controller.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/leave_detail.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutOfPocketApproval extends StatefulWidget {
  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<OutOfPocketApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = "";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachment(controller.outofpocketExpenseToApproveList.value[index].id);

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
                Text(
                  controller
                      .outofpocketExpenseToApproveList.value[index].number,
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
                outOfPocketExpenseLineWidget(context, index),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          '${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalOutOfPocketAmount(index))}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.deepPurple),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () =>
                      controller.outofpocketExpenseToApproveList.value.length >
                              0
                          ? controller.outofpocketExpenseToApproveList
                                      .value[index].state !=
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
                controller.approveOutofPocket(
                    controller.outofpocketExpenseToApproveList.value[index].id);
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
                    controller.outofpocketExpenseToApproveList.value[index].id);
              },
              type: GFButtonType.outline,
              text: labels!.sendBack,
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
                        child: Text(start_date),
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
                  ("${labels!.description} :"),
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
                  ("${labels.status} :"),
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
                (labels!.expenseDate),
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
                labels.expenseTitle,
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

  Widget outOfPocketExpenseLineWidget(BuildContext context, int index) {
    // print("Testing");
    // print(controller.outofpocketExpenseToApproveList[index].pocket_line.length);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

      // child:O bx(() => ListView.builder(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller
            .outofpocketExpenseToApproveList[index].pocket_line.length,
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
                          .outofpocketExpenseToApproveList[index]
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
                        controller.outofpocketExpenseToApproveList[index]
                            .pocket_line[ind].product_id.name
                            .toString(),
                        textAlign: TextAlign.center,
                        style: datalistStyle(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.outofpocketExpenseToApproveList[index]
                                  .pocket_line[ind].description !=
                              null
                          ? Text(
                              controller.outofpocketExpenseToApproveList[index]
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
                          .outofpocketExpenseToApproveList[index]
                          .pocket_line[ind]
                          .price_subtotal),
                      style: datalistStyle(),),

                    ),
                    controller
                        .outofpocketExpenseToApproveList[index]
                        .pocket_line[ind]
                        .attachment_include?
                    Expanded(
                            flex: 1,
                            child:  IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () async {
                                  controller.findExpenseImage(controller.outofpocketExpenseToApproveList.value[index]
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
    // if (controller.outofpocketExpenseToApproveList.value[index].poc != null) {
    //   if (controller.outofpocketExpenseToApproveList.value[index].attached_file.isNotEmpty) {
    //     bytes = base64Decode(controller.outofpocketExpenseToApproveList.value[index].attachment);
    //     print(controller.outofpocketExpenseToApproveList.value[index].attachment);
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
                child: controller.outofpocketExpenseToApproveList.value[index]
                            .employee_id.name !=
                        null
                    ? Text(
                        controller.outofpocketExpenseToApproveList.value[index]
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
                child: controller.outofpocketExpenseToApproveList.value[index]
                            .date !=
                        null
                    ? Text(
                        AppUtils.changeDateFormat(controller
                            .outofpocketExpenseToApproveList.value[index].date
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
}
