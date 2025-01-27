
import 'dart:convert';

import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/purchase_order_approval_response.dart';
import '../utils/app_utils.dart';

import 'odoo_service.dart';

class PurchaseOrderService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<PurchaseOrderService> init() async {
    print('TravelRequestService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<PurchaseOrderApprovalResponse>> getEmployeePurchaseOrderList(
      String empID) async {

    String url = Globals.baseURL +
        "/purchase.order.approval.matrix/" +
        empID.toString() +
        "/employee_purchase_order_list";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': int.parse(empID)}));
    List<PurchaseOrderApprovalResponse> purchase_order_approval_list = <PurchaseOrderApprovalResponse>[];
    if (response.statusCode == 200) {
      var list = response.data;
      if (list.length > 0) {
        list.forEach((v) {
          purchase_order_approval_list.add(PurchaseOrderApprovalResponse.fromMap(v));
        });
      }
    }
    return purchase_order_approval_list;
  }

  Future<bool> approvePurchaseOrder(int id,String empID) async {
    var result = false;
    String url = Globals.baseURL +
        "/purchase.order.approval.matrix/" +
        id.toString() +
        "/button_approve";
        print("leave approve >>"+url);
    
    Response response = await dioClient.put(url,data: jsonEncode({'employee_id': int.parse(empID)}));
    if (response.statusCode == 200) {
      result = true;
    } else {
      AppUtils.showDialog('Warning!', response.data['error_descrip']);
      result = false;
    }
    
    // Response response = await dioClient.put(url,data: jsonEncode({'employee_id': int.parse(empID)})).onError((error, stackTrace) {
    //    print("button approve error");
    //    print(error.toString());
    // });

    // if (response.statusCode == 200) {
    //   result = true;
    // } else {
    //   AppUtils.showDialog('Warning!', response.data['error_descrip']);
    //   result = false;
    // }


    return result;
  }

  Future<bool> cancelPurchaseOrder(int id, String reason) async {
    var result;
    String url = Globals.baseURL +
        "/purchase.order.approval.matrix/" +
        id.toString() +
        "/action_refuse";
    Response response = await dioClient.put(url,data: jsonEncode({'reason': reason.toString()}));

    if (response.statusCode == 200) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }
}
