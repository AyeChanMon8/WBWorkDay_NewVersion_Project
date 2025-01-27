

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/purchase_order_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';

class PurchaseOrderListPage extends StatefulWidget {

  @override
  State<PurchaseOrderListPage> createState() => _PurchaseOrderListPageState();
}

class _PurchaseOrderListPageState extends State<PurchaseOrderListPage> {
  final PurchaseOrderController controller = Get.find();
  final box = GetStorage();
  String image = '';
  var arguments_index = 0;
  Future _loadData() async {
    print("****loadmore****");

    // perform fetching data delay
  }

  @override
  void initState() {
    super.initState();
    arguments_index = Get.arguments ?? 0;

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text('Purchase Order List', style: appbarTextStyle()),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                  //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                }),
            actions: <Widget>[],
            automaticallyImplyLeading: true,

        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.purchaseOrderApprovalList.value.length,
            itemBuilder: (BuildContext context, int dindex) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PURCHASE_ORDER_DETAIL, arguments: dindex);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, right: 20, top: 20),
                                child: Text(
                                  controller.purchaseOrderApprovalList.value[dindex].name,
                                  style: subtitleStyle()
                                ),
                              ),
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20,right: 20),
                                child: Text(
                                  controller.purchaseOrderApprovalList.value[dindex].partner_name,
                                  style: subtitleStyle()
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, right: 20),
                                child: Text(
                                  controller.purchaseOrderApprovalList.value[dindex].company_id!.name,
                                  style: subtitleStyle()
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, right: 20),
                                child: Text(
                                  controller.purchaseOrderApprovalList.value[dindex].amount_total.toString(),
                                  style: subtitleStyle()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
