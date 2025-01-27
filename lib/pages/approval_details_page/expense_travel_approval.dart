
import 'dart:convert';
import 'dart:typed_data';
//import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

class TravelExpenseApproval extends StatefulWidget {
  @override
  _TravelExpenseDetailsState createState() => _TravelExpenseDetailsState();
}

class _TravelExpenseDetailsState extends State<TravelExpenseApproval> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = "";
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachmentTravel(controller.travelExpenseList.value[index].id);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            labels!.expenseTravelApproval, 
            style: appbarTextStyle(),
          ),
          backgroundColor: backgroundIconColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(right: 10,left: 10,top: 10),
          child: Column(
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
              Obx(()=> controller.showDetails.value? controller.travelExpenseList.length > 0 ?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.travelExpenseList.value[index].number,style: TextStyle(fontSize: 20),),
                travelExpenseData(context), 
                SizedBox(
                  height: 15,
                ),
              ]):SizedBox():SizedBox(),),
                travelExpenseLineWidget(context, index),
                SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:Text('${labels?.total} Advance Amount : ${NumberFormat('#,###.#').format(controller.getTotalExpenseTravelAdvanceAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:Text('${labels?.total} Amount : ${NumberFormat('#,###.#').format(controller.getTotalExpenseTravelAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                Divider(height: 2,color:textFieldTapColor,),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child:controller.getTotalRemainingAmount(index)<0?Text('Surplus to be Returned : ${NumberFormat('#,###.#').format(controller.getTotalRemainingAmount(index).abs())}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),) :Text('Deficit for Reimbursement : ${NumberFormat('#,###.#').format(controller.getTotalRemainingAmount(index))}',style: TextStyle(fontSize: 16,color: Colors.deepPurple),))),
                SizedBox(
                  height: 10,
                ),
                Obx(()=>controller.travelExpenseList.length > 0 ? (controller.travelExpenseList.value[index].state!='approve'?
                approveButton(context) : new Container()): SizedBox()),
            ],
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
                    controller.travelExpenseList.value[index].id);
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
                    controller.travelExpenseList.value[index].id);
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
                (labels!.expenseDate),
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
                labels.expenseTitle,
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
                labels.attachment,
                style: subtitleStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget travelExpenseLineWidget(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),

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
                      flex: 2,
                      child: Text(
                        AppUtils.changeDateFormat(controller.travelExpenseList.value[index].travel_line[ind].date
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
                        child: Text(controller.travelExpenseList.value[index]
                            .travel_line[ind].product_id.name
                            .toString()),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.travelExpenseList.value[index]
                          .travel_line[ind].description !=null ?Text(controller.travelExpenseList.value[index]
                          .travel_line[ind].description
                          .toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ):SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(controller.travelExpenseList.value[index]
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
                        .travelExpenseList[index].travel_line[ind].attachment_include!= null&& controller
                        .travelExpenseList[index].travel_line[ind].attachment_include?
                    Expanded(
                        flex: 1,
                        child:Container(
                          child: IconButton(
                            onPressed: () async{

                              controller.findExpenseImage(controller.travelExpenseList.value[index]
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "${labels!.name}:",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.travelExpenseList.value[index].employee_id.name !=
                    null
                    ? Text(
                    controller.travelExpenseList.value[index].employee_id.name,
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
                  ("${labels.date} :"),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.travelExpenseList.value[index].date != null
                    ? Text(AppUtils.changeDateFormat(controller.travelExpenseList.value[index].date),
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
        ],
      ),
    );
  }
  Widget imageGridView(List<String> value) {
    return GridView.builder(
        itemCount: value.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 1,
          crossAxisCount: 4,
        ),
        itemBuilder: (context, fileIndex) => Container(
          child: Card(
            child: Image.memory(
                base64Decode(value[fileIndex]),
                width: 80,
                height: 50),
          ),
        ));
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
        Uint8List ?bytes1;
        if(value[index]!=null){
          bytes1 = base64Decode(value[index]);
        }
        var label = index+1;
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
