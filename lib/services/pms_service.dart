import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../constants/globals.dart';
import '../models/pms_attach.dart';
import '../models/pms_attachment.dart';
import '../models/pms_detail_model.dart';
import '../models/pms_force_ranking_detail_model.dart';
import '../models/pms_hod_force_ranking_detail_model.dart';
import '../utils/app_utils.dart';

import 'odoo_service.dart';

class PMSService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<PMSService> init() async {
    print('LeaveService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<PMSDetailModel>> getPMSDetailModelList(
      String empID, String offset) async {
    String datebefore = AppUtils.oneYearago();
    String url = Globals.baseURL +
        "/employee.performance.management?filters=[('employee_id','=',$empID),('state','not in',['draft','cancel']),('create_date','>=','$datebefore')]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=deadline asc";
    Response response = await dioClient.get(url);
    List<PMSDetailModel> pmsDetailModels = <PMSDetailModel>[];
    if (response.statusCode == 200) {
      if (response.data["count"] > 0) {
        List list = response.data["results"];
        list.forEach((v) {
          pmsDetailModels.add(PMSDetailModel.fromMap(v));
        });
      }
    }
    return pmsDetailModels;
  }

  getSelfPMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_self_pms_ids";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    if (response.statusCode == 200) {
      if (response != null) {
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }

  getToApprovePMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_pms_approval_lists";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    if (response.statusCode == 200) {
      if (response != null) {
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }

  getApprovedPMSIdsList(int empID) async {
    String url = Globals.baseURL + "/hr.employee/1/get_pms_approve_lists";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    if (response.statusCode == 200) {
      if (response != null) {
        List<dynamic> ids = response.data;
        print(response.data);
        return ids;
      }
    }
  }

  Future<List<PMSDetailModel>> getPmsToApproveList(
      int empID, String offset) async {
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList =
        await getToApprovePMSIdsList(empID); //+Globals.pag_limit.toString()
    var limit = idsList.length;
    String url = Globals.baseURL +
        "/employee.performance.management?filters=[('id','in',${idsList.toString()})]&limit=${limit}" +
        "&offset=" +
        offset +
        "&order=create_date desc";
    Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromMap(v));
        });
      }
    }
    print(pmsList);
    return pmsList;
  }

  Future<List<PMSDetailModel>> getPmSelfList(int empID, String offset) async {
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList = await getSelfPMSIdsList(empID);
    String url = Globals.baseURL +
        "/employee.performance.management?filters=[('id','in',${idsList.toString()})]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=create_date desc";
    Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromMap(v));
        });
      }
    }
    return pmsList;
  }

  Future<List<PMSDetailModel>> getPmsApprovedList(
      int empID, String offset) async {
    List<PMSDetailModel> pmsList = [];
    List<dynamic> idsList = await getApprovedPMSIdsList(empID);
    String url = Globals.baseURL +
        "/employee.performance.management?filters=[('id','in',${idsList.toString()})]&limit=" +
        Globals.pag_limit.toString() +
        "&offset=" +
        offset +
        "&order=create_date desc";
    Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromMap(v));
        });
      }
    }

    return pmsList;
  }

  Future<String> editEmployeeRate(String employeeRateId, int value,
      String remark, List<PMSAttach> attachment) async {
    String url =
        Globals.baseURL + "/key.performance/1/employee_update_key_performance";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          "id": int.parse(employeeRateId),
          "employee_assessment": value,
          "employee_remark": remark,
          "attachments": attachment
              .map((e) => {"name": e.name, "attachment_file": e.attachment_file})
              .toList()
        }));
    String message = "";
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      Get.back();
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> editManagerRate(String managerRateId, int value, String remark,
      List<PMSAttach> attachment) async {
    String url = Globals.baseURL + "/key.performance/1/update_key_performance";
    Response response = await dioClient.put(url,
        data: jsonEncode({
          "id": int.parse(managerRateId),
          "manager_rating": value,
          "manager_remark": remark,
          "attachments": attachment
              .map((e) => {"name": e.name, "attachment_file": e.attachment_file})
              .toList()
        }));
    String message = "";
    if (response.statusCode == 200) {
      message = "Success";
    } else {
      Get.back();
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> editCompetencyScore(
      String competenciesId, int value, String remark) async {
    String url = Globals.baseURL + "/key.competencies/$competenciesId";
    Response response = await dioClient.put(url,
        data: jsonEncode({"manager_assessment": value, "comment": remark}));
    String message = "";
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String?> editEmployeeCompetencyScore(
      String competenciesId, int value, String remark) async {
    String url = Globals.baseURL + "/key.competencies/$competenciesId";
    Response response = await dioClient.put(url,
        data: jsonEncode({"employee_assessment": value, "comment": remark}));
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String> sendAcknowledge(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_acknowledge";
    Response response = await dioClient.put(url);
    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      message = "Fail";
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<int?> pmsApproveorNot(String empId, String status) async {
    int value = 0;
    String url = Globals.baseURL + "/hr.employee/2/get_respective_manager_id";
    Response response = await dioClient.put(url,
        data:
            jsonEncode({"employee_id": int.tryParse(empId), "status": status}));
    if (response.statusCode == 200) {
      value = response.data;
      return value;
    }
  }

  Future<String> sendMidYearSelfAssessment(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_mid_year_self_assessment";
    Response response = await dioClient.put(url);
    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      Get.back();
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
      // return response.statusMessage;
    }
    return message;
  }

  Future<String?> sendYearEndSelfAssessment(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_year_end_self_assessment";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String?> sendToManager(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_sent_manager";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String> sentBackToManager(String hodForceId) async {
    String url = Globals.baseURL +
        "/hod.force.ranking.template/$hodForceId/action_sent_back";
    Response response = await dioClient.put(url);

    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String?> sendDone(String pmsId) async {
    String url =
        Globals.baseURL + "/employee.performance.management/$pmsId/action_done";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String> pmsManagerApprove(String pmsId, String status) async {
    String url = Globals.baseURL + "/hr.employee/2/action_pms_approve";
    Response response = await dioClient.put(url,
        data: jsonEncode(
            {"parent_id": int.tryParse(pmsId.toString()), "state": status}));
    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String?> sendMidYearManagerApprove(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_mid_year_manager_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String?> sendYearEndManagerApprove(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_year_end_manager_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String?> sendMidYearDottedManagerApprove(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.managements/$pmsId/action_mid_year_dotted_manager_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<String?> sendYearEndDottedManagerApprove(String pmsId) async {
    String url = Globals.baseURL +
        "/employee.performance.management/$pmsId/action_year_end_dotted_manager_approve";
    Response response = await dioClient.put(url);
    if (response.statusCode == 200) {
      return 'Success';
    } else {
      return response.statusMessage;
    }
  }

  Future<List<PMSattachment>> getAttachment(List<int> id) async {
    String url = Globals.baseURL +
        "/employee.performance.management/2/get_attachment_list";
    Response response =
        await dioClient.put(url, data: jsonEncode({"attachment_ids": id}));
    List<PMSattachment> attachment_list = <PMSattachment>[];
    if (response.statusCode == 200) {
      print(response.toString());
      if (response.data != null) {
        attachment_list = [];
        response.data.forEach((v) {
          PMSattachment data = new PMSattachment();
          data.id = v['id'];
          data.name = v['name'];
          data.attach_file = v['attach_file'];
          attachment_list.add(data);
        });
      }
    }
    return attachment_list;
  }

  Future<String> pmsForceRankingApprove(String pmsId, String status) async {
    String url = Globals.baseURL +
        "/manager.force.ranking.template/$pmsId/action_mid_year_force_rank";
    Response response = await dioClient.put(url);

    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> pmsYearEndForceRankingApprove(
      String pmsId, String status) async {
    String url = Globals.baseURL +
        "/manager.force.ranking.template/$pmsId/action_year_end_force_rank";
    Response response = await dioClient.put(url);

    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> midYearHODForceRankApprove(String pmsId, String status) async {
    String url = Globals.baseURL +
        "/hod.force.ranking.template/$pmsId/action_mid_year_force_rank";
    Response response = await dioClient.put(url);

    String message = '';
    if (response.statusCode == 200) {
      if (response.data != true && response.data['status'] == false) {
        message = response.data['message'].toString();
      } else {
        message = 'Success';
      }
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> yearEndHODForceRankApprove(String pmsId, String status) async {
    String url = Globals.baseURL +
        "/hod.force.ranking.template/$pmsId/action_year_end_force_rank";
    Response response = await dioClient.put(url);

    String message = '';
    if (response.statusCode == 200) {
      message = 'Success';
    } else {
      // return response.statusMessage;
      message = 'Fail';
      Get.back();
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> editForceManagerRate(
      String managerRateId, String value, dynamic remark) async {
    String url = Globals.baseURL +
        "/manager.force.ranking.employees/1/update_force_manager_rate";
    if(remark==false){
      remark = "";
    }
    Response response = await dioClient.put(url,
        data: jsonEncode({
          "id": int.parse(managerRateId),
          "manager_rating": value,
          "remark": remark
        }));
    String message = "";
    if (response.statusCode == 200) {
      message = "Success";
    } else {
      Get.back();
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<String> editHODManagerRate(
      String managerRateId, int value, String remark) async {
    String url = Globals.baseURL +
        "/hod.force.ranking.employees/1/update_hod_manager_rate";
    dynamic hodRate;
    if (value == 0) {
      hodRate = null;
    } else {
      hodRate = value;
    }
    Response response = await dioClient.put(url,
        data: jsonEncode({
          "id": int.parse(managerRateId),
          "hod_rating": hodRate,
          "remark": remark
        }));
    String message = "";
    if (response.statusCode == 200) {
      message = "Success";
    } else {
      Get.back();
      message = "Fail";
      AppUtils.showErrorDialog(
          response.toString(), response.statusCode.toString());
    }
    return message;
  }

  Future<List<PMSDetailModel>> getHODPmsToApproveList(
      int empID, String offset) async {
    List<PMSDetailModel> pmsList = [];
    String url = Globals.baseURL +
        "/manager.force.ranking.template?filters=[('approve_manager','='," +
        empID.toString() +
        ")]";
    Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsList.add(PMSDetailModel.fromMap(v));
        });
      }
    }

    return pmsList;
  }

  Future<List<PMSForceRankingDetailModel>> getManagerPmsApprovalList(
      int empID, String offset) async {
    List<PMSForceRankingDetailModel> pmsForceRankingList = [];
    String url = Globals.baseURL +
        "/manager.force.ranking.template/1/get_manager_force_rank_list";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsForceRankingList.add(PMSForceRankingDetailModel.fromMap(v));
        });
      }
    }

    return pmsForceRankingList;
  }

  Future<List<PMSHODForceRankingDetailModel>> getHODManagerPmsApprovalList(
      int empID, String offset) async {
    List<PMSHODForceRankingDetailModel> pmsHODForceRankingList = [];
    String url = Globals.baseURL +
        "/hod.force.ranking.template/1/get_hod_force_rank_list";
    Response response =
        await dioClient.put(url, data: jsonEncode({'employee_id': empID}));
    if (response.statusCode == 200) {
      var list = response.data['results'];
      var count = response.data['count'];
      if (count != 0) {
        list.forEach((v) {
          pmsHODForceRankingList.add(PMSHODForceRankingDetailModel.fromMap(v));
        });
      }
    }

    return pmsHODForceRankingList;
  }
}
