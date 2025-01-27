
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:winbrother_hr_app/controllers/daytrip_plantrip_fuel_advance_controller.dart';
import 'package:winbrother_hr_app/controllers/plan_trip_controller.dart';
import 'package:winbrother_hr_app/models/base_route.dart';
import 'package:winbrother_hr_app/models/plantrip_waybill.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_line_list_model.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/add_advance_page.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

import 'add_fuel_waybill_page.dart';

class PlanTripWayBillDetails extends StatefulWidget {
  const PlanTripWayBillDetails({super.key});

  @override
  _PlanTripWayBillDetailsState createState() => _PlanTripWayBillDetailsState();
}

class _PlanTripWayBillDetailsState extends State<PlanTripWayBillDetails> with SingleTickerProviderStateMixin {
  final PlanTripController controller = Get.put(PlanTripController());
  var box = GetStorage();
  String image = "";
  int groupValue = 0;
  TabController ? _tabController;
  var arg_index;
  var isDriver = false;
  var is_spare = false;
  var is_branch_manager = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  var next_route_id = 0;
  var previous_route_id = 0;
  var plantrip_waybill_list_lines = [];
  var to_date;
  var isIncharge = false;
  var isStart = false;
  var isEnd = false;
  var employee_id;
  DateTime routeEndselectedDate = DateTime.now();
  List<Asset> galleryImages = <Asset>[];
  List<File> cameraImages = [];
  final ImagePicker _picker = ImagePicker();
  String img64_route = "";
  @override
  void initState() {
    if(Get.arguments!=null){
      isDriver = box.read("is_driver");
      employee_id = box.read('emp_id');
      if(box.read('real_role_category').toString().contains('branch manager')){
        print('contains#');
        is_branch_manager = true;
      }else{
        is_branch_manager = false;
      }
      if(box.read('real_role_category').toString().contains('spare')){
        is_spare = true;
      }else{
        is_spare = false;
      }
      //controller.planTripWayBillModel = Get.arguments;
      controller.arg_index.value = Get.arguments;
      if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds!.isNotEmpty){
        controller.selectedWayBillExpenseRouteCategory = controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![0];
      }
      if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds!.isNotEmpty){
        controller.selectedWayBillRoute = controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds![0];
      }
      controller.waybill_expense_list.value = controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds!;
      // if(controller
      //         .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!=null && controller
      //         .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!.id == int.parse(employee_id)){
      //           isIncharge = true;
      // }
      if (controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].startTripResponsible == 'In-charge'){
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId != null && controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }else if (controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].startTripResponsible == 'Driver'){
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].driverId != null &&controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].driverId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }else{
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId != null && controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }

      if (controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].endTripResponsible == 'In-charge'){
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId != null && controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }else if (controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].endTripResponsible == 'Driver'){
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].driverId != null &&controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].driverId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }else{
        if(controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId != null && controller
              .plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }
     
    }
    controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'?
    _tabController = TabController(length: 3, vsync: this):
    controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'? _tabController = TabController(length: 4, vsync: this):
    _tabController = TabController(length: 5, vsync: this);
    controller.fetchExpenseStatusData(controller.plantrip_with_waybill_list[controller.arg_index.value].id,'plantrip_waybill');
    controller.getRouteList(controller.plantrip_with_waybill_list[controller.arg_index.value].id.toString(),'plantrip_waybill');
    controller.calculateTotalExpense(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds!);
    
    super.initState();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  //   plantrip_waybill_list_lines= [];
  //   next_route_id = 0;
  // }
  Widget routeContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex : 1,
                child: Text(labels!.route,style: maintitleStyle(),)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2,right: 0,left: 0),
          child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
        ),
        controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' && (controller.plantrip_with_waybill_list[controller.arg_index.value].driverId!.id == int.parse(employee_id)) ? Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: routeListWidget(context),
        ): const SizedBox(),
        controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' && (isDriver || is_spare) ?Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: tripRouteListWidget(context),
        ):const SizedBox(),
      ],
    );
  }

  Widget tripRouteListWidget(BuildContext context) {
    
    int fields;
    return Container(
      
      child: Obx(() {
        
        return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds!.length,
        itemBuilder: (BuildContext context, int index1) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].routeId.name
                            .toString()
                        ),
                      ),
                    ),
                    Expanded(
                    flex: 3,
                    child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].startActualDate!=null ? Text(AppUtils.changeDateAndTimeFormat(
                controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].startActualDate)): const SizedBox(),
                        )),
                  ),
                   Expanded(
                    flex: 3,
                    child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Theme(
                          data: ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].endActualDate!=null ? Text(AppUtils.changeDateAndTimeFormat(
                controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].endActualDate)): const SizedBox()
                        )),
                  ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].fuelBalInputByDriver!=null ?Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child:  Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].fuelBalInputByDriver.toString()),
                    ),
                  ): const SizedBox(),
                  controller
                                  .plantrip_with_waybill_list[
                                      controller.arg_index.value]
                                  .routePlanIds![index1]
                                  .status !=
                              null
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: controller
                                    .plantrip_with_waybill_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='to_approve' ? Text("To Approve") : controller
                                    .plantrip_with_waybill_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='to_replace' ? Text("To Replace") : controller
                                    .plantrip_with_waybill_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='done' ? Text("Done") : controller
                                    .plantrip_with_waybill_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='running' ? Text("Running") : Text(controller
                                    .plantrip_with_waybill_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status),
                              ),
                            )
                          : SizedBox()
                  // controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].status!=null ?Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //     margin: const EdgeInsets.only(left: 5, right: 5),
                  //     child:  Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds![index1].status),
                  //   ),
                  // ): const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );}),
    );
  }

  Widget commisionContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels!.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Text(labels.commissionDriver,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),

                  Expanded(
                      flex: 2,
                      child: Text(labels.commissionSpare,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),

                  // Expanded(
                  //   flex: 2,
                  //   child: SizedBox()
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),

            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: productListWidget(context),
              ),
            ),
          ],
        )
    );
  }
  Widget wayBillContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels!.invoice,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.customer,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels!.date,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.state,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: wayBillListWidget(context),
              ),
            ),
          ],
        )
    );
  }
  Widget expenseContainer(BuildContext context){
    var labels = AppLocalizations.of(context);
    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5,top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 2,
                      child: Text(labels!.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 2,
                      child: Text(labels.routeExpense,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.stdAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.actualAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Text(labels.overAmt,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  isDriver==true||is_spare==true&&is_branch_manager==false?const Expanded(
                      //flex: 1,
                      child: SizedBox()
                  ): const SizedBox(),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?const Expanded(
                      //flex: 1,
                      child: SizedBox()
                  ):const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: expenseWidget(context),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalStdAmt),
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalActualAmt),
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(labels.totalOverAmt),
                    ),
                  ),
                  // Obx(()=>Text(AppUtils.addThousnadSperator(controller.expenseStandardAmount.value))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                children: [
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseStandardAmount.value)),
                    ),
                  )),
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseActualAmount.value)),
                    ),
                  )),
                  Obx(()=> Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.only(left:5.0),
                      child: Text(AppUtils.addThousnadSperator(controller.expenseOverAmount.value)),
                    ),
                  )),
                ],
              ),
            ),
          ],
        )
    );
  }
  dynamic fuelInBottomSheet(BuildContext context, WayBill_Fuelin_ids fuelinIds) {
    var labels = AppLocalizations.of(context);

    return  showModalBottomSheet(
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
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Column(
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
                            labels!.date,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(AppUtils.changeDateFormat(
                              fuelinIds.date)))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.shop,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelinIds.shop)))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.product,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelinIds.productId!.name.toString())))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.fromLocation,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: fuelinIds.location_id!=null?
                          Text(AppUtils.removeNullString(
                              fuelinIds.location_id!.name)):const Text(''))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.slipNo,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(AppUtils.removeNullString(
                              fuelinIds.slipNo)))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            "${labels.quantity}(${labels.liter})",
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelinIds.liter.toString())).toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.unitPrice,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelinIds.priceUnit.toString())).toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.amount,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(fuelinIds.amount.toString())).toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
  Widget fuelInContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels!.date,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.product,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(labels.quantity,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.unitPrice,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():const Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left:8.0),
                        child: Text(''),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: fuelInListWidget(context),
              ),
            ),
            (controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false)?
            Align(
              alignment:Alignment.topRight,
              child: FloatingActionButton(onPressed: (){
                Get.to(AddFuelWayBillPage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fromDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].toDatetime,null))!.then((value) {
                  if(value!=null){
                    DayTripPlanTripGeneralController generalController = Get.find();
                    setState(() {
                      controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds!.add(WayBill_Fuelin_ids(id:value,date: generalController.dateTextController.text,
                        shop: generalController.shopNameTextController.text,
                        productId: WayBill_Product_id(id:generalController.selectedProduct.id,name: generalController.selectedProduct.name),
                        slipNo: generalController.slipNoTextController.text,
                        liter: double.tryParse(generalController.qtyController.text)!,
                        priceUnit: double.tryParse(generalController.priceController.text)!,
                        amount: double.tryParse(generalController.totalFuelInAmtController.text)!,
                        location_id: Location_id(id:generalController.selectedLocation.id,name: generalController.selectedLocation.name)),
                    );
                    });
                    
                  }
                });
              },
                mini: true,
                child: const Icon(Icons.add),

              ),
            ):Container(),
          ],
        )
    );
  }
  dynamic advanceBottomSheet(BuildContext context, WayBill_Request_allowance_lines advanceIds) {
    var labels = AppLocalizations.of(context);

    return showModalBottomSheet(
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
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Column(
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
                            labels!.expenseCategory,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              advanceIds.expenseCategId!.name.toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.quantity,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(
                              advanceIds.quantity.toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              labels.amount,
                              style:
                              pmstitleStyle())),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(advanceIds.amount.toString())).toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.totalAmount,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              NumberFormat('#,###').format(double.tryParse(advanceIds.totalAmount.toString())).toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            labels.remark,
                            style: pmstitleStyle(),
                          )),
                      Expanded(
                          child: Text(
                              advanceIds.remark.toString()))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
        ));
  }
  Widget advanceContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 2,
                      child: Text(labels!.expenseCategory,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.quantity,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),

                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.amount,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Text(labels.remark,style: TextStyle(color: backgroundIconColor,fontSize:
                        11),),
                      )),

                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():const Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  const Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),

            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: advnaceListWidget(context),
              ),
            ),
            controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='submit'||controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'&&isDriver==true||is_spare==true &&
                is_branch_manager == false?
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(onPressed: (){
                var itemAdvanceTotal = 0.0;
                for (var element in controller.plantrip_with_waybill_list[controller.arg_index.value].requestAllowanceLines!) {
                  itemAdvanceTotal += element.totalAmount;
                }
                Get.to(AddAdvancePage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list[controller.arg_index.value].totalAdvance,itemAdvanceTotal))!.then((value){
                  // controller.getPlantripWithWayBillList(controller.current_page.value);
                  if(value!=null){
                    DayTripPlanTripGeneralController dayTripController = Get.find();
                    // controller.waybill_advance_allowance_ids_list.add();
                    controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines!.add(WayBill_Request_allowance_lines(id:value,expenseCategId: WayBill_Expense_categ_id(id:dayTripController.selectedExpenseCategory.id,name: dayTripController.selectedExpenseCategory.displayName),quantity: double.tryParse(dayTripController.quantityTextController.text)!,amount: double.tryParse(dayTripController.amountTextController.text)!,totalAmount: double.tryParse(dayTripController.totalAmountController.text)!,remark: dayTripController.remarkTextController.text));
                  }
                });
              },
                mini: true,
                child: const Icon(Icons.add),

              ),
            ):Container(),
          ],
        )
    );
  }
  Widget fuelConsumptionContainer(BuildContext context){
    var labels = AppLocalizations.of(context);

    return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex : 1,
                      child: Text(labels!.route,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 1,
                      child: Text(labels.stdLit,style: TextStyle(color: backgroundIconColor,fontSize: 11),)),
                  Expanded(
                      flex : 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.actualLit,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  Expanded(
                      flex : 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(labels.description,style: TextStyle(color: backgroundIconColor,fontSize: 11),),
                      )),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='close'&&is_branch_manager==true?const SizedBox(): const Expanded(
                      flex: 1,
                      child: SizedBox()
                  ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?const Expanded(
                      flex: 1,
                      child: SizedBox()
                  ):const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 0,left: 0),
              child: Divider(height: 1,thickness: 1,color: backgroundIconColor,),
            ),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top:10),
                child: fuelConsumptionsListWidget(context),
              ),
            ),
            // (controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
            // Align(
            //   alignment: Alignment.topRight,
            //   child: FloatingActionButton(onPressed: (){
            //     showFuelAddDialog(0,null);
            //   },
            //     mini: true,
            //     child: Icon(Icons.add),
            //   ),
            // ):new Container(),
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    //DayTripModel dayTripModel = Get.arguments;
    if(Get.arguments!=null){
      print("Arguments##");

    }

    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    controller.plantrip_waybill_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].id;
    double width = MediaQuery.of(context).size.width;
    double customWidth = width * 0.30;
    // var fromDate = controller.plantrip_with_waybill_list[controller.arg_index.value].fromDatetime;
    var fromDate = DateTime.parse(controller.plantrip_with_waybill_list[controller.arg_index.value].fromDatetime)
          .add(Duration(hours: 6, minutes: 30))
          .toString()
          .replaceAll('.000', '');
    to_date =  AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_waybill_list[controller.arg_index.value].toDatetime);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(labels!.pantripWaybill),
      //   actions: const [
      //   ],
      // ),
      appBar:PreferredSize(preferredSize: Size.fromHeight(60),child:  appbar(context, labels!.pantripWaybill, ""),),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: const EdgeInsets.only(right: 65),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  )
              ),
              Obx(()=> controller.showDetails.value?Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_circle_up_sharp),
                      onPressed: () {
                        controller.showDetails.value = false;
                      },
                    ),
                  ):
                  Expanded(
                    flex:1,
                    child: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_circle_down_sharp),
                      onPressed: () {
                        controller.showDetails.value = true;
                      },
                    ),
                  ),),
              ],
              ),
          ),
          Obx(()=>controller.plantrip_with_waybill_list.isNotEmpty ? controller.showDetails.value?  Column(
              children: [
                Container(
                  margin:const EdgeInsets.only(right:60),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(labels.code,style: maintitlenoBoldStyle(),),
                      AutoSizeText(controller.plantrip_with_waybill_list.value[controller.arg_index.value].code,style: maintitleStyle(),)
                    ],),
                ),
                const SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.fromDate,style: maintitlenoBoldStyle(),),
                      const SizedBox(height: 5,),
                      AutoSizeText(fromDate,style: maintitleStyle(),)
                    ],)),
                  const SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.toDate,style: maintitlenoBoldStyle(),),
                      const SizedBox(height: 5,),
                      AutoSizeText(DateTime.parse(controller.plantrip_with_waybill_list[controller.arg_index.value].toDatetime)
          .add(Duration(hours: 6, minutes: 30))
          .toString()
          .replaceAll('.000', ''),style: maintitleStyle(),)
                    ],)),
                ],),
                const SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.vehicle,style: maintitlenoBoldStyle(),),
                      const SizedBox(height:5),
                      AutoSizeText(controller.plantrip_with_waybill_list.value[controller.arg_index.value].vehicleId!.name,style: maintitleStyle(),)
                    ],)),
                  const SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.driver,style: maintitlenoBoldStyle(),),
                      const SizedBox(height:5),
                      AutoSizeText(controller.plantrip_with_waybill_list.value[controller.arg_index.value].driverId!.name,style: maintitleStyle(),)
                    ],)),
                ],),
                const SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.spare,style: maintitlenoBoldStyle(),),
                      const SizedBox(height:5),
                      AutoSizeText(controller.plantrip_with_waybill_list.value[controller.arg_index.value].spareId!.name,style: maintitleStyle(),)
                    ],)),
                  const SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(labels.trailer,style: maintitlenoBoldStyle(),),
                      const SizedBox(height:5),
                      AutoSizeText(controller.plantrip_with_waybill_list.value[controller.arg_index.value].trailerId!.name,style: maintitleStyle(),)
                    ],)),
                ],),
                const SizedBox(height: 10,),
                Row(children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText('${labels.advanceAmount} :',style: maintitlenoBoldStyle(),),
                      AutoSizeText(AppUtils.addThousnadSperator(controller.plantrip_with_waybill_list.value[controller.arg_index.value].totalAdvance),style: maintitleStyle(),)
                    ],)),
                  const SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText('${labels.expenseStatus} :',style: maintitlenoBoldStyle(),),
                      Obx(()=>AutoSizeText(AppUtils.removeNullString(controller.expense_status.value),style: maintitleStyle(),))
                    ],)),
                ],),
                //Divider(thickness: 1,),
                const SizedBox(height:10),
                controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'running' ?routeContainer(context): const SizedBox(),
              ],
            ):const SizedBox() : const SizedBox()),
            
            controller.plantrip_with_waybill_list.value.isNotEmpty ?Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: controller.plantrip_with_waybill_list[controller.arg_index.value].state=='open'?
              TabBar(isScrollable: true,
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  Tab(
                    text: labels.advance,
                  ),
                ],
              ): controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'?TabBar(
                controller: _tabController,
                isScrollable: true,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.expense,
                  ),
                  Tab(
                    text: labels.fuelIn,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  // Tab(
                  //   text: labels.fuelConsumption,
                  // ),
                ],
              ):TabBar(isScrollable: true,
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: backgroundIconColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // Tab(
                  //   text: 'Route',
                  // ),
                  Tab(
                    text: labels.wayBill,
                  ),
                  Tab(
                    text: labels.expense,
                  ),
                  Tab(
                    text: labels.fuelIn,
                  ),
                  Tab(
                    text: labels.commission,
                  ),
                  Tab(
                    text: labels.advance,
                  ),
                  // Tab(
                  //   text: labels.fuelConsumption,
                  // ),
                ],
              ),
            ):const SizedBox(),
            controller.plantrip_with_waybill_list.value.isNotEmpty ?SizedBox(
              height: 300,
              child: controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='open'?
              TabBarView(
                controller: _tabController,
                children: [
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Add Commission
                  commisionContainer(context),
                  //Advance
                  advanceContainer(context),
                ],
              ) :  controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'?
              TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Expense
                  expenseContainer(context),
                  //Add Fuel
                  fuelInContainer(context),
                  //Commission
                  commisionContainer(context),
                  //fuel Consumption
                  // fuelConsumptionContainer(context),
            
                ],
              ): TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  //Add Route
                  //routeContainer(),
                  //Add Way Bill
                  wayBillContainer(context),
                  //Expense
                  expenseContainer(context),
                  //Fuel In
                  fuelInContainer(context),
                  //Commission
                  commisionContainer(context),
                  //Advance
                  advanceContainer(context),
                  //fuel consumption
                  // fuelConsumptionContainer(context),
            
                ],
              ),
            ):const SizedBox(),
            controller.plantrip_with_waybill_list.value.isNotEmpty && controller.plantrip_with_waybill_list.value[controller.arg_index.value].state == 'advance_withdraw'  && isStart ?
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.clickstartPlanTripWayBill(controller.plantrip_with_waybill_list.value[controller.arg_index.value].id);
                },
                text: 'Start Trip',
                blockButton: true,
                size: GFSize.LARGE,
              ),
            )
                : const SizedBox(),
            controller.plantrip_with_waybill_list.value.isNotEmpty ? 
            controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='running'?
            isEnd?
            Padding(
              padding: const EdgeInsets.only(left:15.0,bottom: 15),
              child: GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.clickendPlanTripWayBill(controller.plantrip_with_waybill_list.value[controller.arg_index.value].id);
                },
                text: 'End Trip',
                blockButton: true,
                size: GFSize.LARGE,
              ),
            ):const SizedBox():controller.plantrip_with_waybill_list.value[controller.arg_index.value].state=='submit'?
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,bottom: 15),
                    child: GFButton(
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.approvePlanTripWayBill();
                      },
                      text: labels.approve,
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0,bottom: 15),
                    child: GFButton(
                      type: GFButtonType.outline,
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.declinePlanTripWayBill();
                      },
                      text: labels.sendBack,
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  ),
                ),
              ],
            )
                :Container(): const SizedBox(),
            const SizedBox(height: 20,),
        ],
      ),
      
    ),
    );
  }
  Widget expenseWidget(BuildContext context) {
    int fields;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds!.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].eRouteId!.name
                            .toString(),style: const TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].routeExpenseId!.name
                            .toString(),style: const TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].standardAmount.toString())).toString(),style: const TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].actualAmount.toString())).toString(),style: const TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      //flex: 1,
                      child: Container(
                        // width: 80,
                          child: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].overAmount!=null?
                          Align(
                            alignment:Alignment.topRight,
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index].overAmount.toString())).toString(),style: const TextStyle(fontSize: 11)),
                          ):const Text('')
                      ),
                    ),
                  controller.plantrip_with_waybill_list[controller.arg_index.value].state=="expense_claim"|| controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const Expanded(flex:1,child: SizedBox()):isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                        //flex:1,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteWayBillExpenseLine(controller.plantrip_with_waybill_list[controller.arg_index.value].expenseIds![index]);
                          },
                        )):const SizedBox(),
                    controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false?
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: InkWell(
                          onTap: (){
                            Get.to(const ExpenseCreate(),arguments: controller.plantrip_with_waybill_list.value[controller.arg_index.value].expenseIds![index])!.then((value){
                              if(value!=null){
                                controller.getPlantripWithWayBillList(controller.current_page.value);
                              }
                            });
                          },
                          child: Container(
                            // width: 80,
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Color.fromRGBO(60, 47, 126, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ): const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),),
    );

  }
  Widget routeListWidget(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    int fields;
    bool firstRoute = false;
    print(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds);
    return Container(
      
      child: Obx(() {
        plantrip_waybill_list_lines = [];
        next_route_id = 0;
        previous_route_id = 0;
          for(var i=0; i< controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds!.length; i++){
            if(i == 0 && (controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == '' || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == null)){
              firstRoute = true;
            }else{
              firstRoute = false;
            }
            if((controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == '' || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == null || controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == 'running') || (((controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds!.length-1) == i) && controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].status == 'end')){
              // plantrip_waybill_list_lines.add(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i]);
              if(controller.plantrip_with_waybill_list
                    .value[controller.arg_index.value].routePlanIds!.length>0){
                int index = controller.plantrip_with_waybill_list
                    .value[controller.arg_index.value].routePlanIds!.indexWhere((item) => item.status == 'to_approve');
                if (index == -1) {
                  plantrip_waybill_list_lines.add(controller
                                          .plantrip_with_waybill_list
                                          .value[controller.arg_index.value]
                                          .routePlanIds?[i]);
                } else {
                  print('Item not found');
                }
                // if(controller.plantrip_with_product_list
                //     .value[controller.arg_index.value].routePlanIds![(i+1)-1].status != 'to_approve'){
                //       plantrip_product_list_lines.add(controller
                //                                             .plantrip_with_product_list
                //                                             .value[controller.arg_index.value]
                //                                             .routePlanIds?[i]);
                // }
              }
              if(i != controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds!.length-1){
                  next_route_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i+1].id;
              }
              break;
            }
        }
        
        return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: plantrip_waybill_list_lines.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        // child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].routeId.name
                        //     .toString()
                        // ),
                        child: Text(plantrip_waybill_list_lines[index].routeId.name
                            .toString()
                        ),
                      ),
                    ),
                  //   Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(left: 10, right: 10),
                  //       child: Theme(
                  //         data: new ThemeData(
                  //           primaryColor: textFieldTapColor,
                  //         ),
                  //         child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].startActualDate!=null ? Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].startActualDate): SizedBox(),
                  //       )),
                  // ),
                  //  Expanded(
                  //   child: Container(
                  //       margin: EdgeInsets.only(right: 10),
                  //       child: Theme(
                  //         data: new ThemeData(
                  //           primaryColor: textFieldTapColor,
                  //         ),
                  //         child: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].endActualDate!=null ? Text(controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index].endActualDate): SizedBox(),
                  //       )),
                  // ),
                  // (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='open'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='advance_request'&&isDriver==true) || (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='advance_withdraw'&&isDriver==true)? Expanded(
                  //     flex: 1,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left:12.0),
                  //       child: InkWell(
                  //         onTap: (){
                  //           Get.toNamed(Routes.CREATEROUTEDATEWAYBILL,arguments: controller.plantrip_with_waybill_list[controller.arg_index.value].routePlanIds[index]).then((value){
                  //             if(value!=null){
                  //               controller.getPlantripWithWayBillList(controller.current_page.value);
                  //             }
                  //           });
                  //         },
                  //         child: Container(
                  //           child: Icon(
                  //             Icons.edit,
                  //             size: 20,
                  //             color: Color.fromRGBO(60, 47, 126, 0.5),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ): new Container(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: plantrip_waybill_list_lines[index].status!=null && plantrip_waybill_list_lines[index].status!='' ? Text(plantrip_waybill_list_lines[index].status): const SizedBox(),
                    ),
                  ),
                  plantrip_waybill_list_lines[index].status == '' || plantrip_waybill_list_lines[index].status == null || plantrip_waybill_list_lines[index].status=='running' ? Expanded(child: SizedBox(
                    width: 50,
                    child: GFButton(
                      onPressed: () {
                        if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds!.length > 1){
                          for(var i=0; i< controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds!.length; i++){
                            if(i!=0){
                                if(plantrip_waybill_list_lines[index].id == controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i].id){
                                  previous_route_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds![i-1].id;break;
                                }
                            }
                          }
                        }
                        plantrip_waybill_list_lines[index].status == 'running' ?
                        showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  controller.remainingFuelController.clear();
                                  return AlertDialog(
                                    scrollable: true,
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0, top: 8.0),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text('Please Enter Remaining Fuel (Liters)'),
                                              const SizedBox(height: 10,),
                                              TextFormField(
                                                keyboardType: TextInputType.number,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (text) {
                                                  // setState(() {});
                                                },
                                                validator: (text) {
                                                  if (text == null || text.isEmpty) {
                                                    return 'Remaining Fuel is empty';
                                                  }else if(text.isNotEmpty && double.parse(text) <=0 ){
                                                    return 'Please Enter Remaining Fuel > 0';
                                                  }
                                                  return null;
                                                },
                                                controller: controller.remainingFuelController,
                                              ),
                                              const SizedBox(height: 10,),
                                              const Text('Please Enter Route End Date'),
                                              const SizedBox(height: 10),
                                              dateWidget(context),
                                              SizedBox(
                                                                height: 10,
                                                              ),
                                              Container(
                                                                width: 125,
                                                                height: 40,
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    getMultipleFile(
                                                                        context);
                                                                  },
                                                                  style:
                                                                      ElevatedButton
                                                                          .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    side: BorderSide(
                                                                        width: 1.0,
                                                                        color:
                                                                            textFieldTapColor),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        // <-- Icon
                                                                        Icons
                                                                            .attach_file,
                                                                        size: 24.0,
                                                                        color:
                                                                            textFieldTapColor,
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Text('Upload',
                                                                          style: TextStyle(
                                                                              color:
                                                                                  textFieldTapColor,
                                                                              fontWeight:
                                                                                  FontWeight.bold)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(height: 10),
                                                              Obx(() => controller
                                                                              .isShowAttachment
                                                                              .value ==
                                                                          true &&
                                                                      controller
                                                                          .imageList
                                                                          .value
                                                                          .isNotEmpty
                                                                  ? SizedBox(
                                                                      height: 150,
                                                                      child: GridView
                                                                          .builder(
                                                                        itemCount: controller
                                                                            .imageList
                                                                            .value
                                                                            .length,
                                                                        gridDelegate:
                                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                                crossAxisCount: 3),
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          if (index <
                                                                              controller.imageList.value.length) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
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
                                                                                    right: 15,
                                                                                    child: GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          nullRoutePhoto(index);
                                                                                        });
                                                                                      },
                                                                                      child: Icon(Icons.close, color: Colors.red),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            int cameraIndex =
                                                                                index - controller.imageList.value.length;
                                                                            return Stack(
                                                                              children: [
                                                                                Image.file(
                                                                                  File(controller.imageList.value[index].path!),
                                                                                  fit: BoxFit.cover,
                                                                                  width: 100,
                                                                                  height: 100,
                                                                                ),
                                                                                Positioned(
                                                                                  top: 0,
                                                                                  right: 15,
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        nullRoutePhoto(index);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.close, color: Colors.red),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    )
                                                                  : SizedBox())
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right:8.0),
                                              child: ElevatedButton(
                                                  child: const Text("Cancel",style: TextStyle(color: Colors.red),),
                                                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(
                                                      255, 255, 255, 1.0)),
                                                  onPressed: () {
                                                    controller.imageList.value = [];
                                                                          controller
                                                                            .isShowAttachment
                                                                            .value = false;
                                                                            controller
                                                                  .remainingFuelPTPController.text = '';
                                                                  controller.routeEndDateTextController.text = '';
                                                    Get.back();
                                                  }),
                                            ),
                                          ),
                                          const SizedBox(width: 10,),
                                          Center(
                                            child: ElevatedButton(
                                                child: const Text("Update",style: TextStyle(color: Colors.white)),
                                                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(
                                                    60, 47, 126, 1),),
                                                onPressed: () {
                                                  if (formKey.currentState!.validate()) {
                                                  controller.clickWayBillRouteLine(firstRoute, controller.plantrip_with_waybill_list.value[controller.arg_index.value].id, plantrip_waybill_list_lines[index].id,next_route_id,previous_route_id,controller.remainingFuelController.text,controller.routeEndDateWTextController.text).then((value){
                                                    
                                                    if(value!=0){
                                                      Get.back();
                                                      controller.remainingFuelController.text = "";
                                                      controller.routeEndDateWTextController.text = "";
                                                      controller.getPlantripWithWayBillList(controller.current_page.value);
                                                    }
                                                  });
                                                  }
                                                }),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }).then((value){
                              // daytrip_controller.getDayTripList(daytrip_controller.current_page.value);
                            }) : controller.clickWayBillRouteStartLine(firstRoute, controller.plantrip_with_waybill_list.value[controller.arg_index.value].id, plantrip_waybill_list_lines[index].id,next_route_id,previous_route_id,'0','').then((value){
                                                    if(value!=0){
                                                      controller.getPlantripWithWayBillList(controller.current_page.value);
                                                    }
                                                  });


                        // if(controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length > 1){
                        //   for(var i=0; i< controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds.length; i++){
                        //     if(i!=0){
                        //         if(plantrip_waybill_list_lines[index].id == controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i].id){
                        //           previous_route_id = controller.plantrip_with_waybill_list.value[controller.arg_index.value].routePlanIds[i-1].id;break;
                        //         }
                        //     }
                        //   }
                        // }
                        // controller.clickWayBillRouteLine(first_route, controller.plantrip_with_waybill_list.value[controller.arg_index.value].id, plantrip_waybill_list_lines[index].id,next_route_id,previous_route_id).then((value){
                        //   if(value!=0){
                        //     controller.getPlantripWithWayBillList(controller.current_page.value);
                        //   }
                        // });
                      },
                      type: GFButtonType.outline,
                      text: plantrip_waybill_list_lines[index].status == '' || plantrip_waybill_list_lines[index].status == null ? 'Start' : plantrip_waybill_list_lines[index].status == 'running' ? 'End' : '',
                      textColor: textFieldTapColor,
                      blockButton: true,
                      size: GFSize.SMALL,
                      color: textFieldTapColor,
                    ),),):const SizedBox(),
                  (plantrip_waybill_list_lines[index].status == 'end' && index == plantrip_waybill_list_lines.length-1) ? Expanded(child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text('Done')
                  ),):const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      );}),
    );
  }

  nullRoutePhoto(int index) {
    setState(() {
      controller.imageList.value.removeAt(index);
      controller.image_base64_wroute_list.removeAt(index);
      controller.imageList.refresh();
    });
  }

  getMultipleFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    var data = [];
    if (result!.files.isNotEmpty) {
      for (var i = 0; i < result.files.length; i++) {
        data.add(result.files[i].name);
      }
    }
    setState(() {
      controller.isShowAttachment.value = true;
      for (var i = 0; i < result.files.length; i++) {
        controller.imageList.value.add(result.files[i]);
        setImageList(result.files[i].path!, result.files[i].name);
      }
      controller.imageList.refresh();
    });
  }

  setImageList(String filePath, String fileName) async {
    File image = File(filePath);
    //File compressedFile = await AppUtils.reduceImageFileSize(image);
    final bytes = Io.File(image.path).readAsBytesSync();
    img64_route = base64Encode(bytes);
    controller.setCameraWRouteImage(image, img64_route, fileName);
  }

  Widget dateWidget(BuildContext context) {
    TextEditingController endDateController;
    endDateController = controller.routeEndDateWTextController;
    final labels = AppLocalizations.of(context);
    final format = DateFormat("yyyy-MM-dd HH:mm:ss");
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(children: <Widget>[
        // Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
          validator: (text) {
            if (text == null) {
              return 'Route End Date is empty';
            }
            return null;
          },
          controller: endDateController,
          decoration: const InputDecoration(
            hintText: "Route End Date",
            border: OutlineInputBorder(),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1988),
                lastDate: DateTime.now(),
                );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              var dateTime =
                  DateTimeField.combine(date, time).toString().split('.000')[0];

              controller.routeEndDateWTextController.text = dateTime.toString();
              routeEndselectedDate = DateTime.parse(dateTime);

              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ]),
    );
  }

  Widget fuelConsumptionsListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>controller.plantrip_with_waybill_list.isNotEmpty ?ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds!.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].routeId!.name
                            .toString(),style: const TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].standardLiter.toString())).toString(),style: const TextStyle(fontSize: 11)),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                          child: Text(
                              NumberFormat('#,###.##').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].consumedLiter.toString())).toString(),style: const TextStyle(fontSize: 11))
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(AppUtils.removeNullString(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].description)
                            ,style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():(controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && isDriver==true||is_spare==true&&is_branch_manager==false)?
                    Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deletePlantripWaybillConsumptionLine(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].id,controller.plantrip_with_waybill_list[controller.arg_index.value].id);
                          },
                        )):const SizedBox(),
                    (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running'&&isDriver==true||is_spare==true&&is_branch_manager==false)? Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: InkWell(
                          onTap: (){
                            showFuelAddDialog(controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index].id,controller.plantrip_with_waybill_list[controller.arg_index.value].consumptionIds![index]);
                          },
                          child: Container(
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Color.fromRGBO(60, 47, 126, 0.5),
                            ),
                          ),
                        ),
                      ),
                    ): Container(),

                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ):const SizedBox()),
    );
  }
  Widget wayBillListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>controller.plantrip_with_waybill_list.isNotEmpty ?ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds!.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].accountMoveId!.name==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].accountMoveId!.name
                            .toString(),style: const TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].partnerId!.name==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].partnerId!.name.toString(),style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        padding: const EdgeInsets.only(left:5),
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].date==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].date
                            .toString(),style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Container(
                          // width: 80,
                            child: controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].amount==null?const Text(''):
                            Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].amount.toString())).toString(),style: const TextStyle(fontSize: 11))
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].state==null?"":controller.plantrip_with_waybill_list[controller.arg_index.value].waybillIds![index].state
                            .toString(),style: const TextStyle(fontSize: 11)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ):const SizedBox()),
    );
  }
  Widget fuelInListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds!.length,
        itemBuilder: (BuildContext context, int index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  fuelInBottomSheet(context, controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index]);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child: Text(AppUtils.changeDateFormat(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].date
                          ),style: const TextStyle(fontSize: 11)
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].productId == null ? "":controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].productId!.name
                                .toString(),style: const TextStyle(fontSize: 11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].liter.toString())).toString(),style: const TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].priceUnit.toString())).toString(),style: const TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].amount.toString())).toString(),style: const TextStyle(fontSize: 11)),
                            )
                        ),
                      ),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():
                      (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].add_from_office==null&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
                      Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(AddFuelWayBillPage("PLanTripWaybill",controller.plantrip_waybill_id,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fromDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].toDatetime,controller.plantrip_with_waybill_list.value[controller.arg_index.value].fuelinIds![index]))!.then((value) {
                                if(value!=null){
                                  setState(() {
                                    controller.getPlantripWithWayBillList(controller.current_page.value);
                                  });
                                  
                                }
                              });
                            },
                          )):const Expanded(flex:1,child: SizedBox()),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():
                      (controller.plantrip_with_waybill_list[controller.arg_index.value].state=='running' && controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].add_from_office==null&&(isDriver==true||is_spare==true)&&is_branch_manager==false)?
                      Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteFuelInLineForPlantripWaybill(controller.plantrip_with_waybill_list[controller.arg_index.value].fuelinIds![index].id);
                            },
                          )):const Expanded(flex:1,child: SizedBox()),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child:   IconButton(
                            icon: Icon(
                              Icons.arrow_circle_up,
                              size: 25,
                            ), onPressed: () {  },),
                        ),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }

  Widget productListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds!.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds![index].routeId!.name
                            .toString(),style: const TextStyle(fontSize: 11)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds![index].commissionDriver
                              .toString(),style: const TextStyle(fontSize: 11)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].commissionIds![index].commissionSpare
                              .toString(),style: const TextStyle(fontSize: 11)),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }

  Widget advnaceListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(()=>ListView.builder(
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemCount: controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines!.length,
        itemBuilder: (BuildContext context, int index) {
          //fields = controller.travelLineModel.length;
          //create dynamic destination textfield controller
          // remark_controllers = List.generate(
          //     fields,
          //     (index) => TextEditingController(
          //         text: controller.outofpocketList[index].display_name
          //             .toString()));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  advanceBottomSheet(context, controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines![index]);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines![index].expenseCategId!.name
                              .toString(),style: const TextStyle(fontSize: 11)
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(padding: const EdgeInsets.only(left:6.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines![index].quantity.toString())).toString(),style: const TextStyle(fontSize: 11))
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            padding: const EdgeInsets.only(left:6.0),
                            child: Text(
                                NumberFormat('#,###').format(double.tryParse(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines![index].amount.toString())).toString(),style: const TextStyle(fontSize: 11))
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     // width: 80,
                      //     child: Text(controller.advance_allowance_ids_list[index].totalAmount
                      //         .toString()),
                      //   ),
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          // width: 80,
                          child: Text(controller.plantrip_with_waybill_list.value[controller.arg_index.value].requestAllowanceLines![index].remark
                              .toString(),style: const TextStyle(fontSize: 11)),
                        ),
                      ),
                      controller.plantrip_with_waybill_list[controller.arg_index.value].state=="expense_claim"|| controller.plantrip_with_waybill_list[controller.arg_index.value].state=="close"?const SizedBox():isDriver==true||is_spare==true&&is_branch_manager==false?Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteWayBillAdvanceLine(controller.plantrip_with_waybill_list[controller.arg_index.value].requestAllowanceLines![index].id);
                            },
                          )):const SizedBox(),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child:   IconButton(
                            icon: Icon(
                              Icons.arrow_circle_up,
                              size: 25,
                            ), onPressed: () {  },),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      )),
    );
  }
  Widget routeDropDown() {
    print('routedropdown');
    print(controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds!.length);
    var consumptionId = controller.plantrip_with_waybill_list.value[controller.arg_index.value].consumptionIds;
    if(consumptionId!.isNotEmpty){
      controller.selectedWayBillRoute = consumptionId[0];
    }

    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  // Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: ThemeData(
                    primaryColor: const Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: const Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<BaseRoute>(
                          hint: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                "Choose Route",
                              )),
                          value: controller.selectedBaseRoute,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (BaseRoute ? value) {
                            controller.onChangeWayBillRouteDropdown(value!);
                          },
                          items: controller.base_route_list
                              .map((BaseRoute route) {
                            return DropdownMenuItem<BaseRoute>(
                              value: route,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  route.name,
                                  style: const TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFuelAddDialog(int lineID,Consumption_ids consumption) {
    controller.selectedBaseRoute = BaseRoute(id:consumption.routeId!.id,name:consumption.routeId!.name,fuel_liter: consumption.standardLiter);
    controller.actualAmountTextController.text = consumption.consumedLiter.toString();
    controller.descriptionTextController.text = consumption.description;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // controller
          //     .actualAmountTextController.clear();
          // controller
          //     .descriptionTextController.clear();
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none, children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Fuel Consumption',style: TextStyle(color: backgroundIconColor,fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: routeDropDown(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Row(
                          children: [
                            Expanded(flex:2,child: Text('Standard Consumption : ',style: TextStyle(color: backgroundIconColor),)),
                            Obx(()=>Expanded(flex:1,child:controller.show_standard_liter.value?Text("${controller.selectedBaseRoute.fuel_liter}Liter",style: TextStyle(color: backgroundIconColor),):const Text(''))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    top: 15),
                                child: Theme(
                                  data: ThemeData(
                                    primaryColor:
                                    textFieldTapColor,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: controller
                                        .actualAmountTextController,
                                    decoration:
                                    const InputDecoration(
                                      border:
                                      OutlineInputBorder(),
                                      hintText: "Actual Fuel Consumption(Liter)",
                                    ),
                                    onChanged:
                                        (text) {

                                    },
                                  ),
                                )),
                          ),

                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:20.0),
                        child: Container(
                          child: TextField(
                            controller: controller
                                .descriptionTextController,
                            enabled: true,
                            style: const TextStyle(
                                color: Colors.black
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: (("Description")),
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0),
                        child: GFButton(
                          onPressed: () {
                            controller.addPlanTripWillbillFuelConsumption(controller.plantrip_with_waybill_list.value[controller.arg_index.value],lineID);
                          },
                          text: "Save",
                          blockButton: true,
                          size: GFSize.LARGE,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).then((value) {
      if(value!=null){
        controller.getPlantripWithWayBillList(controller.current_page.value);
      }

    });
  }
}

class ExpenseCreate extends StatefulWidget {
  const ExpenseCreate({super.key});

  @override
  _ExpenseCreateState createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final PlanTripController controller = Get.find();
  var box = GetStorage();

  String image= '';
  String img64= '';
  List<TravelLineListModel> datalist = [];
  DateTime selectedFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File ? imageFile ;
  String ? expenseValue;
  Uint8List ? bytes;
  WayBill_Expense_ids ? arguments;
  bool show_image_container = true;

  Widget  routeExpenseDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // color: Colors.white,
              // height: 50,
              // margin: EdgeInsets.only(right: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  // Border.all(color: Colors.white, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: ThemeData(
                    primaryColor: const Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: const Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<WayBill_Expense_ids>(
                          hint: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                "Expense Category",
                              )),
                          value: controller.selectedWayBillExpenseRouteCategory,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (WayBill_Expense_ids ? value) {
                            controller.onChangeWayBillRouteExpenseDropdown(value!);
                          },
                          items: controller.waybill_expense_list
                              .map((WayBill_Expense_ids category) {
                            return DropdownMenuItem<WayBill_Expense_ids>(
                              value: category,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  category.routeExpenseId!.name,
                                  style: const TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar:PreferredSize(preferredSize: Size.fromHeight(60),child:  appbar(context, "Plan Trip WayBill Expense Form", image),),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(controller.routeName,style: const TextStyle(fontSize : 15,fontWeight: FontWeight.w500))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: routeExpenseDropDown()),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 10.0),
                    child: Row(
                      children: [
                        Expanded(flex:1,child: Text('Standard Amount : ',style: TextStyle(color: backgroundIconColor),)),
                        Obx(()=>Expanded(flex:1,child:Text(controller.show_standard_amount.value?controller.selectedWayBillExpenseRouteCategory.standardAmount!=null?AppUtils.addThousnadSperator(controller.selectedWayBillExpenseRouteCategory.standardAmount):'':'',style: TextStyle(color: backgroundIconColor),))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.wayBillexpenseActualTextController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "${labels?.actual} ${labels?.amount}",
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          controller: controller.wayBillexpenseDescriptionTextController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description'
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  show_image_container?Obx(()=>InkWell(
                    onTap: (){
                      showOptions(context);
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Column(
                          children: [
                            const Text('Add Image'),
                            controller.isShowImage.value==false?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 80,
                                  height: 80,
                                  padding: const EdgeInsets.all(10),
                                  decoration:
                                  const BoxDecoration(color: Colors.grey),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ):
                            Padding(
                              padding: const EdgeInsets.only(left:10.0),
                              child: Image.memory(bytes!,width: 100,height: 100,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )):const SizedBox(),

                ],
              ),
              const SizedBox(height: 30,),
              GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.saveExpense("waybill",arguments!.id,controller.plantrip_with_waybill_list.value[controller.arg_index.value].id);
                },
                text: "Save",
                blockButton: true,
                size: GFSize.LARGE,
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    arguments = Get.arguments;
    // controller.isShowImage.value = true;
     if (arguments!.attachement != null && arguments!.attachement!="") {
      controller.isShowImage.value = true;
      bytes = base64Decode(arguments!.attachement);
    } else {
      controller.isShowImage.value = false;
    }
    controller.selectedExpensePlanTripWayBillImage = arguments!.attachement;
    bytes = base64Decode(arguments!.attachement);
      controller.wayBillexpenseActualTextController.text = arguments!.actualAmount.toString();
    //controller.wayBillexpenseRouteController.text = arguments.eRouteId.name.toString();
    controller.routeName = arguments!.eRouteId!.name.toString();
    controller.wayBillexpenseDescriptionTextController.text = arguments!.description;
    findDropDownValue(arguments!.routeExpenseId!.id);

    super.initState();
  }
  void findDropDownValue(int expenseID) {
    bool found = false;
    for(int i=0;i<controller.waybill_expense_list.value.length;i++){
      if(controller.waybill_expense_list.value[i].routeExpenseId!.id==expenseID){
        found = true;
        controller.selectedWayBillExpenseRouteCategory = controller.waybill_expense_list.value[i];
        break;
      }
    }
  }
  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getCamera();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        const Icon(
                          FontAwesomeIcons.camera,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: const Text("Camera")),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    getImage();
                    Get.back();
                  },
                  child: Container(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: const Text("Gallery")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null){
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
      controller.setCameraImageFromWayBill(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }

  }
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
      controller.setCameraImageFromWayBill(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }

  }
}

