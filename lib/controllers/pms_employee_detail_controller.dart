import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/assessment_structure.dart';
import 'package:winbrother_hr_app/models/force_manager_rating.dart';
import 'package:winbrother_hr_app/models/force_ranking_hod.dart';
import 'package:winbrother_hr_app/models/pms_attach.dart';
import 'package:winbrother_hr_app/models/pms_attachment.dart';
import 'package:winbrother_hr_app/models/pms_attachments.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/models/pms_force_ranking_detail_model.dart';
import 'package:winbrother_hr_app/models/pms_hod_force_ranking_detail_model.dart';
import 'package:winbrother_hr_app/models/rating_config.dart';
import 'package:winbrother_hr_app/services/master_service.dart';
import 'package:winbrother_hr_app/services/pms_service.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class PMSEmployeeDetailController extends GetxController {
  var detailModel = PMSDetailModel.name().obs;
  var forceManagerdetailModel = ForceRankingGroupId.name().obs;
  var forceManagerRankingdetailModel = <PMSForceRankingDetailModel>[].obs;
  var forceHODManagerdetailModel = HODForceRankingGroupId.name().obs;
  var forceHODManagerRankingdetailModel = <PMSHODForceRankingDetailModel>[].obs;
  var showAcknowledge = true.obs;
  var showApprove = false.obs;
  PmsListController? pmsListController;
  var totalFinalRate = 0.0.obs;
  var totalEmployeeRate = 0.0.obs;
  var totalScoreAverage = 0.0.obs;
  var midYearForceRanking = "".obs;
  var yearEndForceRanking = "".obs;
  TextEditingController managerRateTextController = TextEditingController();
  TextEditingController forceManagerRateTextController =
      TextEditingController();
  TextEditingController forceHodManagerRateTextController =
      TextEditingController();
  TextEditingController empRateTextController = TextEditingController();
  MasterService? masterService;
  final RxBool isShowAttachment = false.obs;
  final RxBool isShowImageAttachment = false.obs;
  final RxList<PlatformFile> imageList = <PlatformFile>[].obs;
  var ratingConfig_list = <AssessmentStructure>[].obs;
  var forceRankingHOD_list = <ForceRankingHOD>[].obs;
  var forceManagerRatingConfig_list = <ForceManagerRating>[].obs;
  final RxList<PMSattachment> attachment_list = <PMSattachment>[].obs;
  Rx<AssessmentStructure> _selectedRatingConfig = AssessmentStructure().obs;
  AssessmentStructure get selectedRatingConfig => _selectedRatingConfig.value;
  set selectedRatingConfig(AssessmentStructure type) =>
      _selectedRatingConfig.value = type;
  Rx<ForceRankingHOD> _selectedForceRankingHODConfig = ForceRankingHOD().obs;
  ForceRankingHOD get selectedForceRankingHODConfig =>
      _selectedForceRankingHODConfig.value;
  set selectedForceRankingHODConfig(ForceRankingHOD type) =>
      _selectedForceRankingHODConfig.value = type;
  Rx<ForceManagerRating> _selectedForceManagerRatingConfig =
      ForceManagerRating().obs;
  ForceManagerRating get selectedForceManagerRatingConfig =>
      _selectedForceManagerRatingConfig.value;
  set selectedForceManagerRatingConfig(ForceManagerRating type) =>
      _selectedForceManagerRatingConfig.value = type;
  Rx<AssessmentStructure> _selectedCompetenciesRatingConfig =
      AssessmentStructure().obs;
  AssessmentStructure get selectedCompetenciesRatingConfig =>
      _selectedCompetenciesRatingConfig.value;
  set selectedCompetenciesRatingConfig(AssessmentStructure type) =>
      _selectedCompetenciesRatingConfig.value = type;
  List<PMSAttach> image_base64_list = [];
  PMSService? pmsService;
  var approve_or_not = 0.obs;
  @override
  void onInit() {
    super.onInit();
    managerRateTextController = TextEditingController();
    empRateTextController = TextEditingController();
    forceManagerRateTextController = TextEditingController();
    forceHodManagerRateTextController = TextEditingController();
  }

  @override
  void onReady() async {
    super.onReady();
    this.pmsService = await PMSService().init();
    this.masterService = await MasterService().init();
    getRatingConfig();
    getForceMangerRatingConfig();
    getHODRatingConfig();
    pmsListController= Get.put(PmsListController());
  }

  Future<int?> checkApproveOrNote(PMSDetailModel value) async {
    this.pmsService = await PMSService().init();
    await pmsService!
        .pmsApproveorNot(value.employeeId!.id.toString(), value.state!)
        .then((value) {
      print("Status#");
      print(value);
      approve_or_not.value = value!;
      return value;
    });
  }

  getRatingConfig() async {
    await masterService!.getRatingConfig().then((data) {
      if (data.length > 0) {
        this.selectedRatingConfig = data[0];
        this.selectedCompetenciesRatingConfig = data[0];
      }
      ratingConfig_list.value = data;
      // ratingConfig_list.value = [];
      // RatingConfig config = new RatingConfig();
      // config.id = 0;
      // config.name = '-';
      // config.rating_description = '-';
      // this.selectedRatingConfig = config;
      // this.selectedCompetenciesRatingConfig = config;
      // ratingConfig_list.value.add(config);
      // for(var i=0;i<data.length;i++){
      //   ratingConfig_list.value.add(data[i]);
      // }
    });
  }

  getHODRatingConfig() async {
    await masterService!.getHODRatingConfig().then((data) {
      // if(data.length > 0){
      //   this.selectedForceRankingHODConfig = data[0];
      // }
      forceRankingHOD_list.value = data;
    });
  }

  getForceMangerRatingConfig() async {
    await masterService!.getForceMangerRatingConfig().then((data) {
      // if(data.length > 0){
      //   this.selectedForceManagerRatingConfig = data[0];
      // }
      forceManagerRatingConfig_list.value = data;
    });
    update();
  }

  void onChangeRatingConfigDropdown(AssessmentStructure ratingConfig) async {
    this.selectedRatingConfig = ratingConfig;
    update();
  }

  void onChangeHODRatingConfigDropdown(ForceRankingHOD ratingConfig) async {
    this.selectedForceRankingHODConfig = ratingConfig;
    update();
  }

  void onChangeRatingCompetenciesConfigDropdown(
      AssessmentStructure ratingConfig) async {
    this.selectedCompetenciesRatingConfig = ratingConfig;
    update();
  }

  void onChangeForceManagerRatingConfigDropdown(
      ForceManagerRating ratingConfig) async {
    this.selectedForceManagerRatingConfig = ratingConfig;
    update();
  }

  void setAttachmentFile() {
    isShowAttachment.value = true;
  }

  void selectImage(List<PlatformFile> files) {
    isShowAttachment.value = true;
  }

  clickAcknowledge(String pmsId) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    String message = await pmsService!.sendAcknowledge(pmsId);
    if (message == 'Success') {
      Get.back();
      var pmsList = await pmsListController!.getPmsList();
      detailModel.value = pmsList
          .where((element) => element.id == detailModel.value.id)
          .toList()[0];
      // AppUtils.showConfirmDialog('Information', message, () async{
      //   showAcknowledge.value = false;
      //   update();
      //   Future.delayed(Duration(milliseconds: 500), () {
      //     Get.back();
      //   });
      //   // Get.back();
      // });
      Get.defaultDialog(
          title: 'Information',
          content: Text('Success!'),
          confirmTextColor: Colors.white,
          onConfirm: () async {
            showAcknowledge.value = false;
            update();
            Future.delayed(Duration(milliseconds: 500), () {
              Get.back();
            });
          });
    }
    update();
    // else{
    //   AppUtils.showDialog("Information", message);
    // }
  }

  clickDone(String pmsId, String status) async {
    String state = detailModel.value.state!;
    if (detailModel.value.keyPerformanceIds!.any((element) =>
        (element.managerAssessmentRating!.id == 0 ||
            element.managerAssessmentRating!.id == null)))
      AppUtils.showDialog(
          "Information", 'Please all fill Manager Rating in WHAT');
    else if (detailModel.value.competenciesIds!.any((element) =>
        (element.manager_assessment_rating!.id == 0 ||
            element.manager_assessment_rating!.id == null)))
      AppUtils.showDialog(
          "Information", 'Please all fill Manager Rating in HOW');
    else {
      // String message = '';
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // message = await pmsService!.pmsManagerApprove(pmsId, status);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information',content: Text(message) , onConfirm: () async {
      //     pmsListController!.getPmsApprovalList();
      //     update();
      //     // Get.back();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // }

      await pmsService!
        .pmsManagerApprove(pmsId, status)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information',content: Text(data.toString()) , onConfirm: () async {
          pmsListController!.getPmsApprovalList();
          update();
          // Get.back();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      } 
    });
      // else{
      //   AppUtils.showDialog("Information", message);
      // }
    }
  }

  midYearForceRank(
      String forceTemplateId, String status, int detailIndex) async {
    // String state = detailModel.value.state!;
    if (forceManagerdetailModel.value.rankingEmployee!.any((element) =>
        (element.managerRating == null ||
            element.managerRating == "" ||
            element.managerRating == false ||
            element.managerRating == "-")))
      AppUtils.showDialog("Information",
          'Force Ranking Rating must be filled in for each employee!');
    // else if(detailModel.value.competenciesIds.any((element) => (element.manager_assessment_rating.id==0 || element.manager_assessment_rating.id==null)))
    //   AppUtils.showDialog("Information", 'Please all fill Manager Rating in HOW');
    else {
      // String message = '';
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // message =
      //     await pmsService!.pmsForceRankingApprove(forceTemplateId, status);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  ()  {
      //     pmsListController!.getManagerPmsApprovalList();
      //     update();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // }

      await pmsService!
        .pmsForceRankingApprove(forceTemplateId, status)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  ()  {
          pmsListController!.getManagerPmsApprovalList();
          update();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      } 
    });
      update();
      // else{
      //   AppUtils.showDialog("Information", message);
      // }
    }
  }

  yearEndForceRank(String forceTemplateId, String status) async {
    // String state = detailModel.value.state!;
    if (forceManagerdetailModel.value.rankingEmployee!.any((element) =>
        (element.managerRating == null ||
            element.managerRating == "" ||
            element.managerRating == false ||
            element.managerRating == "-")))
      AppUtils.showDialog(
          "Information", 'Please all fill Manager Rating in Force Ranking');
    // else if(detailModel.value.competenciesIds.any((element) => (element.manager_assessment_rating.id==0 || element.manager_assessment_rating.id==null)))
    //   AppUtils.showDialog("Information", 'Please all fill Manager Rating in HOW');
    else {
      // String message = '';
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // message = await pmsService!
      //     .pmsYearEndForceRankingApprove(forceTemplateId, status);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
      //     pmsListController!.getManagerPmsApprovalList();
      //     update();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // }

      await pmsService!
        .pmsYearEndForceRankingApprove(forceTemplateId, status)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          pmsListController!.getManagerPmsApprovalList();
          update();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      } 
    });
      update();
      // else{
      //   AppUtils.showDialog("Information", message);
      // }
    }
  }

  midYearHODForceRank(String forceTemplateId, String status, int forceIndex,
      int detailIndex) async {
    String state = forceHODManagerdetailModel.value.state;
    if (forceHODManagerdetailModel.value.rankingEmployee!.any((element) =>
        (element.hodRating == null ||
            element.hodRating == "" ||
            element.hodRating == false)))
      AppUtils.showDialog("Information",
          'Force Ranking Rating must be filled in for each employee!.');
    // else if(detailModel.value.competenciesIds.any((element) => (element.manager_assessment_rating.id==0 || element.manager_assessment_rating.id==null)))
    //   AppUtils.showDialog("Information", 'Please all fill Manager Rating in HOW');
    else {
      // String message = '';
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // message =
      //     await pmsService!.midYearHODForceRankApprove(forceTemplateId, status);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
      //     var pmsForceManagerList =
      //         await pmsListController!.getHODManagerPmsApprovalList();
      //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
      //     forceHODManagerRankingdetailModel.value = pmsForceManagerList;
      //     forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
      //         .value[detailIndex].forceRankingGroupId![forceIndex];

      //     // pmsListController.getHODManagerPmsApprovalList();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // } else if (message != 'Fail') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm: () async {
      //     var pmsForceManagerList =
      //         await pmsListController!.getHODManagerPmsApprovalList();
      //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
      //     forceHODManagerRankingdetailModel.value = pmsForceManagerList;
      //     forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
      //         .value[detailIndex].forceRankingGroupId![forceIndex];
      //     update();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // }

      await pmsService!
        .midYearHODForceRankApprove(forceTemplateId, status)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsForceManagerList =
              await pmsListController!.getHODManagerPmsApprovalList();
          // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
          forceHODManagerRankingdetailModel.value = pmsForceManagerList;
          forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
              .value[detailIndex].forceRankingGroupId![forceIndex];

          // pmsListController.getHODManagerPmsApprovalList();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      }else if (data.toString() != 'Fail') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm: () async {
          var pmsForceManagerList =
              await pmsListController!.getHODManagerPmsApprovalList();
          // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
          forceHODManagerRankingdetailModel.value = pmsForceManagerList;
          forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
              .value[detailIndex].forceRankingGroupId![forceIndex];
          update();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      }
    });
    }
    update();
  }

  sendBackToManager(String hodForceId, int forceIndex, int detailIndex) async {
    String message = '';
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    // message = await pmsService!.sentBackToManager(hodForceId);
    // if (message == 'Success') {
    //   Get.back();
    //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
    //     var pmsForceManagerList =
    //         await pmsListController!.getHODManagerPmsApprovalList();
    //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
    //     forceHODManagerRankingdetailModel.value = pmsForceManagerList;
    //     forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
    //         .value[detailIndex].forceRankingGroupId![forceIndex];
    //     update();
    //     Future.delayed(Duration(milliseconds: 500), () {
    //       Get.back();
    //       Get.back();
    //     });
    //   });
    // }
     await pmsService!
        .sentBackToManager(hodForceId)
        .then((data) {
      if (data == 'Success') {
        Get.back();
      Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
        var pmsForceManagerList =
            await pmsListController!.getHODManagerPmsApprovalList();
        // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
        forceHODManagerRankingdetailModel.value = pmsForceManagerList;
        forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
            .value[detailIndex].forceRankingGroupId![forceIndex];
        update();
        Future.delayed(Duration(milliseconds: 500), () {
          Get.back();
          Get.back();
        });
      });
      } 
    });
    update();
  }

  yearEndHODForceRank(String forceTemplateId, String status, int forceIndex,
      int detailIndex) async {
    String state = forceHODManagerdetailModel.value.state;
    if (forceHODManagerdetailModel.value.rankingEmployee!.any((element) =>
        (element.hodRating == null ||
            element.hodRating == "" ||
            element.hodRating == false)))
      AppUtils.showDialog("Information",
          'Force Ranking Rating must be filled in for each employee!.');
    // else if(detailModel.value.competenciesIds.any((element) => (element.manager_assessment_rating.id==0 || element.manager_assessment_rating.id==null)))
    //   AppUtils.showDialog("Information", 'Please all fill Manager Rating in HOW');
    else {
      // String message = '';
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // message =
      //     await pmsService!.yearEndHODForceRankApprove(forceTemplateId, status);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
      //     var pmsForceManagerList =
      //         await pmsListController!.getHODManagerPmsApprovalList();
      //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
      //     forceHODManagerRankingdetailModel.value = pmsForceManagerList;
      //     forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
      //         .value[detailIndex].forceRankingGroupId![forceIndex];
      //     update();
      //     Future.delayed(Duration(milliseconds: 500), () {
      //       Get.back();
      //       Get.back();
      //     });
      //   });
      // }

      await pmsService!
        .yearEndHODForceRankApprove(forceTemplateId, status)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsForceManagerList =
              await pmsListController!.getHODManagerPmsApprovalList();
          // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
          forceHODManagerRankingdetailModel.value = pmsForceManagerList;
          forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
              .value[detailIndex].forceRankingGroupId![forceIndex];
          update();
          Future.delayed(Duration(milliseconds: 500), () {
            Get.back();
            Get.back();
          });
        });
      } 
    });
    }
    update();
  }

  getForceRankingValue(String value) {
    if (value != null && value != false) {
      for (var i = 0; i < forceManagerRatingConfig_list.length; i++) {
        if (detailModel.value.mgrMidForceRanking.toString() ==
            forceManagerRatingConfig_list[i].id) {
          midYearForceRanking.value = forceManagerRatingConfig_list[i].value!;
        }
      }
    }
    return midYearForceRanking.value;
  }

  getYearEndForceRankingValue(String value) {
    if (value != null && value != false) {
      for (var i = 0; i < forceManagerRatingConfig_list.length; i++) {
        if (value.toString() == forceManagerRatingConfig_list[i].id) {
          yearEndForceRanking.value = forceManagerRatingConfig_list[i].value!;
        }
      }
    }
    return yearEndForceRanking.value;
  }

  clickSubmit(String pmsId) async {
    if (detailModel.value.keyPerformanceIds!.any((element) =>
        (element.employeeAssessmentRating!.id == 0 ||
            element.employeeAssessmentRating!.id == null))) {
      AppUtils.showDialog(
          "Information", 'Please all fill Employee Rating in WHAT');
    } else if (detailModel.value.competenciesIds!.any((element) =>
        (element.employee_assessment_rating!.id == 0 ||
            element.employee_assessment_rating!.id == null))) {
      AppUtils.showDialog(
          "Information", 'Please all fill Employee Rating in HOW');
    } else {
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // String message =detailModel.value.state == 'acknowledge'? await pmsService.sendMidYearSelfAssessment(pmsId) : await pmsService.sendYearEndSelfAssessment(pmsId);
      // detailModel.value.state == 'acknowledge'
      //     ? await pmsService!.sendMidYearSelfAssessment(pmsId)
      //     : await pmsService!.sendYearEndSelfAssessment(pmsId).then((data) async {
      //       if (data == 'Success') {
      //               Get.back();
      //               Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
      //                 pmsListController!.getPmsList();
      //                 showAcknowledge.value = false;
      //                 update();
      //                 // Get.back();
      //                 Get.back();
      //                 Get.back();
      //                 // update();
      //               });
      //             }
      //     });
      if(detailModel.value.state == 'acknowledge'){
        await pmsService!.sendMidYearSelfAssessment(pmsId).then((data) async{
              if (data == 'Success') {
                  Get.back();
                            Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
                              pmsListController!.getPmsList();
                              showAcknowledge.value = false;
                              update();
                              // Get.back();
                              Get.back();
                              Get.back();
                              // update();
                            });
                
              } 
            }); 
            update();
      }else{
        await pmsService!.sendYearEndSelfAssessment(pmsId).then((data)async {
              if (data == 'Success') {
                  Get.back();
                            Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
                              pmsListController!.getPmsList();
                              showAcknowledge.value = false;
                              update();
                              // Get.back();
                              Get.back();
                              Get.back();
                              // update();
                            });
                
              } 
            });
            update();
      }
    //   detailModel.value.state == 'acknowledge'
    //       ? await pmsService!.sendMidYearSelfAssessment(pmsId)
    //       : await pmsService!.sendYearEndSelfAssessment(pmsId)
    //     .then((data) {
    //   if (data == 'Success') {
    //       Get.back();
    //                 Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
    //                   pmsListController!.getPmsList();
    //                   showAcknowledge.value = false;
    //                   update();
    //                   // Get.back();
    //                   Get.back();
    //                   Get.back();
    //                   // update();
    //                 });
        
    //   } 
    // });
      
      
    //   detailModel.value.state == 'acknowledge'
    //       ? await pmsService!.sendMidYearSelfAssessment(pmsId)
    //       : await pmsService!.sendYearEndSelfAssessment(pmsId)
    //     .then((data) {
    //   if (data == 'Success') {
    //      Get.back();
    //     Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
    //       pmsListController!.getPmsList();
    //       showAcknowledge.value = false;
    //       update();
    //       // Get.back();
    //       Get.back();
    //       Get.back();
    //       // update();
    //     });
    //   } 
    // });
    }
    
  }

  refreshData(int index) async {
    var pmsList = await pmsListController!.getPmsList();
    detailModel.value = pmsList
        .where((element) => element.id == detailModel.value.id)
        .toList()[0];
    //calculateTotalEmployeeRate();
    //calculateTotalFinalRate();
  }

  refreshToApproveData(int index) async {
    var pmsList = await pmsListController!.getPmsApprovalList();
    detailModel.value = pmsList
        .where((element) => element.id == detailModel.value.id)
        .toList()[0];
    //calculateTotalEmployeeRate();
    //calculateTotalFinalRate();
  }

  refreshToRankingManagerApproveData(
      dynamic index, int forceIndex, int detailIndex) async {
    var pmsList = await pmsListController!.getManagerPmsApprovalList();
    forceManagerRankingdetailModel.value = pmsList;
    forceManagerdetailModel.value = forceManagerRankingdetailModel
        .value[detailIndex].forceRankingGroupId![forceIndex];
  }

  refreshToRankingHODManagerApproveData(
      dynamic index, int forceIndex, int detailIndex) async {
    var pmsForceManagerList =
        await pmsListController!.getHODManagerPmsApprovalList();
    // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
    forceHODManagerRankingdetailModel.value = pmsForceManagerList;
    forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
        .value[detailIndex].forceRankingGroupId![forceIndex];
  }

  editEmployeeRateAndRate(int index) async {
    if (selectedRatingConfig.id == 0) {
      AppUtils.showDialog("Information", 'Please fill Employee Rating');
    } else {
      var pmsAttach = <PMSAttach>[];
      if (attachment_list.value.length > 0) {
        for (var i = 0; i < attachment_list.value.length; i++) {
          pmsAttach.add(PMSAttach(
              name: attachment_list[i].name,
              attachment_file: attachment_list[i].attach_file));
        }
      }
      if (image_base64_list.length > 0) {
        for (var j = 0; j < image_base64_list.length; j++) {
          pmsAttach.add(PMSAttach(
              name: image_base64_list[j].name,
              attachment_file: image_base64_list[j].attachment_file));
        }
      }
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // String message = await pmsService!.editEmployeeRate(
      //     detailModel.value.keyPerformanceIds![index].id.toString(),
      //     selectedRatingConfig.id!,
      //     detailModel.value.keyPerformanceIds![index].employeeRemark,
      //     pmsAttach);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
      //     var pmsList = await pmsListController!.getPmsList();
      //     detailModel.value = pmsList
      //         .where((element) => element.id == detailModel.value.id)
      //         .toList()[0];
      //     if (ratingConfig_list.length > 0) {
      //       selectedRatingConfig = ratingConfig_list.value[0];
      //     }
      //     isShowImageAttachment.value = false;
      //     isShowAttachment.value = false;
      //     imageList.value = [];
      //     image_base64_list = [];
      //     attachment_list.value = [];
      //     //calculateTotalEmployeeRate();
      //     //calculateTotalFinalRate();
      //     Get.back();
      //     Get.back();
      //   });
      // }

      await pmsService!
        .editEmployeeRate(
              detailModel.value.keyPerformanceIds![index].id.toString(),
          selectedRatingConfig.id!,
          detailModel.value.keyPerformanceIds![index].employeeRemark,
          pmsAttach)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsList = await pmsListController!.getPmsList();
          detailModel.value = pmsList
              .where((element) => element.id == detailModel.value.id)
              .toList()[0];
          if (ratingConfig_list.length > 0) {
            selectedRatingConfig = ratingConfig_list.value[0];
          }
          isShowImageAttachment.value = false;
          isShowAttachment.value = false;
          imageList.value = [];
          image_base64_list = [];
          attachment_list.value = [];
          //calculateTotalEmployeeRate();
          //calculateTotalFinalRate();
          Get.back();
          Get.back();
        });
      } 
    });
    }

    // else{
    //   AppUtils.showDialog("Information", message);
    // }
  }

  editManagerRateAndRate(int index) async {
    if (selectedRatingConfig.id == 0) {
      AppUtils.showDialog("Information", 'Please fill Manager Rating');
    } else {
      print('editManagerRateAndRate');
      print(detailModel.value.keyPerformanceIds![index].managerRate.toString());
      var pmsAttach = <PMSAttach>[];
      if (attachment_list.value.length > 0) {
        for (var i = 0; i < attachment_list.value.length; i++) {
          pmsAttach.add(PMSAttach(
              name: attachment_list[i].name,
              attachment_file: attachment_list[i].attach_file));
        }
      }
      if (image_base64_list.length > 0) {
        for (var j = 0; j < image_base64_list.length; j++) {
          pmsAttach.add(PMSAttach(
              name: image_base64_list[j].name,
              attachment_file: image_base64_list[j].attachment_file));
        }
      }
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      
      await pmsService!
        .editManagerRate(
          detailModel.value.keyPerformanceIds![index].id.toString(),
          selectedRatingConfig.id!,
          detailModel.value.keyPerformanceIds![index].managerRemark,
          pmsAttach)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsList = await pmsListController!.getPmsApprovalList();
          detailModel.value = pmsList
              .where((element) => element.id == detailModel.value.id)
              .toList()[0];
          if (ratingConfig_list.value.length > 0) {
            selectedRatingConfig = ratingConfig_list.value[0];
          }
          isShowImageAttachment.value = false;
          isShowAttachment.value = false;
          imageList.value = [];
          image_base64_list = [];
          attachment_list.value = [];
          //calculateTotalEmployeeRate();
          //calculateTotalFinalRate();
          Get.back();
          Get.back();
        });
      }
    });

      
    //   String message = await pmsService!.editManagerRate(
    //       detailModel.value.keyPerformanceIds![index].id.toString(),
    //       selectedRatingConfig.id!,
    //       detailModel.value.keyPerformanceIds![index].managerRemark,
    //       pmsAttach);
    //   if (message == 'Success') {
    //     Get.back();
    //     Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
    //       var pmsList = await pmsListController!.getPmsApprovalList();
    //       detailModel.value = pmsList
    //           .where((element) => element.id == detailModel.value.id)
    //           .toList()[0];
    //       if (ratingConfig_list.value.length > 0) {
    //         selectedRatingConfig = ratingConfig_list.value[0];
    //       }
    //       isShowImageAttachment.value = false;
    //       isShowAttachment.value = false;
    //       imageList.value = [];
    //       image_base64_list = [];
    //       attachment_list.value = [];
    //       //calculateTotalEmployeeRate();
    //       //calculateTotalFinalRate();
    //       Get.back();
    //       Get.back();
    //     });
    //   }
    // }
  }
  }

  editForceManagerRateAndRate(
    int index,
    int forceIndex,
    int detailIndex,
  ) async {
    if (selectedForceManagerRatingConfig == false ||
        selectedForceManagerRatingConfig == '') {
      AppUtils.showDialog("Information", 'Please fill Force Manager Rating');
    } else {
      print('editManagerRateAndRate');
      print(forceManagerdetailModel.value.rankingEmployee![index].managerRating
          .toString());

      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      // String message = await pmsService!.editForceManagerRate(
      //     forceManagerdetailModel.value.rankingEmployee![index].rankingId
      //         .toString(),
      //     selectedForceManagerRatingConfig.id!,
      //     forceManagerdetailModel.value.rankingEmployee![index].remark);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information',content:  Text(message),onConfirm:  () async {
      //     var pmsForceManagerList =
      //         await pmsListController!.getManagerPmsApprovalList();
      //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
      //     forceManagerRankingdetailModel.value = pmsForceManagerList;
      //     forceManagerdetailModel.value = forceManagerRankingdetailModel
      //         .value[detailIndex].forceRankingGroupId![forceIndex];
      //     // if(forceManagerRatingConfig_list.value.length > 0){
      //     //   selectedForceManagerRatingConfig = forceManagerRatingConfig_list.value[0];
      //     // }
      //     Get.back();
      //     Get.back();
      //   });
      // }

      await pmsService!
        .editForceManagerRate(
          forceManagerdetailModel.value.rankingEmployee![index].rankingId
              .toString(),
          selectedForceManagerRatingConfig.id!,
          forceManagerdetailModel.value.rankingEmployee![index].remark ?? "" )
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information',content:  Text(data.toString()),onConfirm:  () async {
          var pmsForceManagerList =
              await pmsListController!.getManagerPmsApprovalList();
          // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
          forceManagerRankingdetailModel.value = pmsForceManagerList;
          forceManagerdetailModel.value = forceManagerRankingdetailModel
              .value[detailIndex].forceRankingGroupId![forceIndex];
          // if(forceManagerRatingConfig_list.value.length > 0){
          //   selectedForceManagerRatingConfig = forceManagerRatingConfig_list.value[0];
          // }
          Get.back();
          Get.back();
        });
      }
    });
    }
  }

  editForceHODManagerRateAndRate(
      int index, int forceIndex, int detailIndex) async {
    if (selectedForceRankingHODConfig == false ||
        selectedForceRankingHODConfig == '') {
      AppUtils.showDialog("Information", 'Please fill HOD Rating');
    } else if (forceHODManagerdetailModel
                .value.rankingEmployee![index].isRatingMatch ==
            false &&
        (forceHODManagerdetailModel.value.rankingEmployee![index].remark ==
                null ||
            forceHODManagerdetailModel.value.rankingEmployee![index].remark ==
                "")) {
      AppUtils.showDialog("Information", 'Please fill Remark');
    } else {
      print('editManagerRateAndRate');
      print(forceHODManagerdetailModel.value.rankingEmployee![index].hodRating
          .toString());

      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      String remarkPMS = "";
      if(forceHODManagerdetailModel.value.rankingEmployee![index].remark!=false){
        remarkPMS = forceHODManagerdetailModel.value.rankingEmployee![index].remark;
      }
      // String message = await pmsService!.editHODManagerRate(
      //     forceHODManagerdetailModel.value.rankingEmployee![index].rankingId
      //         .toString(),
      //     selectedForceRankingHODConfig.id ?? 0,
      //     remarkPMS);
      // if (message == 'Success') {
      //   Get.back();
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm: () async {
      //     var pmsForceManagerList =
      //         await pmsListController!.getHODManagerPmsApprovalList();
      //     // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
      //     forceHODManagerRankingdetailModel.value = pmsForceManagerList;
      //     forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
      //         .value[detailIndex].forceRankingGroupId![forceIndex];
      //     // if(forceManagerRatingConfig_list.value.length > 0){
      //     //   selectedForceManagerRatingConfig = forceManagerRatingConfig_list.value[0];
      //     // }
      //     Get.back();
      //     Get.back();
      //   });
      // }
      await pmsService!
        .editHODManagerRate(
          forceHODManagerdetailModel.value.rankingEmployee![index].rankingId
              .toString(),
          selectedForceRankingHODConfig.id ?? 0,
          remarkPMS)
        .then((data) {
      if (data == 'Success') {
        Get.back();
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm: () async {
          var pmsForceManagerList =
              await pmsListController!.getHODManagerPmsApprovalList();
          // detailModel.value = pmsForceManagerList.where((element) => element.id == detailModel.value.id).toList()[0];
          forceHODManagerRankingdetailModel.value = pmsForceManagerList;
          forceHODManagerdetailModel.value = forceHODManagerRankingdetailModel
              .value[detailIndex].forceRankingGroupId![forceIndex];
          // if(forceManagerRatingConfig_list.value.length > 0){
          //   selectedForceManagerRatingConfig = forceManagerRatingConfig_list.value[0];
          // }
          Get.back();
          Get.back();
        });
      }
    });
    }
  }

  editCompetenciesScore(int index) async {
    if (selectedCompetenciesRatingConfig.id == 0) {
      AppUtils.showDialog("Information", 'Please fill Manager Rating');
    } else {
      print("editCompetenciesScore");
      print(detailModel.value.competenciesIds![index].score);
      await pmsService!
        .editCompetencyScore(
              detailModel.value.competenciesIds![index].id.toString(),
          selectedCompetenciesRatingConfig.id!,
          detailModel.value.competenciesIds![index].comment ?? "")
        .then((data) {
      if (data == 'Success') {
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsList = await pmsListController!.getPmsApprovalList();
          detailModel.value = pmsList
              .where((element) => element.id == detailModel.value.id)
              .toList()[0];
          if (ratingConfig_list.value.length > 0) {
            selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
          }
          calculateTotalScoreAverage();
          Get.back();
          Get.back();
        });
      } else {
        AppUtils.showDialog("Information", data.toString());
      }
    });
      
      // String message = await pmsService!.editCompetencyScore(
      //     detailModel.value.competenciesIds![index].id.toString(),
      //     selectedCompetenciesRatingConfig.id!,
      //     detailModel.value.competenciesIds![index].comment);
      // if (message == 'Success') {
      //   Get.defaultDialog(textCancel: 'Information', content: Text(message),onConfirm:  () async {
      //     var pmsList = await pmsListController!.getPmsApprovalList();
      //     detailModel.value = pmsList
      //         .where((element) => element.id == detailModel.value.id)
      //         .toList()[0];
      //     if (ratingConfig_list.value.length > 0) {
      //       selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
      //     }
      //     calculateTotalScoreAverage();
      //     Get.back();
      //     Get.back();
      //   });
      // } else {
      //   AppUtils.showDialog("Information", message);
      // }
    }
  }

  editEmployeeCompetenciesScore(int index) async {
    if (selectedCompetenciesRatingConfig.id == 0) {
      AppUtils.showDialog("Information", 'Please fill Employee Rating');
    } else {
      print("editCompetenciesScore");
      print(detailModel.value.competenciesIds![index].score);
      // String message= await pmsService.editEmployeeCompetencyScore(detailModel.value.competenciesIds[index].id.toString(), selectedCompetenciesRatingConfig.id, detailModel.value.competenciesIds[index].comment);
      
      await pmsService!
        .editEmployeeCompetencyScore(
              detailModel.value.competenciesIds![index].id.toString(),
              selectedCompetenciesRatingConfig.id!,
              detailModel.value.competenciesIds![index].comment ?? "")
        .then((data) {
      if (data == 'Success') {
        Get.defaultDialog(title: 'Information', content: Text(data.toString()),onConfirm:  () async {
          var pmsList = await pmsListController!.getPmsList();
          detailModel.value = pmsList
              .where((element) => element.id == detailModel.value.id)
              .toList()[0];
          if (ratingConfig_list.value.length > 0) {
            selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
          }
          calculateTotalScoreAverage();
          Get.back();
          Get.back();
        });
      } else {
        AppUtils.showDialog("Information", data.toString());
      }
    });
      // String message = await pmsService!
      //     .editEmployeeCompetencyScore(
      //         detailModel.value.competenciesIds![index].id.toString(),
      //         selectedCompetenciesRatingConfig.id!,
      //         detailModel.value.competenciesIds![index].comment ?? "")
      //     .toString();
      // if (message == 'Success') {
      //   Get.defaultDialog(title: 'Information', content: Text(message),onConfirm:  () async {
      //     var pmsList = await pmsListController!.getPmsList();
      //     detailModel.value = pmsList
      //         .where((element) => element.id == detailModel.value.id)
      //         .toList()[0];
      //     if (ratingConfig_list.value.length > 0) {
      //       selectedCompetenciesRatingConfig = ratingConfig_list.value[0];
      //     }
      //     calculateTotalScoreAverage();
      //     Get.back();
      //     Get.back();
      //   });
      // } else {
      //   AppUtils.showDialog("Information", message);
      }
    }

  calculateTotalEmployeeRate() {
    var total = 0.0;
    if (detailModel.value != null) {
      detailModel.value.keyPerformanceIds!.forEach((value) {
        total += (value.weightage * value.employeeRate) / 100;
      });
      totalEmployeeRate.value = total;
    }
  }

  calculateTotalScoreAverage() {
    var total = 0.0;
    if (detailModel.value != null) {
      detailModel.value.competenciesIds!.forEach((value) {
        total += value.score;
      });
      totalScoreAverage.value =
          total / detailModel.value.competenciesIds!.length;
    }
  }

  calculateTotalFinalRate() {
    var total = 0.0;
    if (detailModel.value != null) {
      detailModel.value.keyPerformanceIds!.forEach((value) {
        total += (value.weightage * value.managerRate) / 100;
      });
      totalFinalRate.value = total;
    }
  }

  bool allowEditEmployeeRate() {
    DateTime startDate = DateTime.parse(detailModel.value.startDate());
    DateTime endDate = DateTime.parse(detailModel.value.endDate());
    if (DateTime.now().isAfter(startDate) &&
        DateTime.now().isBefore(endDate) &&
        (detailModel.value.state == 'acknowledge' ||
            detailModel.value.state == 'mid_year_hr_approve' ||
            detailModel.value.state == 'mid_year_self_assessment' ||
            detailModel.value.state == 'year_end_self_assessment')) {
      return true;
    }
    return false;
  }

  bool allowSelfEditEmployeeRate() {
    // DateTime startDate = DateTime.parse(detailModel.value.startDate());
    // DateTime endDate = DateTime.parse(detailModel.value.endDate());
    // if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate) && (detailModel.value.state == 'acknowledge' || detailModel.value.state == 'mid_year_hr_approve')){
    //   return true;
    // }
    // return false;
    if (detailModel.value.state == 'acknowledge') {
      DateTime startDate = DateTime.parse(detailModel.value.midFromDate!);
      DateTime endDate = DateTime.parse(detailModel.value.midToDate!);
      if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    } else if (detailModel.value.state == 'mid_year_hr_approve') {
      //mid_year_hr_approve //mid_year_self_assessment
      DateTime startDate = DateTime.parse(detailModel.value.endFromDate!);
      DateTime endDate = DateTime.parse(detailModel.value.endToDate!);
      if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate)) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool checkMidDate() {
    DateTime startDate = DateTime.parse(detailModel.value.midFromDate!);
    DateTime endDate = DateTime.parse(detailModel.value.midToDate!);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  bool checkForceRankingMidDate() {
    DateTime startDate =
        DateTime.parse(forceManagerdetailModel.value.midFromDate);
    DateTime endDate = DateTime.parse(forceManagerdetailModel.value.midToDate);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  bool checkHODForceRankingMidDate() {
    DateTime startDate =
        DateTime.parse(forceHODManagerdetailModel.value.midFromDate);
    DateTime endDate =
        DateTime.parse(forceHODManagerdetailModel.value.midToDate);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  bool checkYearEndDate() {
    DateTime startDate = DateTime.parse(detailModel.value.endFromDate!);
    DateTime endDate = DateTime.parse(detailModel.value.endToDate!);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  bool checkForceRankingYearEndDate() {
    DateTime startDate =
        DateTime.parse(forceManagerdetailModel.value.endFromDate);
    DateTime endDate = DateTime.parse(forceManagerdetailModel.value.endToDate);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  bool checkHODForceRankingYearEndDate() {
    DateTime startDate =
        DateTime.parse(forceHODManagerdetailModel.value.endFromDate);
    DateTime endDate =
        DateTime.parse(forceHODManagerdetailModel.value.endToDate);
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return true;
    }
    return false;
  }

  dynamic showSubmitOrNot() {
    if (detailModel.value.state == 'acknowledge') {
      return checkMidDate();
    } else if (detailModel.value.state == 'mid_year_hr_approve') {
      return checkYearEndDate();
    }
  }

  dynamic showForceRankingApprove() {
    if (forceManagerdetailModel.value.state == 'draft' ||
        forceManagerdetailModel.value.state == 'mid_year_hod_sent_back') {
      return checkForceRankingMidDate();
    } else if (forceManagerdetailModel.value.state == 'mid_year' ||
        forceManagerdetailModel.value.state == 'year_end_hod_sent_back') {
      return checkForceRankingYearEndDate();
    }
  }

  dynamic showHODForceRankingApprove() {
    if (forceHODManagerdetailModel.value.state == 'draft') {
      return checkHODForceRankingMidDate();
    }
    if (forceHODManagerdetailModel.value.state == 'sent_back_to_manager') {
      return true;
    } else if (forceHODManagerdetailModel.value.state == 'mid_year') {
      return checkHODForceRankingYearEndDate();
    }
  }

  bool allowEditManagerRate() {
    String state = detailModel.value.state!;
    return state == 'mid_year_self_assessment' ||
            state == 'year_end_self_assessment'
        ? allowEditManagersRate()
        : allowEditDottedManagerRate();
  }

  bool isAllowEditManagerRate() {
    bool isAllow = false;
    String state = detailModel.value.state!;
    if (state == 'mid_year_self_assessment' ||
        state == 'mid_year_dotted_manager_approve' ||
        state == 'mid_year_manager_approve') {
      DateTime startDate = DateTime.parse(detailModel.value.midFromDate!);
      DateTime endDate = DateTime.parse(detailModel.value.midToDate!);
      if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate)) {
        isAllow = true;
      } else {
        isAllow = false;
      }
    } else if (state == 'year_end_self_assessment' ||
        state == 'year_end_dotted_manager_approve' ||
        state == 'year_end_manager_approve') {
      DateTime startDate = DateTime.parse(detailModel.value.endFromDate!);
      DateTime endDate = DateTime.parse(detailModel.value.endToDate!);
      if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate)) {
        isAllow = true;
      } else {
        isAllow = false;
      }
    }
    return isAllow;
  }

  bool isAllowEditHODManagerRate(bool hasHODAssessment) {
    bool isAllow = false;
    String state = forceHODManagerdetailModel.value.state;
    // if(state == 'draft' && hasHODAssessment){
    //   DateTime startDate = DateTime.parse(forceHODManagerdetailModel.value.midFromDate);
    //   DateTime endDate = DateTime.parse(forceHODManagerdetailModel.value.midToDate);
    //   if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    //     isAllow =  true;
    //   }else{
    //     isAllow = false;
    //   }
    // }else if(state == 'mid_year' && hasHODAssessment){
    //   DateTime startDate = DateTime.parse(forceHODManagerdetailModel.value.endFromDate);
    //   DateTime endDate = DateTime.parse(forceHODManagerdetailModel.value.endToDate);
    //   if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    //     isAllow =  true;
    //   }else{
    //     isAllow = false;
    //   }
    // }
    if (hasHODAssessment) {
      isAllow = true;
    } else {
      isAllow = false;
    }
    return isAllow;
  }

// bool isAllowEditForceManagerRate(String state_value, bool hasMgrAssessment){
//   bool isAllow = false;
//   String state = state_value;
//   if((state == 'draft' || state == 'mid_year') && hasMgrAssessment){
//     isAllow =  true;
//   } else{
//    isAllow =  false;
//   }
//   return isAllow;
// }

  bool isAllowEditForceManagerRate(String state_value, bool hasMgrAssessment) {
    bool isAllow = false;
    String state = state_value;
    // if(state == 'draft' && hasMgrAssessment){
    //   DateTime startDate = DateTime.parse(forceManagerdetailModel.value.midFromDate);
    //   DateTime endDate = DateTime.parse(forceManagerdetailModel.value.midToDate);
    //   if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    //     isAllow =  true;
    //   }else{
    //     isAllow = false;
    //   }
    // }else if(state =='mid_year' && hasMgrAssessment){
    //   DateTime startDate = DateTime.parse(forceManagerdetailModel.value.endFromDate);
    //   DateTime endDate = DateTime.parse(forceManagerdetailModel.value.endToDate);
    //   if(DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)){
    //     isAllow =  true;
    //   }else{
    //     isAllow = false;
    //   }
    // }
    if (hasMgrAssessment) {
      isAllow = true;
    } else {
      isAllow = false;
    }
    return isAllow;
  }

  bool allowEditManagersRate() {
    if (detailModel.value.startDate() != null &&
        detailModel.value.endDate() != null) {
      DateTime startDate = DateTime.parse(detailModel.value.startDate());
      DateTime endDate = DateTime.parse(detailModel.value.endDate());
      if (DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate) &&
          (detailModel.value.state == 'mid_year_self_assessment' ||
              detailModel.value.state == 'year_end_self_assessment')) {
        return true;
      }
    }
    return false;
  }

  bool allowEditDottedManagerRate() {
    DateTime startDate = DateTime.parse(detailModel.value.startDate());
    DateTime endDate = DateTime.parse(detailModel.value.endDate());
    if (DateTime.now().isAfter(startDate) &&
        DateTime.now().isBefore(endDate) &&
        (detailModel.value.state == 'mid_year_manager_approve' ||
            detailModel.value.state == 'year_end_manager_approve')) {
      return true;
    }
    return false;
  }

  getAttachment(List<PMSattachments> data) async {
    isShowImageAttachment.value = true;
    attachment_list.value = [];
    for (var i = 0; i < data.length; i++) {
      PMSattachment data1 = new PMSattachment();
      data1.name = data[i].name;
      data1.attach_file = data[i].datas;
      attachment_list.value.add(data1);
    }
  }

  void setCameraImage(File image, String image64, String fileName) {
    image_base64_list.add(PMSAttach(name: fileName, attachment_file: image64));
  }
}
