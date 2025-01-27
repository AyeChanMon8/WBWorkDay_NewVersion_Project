

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/purchase_order_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PurchaseOrderDetails extends StatefulWidget {
  @override
  State<PurchaseOrderDetails> createState() => _PurchaseOrderDetailsState();
}

class _PurchaseOrderDetailsState extends State<PurchaseOrderDetails> {
  final PurchaseOrderController controller = Get.put(PurchaseOrderController());
  late int index;
  // String _radioGroupValue;
  List<RadioListTile> answersRadio = [];
  List<String> list = [];
  TextEditingController reject_controller = TextEditingController();  
  
  @override
  Widget build(BuildContext context) {
    index = Get.arguments;
   
    final labels = AppLocalizations.of(context);
    if (controller.purchaseOrderApprovalList.value[index].state) {
      controller.button_approve_show.value = false;
    } else {
      controller.button_approve_show.value = true;
    }
    list = controller.purchaseOrderApprovalList.value[index].reject_reasons_list!;
    if(controller.purchaseOrderApprovalList.value[index].reject_reasons_list!.length > 0){
      reject_controller.text = controller.purchaseOrderApprovalList.value[index].reject_reasons_list![0];
    }else{
      reject_controller.text = "";
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, labels?.purchaseOrderDetail, '')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            purchaseOrderData(context),
            SizedBox(
              height: 15,
            ),
            // leaveTitleWidget(context),
            SizedBox(
              height: 10,
            ),
            PurchaseOrderTitleWidget(context),
            controller.purchaseOrderApprovalList.length > 0 ? purchaseOrderWidget(context): SizedBox(),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.button_approve_show.value
                  ? actionsButton(context)
                  : new Container(),
            ),
          ],
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
                    controller.approvePurchaseOrder(
                      controller.purchaseOrderApprovalList.value[index].id,
                    );
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
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    //controller.declinedPurchaseOrder(controller.purchaseOrderApprovalList.value[index].id,);
                    showOptionsDialog();
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
  showOptionsDialog(){
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
        controller.declinedPurchaseOrder(controller.purchaseOrderApprovalList.value[index].id,reject_controller.text);
      },
    );
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    int selectedRadio = 0;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text("Reject Reason"),  
        content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var n in list)
                  RadioListTile<String>(
                    value: n,
                    groupValue: reject_controller.text,
                    onChanged: (val) {
                      reject_controller.text = val!;
                      setState(() {});
                    },
                    title: Text(n),
                    toggleable: true,
                    selected: reject_controller.text == n,
                  ),
                reject_controller.text == 'Others' ? TextField(
                      enabled: true,
                      controller: reject_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Reject Reason")),
                      ),
                      onChanged: (text) {
                        
                      },
                    ): Container()
              ]),
          );
      },
    ),
    actions: [
       okButton,
       cancelButton
    ],);
      });
  }

  Widget purchaseOrderData(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Purchase Order :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.purchaseOrderApprovalList.value[index].name !=
                        null
                    ? Text(
                        controller.purchaseOrderApprovalList.value[index].name,
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
                  "Vendor :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.purchaseOrderApprovalList.value[index]
                            .partner_name !=
                        null
                    ? Text(
                        controller.purchaseOrderApprovalList.value[index]
                            .partner_name,
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
                  "Currency :",
                  // ("Leave type : "),
                  style: datalistStyle(),
                ),
              ),
              Container(
                child: controller.purchaseOrderApprovalList.value[index]
                            .currency_id!.name !=
                        null
                    ? Text(
                        controller.purchaseOrderApprovalList.value[index]
                            .currency_id!.name,
                        style: subtitleStyle())
                    : Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget purchaseOrderWidget(BuildContext context) {
    return Obx(
      () => controller.purchaseOrderApprovalList.length > 0 ? Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              controller.purchaseOrderApprovalList[index].order_line!.length,
          itemBuilder: (BuildContext context, int ind) {
            return Container(
              child: Column(
                children: [
                  Container(
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .categ_id!
                                        .name !=
                                    null && controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .categ_id!
                                        .name !=
                                    false
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .categ_id!
                                          .name,
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 2,
                          ),
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .product_id!
                                        .name !=
                                    null
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .product_id!
                                          .name,
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 2,
                          ),
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .product_qty !=
                                    null
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .product_qty.toString(),
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 1,
                          ),
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .qty_received !=
                                    null
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .qty_received.toString(),
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 2,
                          ),
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .price_unit !=
                                    null
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .price_unit.toString(),
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 2,
                          ),
                          Expanded(
                            child: controller
                                        .purchaseOrderApprovalList
                                        .value[index]
                                        .order_line![ind]
                                        .price_subtotal !=
                                    null
                                ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      controller
                                          .purchaseOrderApprovalList
                                          .value[index]
                                          .order_line![ind]
                                          .price_subtotal.toString(),
                                      style: labelPrimaryHightlightTextStyle()),
                                )
                                : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('-')),
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ) : SizedBox()
    );
  }

  Widget PurchaseOrderTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 1,
          ),
          Container(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(labels!.categoryName,
                          style: labelPrimaryHightlightTextStyle()),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          labels!.productName,
                          style: labelPrimaryHightlightTextStyle(),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.quantity,
                            style: labelPrimaryHightlightTextStyle())),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.received,
                            style: labelPrimaryHightlightTextStyle())),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.unitPrice,
                            style: labelPrimaryHightlightTextStyle())),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.subTotal,
                            style: labelPrimaryHightlightTextStyle())),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}




