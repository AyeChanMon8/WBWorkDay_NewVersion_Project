

import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/models/assessment_structure.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:winbrother_hr_app/utils/pdf_file_utils.dart';

class PmsManagerApprovalDetails extends StatefulWidget {
  const PmsManagerApprovalDetails({super.key});

  @override
  _PmsDetailsState createState() => _PmsDetailsState();
}

class _PmsDetailsState extends State<PmsManagerApprovalDetails>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  TabController ? _tabController;
  TextEditingController remarkTextController = TextEditingController();
  PMSEmployeeDetailController controller =
      Get.put(PMSEmployeeDetailController());
  double ratingValue = 0;
  String role = '';
  int empID = 0;
  String img64 = "";
  @override
  void initState() {
    role = box.read('role_category');
    _tabController = TabController(length: 4, vsync: this);
    controller.detailModel.value = Get.arguments;
    empID = int.tryParse(box.read('emp_id'))!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //PMSDetailModel pmsDetailModel = Get.arguments;
    // controller.detailModel.value = Get.arguments;

    //controller.calculateTotalEmployeeRate();
    //controller.calculateTotalFinalRate();
    controller.calculateTotalScoreAverage();
    final box = GetStorage();
    String userImage = box.read('emp_image');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(preferredSize: const Size.fromHeight(60),child:  appbar(context, "PMS Details", userImage),),
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
                        .refreshToApproveData(controller.detailModel.value.id!);
                  },
                  text: "Refresh",
                  shape: GFButtonShape.pills,
                  size: GFSize.SMALL,
                  type: GFButtonType.outline,
                ),
              ),
            ),
            controller.detailModel.value.isRatingMatch == false || controller.detailModel.value.isRatingMatch == null ? 
                        Align(alignment: Alignment.centerRight, child: Padding(padding: const EdgeInsets.only(right: 30),
                        child: Image.asset("assets/images/send_back_icon.png",
                        width: 18,
                        height: 18,),))
                        : const SizedBox(),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Text(
                (controller.detailModel.value.name!),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(58, 47, 112, 1)),
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
                        (controller.detailModel.value.dateRangeId!.name),
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
                        (("Position")),
                        style: pmstitleStyle(),
                      ),
                      Text(
                        (AppUtils.removeNullString(
                            controller.detailModel.value.job_id!.name)),
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
                        (AppUtils.changeDateFormat(controller.detailModel.value.dateStart!)),
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
                        (AppUtils.changeDateFormat(controller.detailModel.value.dateEnd!)),
                        style: pmstitleStyle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       (("Deadline")),
                  //       style: pmstitleStyle(),
                  //     ),
                  //     Text(
                  //       AppUtils.changeDateFormat(controller.detailModel.value.deadline)
                  //       ,
                  //       style: pmstitleStyle(),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
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
                    text: 'THE WHAT:',
                  ),
                  Tab(
                    text: 'THE HOW:',
                  ),
                  Tab(
                    text: 'Final Evaluation',
                  ),
                  Tab(
                    text: 'Force Ranking',
                  ),
                  // Tab(
                  //   text: 'Attachment',
                  // ),
                ],
              ),
            ),
            // tab bar view here
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
                                      'Goal',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Employee Self-Assessment',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Manager Rating',
                                      style:
                                          TextStyle(color: backgroundIconColor),
                                    )),
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
                                  //physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .detailModel.value.keyPerformanceIds!.length,
                                  itemBuilder: (context, index) {
                                    Key_performance_ids keyPerformance =
                                        controller.detailModel.value
                                            .keyPerformanceIds![index];
                                    controller.managerRateTextController.text =
                                        keyPerformance.managerRate.toString();
                                    return InkWell(
                                      onTap: () {
                                        if(keyPerformance.attachmentIds!=null && keyPerformance.attachmentIds!.isNotEmpty){
                                          controller.getAttachment(keyPerformance.attachmentIds!);
                                        }
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => ListView(
                                              children: [
                                                Container(
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
                                                        child: Container(
                                                          margin: const EdgeInsets.only(
                                                              left: 10, right: 10),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: IconButton(
                                                                  icon: const Icon(Icons
                                                                      .close_outlined),
                                                                  onPressed: () {
                                                                    controller.isShowAttachment.value = false;
                                                                    controller.attachment_list.value = [];
                                                                    controller.isShowImageAttachment.value = false;
                                                                    controller.image_base64_list =[];
                                                                    controller.imageList.value = [];
                                                                    Get.back();
                                                                  },
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                    'Goal',
                                                                    style:
                                                                        pmstitleStyle(),
                                                                  )),
                                                                  Expanded(
                                                                      child: Text(
                                                                          keyPerformance
                                                                              .name))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          'KPI',
                                                                          style:
                                                                              pmstitleStyle())),
                                                                  Expanded(
                                                                      child: Text(
                                                                          keyPerformance
                                                                                  .description ??
                                                                              ''))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          'WEIGHTAGE(%)',
                                                                          style:
                                                                              pmstitleStyle())),
                                                                  Expanded(
                                                                      child: Text(
                                                                          keyPerformance
                                                                              .weightage
                                                                              .toString()))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          'Employee Self-Assessment',
                                                                          style:
                                                                              pmstitleStyle())),
                                                                  keyPerformance
                                                                .employeeAssessmentRating !=
                                                            null &&
                                                        keyPerformance
                                                                .employeeAssessmentRating!
                                                                .name !=
                                                            null ? Expanded(
                                                                      child: Text(keyPerformance
                                                                          .employeeAssessmentRating!.name
                                                                          .toString())):const Expanded(child: Text(''))
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          'Manager Rate',
                                                                          style:
                                                                              pmstitleStyle())),
                                                                  keyPerformance
                                                                .managerAssessmentRating !=
                                                            null &&
                                                        keyPerformance
                                                                .managerAssessmentRating!
                                                                .name !=
                                                            null ? Expanded(
                                                                      child: Text(keyPerformance
                                                                          .managerAssessmentRating!.name
                                                                          .toString())):const Expanded(child: Text(''),)
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('Employee Remarks',
                                                                  style:
                                                                      pmstitleStyle()),
                                                              Text(keyPerformance
                                                                      .employeeRemark
                                                                      .toString() ??
                                                                  ''),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text('Manager Remarks',
                                                                  style:
                                                                      pmstitleStyle()),
                                                              Text(keyPerformance
                                                                      .managerRemark
                                                                      .toString() ??
                                                                  ''),
                                                              const SizedBox(height: 5,),
                                                              Text('Attachments',style:
                                                                      pmstitleStyle()),
                                                              Obx(() => controller.attachment_list.value.isNotEmpty
                                                                                              ? Row(
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                      child: GridView.count(
                                                                                                      shrinkWrap: true,
                                                                                                      physics: const NeverScrollableScrollPhysics(),
                                                                                                      crossAxisCount: 3,
                                                                                                      children: List.generate(controller.attachment_list.value.length, (index1) {
                                                                                                        return controller.attachment_list.value[index1].name.contains(".pdf")
                                                                                                            ? Padding(
                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                child: GestureDetector(
                                                                                                                  onTap: () async {
                                                                                                                    // createPDFFileFromString(controller.attachment_list.value[index1].attach_file).then((path) async {
                                                                                                                    //   await OpenFile.open(path);
                                                                                                                    // });
                                                                                                                    createPDFFileFromString(controller.attachment_list.value[index1].attach_file);
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: 100,
                                                                                                                    width: 100,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                        border: Border.all(
                                                                                                                          color: Colors.black, //color of border
                                                                                                                          width: 1, //width of border
                                                                                                                        ),
                                                                                                                        borderRadius: BorderRadius.circular(5)),
                                                                                                                    child: Center(
                                                                                                                      child: Text(
                                                                                                                        controller.attachment_list.value[index1].name,
                                                                                                                        textAlign: TextAlign.center,
                                                                                                                        style: const TextStyle(
                                                                                                                          color: Colors.black54,
                                                                                                                          fontSize: 16,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              )
                                                                                                            : Padding(
                                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                                child: Image.memory(
                                                                                                                  base64Decode(controller.attachment_list.value[index1].attach_file),
                                                                                                                  fit: BoxFit.cover,
                                                                                                                  width: 100,
                                                                                                                  height: 100,
                                                                                                                ),
                                                                                                              );
                                                                                                      }),
                                                                                                    )),
                                                                                                ],
                                                                                              )
                                                                                              : const SizedBox()),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              ],
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
                                                  keyPerformance.name,
                                                  style: TextStyle(
                                                      color: backgroundIconColor),
                                                )),
                                            keyPerformance
                                                            .employeeAssessmentRating !=
                                                        null &&
                                                    keyPerformance
                                                            .employeeAssessmentRating!
                                                            .name !=
                                                        null
                                                ? Expanded(
                                                  flex: 1,
                                                    child: Text(
                                                      keyPerformance
                                                          .employeeAssessmentRating!.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : Expanded(
                                                  flex:1,
                                                  child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                ),
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    keyPerformance.managerAssessmentRating !=
                                                                null &&
                                                            keyPerformance
                                                                    .managerAssessmentRating!
                                                                    .name !=
                                                                null
                                                        ? Expanded(
                                                          flex: 1,
                                                            child: Text(
                                                              keyPerformance
                                                                  .managerAssessmentRating!
                                                                  .name
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
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                        ),
                                                    controller
                                                            .isAllowEditManagerRate()
                                                        ? IconButton(
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              size: 16,
                                                            ),
                                                            onPressed: () {
                                                              if (keyPerformance
                                                                          .managerAssessmentRating !=
                                                                      null &&
                                                                  keyPerformance
                                                                          .managerAssessmentRating!
                                                                          .id !=
                                                                      0 && keyPerformance.managerAssessmentRating!.id!=null) {
                                                                AssessmentStructure
                                                                    data =
                                                                    AssessmentStructure();
                                                                data.id =
                                                                    keyPerformance
                                                                        .managerAssessmentRating!
                                                                        .id;
                                                                data.name =
                                                                    keyPerformance
                                                                        .managerAssessmentRating!
                                                                        .name;
                                                                data.description =
                                                                    keyPerformance
                                                                        .managerAssessmentRating!
                                                                        .description;
                                                                controller
                                                                        .selectedRatingConfig =
                                                                    data;
                                                              }
                                                              if(keyPerformance.attachmentIds!=null && keyPerformance.attachmentIds!.isNotEmpty){
                                                                controller.getAttachment(keyPerformance.attachmentIds!);
                                                              }
                                                              controller
                                                                  .attachment_list
                                                                  .refresh();
                                                              print("attachment List >>${controller
                                                                      .attachment_list}");
                                                                      if(keyPerformance
                                                                      .managerRemark==null){
                                                                        remarkTextController.text = '';
                                                                      }else{
                                                                          remarkTextController.text = keyPerformance
                                                                      .managerRemark
                                                                      .toString();
                                                                      }
                                                              
                                                              ratingValue =
                                                                  keyPerformance
                                                                      .managerRate;
      
                                                              showBarModalBottomSheet(
                                                                  context:
                                                                      context,
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
                                                                                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                                                                  child:
                                                                                      Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Align(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      child: IconButton(
                                                                                        icon: const Icon(Icons.close_outlined),
                                                                                        onPressed: () {
                                                                                          if(controller.ratingConfig_list.isNotEmpty){
                                                                                              controller.selectedRatingConfig = controller.ratingConfig_list[0];
                                                                                          }
                                                                                          controller.isShowAttachment.value = false;
                                                                                          controller.attachment_list.value = [];
                                                                                          controller.isShowImageAttachment.value = false;
                                                                                          controller.image_base64_list =[];
                                                                                          controller.imageList.value = [];
                                                                                          Get.back();
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(child: Text('Goal', style: pmstitleStyle())),
                                                                                          Expanded(child: Text(keyPerformance.name))
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(child: Text('KPI', style: pmstitleStyle())),
                                                                                          Expanded(child: Text(keyPerformance.description ?? ''))
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(child: Text('WEIGHTAGE(%)', style: pmstitleStyle())),
                                                                                          Expanded(child: Text(keyPerformance.weightage.toString()))
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      // Row(
                                                                                      //   children: [
                                                                                      //     Expanded(child: Text('Manager Rating', style: pmstitleStyle())),
                                                                                      //     Expanded(
                                                                                      //       child:
                                                                                      //           Obx(
                                                                                      //         () => DropdownButtonHideUnderline(
                                                                                      //           child: DropdownButton<RatingConfig>(
                                                                                      //               hint: Container(
                                                                                      //                   // padding: EdgeInsets.only(left: 20),
                                                                                      //                   child: Text(
                                                                                      //                 "Manager Rating",
                                                                                      //               )),
                                                                                      //               value: controller.selectedRatingConfig,
                                                                                      //               icon: Icon(Icons.keyboard_arrow_down),
                                                                                      //               iconSize: 30,
                                                                                      //               isExpanded: false,
                                                                                      //               onChanged: (RatingConfig value) {
                                                                                      //                 controller.onChangeRatingConfigDropdown(value);
                                                                                      //               },
                                                                                      //               items: controller.ratingConfig_list.map((RatingConfig leave) {
                                                                                      //                 return DropdownMenuItem<RatingConfig>(
                                                                                      //                   value: leave,
                                                                                      //                   child: Padding(
                                                                                      //                     padding: EdgeInsets.only(left: 2.0),
                                                                                      //                     child: Text(
                                                                                      //                       leave.rating_description,
                                                                                      //                       style: TextStyle(fontSize: 14),
                                                                                      //                     ),
                                                                                      //                   ),
                                                                                      //                 );
                                                                                      //               }).toList()),
                                                                                      //         ),
                                                                                      //       ),
                                                                                      //     )
                                                                                      //   ],
                                                                                      // ),
                                                                                      // Row(
                                                                                      //   children: [
                                                                                      //     Expanded(
                                                                                      //       flex: 2,
                                                                                      //       child: Text('Manager Rating', style: pmstitleStyle())),
                                                                                      //     Expanded(
                                                                                      //       flex: 4,
                                                                                      //       child:
                                                                                      //           Obx(
                                                                                      //         () => Column(children: createWhatRadioListRating(),)
                                                                                      //       ),
                                                                                      //     )
                                                                                      //   ],
                                                                                      // ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            flex: 2,
                                                                                            child: Text('Manager Rating', style: pmstitleStyle())),
                                                                                          Expanded(
                                                                                            flex: 4,
                                                                                            child:
                                                                                                Obx(
                                                                                              () => Column(
                                                                                                  children: createWhatRadioListRating(),
                                                                                          )
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Text('Final Remarks', style: pmstitleStyle()),
                                                                                      const SizedBox(
                                                                                        height: 10,
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
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(flex: 1, child: Text('Attachment :', style: pmstitleStyle())),
                                                                                          Expanded(
                                                                                            flex: 1,
                                                                                            child: ElevatedButton(
                                                                                              onPressed: () {
                                                                                                getMultipleFile(context);
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Colors.white,
                                                                                                side: BorderSide(width: 1.0, color: textFieldTapColor),
                                                                                              ),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    // <-- Icon
                                                                                                    Icons.attach_file,
                                                                                                    size: 24.0,
                                                                                                    color: textFieldTapColor,
                                                                                                  ),
                                                                                                  const SizedBox(
                                                                                                    width: 5,
                                                                                                  ),
                                                                                                  Text('Upload', style: TextStyle(color: textFieldTapColor, fontWeight: FontWeight.bold)),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          const Expanded(
                                                                                            flex: 1,
                                                                                            child: SizedBox(),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 3,
                                                                                      ),
                                                                                      Obx(() => controller.isShowImageAttachment.value == true && controller.attachment_list.value.isNotEmpty
                                                                                          ? Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                  child: GridView.count(
                                                                                                  shrinkWrap: true,
                                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                                  crossAxisCount: 3,
                                                                                                  children: List.generate(controller.attachment_list.value.length, (index1) {
                                                                                                    return controller.attachment_list.value[index1].name.contains(".pdf")
                                                                                                        ? Padding(
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: Stack(
                                                                                                              children: [
                                                                                                                GestureDetector(
                                                                                                                  onTap: () async {
                                                                                                                    // createPDFFileFromString(controller.attachment_list.value[index1].attach_file).then((path) async {
                                                                                                                    //   await OpenFile.open(path);
                                                                                                                    // });
                                                                                                                    createPDFFileFromString(controller.attachment_list.value[index1].attach_file);
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: 100,
                                                                                                                    width: 100,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                        border: Border.all(
                                                                                                                          color: Colors.black, //color of border
                                                                                                                          width: 1, //width of border
                                                                                                                        ),
                                                                                                                        borderRadius: BorderRadius.circular(5)),
                                                                                                                    child: Center(
                                                                                                                      child: Text(
                                                                                                                        controller.attachment_list.value[index1].name,
                                                                                                                        textAlign: TextAlign.center,
                                                                                                                        style: const TextStyle(
                                                                                                                          color: Colors.black54,
                                                                                                                          fontSize: 16,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Positioned(
                                                                                                                  top: 0,
                                                                                                                  right: 0,
                                                                                                                  child: GestureDetector(
                                                                                                                      onTap: () {
                                                                                                                        setState(() {
                                                                                                                          controller.attachment_list.value.removeAt(index1);
                                                                                                                          controller.attachment_list.refresh();
                                                                                                                        });
                                                                                                                      },
                                                                                                                      child: const Icon(Icons.close, color: Colors.red)),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        : Padding(
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: Stack(
                                                                                                              children: [
                                                                                                                Image.memory(
                                                                                                                  base64Decode(controller.attachment_list.value[index1].attach_file),
                                                                                                                  fit: BoxFit.cover,
                                                                                                                  width: 100,
                                                                                                                  height: 100,
                                                                                                                ),
                                                                                                                Positioned(
                                                                                                                  top: 0,
                                                                                                                  right: 0,
                                                                                                                  child: GestureDetector(
                                                                                                                      onTap: () {
                                                                                                                        setState(() {
                                                                                                                          controller.attachment_list.value.removeAt(index1);
                                                                                                                          controller.attachment_list.refresh();
                                                                                                                        });
                                                                                                                      },
                                                                                                                      child: const Icon(Icons.close, color: Colors.red)),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          );
                                                                                                  }),
                                                                                                )),
                                                                                            ],
                                                                                          )
                                                                                          : const SizedBox()),
                                                                                      const SizedBox(
                                                                                        height: 3,
                                                                                      ),
                                                                                      Obx(() => controller.isShowAttachment.value == true && controller.imageList.value.isNotEmpty
                                                                                          ? Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                  child: GridView.count(
                                                                                                  shrinkWrap: true,
                                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                                  crossAxisCount: 3,
                                                                                                  children: List.generate(controller.imageList.value.length, (index) {
                                                                                                    return controller.imageList.value[index].name.contains(".pdf")
                                                                                                        ? Padding(
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: Stack(
                                                                                                              children: [
                                                                                                                GestureDetector(
                                                                                                                  onTap: () async {
                                                                                                                    await OpenFile.open(controller.imageList.value[index].path);
                                                                                                                  },
                                                                                                                  child: Container(
                                                                                                                    height: 100,
                                                                                                                    width: 100,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                        border: Border.all(
                                                                                                                          color: Colors.black, //color of border
                                                                                                                          width: 1, //width of border
                                                                                                                        ),
                                                                                                                        borderRadius: BorderRadius.circular(5)),
                                                                                                                    child: Center(
                                                                                                                      child: Text(
                                                                                                                        controller.imageList.value[index].name,
                                                                                                                        textAlign: TextAlign.center,
                                                                                                                        style: const TextStyle(
                                                                                                                          color: Colors.black54,
                                                                                                                          fontSize: 16,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                // Container(
                                                                              
                                                                                                                //   color: Colors.white,
                                                                                                                //   width: 250,
                                                                                                                //   height: 250,
                                                                                                                //   child: Center(
                                                                                                                //     child: Text(
                                                                                                                //       _imageFile[index].name,
                                                                                                                //       textAlign: TextAlign.center,
                                                                                                                //       style: TextStyle(
                                                                                                                //         color: Colors.black54,
                                                                                                                //         fontSize: 16,
                                                                                                                //       ),
                                                                                                                //     ),
                                                                                                                //   ),
                                                                                                                // ),
                                                                                                                Positioned(
                                                                                                                  top: 0,
                                                                                                                  right: 0,
                                                                                                                  child: GestureDetector(
                                                                                                                      onTap: () {
                                                                                                                        setState(() {
                                                                                                                          controller.imageList.value.removeAt(index);
                                                                                                                          controller.image_base64_list.removeAt(index);
                                                                                                                          controller.imageList.refresh();
                                                                                                                        });
                                                                                                                      },
                                                                                                                      child: const Icon(Icons.close, color: Colors.red)),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          )
                                                                                                        : Padding(
                                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                                            child: Stack(
                                                                                                              children: [
                                                                                                                Image.file(
                                                                                                                  File(controller.imageList.value[index].path!),
                                                                                                                  fit: BoxFit.cover,
                                                                                                                  width: 100,
                                                                                                                  height: 100,
                                                                                                                ),
                                                                                                                Positioned(
                                                                                                                  top: 0,
                                                                                                                  right: 0,
                                                                                                                  child: GestureDetector(
                                                                                                                      onTap: () {
                                                                                                                        setState(() {
                                                                                                                          controller.imageList.value.removeAt(index);
                                                                                                                          controller.image_base64_list.removeAt(index);
                                                                                                                          controller.imageList.refresh();
                                                                                                                        });
                                                                                                                      },
                                                                                                                      child: const Icon(Icons.close, color: Colors.red)),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          );
                                                                                                  }),
                                                                                                )),
                                                                                            ],
                                                                                          )
                                                                                          : const SizedBox()),
                                                                                      Center(
                                                                                        child: GFButton(
                                                                                          color: textFieldTapColor,
                                                                                          onPressed: () {
                                                                                            controller.detailModel.value.keyPerformanceIds![index].setManagerRate(ratingValue);
                                                                                            controller.detailModel.value.keyPerformanceIds![index].setManagerRemark(remarkTextController.text);
                                                                                            controller.editManagerRateAndRate(index);
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
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10, left: 10),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           flex: 2,
                          //           child: Text(
                          //             'Average',
                          //             style: TextStyle(
                          //                 color: backgroundIconColor,
                          //                 fontSize: 16,
                          //                 fontWeight: FontWeight.bold),
                          //           )),
                          //       Expanded(
                          //           flex: 1,
                          //           child: Obx(
                          //             () => Text(
                          //               NumberFormat("#.##").format(
                          //                   controller.totalEmployeeRate.value),
                          //               style: TextStyle(
                          //                   color: backgroundIconColor,
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold),
                          //               textAlign: TextAlign.center,
                          //             ),
                          //           )),
                          //       Expanded(
                          //           flex: 1,
                          //           child: Obx(
                          //             () => Text(
                          //               NumberFormat("#.##").format(
                          //                   controller.totalFinalRate.value),
                          //               style: TextStyle(
                          //                   color: backgroundIconColor,
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold),
                          //               textAlign: TextAlign.center,
                          //             ),
                          //           )),
                          //     ],
                          //   ),
                          // ),
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
                                flex: 2,
                                child: Text(
                                  'Key Performance Areas',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 2,
                                child: Text('Description',
                                    style: TextStyle(color: backgroundIconColor),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Employee Self-Assessment',
                                  style: TextStyle(
                                    color: backgroundIconColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Manager Rating',
                                  style: TextStyle(
                                    color: backgroundIconColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
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
                            itemCount: controller
                                .detailModel.value.competenciesIds!.length,
                            itemBuilder: (context, index) {
                              Competencies_ids competencies = controller
                                  .detailModel.value.competenciesIds![index];
      
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            color: const Color(0xff757575),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)),
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        'KEY PERFORMANCE AREAS',
                                                        style: pmstitleStyle(),
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                              competencies.name))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                              'Description',
                                                              style:
                                                                  pmstitleStyle())),
                                                      Expanded(
                                                          child: Text(competencies
                                                                  .description ??
                                                              ''))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text('Employee Self-Assessment',
                                                              style:
                                                                  pmstitleStyle())),
                                                      Expanded(
                                                          child: competencies.employee_assessment_rating!=null && competencies.employee_assessment_rating!.id != 0 && competencies.employee_assessment_rating!.id != null ?Text(competencies
                                                              .employee_assessment_rating!.name
                                                              .toString()):const SizedBox())
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text('Manager Rating',
                                                              style:
                                                                  pmstitleStyle())),
                                                      Expanded(
                                                          child: competencies.manager_assessment_rating!=null && competencies.manager_assessment_rating!.id != 0 && competencies.manager_assessment_rating!.id != null ?Text(competencies
                                                              .manager_assessment_rating!.name
                                                              .toString()):const SizedBox())
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('Remark',
                                                      style: pmstitleStyle()),
                                                  Text(competencies.comment
                                                      .toString() ??
                                                      ''),
                                                ],
                                              ),
                                            ),
                                          ));
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
                                              flex: 2,
                                              child: Text(
                                                competencies.name,
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  competencies.description ?? '',
                                                  style: TextStyle(
                                                      color: backgroundIconColor),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          /* Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    competencies.score.toString(),
                                                    style: TextStyle(
                                                      color: backgroundIconColor,
                                                    ),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                  )),*/
                                          competencies.employee_assessment_rating !=
                                                        null &&
                                                    competencies
                                                            .employee_assessment_rating!
                                                            .name !=
                                                        null
                                                ? Expanded(
                                                  flex: 1,
                                                    child: Text(
                                                      competencies
                                                          .employee_assessment_rating!.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  )
                                                : Expanded(
                                                  flex:1,
                                                  child: Text(
                                                      '',
                                                      style: TextStyle(
                                                          color:
                                                              backgroundIconColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  competencies.manager_assessment_rating!=null && competencies.manager_assessment_rating!.id != 0 && competencies.manager_assessment_rating!.id != null ?Text(
                                                    competencies.manager_assessment_rating!.name.toString(),
                                                    style: TextStyle(
                                                        color:
                                                            backgroundIconColor),
                                                    textAlign: TextAlign.center,
                                                  ):Text('',style: TextStyle(
                                                        color:
                                                            backgroundIconColor)),
                                                  controller
                                                          .isAllowEditManagerRate()
                                                      ? IconButton(
                                                          icon: const Icon(
                                                            Icons.edit,
                                                            size: 16,
                                                          ),
                                                          onPressed: () {
                                                            if (competencies.manager_assessment_rating != null && competencies.manager_assessment_rating!.id !=
                                                                      0 && competencies.manager_assessment_rating!.id!=null) {
                                                                AssessmentStructure
                                                                    data =
                                                                    AssessmentStructure();
                                                                data.id =
                                                                    competencies
                                                                        .manager_assessment_rating!
                                                                        .id;
                                                                data.name =
                                                                    competencies
                                                                        .manager_assessment_rating!
                                                                        .name;
                                                                data.description =
                                                                    competencies
                                                                        .manager_assessment_rating!
                                                                        .description;
                                                                controller
                                                                        .selectedCompetenciesRatingConfig =
                                                                    data;
                                                              }
                                                            if(competencies
                                                                    .comment == null){
                                                                    remarkTextController
                                                                    .text = "";  
                                                                    }else{
                                                                      remarkTextController
                                                                    .text =
                                                                competencies
                                                                    .comment;
                                                                    }
                                                            
                                                            ratingValue = controller
                                                                .detailModel
                                                                .value
                                                                .competenciesIds![
                                                                    index]
                                                                .score;
                                                            showBarModalBottomSheet(
                                                                context: context,
                                                                builder:
                                                                    (context) =>
                                                                        ListView(
                                                                          children: [
                                                                            Container(
                                                                              color: const Color(
                                                                                  0xff757575),
                                                                              child:
                                                                                  Container(
                                                                                decoration:
                                                                                    const BoxDecoration(
                                                                                  color:
                                                                                      Colors.white,
                                                                                  borderRadius:
                                                                                      BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                ),
                                                                                padding: const EdgeInsets.symmetric(
                                                                                    vertical: 5,
                                                                                    horizontal: 5),
                                                                                child:
                                                                                    Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,    
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      child: IconButton(
                                                                                        icon: const Icon(Icons.close_outlined),
                                                                                        onPressed: () {
                                                                                          if(controller.ratingConfig_list.isNotEmpty){
                                                                                                  controller.selectedCompetenciesRatingConfig = controller.ratingConfig_list.value[0];
                                                                                          }
                                                                                          Get.back();
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(
                                                                                            child: Text(
                                                                                          'KEY PERFORMANCE AREAS',
                                                                                          style: pmstitleStyle(),
                                                                                        )),
                                                                                        Expanded(child: Text(competencies.name))
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Row(
                                                                                      children: [
                                                                                        Expanded(child: Text('Description', style: pmstitleStyle())),
                                                                                        Expanded(child: Text(competencies.description ?? ''))
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    // Row(
                                                                                    //   children: [
                                                                                    //     Expanded(child: Text('Manager Rating :', style: pmstitleStyle())),
                                                                                    //     Container(
                                                                                    //       child: Expanded(
                                                                                    //         child:
                                                                                    //             Obx(
                                                                                    //           () => Container(
                                                                                    //             decoration: BoxDecoration(
                                                                                    //               borderRadius: BorderRadius.circular(5.0),
                                                                                    //               border: Border.all(color: textFieldTapColor, style: BorderStyle.solid, width: 0.50),
                                                                                    //             ),
                                                                                    //             child: DropdownButtonHideUnderline(
                                                                                    //               child: DropdownButton<RatingConfig>(
                                                                                    //                   isDense: true,
                                                                                    //                   hint: Container(
                                                                                    //                       // padding: EdgeInsets.only(left: 20),
                                                                                    //                       child: Text(
                                                                                    //                     "Final Rating",
                                                                                    //                   )),
                                                                                    //                   value: controller.selectedCompetenciesRatingConfig,
                                                                                    //                   icon: Icon(Icons.keyboard_arrow_down),
                                                                                    //                   iconSize: 30,
                                                                                    //                   isExpanded: false,
                                                                                    //                   onChanged: (RatingConfig value) {
                                                                                    //                     controller.onChangeRatingCompetenciesConfigDropdown(value);
                                                                                    //                   },
                                                                                    //                   items: controller.ratingConfig_list.map((RatingConfig leave) {
                                                                                    //                     return DropdownMenuItem<RatingConfig>(
                                                                                    //                       value: leave,
                                                                                    //                       child: Padding(
                                                                                    //                         padding: const EdgeInsets.only(left: 2),
                                                                                    //                         child: Text(
                                                                                    //                           leave.rating_description,
                                                                                    //                           style: TextStyle(fontSize: 14),
                                                                                    //                         ),
                                                                                    //                       ),
                                                                                    //                     );
                                                                                    //                   }).toList()),
                                                                                    //             ),
                                                                                    //           ),
                                                                                    //         ),
                                                                                    //       ),
                                                                                    //     ),
                                                                                    //   ],
                                                                                    // ),
                                                                                    Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Text('Manager Rating', style: pmstitleStyle())),
                                                                                              Expanded(
                                                                                                flex: 4,
                                                                                                child:
                                                                                                    Obx(
                                                                                                  () => Column(
                                                                                                      children: createRadioListRating(),
                                                                                              )
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                        'Remark',
                                                                                        style:
                                                                                        pmstitleStyle()),
                                                                                    const SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: TextFormField(
                                                                                        scrollPadding: EdgeInsets.only(
                                                                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                        maxLines: 5,
                                                                                        controller: remarkTextController,
                                                                                        decoration: const InputDecoration(
                                                                                          contentPadding:  EdgeInsets.all(20.0),
                                                                                          hintText: "Remarks",
                                                                                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Center(
                                                                                      child: GFButton(
                                                                                        color: textFieldTapColor,
                                                                                        onPressed: () {
                                                                                          controller.detailModel.value.competenciesIds![index].setScore(ratingValue);
                                                                                          controller.detailModel.value.competenciesIds![index].setComment(remarkTextController.text);
                                                                                          controller.editCompetenciesScore(index);
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
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10, left: 10),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           flex: 2,
                      //           child: Text(
                      //             'Average',
                      //             style: TextStyle(
                      //                 color: backgroundIconColor,
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold),
                      //           )),
                      //       Expanded(flex: 2, child: Container()),
                      //       Expanded(
                      //           flex: 1,
                      //           child: Obx(
                      //             () => Text(
                      //               NumberFormat("#.##").format(
                      //                   controller.totalScoreAverage.value),
                      //               style: TextStyle(
                      //                   color: backgroundIconColor,
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.bold),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                    ],
                  )),
                  Container(
                      child: controller.detailModel.value.state ==
                                  'year_end_manager_approve' || controller.detailModel.value.state == 'year_end_hr_approve' ?Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Review Year',
                            //       style: TextStyle(color: backgroundIconColor),
                            //     )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Final Score',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Final Evaluation',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Competency',
                            //       style: TextStyle(color: backgroundIconColor),
                            //     )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Final Rating',
                            //       style: TextStyle(color: backgroundIconColor),
                            //     )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: backgroundIconColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       'Mid',
                            //       style: TextStyle(color: backgroundIconColor),
                            //     )),
                            Obx(() => Expanded(
                                flex: 1,
                                // child: Text(
                                //   AppUtils.removeNullString(controller
                                //       .detailModel.value.mid_kpi
                                //       .toStringAsFixed(1)),
                                //   style: TextStyle(color: backgroundIconColor),
                                // ))),
                                child: controller.detailModel.value.final_rating!=null ?Text(controller.detailModel.value.final_rating.toString(),style: TextStyle(color: backgroundIconColor)):
                                    Text('',style: TextStyle(color: backgroundIconColor),)
                            )),
                            Obx(
                              () => Expanded(
                                  flex: 1,
                                  // child: Text(
                                  //   AppUtils.changeDateFormat(controller
                                  //           .detailModel.value.midFromDate) +
                                  //       " - " +
                                  //       AppUtils.changeDateFormat(controller
                                  //           .detailModel.value.midToDate),
                                  //   style: TextStyle(color: backgroundIconColor),
                                  // )),
                                  child: controller
                                            .detailModel.value.final_evaluation!=null?Text(controller
                                            .detailModel.value.final_evaluation!.name.toString(),
                                            style: TextStyle(color: backgroundIconColor)):Text('',style: TextStyle(color: backgroundIconColor),)
                            )),
                            
                            // Obx(() => Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       AppUtils.removeNullString(controller
                            //           .detailModel.value.mid_competency_score
                            //           .toStringAsFixed(1)),
                            //       style: TextStyle(color: backgroundIconColor),
                            //     ))),
                            // Obx(() => Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       AppUtils.removeNullString(controller
                            //           .detailModel.value.mid_final_rating
                            //           .toStringAsFixed(1)),
                            //       style: TextStyle(color: backgroundIconColor),
                            //     ))),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10, top: 10),
                      //   child: Row(
                      //     children: [
                      //       // Expanded(
                      //       //     flex: 1,
                      //       //     child: Text(
                      //       //       'Annual',
                      //       //       style: TextStyle(color: backgroundIconColor),
                      //       //     )),
                      //       Obx(() => Expanded(
                      //           flex: 1,
                      //           child: Text(
                      //             AppUtils.changeDateFormat(controller
                      //                     .detailModel.value.endFromDate) +
                      //                 " - " +
                      //                 AppUtils.changeDateFormat(
                      //                     controller.detailModel.value.endToDate),
                      //             style: TextStyle(color: backgroundIconColor),
                      //           ))),
                      //       Obx(() => Expanded(
                      //           flex: 1,
                      //           child: Text(
                      //             AppUtils.removeNullString(controller
                      //                 .detailModel.value.kpi
                      //                 .toStringAsFixed(1)),
                      //             style: TextStyle(color: backgroundIconColor),
                      //           ))),
                      //       Obx(() => Expanded(
                      //           flex: 1,
                      //           child: Text(
                      //             AppUtils.removeNullString(controller
                      //                 .detailModel.value.competency_score
                      //                 .toStringAsFixed(1)),
                      //             style: TextStyle(color: backgroundIconColor),
                      //           ))),
                      //       Obx(() => Expanded(
                      //           flex: 1,
                      //           child: Text(
                      //             AppUtils.removeNullString(controller
                      //                 .detailModel.value.final_rating
                      //                 .toStringAsFixed(1)),
                      //             style: TextStyle(color: backgroundIconColor),
                      //           ))),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ):const SizedBox()),
                  Container(
                      child: ListView(
                        children: [controller.detailModel.value.state ==
                                    'mid_year_hr_approve' ||
                                controller.detailModel.value.state ==
                                    'year_end_self_assessment' ||
                                controller.detailModel.value.state ==
                                    'year_end_dotted_manager_approve' ||
                                controller.detailModel.value.state ==
                                    'year_end_manager_force_rank' ||
                                controller.detailModel.value.state ==
                                    'year_end_hod_force_rank' ||
                                controller.detailModel.value.state ==
                                    'year_end_hr_approve'
                              ? Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Manager Mid Force Ranking',
                                              style: TextStyle(
                                                  color: backgroundIconColor),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              'HOD Mid Force Ranking',
                                              style: TextStyle(
                                                  color: backgroundIconColor),
                                            )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, right: 0, left: 0),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: backgroundIconColor,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 10),
                                      child: Row(
                                        children: [
                                          Obx(() => Expanded(
                                              flex: 1,
                                              child: controller.detailModel.value.mgrMidForceRanking !=
                                                      null
                                                  ? Text(
                                                     controller.getForceRankingValue(controller.detailModel.value.mgrMidForceRanking),
                                                      style: TextStyle(
                                                          color: backgroundIconColor))
                                                  : Text(
                                                      '',
                                                      style: TextStyle(
                                                          color: backgroundIconColor),
                                                    ))),
                                          Obx(() => Expanded(
                                              flex: 1,
                                              child: controller.detailModel.value.hodMidForceRanking !=
                                                      null && controller.detailModel.value.hodMidForceRanking!.name !=
                                                      null
                                                  ? Text(
                                                      controller.detailModel.value.hodMidForceRanking!.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: backgroundIconColor))
                                                  : Text(
                                                      '',
                                                      style: TextStyle(
                                                          color: backgroundIconColor),
                                                    ))),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                            const SizedBox(height: 10,),
                            controller.detailModel.value.state ==
                                'year_end_hr_approve'
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Manager Year End Force Ranking',
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          'HOD Year End Force Ranking',
                                          style: TextStyle(
                                              color: backgroundIconColor),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, right: 0, left: 0),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: backgroundIconColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  children: [
                                    Obx(() => Expanded(
                                        flex: 1,
                                        child: controller.detailModel.value.mgrAnnualForceRanking !=
                                                null && controller.detailModel.value.mgrAnnualForceRanking !=
                                                ""
                                            ? Text(
                                                controller.getYearEndForceRankingValue(controller.detailModel.value.mgrAnnualForceRanking),
                                                style: TextStyle(
                                                    color: backgroundIconColor))
                                            : Text(
                                                '-',
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              ))),
                                    Obx(() => Expanded(
                                        flex: 1,
                                        child: controller.detailModel.value
                                                        .hodAnnualForceRanking !=
                                                    null &&
                                                controller.detailModel.value
                                                        .hodAnnualForceRanking !=
                                                    false && controller.detailModel.value
                                                        .hodAnnualForceRanking!.name !=
                                                    null
                                            ? Text(
                                                controller.detailModel.value
                                                    .hodAnnualForceRanking!.name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: backgroundIconColor))
                                            : Text(
                                                '-',
                                                style: TextStyle(
                                                    color: backgroundIconColor),
                                              ))),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                        ],
                      )),
      
                  // Container(
                  //   child: Obx(() =>
                  //   controller.detailModel.value.keyPerformanceAttachmentIds.length <= 0 ?
                  //   Center(child: Text('No attachment'),)
                  //   :
                  //   ListView.builder(
                  //       itemCount: controller.detailModel.value.keyPerformanceAttachmentIds.length,
                  //       itemBuilder: (context, index) {
                  //         return InkWell(
                  //           onTap: ()async{
                  //             controller.detailModel.value
                  //                         .keyPerformanceAttachmentIds[index].mimetype
                  //                         .contains('pdf')
                  //                     ?
                  //                     // open pdf
                  //                     createPDFFileFromString(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file)
                  //                         .then((path) async {
                  //                         await OpenFile.open(path);
                  //                       })
                  //                       :controller.detailModel.value
                  //                         .keyPerformanceAttachmentIds[index].mimetype
                  //                         .contains('application/vnd.ms-excel')
                  //                     ?
                  //                     // open pdf
                  //                     createExcelFileFromString(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file)
                  //                         .then((path) async {
                  //                         await OpenFile.open(path);
                  //                       })
                  //                     :controller.detailModel.value
                  //                         .keyPerformanceAttachmentIds[index].mimetype
                  //                         .contains('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
                  //                     ?
                  //                     // open pdf
                  //                     createExFileFromString(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file)
                  //                         .then((path) async {
                  //                         await OpenFile.open(path);
                  //                       })
                  //                     :controller.detailModel.value
                  //                         .keyPerformanceAttachmentIds[index].mimetype
                  //                         .contains('application/msword')
                  //                     ?
                  //                     // open pdf
                  //                     createWordFileFromString(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file)
                  //                         .then((path) async {
                  //                         await OpenFile.open(path);
                  //                       })
                  //                       :controller.detailModel.value
                  //                         .keyPerformanceAttachmentIds[index].mimetype
                  //                         .contains('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
                  //                     ?
                  //                     // open pdf
                  //                     createDocxWordFileFromString(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file)
                  //                         .then((path) async {
                  //                         await OpenFile.open(path);
                  //                       })
                  //                     :
                  //                     await showDialog(
                  //                         context: context,
                  //                         builder: (_) {
                  //                           return ImageDialog(
                  //                             bytes: base64Decode(controller
                  //                             .detailModel
                  //                             .value
                  //                             .keyPerformanceAttachmentIds[index]
                  //                             .attached_file),
                  //                           );
                  //                         });
                  //           },
                  //           child: Card(
                  //             child: ListTile(
                  //               title: Text('${controller.detailModel.value.keyPerformanceAttachmentIds[index].name}'),
                  //             ),
                  //           ),
                  //         );
                  //       })),
                  // ),
                ],
              ),
            ),
            
            /*  Container(
                // padding: EdgeInsets.only(left: 130, right: 30),
                padding: EdgeInsets.only(left: 40, right: 30),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 6, child: Text("Title", style: labelStyle())),
                    Expanded(
                      flex: 5,
                      child: Text((("employee_rate")), style: labelStyle()),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        (("final_rating")),
                        style: labelStyle(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),*/
      
            /* Container(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _pmsDetailslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 30),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 9,
                                  child: Text(_pmsDetailslist[index]["name"])),
                              Expanded(
                                  flex: 5,
                                  child:
                                      Text(_pmsDetailslist[index]["emp_rate"])),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 13, right: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.indigo)),
                                  height: 30,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "0",
                                    ),
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    );
                  },
                ),
              ),*/
      
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    controller.clickDone(
                        controller.detailModel.value.id.toString(),
                        controller.detailModel.value.state.toString());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(58, 47, 112, 1),),
                  child: Text(
                    (("Approve")),
                    style: buttonTextStyle(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getMultipleFile(BuildContext context) async {
    FilePickerResult ? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf','jpg','jpeg'],
    );
    var data = [];
    if(controller.attachment_list.isNotEmpty){
      for(var j=0;j<controller.attachment_list.length ;j++){
        data.add(controller.attachment_list[j].name);
      }
    }
    if(result!.files.isNotEmpty){
      for(var i=0;i<result.files.length;i++){
        data.add(result.files[i].name);
      }
    }
    if(controller.imageList.value.isNotEmpty){
      for(var k=0;k<controller.imageList.value.length;k++){
        data.add(controller.imageList.value[k].name);
      }
    }
    if (data.length > 2) {
      _showAlertDialog();
    } else {
      setState(() {
        controller.isShowAttachment.value = true;
        for (var i = 0; i < result.files.length; i++) {
          controller.imageList.value.add(result.files[i]);
          setImageList(result.files[i].path!,result.files[i].name);
        }
        controller.imageList.refresh();
      });
    }
  }

  setImageList(String filePath, String fileName) async {
    File image = File(filePath);
    //File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(image.path).readAsBytesSync();
    img64 = base64Encode(bytes);
    controller.setCameraImage(image, img64,fileName);
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Maximum File length is two'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> createRadioListRating() {
    List<Widget> widgets = [];
    for (AssessmentStructure rating in controller.ratingConfig_list) {
      widgets.add(
        RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          value: rating,
          dense: true,
          groupValue: controller.selectedCompetenciesRatingConfig,
          title: Text(rating.description!,
          style: const TextStyle(fontSize: 14),),
          onChanged: (value) {
            controller.onChangeRatingCompetenciesConfigDropdown(value!);
          },
          selected: controller.selectedCompetenciesRatingConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }

  List<Widget> createWhatRadioListRating() {
    List<Widget> widgets = [];
    for (AssessmentStructure rating in controller.ratingConfig_list) {
      widgets.add(
        RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          value: rating,
          dense: true,
          groupValue: controller.selectedRatingConfig,
          title: Text(rating.description!,
          style: const TextStyle(fontSize: 14),),
          onChanged: (value) {
            controller.onChangeRatingConfigDropdown(value!);
          },
          selected: controller.selectedRatingConfig == rating,
          activeColor: textFieldTapColor,
        ),
      );
    }
    return widgets;
  }
}
