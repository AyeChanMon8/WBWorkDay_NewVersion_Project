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
import 'package:path_provider/path_provider.dart';
import 'package:winbrother_hr_app/controllers/daytrip_plantrip_fuel_advance_controller.dart';
import 'package:winbrother_hr_app/controllers/plan_trip_controller.dart';
import 'package:winbrother_hr_app/models/base_route.dart';
import 'package:winbrother_hr_app/models/plan_trip_product.dart';
import 'package:winbrother_hr_app/models/stock_location.dart';
import 'package:winbrother_hr_app/models/travel_expense/list/travel_line_list_model.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/add_advance_page.dart';
import 'package:winbrother_hr_app/pages/add_fuel_page.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';

class PlanTripDetails extends StatefulWidget {
  @override
  _PlanTripDetailsState createState() => _PlanTripDetailsState();
}

class _PlanTripDetailsState extends State<PlanTripDetails>
    with SingleTickerProviderStateMixin {
  final PlanTripController controller = Get.put(PlanTripController());
  var box = GetStorage();
  String image = "";
  int groupValue = 0;
  TabController? _tabController;
  var arg_index;
  var isDriver = false;
  var is_spare = false;
  var is_branch_manager = false;
  var plantrip_product_list_lines = [];
  var next_route_id = 0;
  var previous_route_id = 0;
  var isIncharge = false;
  var isStart = false;
  var isEnd = false;
  var employee_id;
  List<Asset> routeImages = <Asset>[];
  String _error = 'No Error Dectected';
  List image_64_route = [];
  DateTime routeEndselectedDate = DateTime.now();
  List<Asset> galleryImages = <Asset>[];
  List<File> cameraImages = [];
  final ImagePicker _picker = ImagePicker();
  String img64_route = "";
  @override
  void initState() {
    isDriver = box.read("is_driver");
    employee_id = box.read('emp_id');
    if (box.read('real_role_category').toString().contains('branch manager')) {
      is_branch_manager = true;
    } else {
      is_branch_manager = false;
    }
    if (box.read('real_role_category').toString().contains('spare')) {
      is_spare = true;
    } else {
      is_spare = false;
    }
    if (Get.arguments != null) {
      arg_index = Get.arguments;
      if (controller.plantrip_with_product_list[arg_index].expenseIds!.length >
          0) {
        controller.selectedExpenseRouteCategory =
            controller.plantrip_with_product_list[arg_index].expenseIds![0];
        controller.expense_list.value =
            controller.plantrip_with_product_list[arg_index].expenseIds!;
      }

      if (controller
              .plantrip_with_product_list[arg_index].consumptionIds!.length !=
          0) {
        controller.selectedRoute =
            controller.plantrip_with_product_list[arg_index].consumptionIds![0];
      }
      // if (controller.plantrip_with_product_list[arg_index].vehicleId!
      //             .inchargeId !=
      //         null &&
      //     controller.plantrip_with_product_list[arg_index].vehicleId!.inchargeId
      //             .id ==
      //         int.parse(employee_id)) {
      //   isIncharge = true;
      // }
      if (controller
              .plantrip_with_product_list[arg_index].startTripResponsible ==
          'In-charge') {
        if (controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId !=
                null &&
            controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId.id ==
                int.parse(employee_id)) {
          isStart = true;
        }
      } else if (controller
              .plantrip_with_product_list[arg_index].startTripResponsible ==
          'Driver') {
        if (controller.plantrip_with_product_list[arg_index].driverId != null &&
            controller.plantrip_with_product_list[arg_index].driverId!.id ==
                int.parse(employee_id)) {
          isStart = true;
        }
      } else {
        if (controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId !=
                null &&
            controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId.id ==
                int.parse(employee_id)) {
          isStart = true;
        }
      }

      if (controller.plantrip_with_product_list[arg_index].endTripResponsible ==
          'In-charge') {
        if (controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId !=
                null &&
            controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId.id ==
                int.parse(employee_id)) {
          isEnd = true;
        }
      } else if (controller
              .plantrip_with_product_list[arg_index].endTripResponsible ==
          'Driver') {
        if (controller.plantrip_with_product_list[arg_index].driverId != null &&
            controller.plantrip_with_product_list[arg_index].driverId!.id ==
                int.parse(employee_id)) {
          isEnd = true;
        }
      } else {
        if (controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId !=
                null &&
            controller.plantrip_with_product_list[arg_index].vehicleId!
                    .inchargeId.id ==
                int.parse(employee_id)) {
          isEnd = true;
        }
      }
    }
    controller.plantrip_with_product_list[arg_index].state == 'open'
        ? _tabController = TabController(length: 2, vsync: this)
        : controller.plantrip_with_product_list[arg_index].state == 'running'
            ? _tabController = TabController(length: 3, vsync: this)
            : _tabController = TabController(length: 3, vsync: this);
    controller.fetchExpenseStatusData(
        controller.plantrip_with_product_list[arg_index].id,
        'plantrip_product');
    controller.getRouteList(
        controller.plantrip_with_product_list[arg_index].id.toString(),
        'plantrip_product');
    controller.calculatePlantripTotalExpense(
        controller.plantrip_with_product_list[arg_index].expenseIds!);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget routeContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  labels!.route,
                  style: maintitleStyle(),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 20),
        //   child: routeListWidget(context),
        // ),
        controller.plantrip_with_product_list.value[controller.arg_index.value]
                        .state ==
                    'running' &&
                (controller
                        .plantrip_with_product_list[arg_index].driverId!.id ==
                    int.parse(employee_id))
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: routeListWidget(context),
              )
            : SizedBox(),
        controller.plantrip_with_product_list.value[controller.arg_index.value]
                        .state ==
                    'running' &&
                (isDriver || is_spare)
            ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: tripRouteListWidget(context),
              )
            : SizedBox(),
      ],
    );
  }

  Widget tripRouteListWidget(BuildContext context) {
    int fields;
    return Container(
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller
              .plantrip_with_product_list[controller.arg_index.value]
              .routePlanIds!
              .length,
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
                        child: Container(
                          width: 80,
                          child: Text(controller
                              .plantrip_with_product_list[
                                  controller.arg_index.value]
                              .routePlanIds![index1]
                              .routeId
                              .name
                              .toString()),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: textFieldTapColor,
                              ),
                              child: controller
                                          .plantrip_with_product_list[controller
                                              .arg_index.value]
                                          .routePlanIds![index1]
                                          .startActualDate !=
                                      null
                                  ? Text(AppUtils.changeDateAndTimeFormat(
                                      controller
                                          .plantrip_with_product_list[
                                              controller.arg_index.value]
                                          .routePlanIds![index1]
                                          .startActualDate))
                                  : SizedBox(),
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Theme(
                                data: new ThemeData(
                                  primaryColor: textFieldTapColor,
                                ),
                                child: controller
                                            .plantrip_with_product_list[
                                                controller.arg_index.value]
                                            .routePlanIds![index1]
                                            .endActualDate !=
                                        null
                                    ? Text(AppUtils.changeDateAndTimeFormat(
                                        controller
                                            .plantrip_with_product_list[
                                                controller.arg_index.value]
                                            .routePlanIds![index1]
                                            .endActualDate))
                                    : SizedBox())),
                      ),
                      controller
                                  .plantrip_with_product_list[
                                      controller.arg_index.value]
                                  .routePlanIds![index1]
                                  .fuelBalInputByDriver !=
                              null
                          ? Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .fuelBalInputByDriver
                                    .toString()),
                              ),
                            )
                          : SizedBox(),
                      controller
                                  .plantrip_with_product_list[
                                      controller.arg_index.value]
                                  .routePlanIds![index1]
                                  .status !=
                              null
                          ? Expanded(
                              flex: 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='to_approve' ? Text("To Approve") :controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='to_replace' ? Text("To Replace"): controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='done' ? Text("Done") : controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status=='running' ? Text("Running") : Text(controller
                                    .plantrip_with_product_list[
                                        controller.arg_index.value]
                                    .routePlanIds![index1]
                                    .status),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        );
      }),
    );
  }

  Widget productContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    labels!.name,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels!.uom,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.quantity,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              controller.plantrip_with_product_list[arg_index].state ==
                      'running'
                  ? Expanded(flex: 1, child: SizedBox())
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        controller.plantrip_with_product_list[arg_index].productIds!.isNotEmpty
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: productListWidget(context),
                ),
              )
            : new Container(),
      ],
    );
  }

  Widget advanceContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    labels!.expenseCategory,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      labels.quantity,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      labels.amount,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      labels.remark,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              controller.plantrip_with_product_list[arg_index].state == "close"
                  ? SizedBox()
                  : Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: advnaceListWidget(context),
          ),
        ),
        controller.plantrip_with_product_list[arg_index].state == 'submit' ||
                controller.plantrip_with_product_list[arg_index].state ==
                        'open' &&
                    isDriver == true ||
                is_spare == true && is_branch_manager == false
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    var itemAdvanceTotal = 0.0;
                    controller.plantrip_with_product_list[arg_index]
                        .requestAllowanceLines!
                        .forEach((element) {
                      itemAdvanceTotal += element.totalAmount;
                    });
                    Get.to(AddAdvancePage(
                            "PlanTripProduct",
                            controller.plantrip_id,
                            controller.plantrip_with_product_list[arg_index]
                                .totalAdvance,
                            itemAdvanceTotal))!
                        .then((value) {
                      //controller.getPlantripList(controller.current_page.value);
                      if (value != null) {
                        DayTripPlanTripGeneralController day_trip_controller =
                            Get.find();
                        controller.plantrip_with_product_list[arg_index]
                            .requestAllowanceLines!
                            .add(Request_allowance_lines(
                                id: value,
                                expenseCategId: Expense_categ_id(
                                    id: day_trip_controller
                                        .selectedExpenseCategory.id,
                                    name: day_trip_controller
                                        .selectedExpenseCategory.displayName),
                                quantity: double.tryParse(day_trip_controller
                                    .quantityTextController.text)!,
                                amount: double.tryParse(day_trip_controller
                                    .amountTextController.text)!,
                                totalAmount: double.tryParse(
                                    day_trip_controller.totalAmountController.text)!,
                                remark: day_trip_controller.remarkTextController.text));
                      }
                    });
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
              )
            : new Container(),
      ],
    );
  }

  Widget expenseContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    labels!.route,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    labels.routeExpense,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.stdAmt,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.actualAmt,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.overAmt,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              controller.plantrip_with_product_list[arg_index].state == "close"
                  ? SizedBox()
                  : Expanded(child: SizedBox()),
              controller.plantrip_with_product_list[arg_index].state ==
                              'running' &&
                          isDriver == true ||
                      is_spare == true && is_branch_manager == false
                  ? Expanded(child: SizedBox())
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: expenseWidget(context),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(labels.totalStdAmt + ' : '),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(labels.totalActualAmt + ' : '),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(labels.totalOverAmt + ' : '),
                ),
              ),
              // Obx(()=>Text(AppUtils.addThousnadSperator(controller.expenseStandardAmount.value))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              Obx(() => Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(AppUtils.addThousnadSperator(
                          controller.expenseStandardAmount.value)),
                    ),
                  )),
              Obx(() => Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(AppUtils.addThousnadSperator(
                          controller.expenseActualAmount.value)),
                    ),
                  )),
              Obx(() => Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(AppUtils.addThousnadSperator(
                          controller.expenseOverAmount.value)),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget expenseViewContainer(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    'Route Expense',
                    style: TextStyle(color: backgroundIconColor),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    'Standard Amount',
                    style: TextStyle(color: backgroundIconColor),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    'Actual Amount',
                    style: TextStyle(color: backgroundIconColor),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    'Over Amount',
                    style: TextStyle(color: backgroundIconColor),
                  )),
              // Expanded(
              //   flex: 2,
              //   child: SizedBox()
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: expenseWidget(context),
        ),
      ],
    ));
  }

  Widget fuelInContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    labels!.date,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.product,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    labels.quantity,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.unitPrice,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.amount,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              controller.plantrip_with_product_list[arg_index].state == "close"
                  ? SizedBox()
                  : Expanded(flex: 1, child: SizedBox()),
              Expanded(flex: 1, child: Text('')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: fuelInListWidget(context),
          ),
        ),
        (controller.plantrip_with_product_list[arg_index].state == 'running' &&
                    isDriver == true ||
                is_spare == true && is_branch_manager == false)
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(AddFuelPage(
                            "PlanTripProduct",
                            controller.plantrip_with_product_list[arg_index].id,
                            controller.plantrip_with_product_list[arg_index]
                                .fromDatetime,
                            controller.plantrip_with_product_list[arg_index]
                                .toDatetime,
                            Fuelin_ids()))!
                        .then((value) {
                      if (value != null) {
                        DayTripPlanTripGeneralController general_controller =
                            Get.find();
                        setState(() {
                          controller
                              .plantrip_with_product_list[arg_index].fuelinIds!
                              .add(
                            Fuelin_ids(
                                id: value,
                                date:
                                    general_controller.dateTextController.text,
                                shop: general_controller
                                    .shopNameTextController.text,
                                productId: Product_id(
                                    id: general_controller.selectedProduct.id,
                                    name: general_controller
                                        .selectedProduct.name),
                                location_id: Stock_location(
                                    id: general_controller.selectedLocation.id,
                                    name: general_controller
                                        .selectedLocation.name),
                                slipNo: general_controller
                                    .slipNoTextController.text,
                                liter: double.tryParse(
                                    general_controller.qtyController.text)!,
                                priceUnit: double.tryParse(
                                    general_controller.priceController.text)!,
                                amount: double.tryParse(general_controller
                                    .totalFuelInAmtController.text)!),
                          );
                        });
                      }
                    });
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget consumptionContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    labels!.route,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.stdLit,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      labels.actualLit,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      labels.description,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              controller.plantrip_with_product_list[arg_index].state == 'close'
                  ? SizedBox()
                  : Expanded(flex: 1, child: SizedBox()),
              controller.plantrip_with_product_list[arg_index].state ==
                              'running' &&
                          isDriver == true ||
                      is_spare == true && is_branch_manager == false
                  ? Expanded(flex: 1, child: SizedBox())
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: consumptionListWidget(context),
          ),
        ),
        // (controller.plantrip_with_product_list.value[arg_index].state ==
        //             'running' &&
        //         isDriver == true ||is_spare == true&&
        //         is_branch_manager == false)
        //     ? Align(
        //      alignment: Alignment.topRight,
        //       child: FloatingActionButton(
        //         onPressed: () {
        //           fuelAddDialog(0, null);
        //         },
        //         mini: true,
        //         child: Icon(Icons.add),
        //       ),
        //     )
        //     : new Container(),
      ],
    );
  }

  Widget wayBillContainer(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    'Route',
                    style: TextStyle(color: backgroundIconColor),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 10),
        //     child: routeListWidget(context),
        //   ),
        // ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var spare_one = AppUtils.removeNullString(
        controller.plantrip_with_product_list[arg_index].spare1Id!.name);
    var spare_two = AppUtils.removeNullString(
        controller.plantrip_with_product_list[arg_index].spare2Id!.name);

    image = box.read('emp_image');
    controller.plantrip_id =
        controller.plantrip_with_product_list[arg_index].id;

    double width = MediaQuery.of(context).size.width;
    double customWidth = width * 0.30;
    // var from_date = AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_product_list[arg_index].fromDatetime);
    // var from_date =
    //     controller.plantrip_with_product_list[arg_index].fromDatetime;
    var from_date = DateTime.parse(controller.plantrip_with_product_list[arg_index].fromDatetime)
          .add(Duration(hours: 6, minutes: 30))
          .toString()
          .replaceAll('.000', '');
    //var to_date = AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_product_list[arg_index].toDatetime);
    var to_date = AppUtils.changeDateAndTimeFormat(
        controller.plantrip_with_product_list[arg_index].fromDatetime);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(labels!.planTrip),
      //   actions: [],
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(context, labels!.planTrip, ""),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AutoSizeText(planTripModel.totalAdvance.toString(),style: DetailtitleStyle(),),
            Container(
              // height: 250,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 65),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => controller.showDetails.value
                            ? Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  labels.viewDetailsClose,
                                  style: maintitlenoBoldStyle(),
                                ),
                              )
                            : Expanded(
                                flex: 2,
                                child: AutoSizeText(
                                  labels.viewDetails,
                                  style: maintitlenoBoldStyle(),
                                ),
                              )),
                        Obx(() => controller.showDetails.value
                            ? Expanded(
                                flex: 1,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_circle_up_sharp),
                                  onPressed: () {
                                    controller.showDetails.value = false;
                                  },
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.arrow_circle_down_sharp),
                                  onPressed: () {
                                    controller.showDetails.value = true;
                                  },
                                ),
                              ))
                      ],
                    ),
                  ),
                  Obx(() => controller.showDetails.value
                      ? Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 65),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    labels.code,
                                    style: maintitlenoBoldStyle(),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  controller.plantrip_with_product_list.length >
                                          0
                                      ? AutoSizeText(
                                          '${controller.plantrip_with_product_list[arg_index].code}',
                                          style: maintitleStyle(),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.fromDate,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${from_date}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.toDate,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.plantrip_with_product_list
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            // controller
                                            //     .plantrip_with_product_list[
                                            //         controller.arg_index.value]
                                            //     .toDatetime,
                                                DateTime.parse(controller.plantrip_with_product_list[controller.arg_index.value].toDatetime)
                                                .add(Duration(hours: 6, minutes: 30))
                                                .toString()
                                                .replaceAll('.000', ''),
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.vehicle,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.plantrip_with_product_list
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${controller.plantrip_with_product_list[arg_index].vehicleId!.name}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.driver,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.plantrip_with_product_list
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${controller.plantrip_with_product_list[arg_index].driverId!.name}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.spare1,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${spare_one}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.spare2,
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      '${spare_two}',
                                      style: maintitleStyle(),
                                    )
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.advanceAmount + ':',
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.plantrip_with_product_list
                                                .length >
                                            0
                                        ? AutoSizeText(
                                            '${AppUtils.addThousnadSperator(controller.plantrip_with_product_list.value[arg_index].totalAdvance)}',
                                            style: maintitleStyle(),
                                          )
                                        : SizedBox()
                                  ],
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      labels.expenseStatus + ' :',
                                      style: maintitlenoBoldStyle(),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Obx(() => AutoSizeText(
                                          '${AppUtils.removeNullString(controller.expense_status.value)}',
                                          style: maintitleStyle(),
                                        ))
                                  ],
                                )),
                              ],
                            ),
                            //Divider(thickness: 1,),
                            SizedBox(height: 15),
                            controller.plantrip_with_product_list.length > 0 &&
                                    controller
                                            .plantrip_with_product_list
                                            .value[controller.arg_index.value]
                                            .state ==
                                        'running'
                                ? routeContainer(context)
                                : SizedBox(),
                          ],
                        )
                      : SizedBox()),
                ],
              ),
            ),

            SizedBox(
              height: 5,
            ),
            controller.plantrip_with_product_list.length > 0
                ? Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: controller
                                .plantrip_with_product_list[arg_index].state ==
                            'open'
                        ? TabBar(
                            isScrollable: true,
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
                              Tab(
                                text: labels.product,
                              ),
                              Tab(
                                text: labels.advance,
                              ),
                            ],
                          )
                        : TabBar(
                            isScrollable: true,
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
                              Tab(
                                text: labels.expense,
                              ),
                              Tab(
                                text: labels.fuelIn,
                              ),
                              Tab(
                                text: labels.product,
                              ),
                              // Tab(
                              //   text: labels.fuelConsumption,
                              // ),
                            ],
                          ))
                : SizedBox(),
            // tab bar view here
            controller.plantrip_with_product_list.length > 0
                ? Container(
                    height: 300,
                    child: controller
                                .plantrip_with_product_list[arg_index].state ==
                            'open'
                        ? TabBarView(
                            controller: _tabController,
                            children: [
                              //Add Route
                              //routeContainer(context),
                              // Product
                              productContainer(context),
                              //Advance
                              advanceContainer(context),
                            ],
                          )
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              expenseContainer(context),
                              //Fuel In
                              fuelInContainer(context),
                              //Product
                              productContainer(context),
                              //Fuel Consumption
                              // consumptionContainer(context),
                            ],
                          ))
                : SizedBox(),
            controller.plantrip_with_product_list.length > 0 &&
                    controller.plantrip_with_product_list[arg_index].state ==
                        'advance_withdraw' &&
                    isStart
                ? Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: GFButton(
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.clickstartPlanTripProduct(controller
                            .plantrip_with_product_list[arg_index].id);
                      },
                      text: 'Start Trip',
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  )
                : SizedBox(),
            controller.plantrip_with_product_list.length > 0 &&
                    controller.plantrip_with_product_list[arg_index].state ==
                        'running'
                ? isEnd
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                        child: GFButton(
                          color: textFieldTapColor,
                          onPressed: () {
                            controller.clickendPlanTripProduct(controller
                                .plantrip_with_product_list[arg_index].id);
                          },
                          text: 'End Trip',
                          blockButton: true,
                          size: GFSize.LARGE,
                        ),
                      )
                    : SizedBox()
                : controller.plantrip_with_product_list[arg_index].state ==
                        'submit'
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 15),
                              child: GFButton(
                                color: textFieldTapColor,
                                onPressed: () {
                                  controller.approvePlanTripProduct();
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
                              padding:
                                  const EdgeInsets.only(left: 5.0, bottom: 15),
                              child: GFButton(
                                type: GFButtonType.outline,
                                color: textFieldTapColor,
                                onPressed: () {
                                  controller.declinePlanTripProduct();
                                },
                                text: labels.sendBack,
                                blockButton: true,
                                size: GFSize.LARGE,
                              ),
                            ),
                          ),
                        ],
                      )
                    : new Container(),
          ],
        ),
      ),
    );
  }

  Widget consumptionListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            itemCount: controller
                .plantrip_with_product_list[arg_index].consumptionIds?.length,
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
                            child: Text(
                                controller.plantrip_with_product_list[arg_index]
                                        .consumptionIds?[index].routeId!.name
                                        .toString() ??
                                    "",
                                style: TextStyle(fontSize: 11)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              // width: 80,
                              child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                                NumberFormat('#,###')
                                    .format(double.tryParse(controller
                                        .plantrip_with_product_list[arg_index]
                                        .consumptionIds![index]
                                        .standardLiter
                                        .toString()))
                                    .toString(),
                                style: TextStyle(fontSize: 11)),
                          )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              // width: 80,
                              child: Text(
                                  NumberFormat('#,###.##')
                                      .format(double.tryParse(controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .consumptionIds?[index]
                                              .consumedLiter
                                              .toString() ??
                                          ""))
                                      .toString(),
                                  style: TextStyle(fontSize: 11))),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 80,
                            child: Text(
                                AppUtils.removeNullString(controller
                                    .plantrip_with_product_list[arg_index]
                                    .consumptionIds?[index]
                                    .description),
                                style: TextStyle(fontSize: 11)),
                          ),
                        ),
                        controller.plantrip_with_product_list[arg_index]
                                    .state ==
                                "close"
                            ? SizedBox()
                            : ((controller.plantrip_with_product_list[arg_index]
                                            .state ==
                                        "running" &&
                                    (isDriver == true || is_spare == true) &&
                                    is_branch_manager == false))
                                ? Expanded(
                                    child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      controller
                                          .deletePlantripProuctConsumptionLine(
                                              controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .consumptionIds?[index]
                                                      .id ??
                                                  0,
                                              controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .id);
                                    },
                                  ))
                                : SizedBox(),
                        (controller.plantrip_with_product_list[arg_index]
                                            .state ==
                                        'running' &&
                                    isDriver == true ||
                                is_spare == true && is_branch_manager == false)
                            ? Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      fuelAddDialog(
                                          controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .consumptionIds?[index]
                                                  .id ??
                                              0,
                                          controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .consumptionIds![index]);
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Color.fromRGBO(60, 47, 126, 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : new Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget routeDropDown() {
    var planTrip_Consumption_ids =
        controller.plantrip_with_product_list[arg_index].consumptionIds;

    if (controller
            .plantrip_with_product_list[arg_index].consumptionIds?.length !=
        0) {
      controller.selectedRoute =
          controller.plantrip_with_product_list[arg_index].consumptionIds![0];
    }
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                // Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(1),
                ),
              ),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Color.fromRGBO(60, 47, 126, 1),
                  primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<BaseRoute>(
                        hint: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Choose Route",
                            )),
                        value: controller.selectedBaseRoute,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 30,
                        isExpanded: true,
                        onChanged: (BaseRoute? value) {
                          controller.onChangeRouteCategoryDropdown(value!);
                        },
                        items:
                            controller.base_route_list.map((BaseRoute route) {
                          return DropdownMenuItem<BaseRoute>(
                            value: route,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: route.name != null
                                  ? Text(
                                      route.name,
                                      style: TextStyle(),
                                    )
                                  : Text(''),
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseWidget(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Container(
      // height: 300,
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Obx(
        () => controller.plantrip_with_product_list.length > 0
            ? Scrollbar(
                // isAlwaysShown: true,
                thickness: 5,
                controller: scrollController,
                child: ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: controller
                      .plantrip_with_product_list[arg_index].expenseIds!.length,
                  itemBuilder: (BuildContext context, int index) {
                    //fields = controller.travelLineModel.length;
                    //create dynamic destination textfield controller
                    // remark_controllers = List.generate(
                    //     fields,
                    //     (index) => TextEditingController(
                    //         text: controller.outofpocketList[index].display_name
                    //             .toString()));

                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      // width: 80,
                                      child: Text(
                                          controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .expenseIds?[index]
                                                  .eRouteId!
                                                  .name
                                                  .toString() ??
                                              "",
                                          style: TextStyle(fontSize: 11)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      // width: 80,
                                      child: Text(
                                          controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .expenseIds?[index]
                                                  .routeExpenseId!
                                                  .name
                                                  .toString() ??
                                              "",
                                          style: TextStyle(fontSize: 11)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Container(
                                        // width: 80,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                              NumberFormat('#,###')
                                                  .format(double.tryParse(controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .expenseIds![index]
                                                      .standardAmount
                                                      .toString()))
                                                  .toString(),
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      // width: 80,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                              NumberFormat('#,###')
                                                  .format(double.tryParse(controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .expenseIds![index]
                                                      .actualAmount
                                                      .toString()))
                                                  .toString(),
                                              style: TextStyle(fontSize: 11)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    //flex: 1,
                                    child: Container(
                                      // width: 80,
                                      child: controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .expenseIds![index]
                                                  .overAmount !=
                                              null
                                          ? Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                  NumberFormat('#,###')
                                                      .format(double.tryParse(
                                                          controller
                                                              .plantrip_with_product_list[
                                                                  arg_index]
                                                              .expenseIds![
                                                                  index]
                                                              .overAmount
                                                              .toString()))
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 11)),
                                            )
                                          : Text(''),
                                    ),
                                  ),
                                  controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .state ==
                                              "expense_claim" ||
                                          controller
                                                  .plantrip_with_product_list[
                                                      arg_index]
                                                  .state ==
                                              "close"
                                      ? SizedBox()
                                      : isDriver == true ||
                                              is_spare == true &&
                                                  is_branch_manager == false
                                          ? Expanded(
                                              //flex: 1,
                                              child: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                controller.deleteExpenseLine(
                                                    controller
                                                        .plantrip_with_product_list[
                                                            arg_index]
                                                        .expenseIds![index]);
                                              },
                                            ))
                                          : SizedBox(),
                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .state ==
                                                  'running' &&
                                              isDriver == true ||
                                          is_spare == true &&
                                              is_branch_manager == false
                                      ? Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(ExpenseCreate(),
                                                        arguments: controller
                                                            .plantrip_with_product_list[
                                                                arg_index]
                                                            .expenseIds![index])!
                                                    .then((value) {
                                                  if (value != null) {
                                                    controller.getPlantripList(
                                                        controller.current_page
                                                            .value);
                                                    // setState(() {
                                                    //   print("actual ${controller.expenseActualTextController.text.toString()}");
                                                    //   controller.expense_list.add(Expense_ids(routeExpenseId: controller.selectedExpenseRouteCategory.routeExpenseId,standardAmount:controller.selectedExpenseRouteCategory.standardAmount,actualAmount: double.parse(controller.expenseActualTextController.text.toString())));
                                                    // });
                                                  }
                                                });
                                              },
                                              child: Container(
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Color.fromRGBO(
                                                      60, 47, 126, 0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : new Container(),
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : SizedBox(),
      ),
    );
  }

  // Widget routeListWidget(BuildContext context) {
  //   int fields;
  //   return Container(
  //      margin: EdgeInsets.only(top: 20),
  //     child: Obx(() => ListView.builder(
  //           shrinkWrap: true,
  //           //physics: NeverScrollableScrollPhysics(),
  //           itemCount: controller
  //               .plantrip_with_product_list[arg_index].routePlanIds.length,
  //           // itemCount: controller.route_plan_ids_list.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   child: Container(
  //                     // width: 80,
  //                     child: Text(controller
  //                         .plantrip_with_product_list[arg_index]
  //                         .routePlanIds[index]
  //                         .routeId
  //                         .name
  //                         .toString()),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 3,
  //                 ),
  //                 Divider(
  //                   thickness: 1,
  //                 ),
  //                 SizedBox(
  //                   height: 3,
  //                 ),
  //               ],
  //             );
  //           },
  //         )),
  //   );
  // }

  Widget routeListWidget(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    int fields;
    bool first_route = false;
    print(controller.plantrip_with_product_list
        .value[controller.arg_index.value].routePlanIds);
    return Container(
      child: Obx(() {
        plantrip_product_list_lines = [];
        next_route_id = 0;
        previous_route_id = 0;
        for (var i = 0;
            i <
                controller.plantrip_with_product_list
                    .value[controller.arg_index.value].routePlanIds!.length;
            i++) {
          if (i == 0 &&
              (controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds![i]
                          .status ==
                      '' ||
                  controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds?[i]
                          .status ==
                      null)) {
            first_route = true;
          } else {
            first_route = false;
          }
          if ((controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds?[i]
                          .status ==
                      '' ||
                  controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds?[i]
                          .status ==
                      null ||
                  controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds?[i]
                          .status ==
                      'running') ||
              (((controller
                              .plantrip_with_product_list
                              .value[controller.arg_index.value]
                              .routePlanIds!
                              .length -
                          1) ==
                      i) &&
                  controller
                          .plantrip_with_product_list
                          .value[controller.arg_index.value]
                          .routePlanIds![i]
                          .status ==
                      'end')) {
            if(controller.plantrip_with_product_list
                    .value[controller.arg_index.value].routePlanIds!.length>0){
                int index = controller.plantrip_with_product_list
                    .value[controller.arg_index.value].routePlanIds!.indexWhere((item) => item.status == 'to_approve');
                if (index == -1) {
                  plantrip_product_list_lines.add(controller
                                          .plantrip_with_product_list
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
              // else{
              //   plantrip_product_list_lines.add(controller
              //                   .plantrip_with_product_list
              //                   .value[controller.arg_index.value]
              //                   .routePlanIds?[i]);
              // }
            
            if (i !=
                controller
                        .plantrip_with_product_list
                        .value[controller.arg_index.value]
                        .routePlanIds!
                        .length -
                    1) {
              next_route_id = controller.plantrip_with_product_list
                  .value[controller.arg_index.value].routePlanIds![i + 1].id;
            }
            break;
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: plantrip_product_list_lines.length,
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
                          child: Text(plantrip_product_list_lines[index]
                              .routeId
                              .name
                              .toString()),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: plantrip_product_list_lines[index].status !=
                                      null &&
                                  plantrip_product_list_lines[index].status !=
                                      ''
                              ? Text(plantrip_product_list_lines[index].status)
                              : SizedBox(),
                        ),
                      ),
                       plantrip_product_list_lines[index].status == '' ||
                              plantrip_product_list_lines[index].status ==
                                  null ||
                              plantrip_product_list_lines[index].status ==
                                  'running' 
                          ? Expanded(
                              child: SizedBox(
                                width: 50,
                                child: GFButton(
                                  onPressed: () {
                                    if (controller
                                            .plantrip_with_product_list
                                            .value[controller.arg_index.value]
                                            .routePlanIds!
                                            .length >
                                        1) {
                                      for (var i = 0;
                                          i <
                                              controller
                                                  .plantrip_with_product_list
                                                  .value[controller
                                                      .arg_index.value]
                                                  .routePlanIds!
                                                  .length;
                                          i++) {
                                        if (i != 0) {
                                          if (plantrip_product_list_lines[index]
                                                  .id ==
                                              controller
                                                  .plantrip_with_product_list
                                                  .value[controller
                                                      .arg_index.value]
                                                  .routePlanIds![i]
                                                  .id) {
                                            previous_route_id = controller
                                                .plantrip_with_product_list
                                                .value[
                                                    controller.arg_index.value]
                                                .routePlanIds![i - 1]
                                                .id;
                                            break;
                                          }
                                        }
                                      }
                                    }
                                    plantrip_product_list_lines[index].status ==
                                            'running'
                                        ? showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                controller
                                                    .remainingFuelController
                                                    .clear();
                                                return AlertDialog(
                                                  scrollable: true,
                                                  content: SizedBox(
                                                    width: double.maxFinite,
                                                    height: double.maxFinite * .8,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0,
                                                              top: 8.0),
                                                      child: Form(
                                                        key: _formKey,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                'Please Enter Remaining Fuel (Liters)'),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                // setState(() {});
                                                              },
                                                              validator:
                                                                  (text) {
                                                                if (text ==
                                                                        null ||
                                                                    text
                                                                        .isEmpty) {
                                                                  return 'Remaining Fuel is empty';
                                                                } else if (text
                                                                        .isNotEmpty &&
                                                                    double.parse(
                                                                            text) <=
                                                                        0) {
                                                                  return 'Please Enter Remaining Fuel > 0';
                                                                }
                                                                return null;
                                                              },
                                                              controller: controller
                                                                  .remainingFuelPTPController,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                'Please Enter Route End Date'),
                                                            SizedBox(
                                                                height: 10),
                                                            dateWidget(context),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            // ElevatedButton.icon(
                                                            //   icon: Icon(Icons.photo_library),
                                                            //   label: Text("Select multiple images from Gallery"),
                                                            //   onPressed: () async {
                                                            //     List<Asset> resultList;
                                                            //     try {
                                                            //       resultList = await MultiImagePicker.pickImages(
                                                            //       );
                                                            //     } on Exception catch (e) {
                                                            //       print(e.toString());
                                                            //       return;
                                                            //     }
                                                            //     setState(() {
                                                            //       galleryImages = resultList;
                                                            //     });
                                                            //   },
                                                            // ),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child:
                                                                ElevatedButton(
                                                                    child: Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1.0)),
                                                                    onPressed:
                                                                        () {
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
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Center(
                                                          child: ElevatedButton(
                                                              child: Text(
                                                                  "Update",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            60,
                                                                            47,
                                                                            126,
                                                                            1),
                                                              ),
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  controller
                                                                      .clickProductRouteLine(
                                                                          first_route,
                                                                          controller
                                                                              .plantrip_with_product_list
                                                                              .value[controller
                                                                                  .arg_index.value]
                                                                              .id,
                                                                          plantrip_product_list_lines[index]
                                                                              .id,
                                                                          next_route_id,
                                                                          previous_route_id,
                                                                          controller
                                                                              .remainingFuelPTPController
                                                                              .text,
                                                                          controller
                                                                              .routeEndDateTextController
                                                                              .text)
                                                                      .then(
                                                                          (value) {
                                                                    if (value !=
                                                                        0) {
                                                                      Get.back();
                                                                      controller
                                                                          .remainingFuelPTPController
                                                                          .text = "";
                                                                      controller
                                                                          .routeEndDateTextController
                                                                          .text = "";
                                                                      controller.getPlantripWithProductList(controller
                                                                          .current_page
                                                                          .value);
                                                                    }
                                                                  });
                                                                }
                                                              }),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                            }).then((value) {
                                            // daytrip_controller.getDayTripList(daytrip_controller.current_page.value);
                                          })
                                        : controller
                                            .clickProductRouteStartLine(
                                                first_route,
                                                controller
                                                    .plantrip_with_product_list
                                                    .value[controller
                                                        .arg_index.value]
                                                    .id,
                                                plantrip_product_list_lines[
                                                        index]
                                                    .id,
                                                next_route_id,
                                                previous_route_id,
                                                '0',
                                                '')
                                            .then((value) {
                                            if (value != 0) {
                                              controller
                                                  .getPlantripWithProductList(
                                                      controller
                                                          .current_page.value);
                                            }
                                          });

                                    // if(controller.plantrip_with_product_list.value[controller.arg_index.value].routePlanIds.length > 1){
                                    //   for(var i=0; i< controller.plantrip_with_product_list.value[controller.arg_index.value].routePlanIds.length; i++){
                                    //     if(i!=0){
                                    //         if(plantrip_product_list_lines[index].id == controller.plantrip_with_product_list.value[controller.arg_index.value].routePlanIds[i].id){
                                    //           previous_route_id = controller.plantrip_with_product_list.value[controller.arg_index.value].routePlanIds[i-1].id;break;
                                    //         }
                                    //     }
                                    //   }
                                    // }
                                    // controller.clickProductRouteLine(first_route, controller.plantrip_with_product_list.value[controller.arg_index.value].id, plantrip_product_list_lines[index].id,next_route_id,previous_route_id).then((value){
                                    //   if(value!=0){
                                    //     controller.getPlantripWithProductList(controller.current_page.value);
                                    //   }
                                    // });
                                  },
                                  type: GFButtonType.outline,
                                  text: plantrip_product_list_lines[index]
                                                  .status ==
                                              '' ||
                                          plantrip_product_list_lines[index]
                                                  .status ==
                                              null
                                      ? 'Start'
                                      : plantrip_product_list_lines[index]
                                                  .status ==
                                              'running'
                                          ? 'End'
                                          : '',
                                  textColor: textFieldTapColor,
                                  blockButton: true,
                                  size: GFSize.SMALL,
                                  color: textFieldTapColor,
                                ),
                              ),
                            )
                          : SizedBox(),
                      (plantrip_product_list_lines[index].status == 'end' &&
                              index == plantrip_product_list_lines.length - 1)
                          ? Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text('Done')),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        );
      }),
    );
  }

  nullRoutePhoto(int index) {
    setState(() {
      controller.imageList.value.removeAt(index);
      controller.image_base64_route_list.removeAt(index);
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
    controller.setCameraRouteImage(image, img64_route, fileName);
  }

  Widget dateWidget(BuildContext context) {
    var end_date_controller;
    end_date_controller = controller.routeEndDateTextController;
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
          controller: end_date_controller,
          decoration: InputDecoration(
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
              var date_time =
                  DateTimeField.combine(date, time).toString().split('.000')[0];

              controller.routeEndDateTextController.text = date_time.toString();
              routeEndselectedDate = DateTime.parse(date_time);

              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ]),
    );
  }

  attachRouteFilePath() async {
    if (routeImages.length > 0) {
      for (var i = 0; i < routeImages.length; i++) {
        final byteData = await routeImages[i].getByteData();
        final tempFile = File(
            "${(await getTemporaryDirectory()).path}/${routeImages[i].name}");
        final file = await tempFile.writeAsBytes(
          byteData.buffer
              .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
        );
        File compressedFile = await AppUtils.reduceImageFileSize(file);
        final bytes = Io.File(compressedFile.path).readAsBytesSync();
        String base64Encode(List<int> bytes) => base64.encode(bytes);
        String encoded_image = base64Encode(bytes);
        image_64_route.add(encoded_image);
      }
    }
  }

  dynamic fuelInBottomSheet(BuildContext context, Fuelin_ids fuelIn_ids) {
    var labels = AppLocalizations.of(context);

    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.close_outlined),
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
                              child: Text(
                                  AppUtils.changeDateFormat(fuelIn_ids.date)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(labels.shop, style: pmstitleStyle())),
                          Expanded(
                              child: Text(
                                  AppUtils.removeNullString(fuelIn_ids.shop)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  Text(labels.product, style: pmstitleStyle())),
                          Expanded(
                              child: Text(AppUtils.removeNullString(
                                  fuelIn_ids.productId!.name)))
                        ],
                      ),
                      SizedBox(
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
                              child: Text(fuelIn_ids.location_id != null
                                  ? AppUtils.removeNullString(
                                      fuelIn_ids.location_id!.name)
                                  : ''))
                        ],
                      ),
                      SizedBox(
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
                              child: Text(
                                  AppUtils.removeNullString(fuelIn_ids.slipNo)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels.quantity + "(" + labels.liter + ")",
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      fuelIn_ids.liter.toString()))
                                  .toString()))
                        ],
                      ),
                      SizedBox(
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
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      fuelIn_ids.priceUnit.toString()))
                                  .toString()))
                        ],
                      ),
                      SizedBox(
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
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      fuelIn_ids.amount.toString()))
                                  .toString()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget fuelInListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            itemCount: controller
                .plantrip_with_product_list[arg_index].fuelinIds!.length,
            itemBuilder: (BuildContext context, int index) {
              var date = AppUtils.changeDateFormat(controller
                  .plantrip_with_product_list[arg_index]
                  .fuelinIds![index]
                  .date);
              return InkWell(
                onTap: () {
                  fuelInBottomSheet(
                      context,
                      controller.plantrip_with_product_list[arg_index]
                          .fuelinIds![index]);
                },
                child: Column(
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
                              child: Text(date.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     // width: 80,
                          //     child: Text(controller.fuel_list[index].shop == null ? "":controller.fuel_list[index].shop
                          //         .toString()),
                          //   ),
                          // ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .fuelinIds![index]
                                              .productId!
                                              .name !=
                                          null
                                      ? controller
                                          .plantrip_with_product_list[arg_index]
                                          .fuelinIds![index]
                                          .productId!
                                          .name
                                          .toString()
                                      : '',
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(
                                      controller
                                          .plantrip_with_product_list[arg_index]
                                          .fuelinIds![index]
                                          .liter
                                          .toString())),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(
                                      controller
                                          .plantrip_with_product_list[arg_index]
                                          .fuelinIds![index]
                                          .priceUnit
                                          .toString())),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  NumberFormat('#,###').format(double.tryParse(
                                      controller
                                          .plantrip_with_product_list[arg_index]
                                          .fuelinIds![index]
                                          .amount
                                          .toString())),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          controller.plantrip_with_product_list[arg_index]
                                      .state ==
                                  "close"
                              ? SizedBox()
                              : (controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .state ==
                                          'running' &&
                                      (controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .fuelinIds![index]
                                              .add_from_office ==
                                          null) &&
                                      (isDriver == true || is_spare == true) &&
                                      is_branch_manager == false)
                                  ? Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Get.to(AddFuelPage(
                                                  "PlanTripProduct",
                                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .id,
                                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .fromDatetime,
                                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .toDatetime,
                                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .fuelinIds![index]))!
                                              .then((value) {
                                            if (value != null) {
                                              controller.getPlantripList(
                                                  controller
                                                      .current_page.value);
                                            }
                                          });
                                        },
                                      ))
                                  : Expanded(flex: 1, child: SizedBox()),
                          controller.plantrip_with_product_list[arg_index]
                                      .state ==
                                  "close"
                              ? SizedBox()
                              : (controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .state ==
                                          'running' &&
                                      (controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .fuelinIds![index]
                                              .add_from_office ==
                                          null) &&
                                      (isDriver == true || is_spare == true) &&
                                      is_branch_manager == false)
                                  ? Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          controller
                                              .deleteFuelInLineForPlantripProduct(
                                                  controller
                                                      .plantrip_with_product_list[
                                                          arg_index]
                                                      .fuelinIds![index]
                                                      .id);
                                        },
                                      ))
                                  : Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_circle_up,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget productListWidget(BuildContext context) {
    int fields;
    List<TextEditingController> qty_controllers;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller
              .plantrip_with_product_list[arg_index].productIds!.length,
          itemBuilder: (BuildContext context, int index) {
            fields = controller
                .plantrip_with_product_list[arg_index].productIds!.length;
            //create dynamic destination textfield controller
            qty_controllers = List.generate(
                fields,
                (index) => TextEditingController(
                    text: controller.plantrip_with_product_list[arg_index]
                        .productIds![index].quantity
                        .toString()));
            var formatter = NumberFormat(',000.0');
            var quantity = "0";
            if (controller.plantrip_with_product_list[arg_index]
                    .productIds![index].quantity
                    .round()
                    .toString()
                    .length >=
                4) {
              quantity = formatter.format(double.tryParse(controller
                  .plantrip_with_product_list[arg_index]
                  .productIds![index]
                  .quantity
                  .toString()));
            } else {
              quantity = controller.plantrip_with_product_list[arg_index]
                  .productIds![index].quantity
                  .toInt()
                  .toString();
            }
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
                          child: Text(
                              controller.plantrip_with_product_list[arg_index]
                                  .productIds![index].productId!.name
                                  .toString(),
                              style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            // width: 80,
                            child: controller
                                        .plantrip_with_product_list[arg_index]
                                        .productIds![index]
                                        .productUom!
                                        .name !=
                                    null
                                ? Text(
                                    controller
                                        .plantrip_with_product_list[arg_index]
                                        .productIds![index]
                                        .productUom!
                                        .name,
                                    style: TextStyle(fontSize: 11))
                                : Text(''),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child: Text(quantity.toString(),
                              style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      controller.plantrip_with_product_list[arg_index].state ==
                                  'running' &&
                              is_branch_manager == false
                          ? Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          controller.productQtyController
                                              .clear();
                                          return AlertDialog(
                                            scrollable: true,
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                child: Column(
                                                  children: <Widget>[
                                                    Text('Enter Quantity'),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      onChanged: (text) {
                                                        // setState(() {});
                                                      },
                                                      controller: controller
                                                          .productQtyController,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: ElevatedButton(
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1.0)),
                                                          onPressed: () {
                                                            Get.back();
                                                          }),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                        child: Text("Update"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            60,
                                                                            47,
                                                                            126,
                                                                            1)),
                                                        onPressed: () {
                                                          controller.updateQty(
                                                              controller
                                                                  .plantrip_with_product_list[
                                                                      arg_index]
                                                                  .productIds![
                                                                      index]
                                                                  .id);
                                                        }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        }).then((value) {
                                      controller.getPlantripList(
                                          controller.current_page.value);
                                    });
                                  },
                                  child: Container(
                                    // width: 80,
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Color.fromRGBO(60, 47, 126, 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        );
      }),
    );
  }

  // Widget productListWidget(BuildContext context) {
  //   int fields;
  //   ScrollController scrollController = ScrollController();
  //   return Container(
  //     // margin: EdgeInsets.only(left: 10, right: 10),
  //     child: Obx((){
  //       return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: controller.plantrip_with_product_list[arg_index].productIds.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         //fields = controller.travelLineModel.length;
  //         //create dynamic destination textfield controller
  //         // remark_controllers = List.generate(
  //         //     fields,
  //         //     (index) => TextEditingController(
  //         //         text: controller.outofpocketList[index].display_name
  //         //             .toString()));
  //         //controller.productQtyController.text = controller.product_ids_list[index].quantity.toString();
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       // width: 80,
  //                       child: Text(controller.plantrip_with_product_list[arg_index].productIds[index].productId.name
  //                           .toString()
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       // width: 80,
  //                       child: Text(controller.plantrip_with_product_list[arg_index].productIds[index].productUom.name
  //                           .toString()
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Container(
  //                       // width: 80,
  //                       child: Text(controller.plantrip_with_product_list[arg_index].productIds[index].quantity
  //                           .toString()
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       controller.plantrip_with_product_list[arg_index].state=='running'?
  //                       Expanded(
  //                         flex:1,
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left:12.0),
  //                           child: InkWell(
  //                             onTap: (){
  //                               showDialog(
  //                                   context: context,
  //                                   builder: (BuildContext context) {
  //                                     controller.productQtyController.clear();
  //                                     return AlertDialog(
  //                                       scrollable: true,
  //                                       content: Padding(
  //                                         padding: const EdgeInsets.all(8.0),
  //                                         child: Form(
  //                                           child: Column(
  //                                             crossAxisAlignment: CrossAxisAlignment.start,
  //                                             children: <Widget>[
  //                                               Text('Enter Quantity',style: TextStyle(color: Color.fromRGBO(
  //                                                   60, 47, 126, 1)),),
  //                                               TextField(
  //                                                 decoration: InputDecoration(
  //                                                   border: OutlineInputBorder(),
  //                                                 ),
  //                                                 onChanged: (text) {
  //                                                   // setState(() {});
  //                                                 },
  //                                                 controller: controller.productQtyController,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                       actions: [
  //                                         Center(
  //                                           child: RaisedButton(
  //                                               child: Text("Update"),
  //                                               color: Color.fromRGBO(
  //                                                   60, 47, 126, 1),
  //                                               onPressed: () {
  //                                                 controller.updateQty(controller.plantrip_with_product_list[arg_index].productIds[index].id).then((value) {
  //                                                   controller.plantrip_with_product_list[arg_index].productIds[index].setQuantity(value.toDouble());
  //                                                   setState(() {
  //
  //                                                   });
  //                                                 });
  //                                               }),
  //                                         )
  //                                       ],
  //                                     );
  //                                   }).then((value){
  //                                    // controller.getPlantripList(controller.current_page.value);
  //                               });
  //                             },
  //                             child: Container(
  //                               // width: 80,
  //                               child: Icon(
  //                                 Icons.edit,
  //                                 size: 20,
  //                                 color: Color.fromRGBO(60, 47, 126, 0.5),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ): new Container(),
  //                     ],
  //                   ),
  //
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Divider(
  //               thickness: 1,
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //           ],
  //         );
  //       },
  //     );}
  //      ),
  //   );
  // }
  dynamic advanceBottomSheet(
      BuildContext context, Request_allowance_lines advance_ids) {
    var labels = AppLocalizations.of(context);

    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              color: Color(0xff757575),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.close_outlined),
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
                          )),
                          Expanded(
                            child: Text(
                                advance_ids.expenseCategId!.name.toString(),
                                style: pmstitleStyle()),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels.quantity,
                          )),
                          Expanded(
                              child: Text(advance_ids.quantity.toString(),
                                  style: pmstitleStyle()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels.amount,
                          )),
                          Expanded(
                              child: Text(
                                  NumberFormat('#,###')
                                      .format(double.tryParse(
                                          advance_ids.amount.toString()))
                                      .toString(),
                                  style: pmstitleStyle()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels.totalAmount,
                          )),
                          Expanded(
                              child: Text(
                                  NumberFormat('#,###')
                                      .format(double.tryParse(
                                          advance_ids.totalAmount.toString()))
                                      .toString(),
                                  style: pmstitleStyle()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels.remark,
                          )),
                          Expanded(
                              child: advance_ids.remark.toString() == null ||
                                      advance_ids.remark.toString() == "null"
                                  ? Text("-")
                                  : Text(
                                      advance_ids.remark.toString(),
                                      style: pmstitleStyle(),
                                    ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget advnaceListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            itemCount: controller.plantrip_with_product_list[arg_index]
                .requestAllowanceLines!.length,
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
                    onTap: () {
                      advanceBottomSheet(
                          context,
                          controller.plantrip_with_product_list[arg_index]
                              .requestAllowanceLines![index]);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  controller
                                      .plantrip_with_product_list[arg_index]
                                      .requestAllowanceLines![index]
                                      .expenseCategId!
                                      .name
                                      .toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                  controller
                                      .plantrip_with_product_list[arg_index]
                                      .requestAllowanceLines![index]
                                      .quantity
                                      .toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  NumberFormat('#,###')
                                      .format(double.tryParse(controller
                                          .plantrip_with_product_list[arg_index]
                                          .requestAllowanceLines![index]
                                          .amount
                                          .obs
                                          .toString()))
                                      .toString(),
                                  style: TextStyle(fontSize: 11)),
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
                              padding: EdgeInsets.only(left: 5),
                              child: controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .requestAllowanceLines![index]
                                              .remark
                                              .toString() ==
                                          null ||
                                      controller
                                              .plantrip_with_product_list[
                                                  arg_index]
                                              .requestAllowanceLines![index]
                                              .remark
                                              .toString() ==
                                          "null"
                                  ? Text("-")
                                  : Text(
                                      controller
                                          .plantrip_with_product_list[arg_index]
                                          .requestAllowanceLines![index]
                                          .remark
                                          .toString(),
                                      style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          controller.plantrip_with_product_list[arg_index]
                                          .state ==
                                      "expense_claim" ||
                                  controller
                                          .plantrip_with_product_list[arg_index]
                                          .state ==
                                      "close"
                              ? SizedBox()
                              : isDriver == true ||
                                      is_spare == true &&
                                          is_branch_manager == false
                                  ? Expanded(
                                      child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        controller.deleteAdvanceLine(controller
                                            .plantrip_with_product_list[
                                                arg_index]
                                            .requestAllowanceLines![index]
                                            .id);
                                      },
                                    ))
                                  : SizedBox(),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_circle_up,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ),
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          )),
    );
  }

  void fuelAddDialog(int lineID, PlanTrip_Consumption_ids consumption) {
    if (consumption != null) {
      controller.selectedBaseRoute = BaseRoute(
          id: consumption.routeId!.id,
          name: consumption.routeId!.name,
          fuel_liter: consumption.standardLiter);
      controller.actualAmountTextController.text =
          consumption.consumedLiter.toString();
      controller.descriptionTextController.text = consumption.description;
    } else {
      if (controller.base_route_list != null &&
          controller.base_route_list.value.length > 0) {
        controller.selectedBaseRoute = controller.base_route_list.value[0];
      }
      controller.actualAmountTextController.text = "";
      controller.descriptionTextController.text = "";
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Fuel Consumption',
                          style: TextStyle(
                              color: backgroundIconColor, fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: routeDropDown(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  'Std Consumption : ',
                                  style: TextStyle(color: backgroundIconColor),
                                )),
                            Obx(() => Expanded(
                                flex: 1,
                                child: controller.show_standard_liter.value
                                    ? Text(
                                        controller.selectedBaseRoute.fuel_liter
                                                .toString() +
                                            "Liter",
                                        style: TextStyle(
                                            color: backgroundIconColor),
                                      )
                                    : Text(''))),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Theme(
                                  data: new ThemeData(
                                    primaryColor: textFieldTapColor,
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller:
                                        controller.actualAmountTextController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                          "Actual Fuel Consumption(Liter)",
                                    ),
                                    onChanged: (text) {},
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          child: TextField(
                            controller: controller.descriptionTextController,
                            enabled: true,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: (("Description")),
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GFButton(
                          onPressed: () {
                            controller.addPlanTripProductFuelConsumption(
                                controller
                                    .plantrip_with_product_list[arg_index],
                                lineID);
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
      if (value != null) {
        controller.getPlantripList(controller.current_page.value);
      }
    });
  }
}

class ExpenseCreate extends StatefulWidget {
  @override
  _ExpenseCreateState createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final PlanTripController controller = Get.find();
  var box = GetStorage();
  String image = "";
  String img64 = "";
  List<TravelLineListModel> datalist = [];
  DateTime selectedFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File? imageFile;
  String expenseValue = "";
  Expense_ids? arguments;
  Uint8List? bytes;
  Widget routeExpenseDropDown() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                // Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(1),
                ),
              ),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Color.fromRGBO(60, 47, 126, 1),
                  primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<Expense_ids>(
                        hint: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Expense Category",
                            )),
                        value: controller.selectedExpenseRouteCategory,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 30,
                        isExpanded: true,
                        onChanged: (Expense_ids? value) {
                          controller.onChangeRouteExpenseDropdown(value!);
                        },
                        items:
                            controller.expense_list.map((Expense_ids category) {
                          return DropdownMenuItem<Expense_ids>(
                            value: category,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                category.routeExpenseId!.name,
                                style: TextStyle(),
                              ),
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool show_image_container = true;
  @override
  void initState() {
    arguments = Get.arguments;
    controller.expenseActualTextController.text =
        arguments!.actualAmount.toString();
    controller.expenseDescriptionTextController.text =
        arguments!.description.toString();
    if (arguments!.attachement_image != null &&
        arguments!.attachement_image != "") {
      controller.isShowImage.value = true;
      controller.selectedExpensePlanTripProductImage =
          arguments!.attachement_image;
      bytes = base64Decode(arguments!.attachement_image);
    } else {
      controller.isShowImage.value = false;
      controller.selectedExpensePlanTripProductImage = "";
    }
    controller.routeName = arguments!.eRouteId!.name.toString();
    findDropDownValue(arguments!.routeExpenseId!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller.expenseDescriptionTextController.clear();
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    String std_amount = AppUtils.removeNullString(
        controller.selectedExpenseRouteCategory.standardAmount.toString());
    if (std_amount.isNotEmpty) {
      std_amount = AppUtils.addThousnadSperator(double.tryParse(std_amount)!);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(context, "Plan Trip Expense Form", image),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(controller.routeName,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: routeExpenseDropDown()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Standard Amount : ',
                              style: TextStyle(color: backgroundIconColor),
                            )),
                        Obx(() => Expanded(
                            flex: 1,
                            child: Text(
                              controller.show_standard_amount.value
                                  ? controller.selectedExpenseRouteCategory
                                              .standardAmount !=
                                          null
                                      ? AppUtils.addThousnadSperator(controller
                                          .selectedExpenseRouteCategory
                                          .standardAmount)
                                      : ''
                                  : '',
                              style: TextStyle(color: backgroundIconColor),
                            ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.expenseActualTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "${labels!.actual} ${labels.amount}",
                          ),
                          onChanged: (text) {},
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: textFieldTapColor,
                        ),
                        child: TextField(
                          controller:
                              controller.expenseDescriptionTextController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Description'),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  show_image_container
                      ? Obx(() => InkWell(
                            onTap: () {
                              showOptions(context);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text('Add Image'),
                                    controller.isShowImage.value == false
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                                width: 80,
                                                height: 80,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey),
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                  size: 30,
                                                )),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Image.memory(
                                              bytes!,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.saveExpense(
                      "product",
                      arguments!.id,
                      controller.plantrip_with_product_list
                          .value[controller.arg_index.value].id);
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

  void findDropDownValue(int expenseID) {
    bool found = false;
    for (int i = 0; i < controller.expense_list.value.length; i++) {
      if (controller.expense_list.value[i].routeExpenseId!.id == expenseID) {
        found = true;
        controller.selectedExpenseRouteCategory =
            controller.expense_list.value[i];
        break;
      }
    }
  }

  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
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
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Camera")),
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
                        Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromRGBO(54, 54, 94, 0.9),
                        ),
                        Container(child: Text("Gallery")),
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
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
      controller.setCameraImage(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
      controller.setCameraImage(compressedFile, img64);
      setState(() {
        show_image_container = true;
      });
    }
  }
}
