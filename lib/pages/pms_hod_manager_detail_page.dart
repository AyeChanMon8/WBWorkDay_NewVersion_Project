

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/models/force_ranking_hod.dart';
import 'package:winbrother_hr_app/models/pms_hod_force_ranking_detail_model.dart';

import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class PMSHODForceManagerDetailPage extends StatefulWidget {
  const PMSHODForceManagerDetailPage({ super.key});

  @override
  State<PMSHODForceManagerDetailPage> createState() =>
      _PMSHODForceManagerDetailPageState();
}

class _PMSHODForceManagerDetailPageState
    extends State<PMSHODForceManagerDetailPage>
    with SingleTickerProviderStateMixin {
  TabController ? _tabController;
  final box = GetStorage();
  String role = '';
  int empID = 0;
  PMSEmployeeDetailController controller =
      Get.put(PMSEmployeeDetailController());
  int forceRankingIndex = 0;
  int forceDetailIndex = 0;
  bool isRatingMatch = true;
  bool alreadySentBack = true;
  TextEditingController remarkTextController = TextEditingController();

  @override
  void initState() {
    role = box.read('role_category');
    controller.forceHODManagerdetailModel.value = Get.arguments[0]['first'];
    forceRankingIndex = Get.arguments[1]['second'];
    forceDetailIndex = Get.arguments[2]['third'];
    isRatingMatch = Get.arguments[3]['fourth'];
    alreadySentBack = Get.arguments[4]['fifth'];
    empID = int.tryParse(box.read('emp_id'))!;
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
                    controller
                        .refreshToRankingHODManagerApproveData(controller.forceHODManagerdetailModel.value.id, forceRankingIndex, forceDetailIndex);
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
                        (controller.forceHODManagerdetailModel.value.dateRangeName.toString()),
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
                        (controller.forceHODManagerdetailModel.value.startDate() != null
                            ? AppUtils.changeDateFormat(
                                controller.forceHODManagerdetailModel.value.startDate())
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
                        (controller.forceHODManagerdetailModel.value.endDate() != null
                            ? AppUtils.changeDateFormat(
                                controller.forceHODManagerdetailModel.value.endDate())
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
                        (controller.forceHODManagerdetailModel.value.name != null && controller.forceHODManagerdetailModel.value.name !=false
                            ? controller.forceHODManagerdetailModel.value.name
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
            //         child: Text(controller.forceHODManagerdetailModel.value.name),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(
                    text: 'Force Ranking Employees',
                  ),
                  Tab(
                    text: 'Manager Force Ranking Template',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Employee',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Manager Rating',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'HOD Rating',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Remark',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                const Expanded(flex: 1, child: SizedBox()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 0, right: 5, left: 5),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: backgroundIconColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Obx(
                              () => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.forceHODManagerdetailModel
                                      .value.rankingEmployee!.length,
                                  itemBuilder: (context, index) {
                                    String managerRating = "";
                                    HODRankingEmployee hodRankingEmployee =
                                        controller.forceHODManagerdetailModel
                                            .value.rankingEmployee![index];
                                    controller.forceHodManagerRateTextController
                                            .text =
                                        hodRankingEmployee.hodRating.toString();
      
                                    if (hodRankingEmployee.managerRating !=
                                            null &&
                                        hodRankingEmployee.managerRating !=
                                            false) {
                                      for (var i = 0;
                                          i <
                                              controller
                                                  .forceManagerRatingConfig_list
                                                  .length;
                                          i++) {
                                        if (hodRankingEmployee.managerRating
                                                .toString() ==
                                            controller
                                                .forceManagerRatingConfig_list[i]
                                                .id) {
                                          managerRating = controller
                                              .forceManagerRatingConfig_list[i]
                                              .value!;
                                        }
                                      }
                                    }
                                    return InkWell(
                                      onTap: () {
                                        String mgrRating = "";
                                        if (controller
                                                    .forceHODManagerdetailModel
                                                    .value
                                                    .rankingEmployee![index]
                                                    .managerRating !=
                                                null &&
                                            controller
                                                    .forceHODManagerdetailModel
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
                                                    .forceHODManagerdetailModel
                                                    .value
                                                    .rankingEmployee![index]
                                                    .managerRating
                                                    .toString() ==
                                                controller
                                                    .forceManagerRatingConfig_list[
                                                        i]
                                                    .id) {
                                              mgrRating = controller
                                                  .forceManagerRatingConfig_list[
                                                      i]
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
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight:
                                                                  Radius.circular(
                                                                      10)),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: IconButton(
                                                            icon: const Icon(Icons
                                                                .close_outlined),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                        ),
                                                        controller
                                                                .forceHODManagerdetailModel
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
                                                                    .forceHODManagerdetailModel
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
                                                                    'Manager Rating',
                                                                    style:
                                                                        pmstitleStyle())),
                                                            Expanded(
                                                              flex: 5,
                                                              child: mgrRating !=
                                                                          false
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
                                                                                .forceHODManagerdetailModel
                                                                                .value
                                                                                .rankingEmployee![
                                                                                    index]
                                                                                .hodRating !=
                                                                            null &&
                                                                        controller
                                                                                .forceHODManagerdetailModel
                                                                                .value
                                                                                .rankingEmployee![
                                                                                    index]
                                                                                .hodRating !=
                                                                            false
                                                                    ? Text(controller
                                                                        .forceHODManagerdetailModel
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
                                                                    .forceHODManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark!=null && controller
                                                                    .forceHODManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark!=false ? Text(controller
                                                                    .forceHODManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark): const Text('-'))
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
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  hodRankingEmployee.name!,
                                                  style: TextStyle(
                                                      color: backgroundIconColor),
                                                )),
                                            managerRating != '' &&
                                                    managerRating != false
                                                ? Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      managerRating.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  )
                                                : Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    hodRankingEmployee
                                                                    .hodRating !=
                                                                null &&
                                                            hodRankingEmployee
                                                                    .hodRating !=
                                                                false
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              hodRankingEmployee
                                                                  .hodRating
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      backgroundIconColor),
                                                              textAlign: TextAlign
                                                                  .center,
                                                            ),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              '',
                                                              style: TextStyle(
                                                                  color:
                                                                      backgroundIconColor),
                                                              textAlign: TextAlign
                                                                  .center,
                                                            ),
                                                          ),
                                                    controller.isAllowEditHODManagerRate(
                                                            hodRankingEmployee
                                                                .hasManagerForceRank)
                                                        ? IconButton(
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              size: 16,
                                                            ),
                                                            onPressed: () {
                                                              if (controller
                                                                      .forceHODManagerdetailModel
                                                                      .value
                                                                      .rankingEmployee![
                                                                          index]
                                                                      .remark !=
                                                                  false &&
                                                              controller
                                                                      .forceHODManagerdetailModel
                                                                      .value
                                                                      .rankingEmployee![
                                                                          index]
                                                                      .remark !=
                                                                  null) {
                                                            remarkTextController
                                                                    .text =
                                                                controller
                                                                    .forceHODManagerdetailModel
                                                                    .value
                                                                    .rankingEmployee![
                                                                        index]
                                                                    .remark;
                                                          }
                                                              if (hodRankingEmployee
                                                                          .hodRating !=
                                                                      null &&
                                                                  hodRankingEmployee
                                                                          .hodRating !=
                                                                      false) {
                                                                ForceRankingHOD
                                                                    data =
                                                                    ForceRankingHOD();
                                                                for (var i = 0;
                                                                    i <
                                                                        controller
                                                                            .forceRankingHOD_list
                                                                            .length;
                                                                    i++) {
                                                                  if (hodRankingEmployee
                                                                          .hodRating
                                                                          .toString() ==
                                                                      controller
                                                                          .forceRankingHOD_list[
                                                                              i]
                                                                          .name) {
                                                                    data = controller
                                                                        .forceRankingHOD_list[i];
                                                                    controller
                                                                            .selectedForceRankingHODConfig =
                                                                        data;
                                                                  }
                                                                }
                                                              }
                                                              showBarModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          ListView(
                                                                            children: [
                                                                              Container(
                                                                                color: const Color(0xff757575),
                                                                                child: Container(
                                                                                  decoration: const BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: Alignment.bottomRight,
                                                                                        child: IconButton(
                                                                                          icon: const Icon(Icons.close_outlined),
                                                                                          onPressed: () {
                                                                                            controller.selectedForceRankingHODConfig = ForceRankingHOD();
                                                                                            remarkTextController.text = '';
                                                                                            // if (controller.forceRankingHOD_list.length > 0) {
                                                                                            //   controller.selectedForceRankingHODConfig = controller.forceRankingHOD_list.value[0];
                                                                                            // }
                                                                                            Get.back();
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      controller.forceHODManagerdetailModel.value.rankingEmployee![index].isRatingMatch == false
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
                                                                                          Expanded(flex: 5, child: Text(controller.forceHODManagerdetailModel.value.rankingEmployee![index].name!))
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                              flex: 3,
                                                                                              child: Text(
                                                                                                'Manager Rating',
                                                                                                style: pmstitleStyle(),
                                                                                              )),
                                                                                          Expanded(flex: 5, child: managerRating != false ? Text(managerRating) : const Text('-'))
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(flex: 2, child: Text('HOD Rating', style: pmstitleStyle())),
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
                                                                                      Align(
                                                                                        alignment: Alignment.centerLeft,
                                                                                        child: Text('Employee Remarks', style: pmstitleStyle())),
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
                                                                                      border: OutlineInputBorder(borderSide:  BorderSide(color: Colors.grey)),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                    const SizedBox(height: 5),
                                                                                      Center(
                                                                                        child: GFButton(
                                                                                          color: textFieldTapColor,
                                                                                          onPressed: () {
                                                                                            controller.forceHODManagerdetailModel.value.rankingEmployee![index].setHODManagerRate(controller.selectedForceRankingHODConfig.name ?? '');
                                                                                            controller.forceHODManagerdetailModel.value.rankingEmployee![index].setRemark(remarkTextController.text);
                                                                                            controller.editForceHODManagerRateAndRate(index, forceRankingIndex, forceDetailIndex);
                                                                                            controller.selectedForceRankingHODConfig = ForceRankingHOD();
                                                                                            remarkTextController.text = '';
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
                                                            },
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                )),
                                          Expanded(
                                            flex: 2,
                                                child: hodRankingEmployee.remark!=null && hodRankingEmployee.remark!=false ?Text(
                                                  hodRankingEmployee.remark,
                                                  style: TextStyle(
                                                      color: backgroundIconColor),
                                                ):const Text('-')),
                                          Expanded(
                                          child: controller
                                                      .forceHODManagerdetailModel
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 5, left: 5, bottom: 10),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: backgroundIconColor,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      child: ListView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  'Approve Manager',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 8,
                                child: Text('Manager Force Ranking Template',
                                    style: TextStyle(color: backgroundIconColor),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 5, left: 5),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.forceHODManagerdetailModel.value
                                .managerForceRankingTemplate!.length,
                            itemBuilder: (context, index) {
                              ManagerForceRankingTemplate mgrRankingTemplate =
                                  controller.forceHODManagerdetailModel.value
                                      .managerForceRankingTemplate![index];
      
                              return InkWell(
                                onTap: () {
                                  // showModalBottomSheet(
                                  //     context: context,
                                  //     builder: (context) => Container(
                                  //           color: Color(0xff757575),
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               borderRadius: BorderRadius.only(
                                  //                   topLeft: Radius.circular(10),
                                  //                   topRight:
                                  //                       Radius.circular(10)),
                                  //             ),
                                  //             padding: EdgeInsets.symmetric(
                                  //                 vertical: 5, horizontal: 5),
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Align(
                                  //                   alignment:
                                  //                       Alignment.bottomRight,
                                  //                   child: IconButton(
                                  //                     icon: Icon(
                                  //                         Icons.close_outlined),
                                  //                     onPressed: () {
                                  //                       Get.back();
                                  //                     },
                                  //                   ),
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Expanded(
                                  //                         child: Text(
                                  //                       'KEY PERFORMANCE AREAS',
                                  //                       style: pmstitleStyle(),
                                  //                     )),
                                  //                     Expanded(
                                  //                         child: Text(
                                  //                             competencies.name))
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Expanded(
                                  //                         child: Text(
                                  //                             'Description',
                                  //                             style:
                                  //                                 pmstitleStyle())),
                                  //                     Expanded(
                                  //                         child: Text(competencies
                                  //                                 .description ??
                                  //                             ''))
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Expanded(
                                  //                         child: Text('Employee Self-Assessment',
                                  //                             style:
                                  //                                 pmstitleStyle())),
                                  //                     Expanded(
                                  //                         child: competencies.employee_assessment_rating!=null && competencies.employee_assessment_rating.id != 0 && competencies.employee_assessment_rating.id != null ?Text(competencies
                                  //                             .employee_assessment_rating.name
                                  //                             .toString()):SizedBox())
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     Expanded(
                                  //                         child: Text('Manager Rating',
                                  //                             style:
                                  //                                 pmstitleStyle())),
                                  //                     Expanded(
                                  //                         child: competencies.manager_assessment_rating!=null && competencies.manager_assessment_rating.id != 0 && competencies.manager_assessment_rating.id != null ?Text(competencies
                                  //                             .manager_assessment_rating.name
                                  //                             .toString()):SizedBox())
                                  //                   ],
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //                 Text('Remark',
                                  //                     style: pmstitleStyle()),
                                  //                 Text(competencies.comment
                                  //                     .toString() ??
                                  //                     ''),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                mgrRankingTemplate.name!,
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              )),
                                          Expanded(
                                              flex: 8,
                                              child: Text(
                                                  mgrRankingTemplate
                                                          .forceRankingGroupName!=null && mgrRankingTemplate
                                                          .forceRankingGroupName!=false ?
                                                      mgrRankingTemplate
                                                          .forceRankingGroupName: '-',
                                                  style: TextStyle(
                                                      color: backgroundIconColor),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => 
            controller.forceHODManagerdetailModel.value.state == 'draft'
                ? controller.showHODForceRankingApprove() ? (isRatingMatch==false && alreadySentBack == false) ? 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                        // width: 270,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.midYearHODForceRank(
                                controller.forceHODManagerdetailModel.value
                                    .forceTemplateId
                                    .toString(),
                                controller.forceHODManagerdetailModel.value.state
                                    .toString(),
                                forceRankingIndex, forceDetailIndex);
                          },
                         style: ElevatedButton.styleFrom(backgroundColor:   const Color.fromRGBO(58, 47, 112, 1),),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Text(
                                (("MID YEAR FORCE RANK")),
                                textAlign: TextAlign.center,
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                  const SizedBox(width: 15,),
                    Expanded(
                      child: SizedBox(
                        width: 270,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.sendBackToManager(
                                controller.forceHODManagerdetailModel.value
                                    .forceTemplateId
                                    .toString(),
                                forceRankingIndex, forceDetailIndex);
                          },
                       style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromRGBO(58, 47, 112, 1),),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Text(
                                (("Sent Back To Manager")),
                                textAlign: TextAlign.center,
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10)
                ],) : Center(
                    child: SizedBox(
                      width: 270,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.midYearHODForceRank(
                              controller.forceHODManagerdetailModel.value
                                  .forceTemplateId
                                  .toString(),
                              controller.forceHODManagerdetailModel.value.state
                                  .toString(),
                              forceRankingIndex, forceDetailIndex
                              );
                        },
                       style: ElevatedButton.styleFrom(backgroundColor: const   Color.fromRGBO(58, 47, 112, 1),),
                        child: Center(
                          child: Text(
                            (("MID YEAR FORCE RANK")),
                            style: buttonTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ) : const SizedBox() : (controller.forceHODManagerdetailModel.value.state == 'mid_year_sent_back' || controller.forceHODManagerdetailModel.value.state == 'sent_back_to_manager') ? Center(
                    child: SizedBox(
                      width: 270,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.midYearHODForceRank(
                              controller.forceHODManagerdetailModel.value
                                  .forceTemplateId
                                  .toString(),
                              controller.forceHODManagerdetailModel.value.state
                                  .toString(),
                              forceRankingIndex, forceDetailIndex);
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
                : controller.forceHODManagerdetailModel.value.state == 'mid_year'
                    ? controller.showHODForceRankingApprove() ? (isRatingMatch==false && alreadySentBack == false) ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.yearEndHODForceRank(
                                  controller.forceHODManagerdetailModel.value
                                      .forceTemplateId
                                      .toString(),
                                  controller
                                      .forceHODManagerdetailModel.value.state
                                      .toString(),
                                  forceRankingIndex, forceDetailIndex);
                            },
                          style: ElevatedButton.styleFrom(backgroundColor:  const Color.fromRGBO(58, 47, 112, 1),),
                            child: Center(
                              child: Text(
                                (("YEAR END FORCE RANK")),
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.sendBackToManager(
                                  controller.forceHODManagerdetailModel.value
                                      .forceTemplateId
                                      .toString(),
                                  forceRankingIndex, forceDetailIndex);
                            },
                          style: ElevatedButton.styleFrom(backgroundColor:    const Color.fromRGBO(58, 47, 112, 1),),
                            child: Center(
                              child: Text(
                                (("Sent Back To Manager")),
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        )
                      ],) : Center(
                        child: SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.yearEndHODForceRank(
                                  controller.forceHODManagerdetailModel.value
                                      .forceTemplateId
                                      .toString(),
                                  controller
                                      .forceHODManagerdetailModel.value.state
                                      .toString(),
                                  forceRankingIndex, forceDetailIndex);
                            },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(58, 47, 112, 1),),
                            child: Center(
                              child: Text(
                                (("YEAR END FORCE RANK")),
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ) : const SizedBox() 
                    : (controller.forceHODManagerdetailModel.value.state == 'sent_back_to_manager' || controller.forceHODManagerdetailModel.value.state == 'year_end_sent_back') ? Center(
                        child: SizedBox(
                          width: 270,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.yearEndHODForceRank(
                                  controller.forceHODManagerdetailModel.value
                                      .forceTemplateId
                                      .toString(),
                                  controller
                                      .forceHODManagerdetailModel.value.state
                                      .toString(),
                                  forceRankingIndex, forceDetailIndex);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(58, 47, 112, 1),),
                            child: Center(
                              child: Text(
                                (("YEAR END FORCE RANK")),
                                style: buttonTextStyle(),
                              ),
                            ),
                          ),
                        ),
                      ) : const SizedBox()),
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
    for (ForceRankingHOD rating in controller.forceRankingHOD_list) {
      widgets.add(
        RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          value: rating,
          dense: true,
          groupValue: controller.selectedForceRankingHODConfig,
          title: Text(
            rating.name,
            style: const TextStyle(fontSize: 14),
          ),
          onChanged: (value) {
            controller.onChangeHODRatingConfigDropdown(value!);
          },
          selected: controller.selectedForceRankingHODConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }
}
