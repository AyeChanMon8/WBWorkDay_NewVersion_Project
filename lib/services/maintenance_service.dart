

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../constants/globals.dart';
import '../models/fleet_model.dart';
import '../models/maintenance_product_category_model.dart';
import '../models/maintenance_request_model.dart';
import '../services/odoo_service.dart';
import '../utils/app_utils.dart';

class MaintenanceService extends OdooService{
  Dio dioClient = Dio();
 @override
  Future<MaintenanceService> init() async{
     dioClient = await client();
    return this;
  }


 Future<List<Product_id>> getProductList(int id,String companyID)async{
   List<Product_id> productList = [];
   String url = Globals.baseURL+"/product.product?filters=[('product_tmpl_id.categ_id','=',"+id.toString()+"),'|',('product_tmpl_id.company_id','=',"+companyID.toString()+"),('product_tmpl_id.company_id','=','false')]";
   Response response = await dioClient.get(url);
   if(response.statusCode == 200){
     var list = response.data['results'];
     if(response.data['count']>0)
       list.forEach((v) {
         productList.add(Product_id.fromMap(v));
       });
   }
   return productList;
 }


 Future<List<Maintenance_product_category_model>> getProductCategory(int companyID)async{
   List<Maintenance_product_category_model> productList = [];
   String url = Globals.baseURL+"/product.category?filters=[('maintenance', '=', True),'|', ('company_id', '=', "+companyID.toString()+"), ('company_id', '=', False)]";
   Response response = await dioClient.get(url);
   if(response.statusCode == 200){
     var list = response.data['results'];
     if(response.data['count']>0)
       list.forEach((v) {
         productList.add(Maintenance_product_category_model.fromMap(v));
       });
   }
   return productList;
 }

  getMaintenanceIdList(int empID,String status) async {
    String url = Globals.baseURL + "/hr.employee/2/get_maintenance_request";
    Response response = await dioClient.put(url,
        data: jsonEncode({'employee_id': empID,'state':status}));
    List<dynamic> planTripIds = response.data;
    return planTripIds;
  }
  Future<List<Maintenance_request_model>> getMaintenanceRequestList(int empID,String status) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    List<dynamic> maintenanceIdList = await getMaintenanceIdList(empID,status);
    if(maintenanceIdList!=null){
      String url = Globals.baseURL + "/maintenance.request?filters=[('id','in',${maintenanceIdList.toString()})]";
      Response response = await dioClient.get(url);
      if(response.statusCode==200){
        var list = response.data['results'];
        var count = response.data['count'];
        if(count!=0){
          list.forEach((v) {
            maintenanceRequestModelList.add(Maintenance_request_model.fromMap(v));
          });
        }
      }
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> getMaintenanceRequestModelWithVehicle(var vehicleId)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request?filters=[('vehicle_id', '=', ${vehicleId})]";
    Response response = await dioClient.get(url);
    if(response.statusCode == 200){
      var list = response.data['results'];
      if(response.data['count']>0)
        list.forEach((v) {
          maintenanceRequestModelList.add(Maintenance_request_model.fromMap(v));
        });
    }
    return maintenanceRequestModelList;
  }

  Future<List<Maintenance_request_model>> createMaintenanceRequestModel(var employeeId,var vehicleId,var fromDate,var toDate,List<Maintenance_product_id> maintenance_product_ids,int priority,String description,List<Uint8List> imageList, String imgOne,String imgTwo,String imgThree,String imgFour,String imgFive,String imgSix, Fleet_model selectedVehicle, String formattedTodayDate, String selectedWorkShopID, int selectedTeamID, int partnerId,String remark)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String image1,image2,image3,image4,image5,image6;
    String json;
    String selectedTeam = '';
    
    if(selectedWorkShopID!='0'){
      if(selectedTeamID != 0){
        json = jsonEncode({'start_date':fromDate,'end_date':toDate,'name':description.isEmpty?'Corrective Maintenance': description,'driver_id':int.parse(employeeId),'vehicle_id':vehicleId,'request_date':formattedTodayDate,'maintenance_type':'corrective','priority':priority.toString(),'description':description,'image':imgOne,'image1':imgTwo,'image2':imgThree,'image3':imgFour,'image4':imgFive,'image5':imgSix,
        //  'maintenance_product_ids': maintenance_product_ids.map((v) => v.toJson()).toList(),
        "maintenance_product_ids": maintenance_product_ids
                .map((e) => {"product_id": e.productId, "category_id": e.categoryId, "type": e.type, "qty": e.qty})
                .toList(),
        'maintenance_req_from_mobile': true, 'workshop_selection': selectedWorkShopID, 'maintenance_team_id': selectedTeamID, 'partner_id': partnerId, 'remark': remark});
      }else{
        json = jsonEncode({'start_date':fromDate,'end_date':toDate,'name':description.isEmpty?'Corrective Maintenance': description,'driver_id':int.parse(employeeId),'vehicle_id':vehicleId,'request_date':formattedTodayDate,'maintenance_type':'corrective','priority':priority.toString(),'description':description,'image':imgOne,'image1':imgTwo,'image2':imgThree,'image3':imgFour,'image4':imgFive,'image5':imgSix,
              //  'maintenance_product_ids': maintenance_product_ids.map((v) => v.toJson()).toList(),
              "maintenance_product_ids": maintenance_product_ids
                      .map((e) => {"product_id": e.productId, "category_id": e.categoryId, "type": e.type, "qty": e.qty})
                      .toList(),
              'maintenance_req_from_mobile': true, 'workshop_selection': selectedWorkShopID, 'remark': remark});
      }
       
    }else{
      if(selectedTeamID!=0){
        json = jsonEncode({'start_date':fromDate,'end_date':toDate,'name':description.isEmpty?'Corrective Maintenance': description,'driver_id':int.parse(employeeId),'vehicle_id':vehicleId,'request_date':formattedTodayDate,'maintenance_type':'corrective','priority':priority.toString(),'description':description,'image':imgOne,'image1':imgTwo,'image2':imgThree,'image3':imgFour,'image4':imgFive,'image5':imgSix,
      // 'maintenance_product_ids': maintenance_product_ids.map((v) => v.toJson()).toList(),
      "maintenance_product_ids": maintenance_product_ids
              .map((e) => {"product_id": e.productId, "category_id": e.categoryId, "type": e.type, "qty": e.qty})
              .toList(),
      'maintenance_req_from_mobile': true, 'maintenance_team_id': selectedTeamID, 'partner_id': partnerId,
      'remark': remark});
      }else{
json = jsonEncode({'start_date':fromDate,'end_date':toDate,'name':description.isEmpty?'Corrective Maintenance': description,'driver_id':int.parse(employeeId),'vehicle_id':vehicleId,'request_date':formattedTodayDate,'maintenance_type':'corrective','priority':priority.toString(),'description':description,'image':imgOne,'image1':imgTwo,'image2':imgThree,'image3':imgFour,'image4':imgFive,'image5':imgSix,
      // 'maintenance_product_ids': maintenance_product_ids.map((v) => v.toJson()).toList(),
      "maintenance_product_ids": maintenance_product_ids
              .map((e) => {"product_id": e.productId, "category_id": e.categoryId, "type": e.type, "qty": e.qty})
              .toList(),
      'maintenance_req_from_mobile': true,
      'remark': remark});
      }
      
    }
   
   // json = jsonEncode({'start_date':fromDate,'end_date':toDate,'company_id':selectedVehicle.companyId.id,'branch_id':selectedVehicle.branchId.id,'name':description.isEmpty?'Corrective Maintenance':description,'driver_id':int.parse(employeeId),'vehicle_id':vehicleId,'request_date':formattedTodayDate,'maintenance_type':'corrective','priority':priority.toString(),'description':description,'image':imgOne,'image1':imgTwo,'image2':imgThree,'image3':imgFour,'image4':imgFive,'image5':imgSix,'maintenance_product_ids': maintenance_product_ids.map((v) => v.toJson()).toList()});
     print(json);
    String url = Globals.baseURL+"/maintenance.request";
    Response response = await dioClient.post(url,data: json);
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,"planned") as List<Maintenance_request_model>;

    }else{
      Get.back();
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return maintenanceRequestModelList;
  }


  Future<List<Maintenance_request_model>> createProductLine (var id,Maintenance_product_id maintenance_product_id,var employeeId)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
   String url = Globals.baseURL+"/maintenance.product";
   Response response = await dioClient.post(url,data: jsonEncode({"line_id":id,"category_id":maintenance_product_id.categoryId,"product_id":maintenance_product_id.productId,"type":maintenance_product_id.type,"qty":maintenance_product_id.qty}));
   if(response.statusCode == 200){
     maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,"planned") as List<Maintenance_request_model>;
     // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
     // Response response = await dioClient.get(url);
     // if(response.statusCode == 200){
     //   var list = response.data['results'];
     //   if(response.data['count']>0)
     //     list.forEach((v) {
     //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
     //     });
     // }
   }
    return maintenanceRequestModelList;
  }
  
  
  Future<List<Maintenance_request_model>> deleteProductLine(var id,var employeeId) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
   String url = Globals.baseURL+"/maintenance.product/${id}";
   Response response = await dioClient.delete(url);
   if(response.statusCode == 200){
     maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,"planned") as List<Maintenance_request_model>;
     // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
     // Response response = await dioClient.get(url);
     // if(response.statusCode == 200){
     //   var list = response.data['results'];
     //   if(response.data['count']>0)
     //     list.forEach((v) {
     //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
     //     });
     // }
   }
    return maintenanceRequestModelList;
  }
  
  Future<List<Maintenance_request_model>> updateImage(var id,var index,var imageFile,var employeeId) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    int imageIndex = index;
    String json = jsonEncode({'image':imageFile});
    if(imageIndex > 0){
      json = jsonEncode({'image${imageIndex}':imageFile});
    }
    Response response = await dioClient.put(url,data: json);
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,"planned") as List<Maintenance_request_model>;
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
    }
    return maintenanceRequestModelList;
  }


  Future<List<Maintenance_request_model>> submitReproposeButton(var employeeId,var id,String state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : 'reproposed'}));
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> approveMaintenance(var employeeId,var id,String state) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : 'approved','maintenance_req_from_mobile': true}));
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> rejectMaintenance(var employeeId,var id,String state) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : 'reject'}));
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> secondApproveMaintenance(var employeeId,var id,String state) async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : 'approve','maintenance_req_from_mobile': true}));
    if(response.statusCode == 200){
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
    }else{
      Get.back();
      AppUtils.showErrorDialog(response.toString(),response.statusCode.toString());
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> submitQCButton(var employeeId,var id,String state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : "qc"}));
    if(response.statusCode == 200){
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> submitStartButton(var employeeId,var id,String state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : "start"}));
    if(response.statusCode == 200){
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> reSubmitButton(var employeeId,var id,String state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'state' : "resubmitted"}));
    if(response.statusCode == 200){
      // String url = Globals.baseURL+"/maintenance.request?filters=[('driver_id', '=', ${employeeId})]";
      // Response response = await dioClient.get(url);
      // if(response.statusCode == 200){
      //   var list = response.data['results'];
      //   if(response.data['count']>0)
      //     list.forEach((v) {
      //       maintenanceRequestModelList.add(Maintenance_request_model.fromJson(v));
      //     });
      // }
      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(employeeId)!,state) as List<Maintenance_request_model>;
    }
    return maintenanceRequestModelList;
  }

  Future<List<Maintenance_request_model>> updateStartDate(var empID,var id,String date,var state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'start_date' : date}));
    if(response.statusCode == 200){

      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(empID)!,state) as List<Maintenance_request_model>;
    }
    return maintenanceRequestModelList;
  }
  Future<List<Maintenance_request_model>> updateEndDate(var empID,var id,String date,var state)async{
    List<Maintenance_request_model> maintenanceRequestModelList = [];
    String url = Globals.baseURL+"/maintenance.request/${id}";
    Response response = await dioClient.put(url,data: jsonEncode({'end_date' : date}));
    if(response.statusCode == 200){

      maintenanceRequestModelList = await getMaintenanceRequestList(int.tryParse(empID)!,state) as List<Maintenance_request_model>;
    }
    return maintenanceRequestModelList;
  }
}