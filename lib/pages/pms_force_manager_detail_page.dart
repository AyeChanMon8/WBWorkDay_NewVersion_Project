

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/models/force_manager_rating.dart';
import 'package:winbrother_hr_app/models/pms_force_ranking_detail_model.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import '../controllers/pms_list_controller.dart';

class PMSForceManagerDetailPage extends StatefulWidget {
   const PMSForceManagerDetailPage({super.key});

  @override
  State<PMSForceManagerDetailPage> createState() =>
      _PMSForceManagerDetailPageState();
}

class _PMSForceManagerDetailPageState extends State<PMSForceManagerDetailPage>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  String role = '';
  int empID = 0;
  PMSEmployeeDetailController controller =
      Get.put(PMSEmployeeDetailController());
  // PmsListController pmsController =
  //     Get.put(PmsListController());
  int forceRankingIndex = 0;
  int forceDetailIndex = 0;
  TextEditingController remarkTextController = TextEditingController();
  @override
  void initState() {
    role = box.read('role_category');
    controller.forceManagerdetailModel.value = Get.arguments[0]['first'];
    // getPMSDetail(Get.arguments[1]['second'], Get.arguments[2]['third']);
    forceRankingIndex = Get.arguments[1]['second'];
    forceDetailIndex = Get.arguments[2]['third'];
    
    empID = int.tryParse(box.read('emp_id'))!;

    // if(controller.forceManagerdetailModel.value!=null){
    //   if(controller.forceManagerdetailModel.value.state == 'mid_year_self_assessment'|| controller.detailModel.value.state == 'year_end_self_assessment')
    //     controller.detailModel.value.state == 'mid_year_self_assessment' || controller.detailModel.value.state == 'year_end_self_assessment' ? controller.showApprove.value=true : controller.showApprove.value=false;
    //   else
    //     controller.detailModel.value.state == 'mid_year_manager_approve' || controller.detailModel.value.state == 'year_end_manager_approve' || controller.detailModel.value.state == 'mid_year_dotted_manager_approve'|| controller.detailModel.value.state == 'year_end_dotted_manager_approve' ? controller.showApprove.value=true : controller.showApprove.value=false;
    // }

    super.initState();
  }

  // Future<void> getPMSDetail(int forceRankingIndex, int forceDetailIndex) async{
  //   var pmsList = await pmsController.getManagerPmsApprovalList();
  //   controller.forceManagerRankingdetailModel.value = pmsList;
  //   controller.forceManagerdetailModel.value  = controller.forceManagerRankingdetailModel
  //       .value[forceDetailIndex].forceRankingGroupId![forceRankingIndex];
  // }

  @override
  Widget build(BuildContext context) {
    String userImage = box.read('emp_image');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60),child: appbar(context, "PMS Details", userImage),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GFButton(
                  color: textFieldTapColor,
                  onPressed: () {
                    controller.refreshToRankingManagerApproveData(
                        controller.forceManagerdetailModel.value.id,
                        forceRankingIndex,
                        forceDetailIndex);
                  },
                  text: "Refresh",
                  shape: GFButtonShape.pills,
                  size: GFSize.SMALL,
                  type: GFButtonType.outline,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (("Period")),
                        style: pmstitleStyle(),
                      ),
                      Text(
                        (controller.forceManagerdetailModel.value.dateRangeName
                            .toString()),
                        style: pmstitleStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (("Strat date")),
                        style: pmstitleStyle(),
                      ),
                      Text(
                        (controller.forceManagerdetailModel.value.startDate() !=
                                null
                            ? AppUtils.changeDateFormat(controller
                                .forceManagerdetailModel.value
                                .startDate())
                            : ''),
                        style: pmstitleStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (("End date")),
                        style: pmstitleStyle(),
                      ),
                      Text(
                        (controller.forceManagerdetailModel.value.endDate() !=
                                null
                            ? AppUtils.changeDateFormat(controller
                                .forceManagerdetailModel.value
                                .endDate())
                            : ''),
                        style: pmstitleStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (("Force Ranking Group Position")),
                        style: pmstitleStyle(),
                      ),
                      Text(
                        (controller.forceManagerdetailModel.value.name != null &&
                                controller.forceManagerdetailModel.value.name !=
                                    false
                            ? controller.forceManagerdetailModel.value.name
                            : '-'),
                        style: pmstitleStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Expanded(
            //         flex: 8,
            //         child: Text("Force Ranking Group Position"),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text("-"),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(controller.forceManagerdetailModel.value.name),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Text('Force Ranking'),
                          )),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, right: 5, left: 5),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Name',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Final Review',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Mgr Rating',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'HOD Rating',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Remark',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, right: 5, left: 5),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                          () => Expanded(
                        child:  ListView.builder(
                              shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.forceManagerdetailModel.value
                                  .rankingEmployee!.length,
                              itemBuilder: (context, index) {
                                String managerRating = "";
                                RankingEmployee rankingEmployee = controller
                                    .forceManagerdetailModel
                                    .value
                                    .rankingEmployee![index];
                                if (rankingEmployee.managerRating != null &&
                                    rankingEmployee.managerRating != false) {
                                  for (var i = 0;
                                      i <
                                          controller.forceManagerRatingConfig_list
                                              .length;
                                      i++) {
                                    if (rankingEmployee.managerRating
                                            .toString() ==
                                        controller
                                            .forceManagerRatingConfig_list[i]
                                            .id) {
                                      controller.forceManagerRateTextController
                                              .text =
                                          controller
                                              .forceManagerRatingConfig_list[i]
                                              .value!;
                                      managerRating = controller
                                          .forceManagerRatingConfig_list[i].value!;
                                    }
                                  }
                                }
                                return InkWell(
                                  onTap: () {
                                    String mgrRating = "";
                                    if (controller
                                                .forceManagerdetailModel
                                                .value
                                                .rankingEmployee![index]
                                                .managerRating !=
                                            null &&
                                        controller
                                                .forceManagerdetailModel
                                                .value
                                                .rankingEmployee![index]
                                                .managerRating !=
                                            false) {
                                      for (var i = 0;
                                          i <
                                              controller
                                                  .forceManagerRatingConfig_list
                                                  .length;
                                          i++) {
                                        if (controller
                                                .forceManagerdetailModel
                                                .value
                                                .rankingEmployee![index]
                                                .managerRating
                                                .toString() ==
                                            controller
                                                .forceManagerRatingConfig_list[i]
                                                .id) {
                                          mgrRating = controller
                                              .forceManagerRatingConfig_list[i]
                                              .value!;
                                        }
                                      }
                                    }
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              color: const Color(0xff757575),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.close_outlined),
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                      ),
                                                    ),
                                                    controller
                                                                .forceManagerdetailModel
                                                                .value
                                                                .rankingEmployee![
                                                                    index]
                                                                .isRatingMatch ==
                                                            false
                                                        ? Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 16.0,
                                                                      bottom: 10),
                                                              child: Image.asset(
                                                                "assets/images/send_back_icon.png",
                                                                width: 20,
                                                                height: 20,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'Employee',
                                                              style:
                                                                  pmstitleStyle(),
                                                            )),
                                                        Expanded(
                                                            flex: 5,
                                                            child: Text(controller
                                                                .forceManagerdetailModel
                                                                .value
                                                                .rankingEmployee![
                                                                    index]
                                                                .name!))
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'Final Review',
                                                              style:
                                                                  pmstitleStyle(),
                                                            )),
                                                        Expanded(
                                                            flex: 5,
                                                            child: controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .mgrFinalEvaluation !=
                                                                        null &&
                                                                    controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .mgrFinalEvaluation !=
                                                                        false
                                                                ? Text(controller
                                                                    .forceManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .mgrFinalEvaluation)
                                                                : const Text('-'))
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                                'Manager Rating',
                                                                style:
                                                                    pmstitleStyle())),
                                                        Expanded(
                                                          flex: 5,
                                                          child: mgrRating !=
                                                                      false &&
                                                                  mgrRating != ''
                                                              ? Text(mgrRating
                                                                  .toString())
                                                              : const Text('-'),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'HOD Rating',
                                                              style:
                                                                  pmstitleStyle(),
                                                            )),
                                                        Expanded(
                                                            flex: 5,
                                                            child: controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .hodRating !=
                                                                        null &&
                                                                    controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .hodRating !=
                                                                        false
                                                                ? Text(controller
                                                                    .forceManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .hodRating)
                                                                : const Text('-'))
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              'Remark',
                                                              style:
                                                                  pmstitleStyle(),
                                                            )),
                                                        Expanded(
                                                            flex: 5,
                                                            child: controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .remark !=
                                                                        null &&
                                                                    controller
                                                                            .forceManagerdetailModel
                                                                            .value
                                                                            .rankingEmployee![
                                                                                index]
                                                                            .remark !=
                                                                        false
                                                                ? Text(controller
                                                                    .forceManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark)
                                                                : const Text('-'))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade100,
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              rankingEmployee.name!,
                                              style: TextStyle(
                                                  color: backgroundIconColor),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: rankingEmployee
                                                            .mgrFinalEvaluation !=
                                                        false &&
                                                    rankingEmployee
                                                            .mgrFinalEvaluation !=
                                                        null
                                                ? Text(
                                                    rankingEmployee
                                                        .mgrFinalEvaluation,
                                                    style: TextStyle(
                                                        color:
                                                            backgroundIconColor),
                                                  )
                                                : Text('-',
                                                    style: TextStyle(
                                                        color:
                                                            backgroundIconColor))),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                managerRating != '' &&
                                                        managerRating != false
                                                    ? Text(
                                                        managerRating.toString(),
                                                        style: TextStyle(
                                                            color:
                                                                backgroundIconColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : Text('-',
                                                        style: TextStyle(
                                                            color:
                                                                backgroundIconColor)),
                                                controller.isAllowEditForceManagerRate(
                                                        controller
                                                            .forceManagerdetailModel
                                                            .value
                                                            .state,
                                                        rankingEmployee
                                                            .hasMgrAssessment)
                                                    ? IconButton(
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          size: 16,
                                                        ),
                                                        onPressed: () {
                                                          if (controller
                                                                      .forceManagerdetailModel
                                                                      .value
                                                                      .rankingEmployee![
                                                                          index]
                                                                      .remark !=
                                                                  false &&
                                                              controller
                                                                      .forceManagerdetailModel
                                                                      .value
                                                                      .rankingEmployee?[
                                                                          index]
                                                                      .remark !=
                                                                  null) {
                                                            remarkTextController
                                                                    .text =
                                                                controller
                                                                    .forceManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark;
                                                          }
      
                                                          if (rankingEmployee
                                                                      .managerRating !=
                                                                  null &&
                                                              rankingEmployee
                                                                      .managerRating !=
                                                                  false) {
                                                            ForceManagerRating
                                                                data =
                                                                ForceManagerRating();
                                                            for (var i = 0;
                                                                i <
                                                                    controller
                                                                        .forceManagerRatingConfig_list
                                                                        .length;
                                                                i++) {
                                                              if (rankingEmployee
                                                                      .managerRating
                                                                      .toString() ==
                                                                  controller
                                                                      .forceManagerRatingConfig_list[
                                                                          i]
                                                                      .id) {
                                                                data = controller
                                                                    .forceManagerRatingConfig_list[i];
                                                                controller
                                                                        .selectedForceManagerRatingConfig =
                                                                    data;
                                                              }
                                                            }
                                                          }
                                                          showBarModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      ListView(
                                                                        children: [
                                                                          Container(
                                                                            color:
                                                                                const Color(0xff757575),
                                                                            child:
                                                                                Container(
                                                                              decoration:
                                                                                  const BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                              ),
                                                                              padding:
                                                                                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                                              child:
                                                                                  Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: Alignment.bottomRight,
                                                                                    child: IconButton(
                                                                                      icon: const Icon(Icons.close_outlined),
                                                                                      onPressed: () {
                                                                                        // if (controller.forceManagerRatingConfig_list.length > 0) {
                                                                                        //   controller.selectedForceManagerRatingConfig = controller.forceManagerRatingConfig_list.value[0];
                                                                                        // }
                                                                                        controller.selectedForceManagerRatingConfig = ForceManagerRating();
                                                                                        remarkTextController.text = "";
                                                                                        Get.back();
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  controller.forceManagerdetailModel.value.rankingEmployee![index].isRatingMatch == false
                                                                                      ? Align(
                                                                                          alignment: Alignment.bottomRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.only(right: 14.0, bottom: 8),
                                                                                            child: Image.asset(
                                                                                              "assets/images/send_back_icon.png",
                                                                                              width: 20,
                                                                                              height: 20,
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      : const SizedBox(),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                          flex: 3,
                                                                                          child: Text(
                                                                                            'Employee',
                                                                                            style: pmstitleStyle(),
                                                                                          )),
                                                                                      Expanded(flex: 5, child: Text(controller.forceManagerdetailModel.value.rankingEmployee![index].name!))
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(flex: 2, child: Text('Manager Rating', style: pmstitleStyle())),
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Obx(() => Column(
                                                                                              children: createRadioListRating(),
                                                                                            )),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                          flex: 3,
                                                                                          child: Text(
                                                                                            'HOD Rating',
                                                                                            style: pmstitleStyle(),
                                                                                          )),
                                                                                      Expanded(flex: 5, child: controller.forceManagerdetailModel.value.rankingEmployee![index].hodRating != null && controller.forceManagerdetailModel.value.rankingEmployee![index].hodRating != false ? Text(controller.forceManagerdetailModel.value.rankingEmployee![index].hodRating) : const Text('-'))
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text('Employee Remarks', textAlign: TextAlign.left, style: pmstitleStyle()),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: TextFormField(
                                                                                      scrollPadding: EdgeInsets.only(
                                                                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      maxLines: 5,
                                                                                      controller: remarkTextController,
                                                                                      decoration: const InputDecoration(
                                                                                        contentPadding: EdgeInsets.all(20.0),
                                                                                        hintText: "Remarks",
                                                                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Center(
                                                                                    child: GFButton(
                                                                                      color: textFieldTapColor,
                                                                                      onPressed: () {
                                                                                        controller.forceManagerdetailModel.value.rankingEmployee![index].setForceManagerRate(controller.selectedForceManagerRatingConfig.value!);
                                                                                        controller.forceManagerdetailModel.value.rankingEmployee![index].setRemark(remarkTextController.text);
                                                                                        controller.editForceManagerRateAndRate(index, forceRankingIndex, forceDetailIndex);
                                                                                        remarkTextController.text = "";
                                                                                        controller.selectedForceManagerRatingConfig = ForceManagerRating();
                                                                                      },
                                                                                      text: "SAVE",
                                                                                      blockButton: true,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                        })
                                                    : const SizedBox()
                                              ],
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                rankingEmployee.hodRating !=
                                                            null &&
                                                        rankingEmployee
                                                                .hodRating !=
                                                            '' &&
                                                        rankingEmployee
                                                                .hodRating !=
                                                            false
                                                    ? Text(
                                                        rankingEmployee.hodRating
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                backgroundIconColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : Text('',
                                                        style: TextStyle(
                                                            color:
                                                                backgroundIconColor)),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: rankingEmployee.remark !=
                                                        null &&
                                                    rankingEmployee.remark !=
                                                        false
                                                ? Text(
                                                    rankingEmployee.remark,
                                                    style: TextStyle(
                                                        color:
                                                            backgroundIconColor),
                                                  )
                                                : Text('-',
                                                    style: TextStyle(
                                                        color:
                                                            backgroundIconColor))),
                                        Expanded(
                                          child: controller
                                                      .forceManagerdetailModel
                                                      .value
                                                      .rankingEmployee![index]
                                                      .isRatingMatch ==
                                                  false
                                              ? Image.asset(
                                                  "assets/images/send_back_icon.png",
                                                  width: 16,
                                                  height: 16,
                                                )
                                              : const SizedBox(),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => controller.forceManagerdetailModel.value.state == 'draft' || controller.forceManagerdetailModel.value.state == 'mid_year_hod_sent_back'
                ? controller.showForceRankingApprove()
                    ? Center(
                        child: SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.midYearForceRank(
                                  controller.forceManagerdetailModel.value
                                      .forceTemplateId
                                      .toString(),
                                  controller.forceManagerdetailModel.value.state
                                      .toString(),
                                  forceDetailIndex);
                            },
                        style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(58, 47, 112, 1),),
                            child: Center(
                              child: Text(
                                (("MID YEAR FORCE RANK")),
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox()
                : controller.forceManagerdetailModel.value.state == 'mid_year' || controller.forceManagerdetailModel.value.state == 'year_end_hod_sent_back'
                    ? controller.showForceRankingApprove()
                        ? Center(
                            child: SizedBox(
                              width: 270,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.yearEndForceRank(
                                      controller.forceManagerdetailModel.value
                                          .forceTemplateId
                                          .toString(),
                                      controller
                                          .forceManagerdetailModel.value.state
                                          .toString());
                                },
                             style: ElevatedButton.styleFrom(backgroundColor:    const Color.fromRGBO(58, 47, 112, 1),),
                                child: Center(
                                  child: Text(
                                    (("YEAR END FORCE RANK")),
                                    style: buttonTextStyle(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                    : const SizedBox()),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createRadioListRating() {
    List<Widget> widgets = [];
    for (ForceManagerRating rating
        in controller.forceManagerRatingConfig_list) {
      widgets.add(
        RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          value: rating,
          dense: true,
          groupValue: controller.selectedForceManagerRatingConfig,
          title: Text(
            rating.value!,
            style: const TextStyle(fontSize: 14),
          ),
          onChanged: (value) {
            controller.onChangeForceManagerRatingConfigDropdown(value!);
          },
          selected: controller.selectedForceManagerRatingConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }
}
