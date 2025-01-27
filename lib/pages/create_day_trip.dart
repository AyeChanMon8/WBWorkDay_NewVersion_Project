import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../controllers/day_trip_controller.dart';
import '../controllers/day_trip_expense_controller.dart';
import '../controllers/daytrip_plantrip_fuel_advance_controller.dart';
// import '../localization.dart';
import '../models/day_trip_model.dart';
import '../models/daytrip_expense.dart';
import '../models/travel_expense/list/travel_line_list_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/add_advance_page.dart';
import '../pages/add_fuel_page.dart';
import '../utils/app_utils.dart';

import 'add_fuel_daytrip_page.dart';
import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateDayTrip extends StatefulWidget {
  @override
  _CreateDayTripState createState() => _CreateDayTripState();
}

class _CreateDayTripState extends State<CreateDayTrip>
    with SingleTickerProviderStateMixin {
  final DayTripExpenseController controller =
      Get.put(DayTripExpenseController());
  final DayTripController daytrip_controller = Get.find();

  var box = GetStorage();
  String image = '';
  int groupValue = 0;
  TabController? _tabController;
  var arg_index;
  var isDriver = false;
  var is_branch_manager = false;
  var is_spare = false;
  var employee_id;
  var isIncharge = false;
  var isStart = false;
  var isEnd = false;
  @override
  void initState() {
    if (Get.arguments != null) {
      arg_index = Get.arguments;
    }
    isDriver = box.read("is_driver");
    employee_id = box.read('emp_id');
    if (box.read('real_role_category').toString().contains('branch manager')) {
      ;
      is_branch_manager = true;
    } else {
      is_branch_manager = false;
    }
    if (box.read('real_role_category').toString().contains('spare')) {
      is_spare = true;
    } else {
      is_spare = false;
    }
    print('is_spare#');
    print(is_spare);
    print('is_drive#');
    print(isDriver);
    daytrip_controller.dayTripList[arg_index].state == 'open'
        ? _tabController = TabController(length: 2, vsync: this)
        : daytrip_controller.dayTripList[arg_index].state == 'running'
            ? _tabController = TabController(length: 4, vsync: this)
            : _tabController = TabController(length: 5, vsync: this);
    controller
        .fetchExpenseStatusData(daytrip_controller.dayTripList[arg_index].id);
    controller.calculateTotalExpense(
        daytrip_controller.dayTripList[arg_index].expenseIds!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  DayTripModel dayTripModel = DayTripModel();
  @override
  Widget build(BuildContext context) {
    //DayTripModel dayTripModel = Get.arguments;
    if (Get.arguments != null) {
      arg_index = Get.arguments;
      print(daytrip_controller.dayTripList[arg_index].product_lines!.length);
      controller.expense_list.value =
          daytrip_controller.dayTripList[arg_index].expenseIds!;
      controller.fuel_list.value =
          daytrip_controller.dayTripList[arg_index].fuelInIds!;
      controller.product_ids_list.value =
          daytrip_controller.dayTripList[arg_index].product_lines!;
      controller.advance_ids_list.value =
          daytrip_controller.dayTripList[arg_index].advance_lines!;
      controller.consumption_ids_list.value =
          daytrip_controller.dayTripList[arg_index].consumption_ids!;
      // if (daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId !=
      //         null &&
      //     daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId?.id ==
      //         int.parse(employee_id)) {
      //   isIncharge = true;
      // }

      if (daytrip_controller.dayTripList[arg_index].startTripResponsible == 'In-charge'){
        if(daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId != null && daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }else if (daytrip_controller.dayTripList[arg_index].startTripResponsible == 'Driver'){
        if(daytrip_controller.dayTripList[arg_index].driverId != null &&daytrip_controller.dayTripList[arg_index].driverId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }else{
        if(daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId != null && daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isStart = true;
        }
      }

      if (daytrip_controller.dayTripList[arg_index].endTripResponsible == 'In-charge'){
        if(daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId != null && daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }else if (daytrip_controller.dayTripList[arg_index].endTripResponsible == 'Driver'){
        if(daytrip_controller.dayTripList[arg_index].driverId != null &&daytrip_controller.dayTripList[arg_index].driverId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }else{
        if(daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId != null && daytrip_controller.dayTripList[arg_index].vehicleId!.inchargeId!.id ==int.parse(employee_id)){
          isEnd = true;
        }
      }
    }
    dayTripModel = daytrip_controller.dayTripList[arg_index];
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    if (dayTripModel != null) {
      controller.daytrip_id = dayTripModel.id;
    }

    double width = MediaQuery.of(context).size.width;
    double customWidth = width * 0.30;
    var from_date = AppUtils.changeDefaultDateTimeFormat(
        daytrip_controller.dayTripList[arg_index].fromDatetime);
    var to_date = AppUtils.changeDefaultDateTimeFormat(
        daytrip_controller.dayTripList[arg_index].toDatetime);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(labels!.dayTrip, style: TextStyle(color: Colors.white)),
      //   actions: [],
      // ),
      appBar:PreferredSize(preferredSize: Size.fromHeight(60),child:  appbar(context, labels!.dayTrip, ""),),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 65),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => daytrip_controller.showDetails.value
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
                  Obx(() => daytrip_controller.showDetails.value
                      ? Expanded(
                          flex: 1,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.arrow_circle_up_sharp),
                            onPressed: () {
                              daytrip_controller.showDetails.value = false;
                            },
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.arrow_circle_down_sharp),
                            onPressed: () {
                              daytrip_controller.showDetails.value = true;
                            },
                          ),
                        ))
                ],
              ),
            ),
            Obx(() => daytrip_controller.showDetails.value
                ? Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      dayTripModel.code != null
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: AutoSizeText(
                                dayTripModel.code,
                                style: DetailtitleStyle(),
                              ))
                          : AutoSizeText(''),
                      SizedBox(
                        height: 5,
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
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${from_date}',
                                style: maintitleStyle(),
                              )
                            ],
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                labels.toDate,
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${to_date}',
                                style: maintitleStyle(),
                              )
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                labels.vehicle + ':',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${dayTripModel.vehicleId!.name}',
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
                                labels.driver + ':',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${dayTripModel.driverId!.name}',
                                style: maintitleStyle(),
                              )
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                labels.spare1 + ':',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${AppUtils.removeNullString(dayTripModel.spare1Id!.name)}',
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
                                labels.spare2 + ' :',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              dayTripModel.spare2Id!.name == null
                                  ? Text("-")
                                  : AutoSizeText(
                                      '${AppUtils.removeNullString(dayTripModel.spare2Id!.name)}',
                                      style: maintitleStyle(),
                                    )
                            ],
                          )),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                labels.advanceAmount + ' :',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              AutoSizeText(
                                '${AppUtils.addThousnadSperator(dayTripModel.advancedRequest)}',
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
                                labels.expenseStatus + ' :',
                                style: maintitlenoBoldStyle(),
                              ),
                              SizedBox(height: 5),
                              Obx(() => AutoSizeText(
                                    '${AppUtils.removeNullString(controller.expense_status.value)}',
                                    style: maintitleStyle(),
                                  ))
                            ],
                          )),
                        ],
                      ),
                    ],
                  )
                : SizedBox()),
            //Divider(thickness: 1,),
            SizedBox(height: 15),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: daytrip_controller.dayTripList[arg_index].state == 'open'
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
                  : daytrip_controller.dayTripList[arg_index].state == 'running'
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
                              text: labels.expense,
                            ),
                            Tab(
                              text: labels.fuelConsumption,
                            ),
                            Tab(
                              text: labels.fuelIn,
                            ),
                            Tab(
                              text: labels.product,
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
                              text: labels.fuelConsumption,
                            ),
                            Tab(
                              text: labels.fuelIn,
                            ),
                            Tab(
                              text: labels.advance,
                            ),
                            Tab(
                              text: labels.product,
                            ),
                          ],
                        ),
            ),
            // tab bar view here
            Expanded(
              child: daytrip_controller.dayTripList[arg_index].state == 'open'
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        //Product
                        Container(
                            child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        labels.name,
                                        style: TextStyle(
                                            color: backgroundIconColor),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        labels.uom,
                                        style: TextStyle(
                                            color: backgroundIconColor),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        labels.quantity,
                                        style: TextStyle(
                                            color: backgroundIconColor),
                                      )),
                                  daytrip_controller
                                              .dayTripList[arg_index].state ==
                                          'running'
                                      ? Expanded(flex: 1, child: SizedBox())
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, right: 0, left: 0),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: backgroundIconColor,
                              ),
                            ),
                            controller.product_ids_list.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: productListWidget(context),
                                  )
                                : new Container(),
                          ],
                        )),
                        //Advance
                        advanceContainer(context),
                      ],
                    )
                  : daytrip_controller.dayTripList[arg_index].state == 'running'
                      ? TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            //Expense
                            expenseContainer(context),
                            //Fuel Consumption
                            fuelConsumptionContainer(context),
                            //Fuel In
                            fuelInContainer(context),
                            //Product
                            productContainer(context),
                          ],
                        )
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            //Expense
                            expenseContainer(context),
                            //Fuel Consumption
                            fuelConsumptionContainer(context),
                            //Fuel in
                            fuelInContainer(context),
                            //Advance
                            advanceContainer(context),
                            //Product
                            productContainer(context),
                          ],
                        ),
            ),
            daytrip_controller.dayTripList[arg_index].state ==
                        'advance_withdraw' &&
                    isStart
                ? Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: GFButton(
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.clickstartDayTrip(
                            daytrip_controller.dayTripList[arg_index].id);
                      },
                      text: 'Start Trip',
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  )
                : SizedBox(),
            daytrip_controller.dayTripList[arg_index].state == 'running' &&
                    isEnd
                ? Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: GFButton(
                      color: textFieldTapColor,
                      onPressed: () {
                        controller.clickendDayTrip(
                            daytrip_controller.dayTripList[arg_index].id);
                      },
                      text: 'End Trip',
                      blockButton: true,
                      size: GFSize.LARGE,
                    ),
                  )
                : SizedBox(),
            daytrip_controller.dayTripList[arg_index].state == 'submit'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 15),
                          child: GFButton(
                            color: textFieldTapColor,
                            onPressed: () {
                              controller.approveDayTrip();
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
                              const EdgeInsets.only(left: 15.0, bottom: 15),
                          child: GFButton(
                            type: GFButtonType.outline,
                            color: textFieldTapColor,
                            onPressed: () {
                              controller.declineDayTrip();
                            },
                            text: labels.sendBack,
                            blockButton: true,
                            size: GFSize.LARGE,
                          ),
                        ),
                      ),
                    ],
                  )
                : new Container()
          ],
        ),
      ),
    );
  }

  Widget expenseWidget(BuildContext context) {
    int fields;

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount:
              daytrip_controller.dayTripList[arg_index].expenseIds!.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List? bytes;
            if (daytrip_controller.dayTripList[arg_index].expenseIds![index]
                    .attachement_image !=
                null && daytrip_controller.dayTripList[arg_index].expenseIds![index]
                    .attachement_image!="") {
              bytes = base64Decode(daytrip_controller
                  .dayTripList[arg_index].expenseIds![index].attachement_image);
            }
            var formatter = NumberFormat(',000.0');
            var amount = "0";
            if (daytrip_controller
                    .dayTripList[arg_index].expenseIds![index].amount
                    .round()
                    .toString()
                    .length >=
                4) {
              amount = formatter.format(double.tryParse(daytrip_controller
                  .dayTripList[arg_index].expenseIds![index].amount
                  .toString()));
            } else {
              amount = daytrip_controller
                  .dayTripList[arg_index].expenseIds![index].amount
                  .toString();
            }
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                            daytrip_controller.dayTripList[arg_index]
                                .expenseIds![index].productId.name
                                .toString(),
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child: Text(
                              daytrip_controller.dayTripList[arg_index]
                                  .expenseIds![index].name
                                  .toString(),
                              style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // width: 80,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(amount.toString(),
                                style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  return ImageDialog(
                                    bytes: bytes,
                                  );
                                });
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: bytes != null
                                  ? Image.memory(
                                      bytes,
                                      width: 100,
                                      height: 100,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ),
                      ),
                      daytrip_controller.dayTripList[arg_index].state ==
                                  "expense_claim" ||
                              daytrip_controller.dayTripList[arg_index].state ==
                                  "close"
                          ? Expanded(flex: 1, child: new Container())
                          : isDriver == true ||
                                  is_spare == true && is_branch_manager == false
                              ? Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      daytrip_controller.deleteExpenseLine(
                                          daytrip_controller
                                              .dayTripList[arg_index]
                                              .expenseIds![index]
                                              .id);
                                    },
                                  ))
                              : Expanded(flex: 1, child: Text('')),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  dynamic fuelInBottomSheet(BuildContext context, FuelIn_ids fuelIn_ids) {
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
                                  fuelIn_ids.productId.name)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            labels!.fromLocation,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(AppUtils.removeNullString(
                                  fuelIn_ids.location_id.name)))
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
                                  AppUtils.removeNullString(fuelIn_ids.slip_no)
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
                                      fuelIn_ids.price_unit.toString()))
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
            itemCount:
                daytrip_controller.dayTripList[arg_index].fuelInIds!.length,
            itemBuilder: (BuildContext context, int index) {
              //fields = controller.travelLineModel.length;
              //create dynamic destination textfield controller
              // remark_controllers = List.generate(
              //     fields,
              //     (index) => TextEditingController(
              //         text: controller.outofpocketList[index].display_name
              //             .toString()));
              var formatter = NumberFormat(',000.0');
              var totalAmt = "0";
              var price_unit = "0";
              if (daytrip_controller
                      .dayTripList[arg_index].fuelInIds![index].amount
                      .round()
                      .toString()
                      .length >=
                  4) {
                totalAmt = formatter.format(double.tryParse(daytrip_controller
                    .dayTripList[arg_index].fuelInIds![index].amount
                    .toString()));
              } else {
                totalAmt = daytrip_controller
                    .dayTripList[arg_index].fuelInIds![index].amount
                    .toString();
              }
              if (daytrip_controller
                      .dayTripList[arg_index].fuelInIds![index].price_unit
                      .round()
                      .toString()
                      .length >=
                  4) {
                price_unit = formatter.format(double.tryParse(daytrip_controller
                    .dayTripList[arg_index].fuelInIds![index].price_unit
                    .toString()));
              } else {
                price_unit = daytrip_controller
                    .dayTripList[arg_index].fuelInIds![index].price_unit
                    .toString();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      fuelInBottomSheet(
                          context,
                          daytrip_controller
                              .dayTripList[arg_index].fuelInIds![index]);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  AppUtils.changeDateFormat(daytrip_controller
                                      .dayTripList[arg_index]
                                      .fuelInIds![index]
                                      .date),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                  daytrip_controller
                                              .dayTripList[arg_index]
                                              .fuelInIds![index]
                                              .productId
                                              .name !=
                                          null
                                      ? daytrip_controller
                                          .dayTripList[arg_index]
                                          .fuelInIds![index]
                                          .productId
                                          .name
                                      : ''.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(
                                  daytrip_controller.dayTripList[arg_index]
                                      .fuelInIds![index].liter
                                      .toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Text(price_unit.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(totalAmt.toString(),
                                    style: TextStyle(fontSize: 11)),
                              ),
                            ),
                          ),
                          daytrip_controller.dayTripList[arg_index].state ==
                                  "close"
                              ? SizedBox()
                              : (daytrip_controller
                                              .dayTripList[arg_index].state ==
                                          'running' &&
                                      daytrip_controller
                                              .dayTripList[arg_index]
                                              .fuelInIds![index]
                                              .add_from_office ==
                                          null &&
                                      (isDriver == true || is_spare == true) &&
                                      is_branch_manager == false)
                                  ? Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Get.to(AddFuelDaytripPage(
                                                  "DayTrip",
                                                  controller.daytrip_id,
                                                  daytrip_controller
                                                      .dayTripList[arg_index]
                                                      .fromDatetime,
                                                  daytrip_controller
                                                      .dayTripList[arg_index]
                                                      .toDatetime,
                                                  daytrip_controller
                                                      .dayTripList[arg_index]
                                                      .fuelInIds![index]))
                                              ?.then((value) {
                                            daytrip_controller.getDayTripList(
                                                daytrip_controller
                                                    .current_page.value);
                                          });
                                        },
                                      ))
                                  : Expanded(flex: 1, child: SizedBox()),
                          daytrip_controller.dayTripList[arg_index].state ==
                                  "close"
                              ? SizedBox()
                              : (daytrip_controller.dayTripList[arg_index]
                                                  .state ==
                                              'running' &&
                                          daytrip_controller
                                                  .dayTripList[arg_index]
                                                  .fuelInIds![index]
                                                  .add_from_office ==
                                              null &&
                                          isDriver == true ||
                                      is_spare == true &&
                                          is_branch_manager == false)
                                  ? Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          daytrip_controller.deleteFuelInLine(
                                              daytrip_controller
                                                  .dayTripList[arg_index]
                                                  .fuelInIds![index]
                                                  .id);
                                        },
                                      ))
                                  : Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.more_horiz,
                                  size: 25,
                                ),
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

  Widget productListWidget(BuildContext context) {
    int fields;
    List<TextEditingController> qty_controllers;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount:
              daytrip_controller.dayTripList[arg_index].product_lines!.length,
          itemBuilder: (BuildContext context, int index) {
            fields =
                daytrip_controller.dayTripList[arg_index].product_lines!.length;
            //create dynamic destination textfield controller
            qty_controllers = List.generate(
                fields,
                (index) => TextEditingController(
                    text: daytrip_controller
                        .dayTripList[arg_index].product_lines![index].quantity
                        .toString()));
            var formatter = NumberFormat(',000.0');
            var quantity = "0";
            if (daytrip_controller
                    .dayTripList[arg_index].product_lines![index].quantity
                    .round()
                    .toString()
                    .length >=
                4) {
              quantity = formatter.format(double.tryParse(daytrip_controller
                  .dayTripList[arg_index].product_lines![index].quantity
                  .toString()));
            } else {
              quantity = daytrip_controller
                  .dayTripList[arg_index].product_lines![index].quantity
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
                            daytrip_controller.dayTripList[arg_index]
                                .product_lines![index].productId.name
                                .toString(),
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            // width: 80,
                            child: daytrip_controller.dayTripList[arg_index]
                                            .product_lines![index].uom !=
                                        null &&
                                    daytrip_controller.dayTripList[arg_index]
                                            .product_lines![index].uom.name !=
                                        null
                                ? Text(
                                    daytrip_controller.dayTripList[arg_index]
                                        .product_lines![index].uom.name,
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
                      daytrip_controller.dayTripList[arg_index].state ==
                              'running'
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
                                                      child: TextButton(
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
                                                                    1.0),
                                                          ),
                                                          // color: Color.fromRGBO(
                                                          //     255, 255, 255, 1.0),
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
                                                              Color.fromRGBO(60,
                                                                  47, 126, 1),
                                                        ),
                                                        // color: Color.fromRGBO(
                                                        //     60, 47, 126, 1),
                                                        onPressed: () {
                                                          controller.updateQty(
                                                              daytrip_controller
                                                                  .dayTripList[
                                                                      arg_index]
                                                                  .product_lines![
                                                                      index]
                                                                  .id);
                                                        }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        }).then((value) {
                                      daytrip_controller.getDayTripList(
                                          daytrip_controller
                                              .current_page.value);
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

  dynamic consumptionBottomSheet(
      BuildContext context, Consumption_ids consumption_ids) {
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
                            labels!.lastOdometer,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      consumption_ids.last_odometer.toString()))
                                  .toString()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(labels!.currentOdometer,
                                  style: pmstitleStyle())),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(consumption_ids
                                      .current_odometer
                                      .toString()))
                                  .toString()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(labels.tripDistance,
                                  style: pmstitleStyle())),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      consumption_ids.trip_distance.toString()))
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
                            labels.actualConsum,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(NumberFormat('#,###.##')
                                  .format(double.tryParse(consumption_ids
                                      .consumed_liter
                                      .toString()))
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
                            labels.average,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(consumption_ids
                                      .avg_calculation
                                      .toString()))
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

  Widget consumptionListWidget(BuildContext context) {
    int fields;
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: daytrip_controller
                .dayTripList[arg_index].consumption_ids!.length,
            itemBuilder: (BuildContext context, int index) {
              var formatter = NumberFormat(',000.0');
              var trip_distance = "0";
              var current_odometer = "0";
              var last_odometer = "0";
              var avg_calculation = "0";
              var consumed_liter = "0";
              trip_distance = NumberFormat('#,###').format(double.tryParse(
                  daytrip_controller.dayTripList[arg_index]
                      .consumption_ids![index].trip_distance
                      .toString()));
              current_odometer = NumberFormat('#,###').format(double.tryParse(
                  daytrip_controller.dayTripList[arg_index]
                      .consumption_ids![index].current_odometer
                      .toString()));
              last_odometer = NumberFormat('#,###').format(double.tryParse(
                  daytrip_controller.dayTripList[arg_index]
                      .consumption_ids![index].last_odometer
                      .toString()));
              avg_calculation = NumberFormat('#,###').format(double.tryParse(
                  daytrip_controller.dayTripList[arg_index]
                      .consumption_ids![index].avg_calculation
                      .toString()));
              consumed_liter = NumberFormat('#,###.##').format(double.tryParse(
                  daytrip_controller.dayTripList[arg_index]
                      .consumption_ids![index].consumed_liter
                      .toString()));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      consumptionBottomSheet(
                          context,
                          daytrip_controller
                              .dayTripList[arg_index].consumption_ids![index]);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     padding: const EdgeInsets.only(left:5.0),
                          //     child: Text(last_odometer
                          //         .toString()
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                current_odometer.toString(),
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(trip_distance.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(consumed_liter.toString(),
                                    style: TextStyle(fontSize: 11)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(avg_calculation.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.more_horiz,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          (daytrip_controller.dayTripList[arg_index].state ==
                                          'running' &&
                                      isDriver == true ||
                                  is_spare == true &&
                                      is_branch_manager == false)
                              ? Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: InkWell(
                                      onTap: () {
                                        showFuelAddDialog(
                                            daytrip_controller
                                                .dayTripList[arg_index]
                                                .consumption_ids![index]
                                                .id,
                                            daytrip_controller
                                                .dayTripList[arg_index]
                                                .consumption_ids![index]);
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color:
                                              Color.fromRGBO(60, 47, 126, 0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : new Container(),
                          daytrip_controller.dayTripList[arg_index].state ==
                                  "close"
                              ? SizedBox()
                              : (daytrip_controller
                                              .dayTripList[arg_index].state ==
                                          "running" &&
                                      (isDriver == true || is_spare == true) &&
                                      is_branch_manager == false)
                                  ? Expanded(
                                      child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        daytrip_controller
                                            .deleteConsumptionLine(
                                                daytrip_controller
                                                    .dayTripList[arg_index]
                                                    .consumption_ids![index]
                                                    .id,
                                                daytrip_controller
                                                    .dayTripList[arg_index].id);
                                      },
                                    ))
                                  : SizedBox(),
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

  dynamic advanceBottomSheet(BuildContext context, Advance_ids advance_ids) {
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
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(
                                  advance_ids.expense_categ_id.name.toString()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(labels.quantity,
                                  style: pmstitleStyle())),
                          Expanded(child: Text(advance_ids.quantity.toString()))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  Text(labels!.amount, style: pmstitleStyle())),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      advance_ids.amount.toString()))
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
                            labels.totalAmount,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(NumberFormat('#,###')
                                  .format(double.tryParse(
                                      advance_ids.total_amount.toString()))
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
                            labels.remark,
                            style: pmstitleStyle(),
                          )),
                          Expanded(
                              child: Text(AppUtils.removeNullString(
                                  advance_ids.remark)))
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
    return Container(
      // margin: EdgeInsets.only(left: 10, right: 10),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            itemCount:
                daytrip_controller.dayTripList[arg_index].advance_lines!.length,
            itemBuilder: (BuildContext context, int index) {
              //fields = controller.travelLineModel.length;
              //create dynamic destination textfield controller
              // remark_controllers = List.generate(
              //     fields,
              //     (index) => TextEditingController(
              //         text: controller.outofpocketList[index].display_name
              //             .toString()));
              var formatter = NumberFormat('0,000.0');
              var totalAmt = "0";
              var amount = "0";
              var quantity = "0";
              if (daytrip_controller
                      .dayTripList[arg_index].advance_lines![index].amount
                      .round()
                      .toString()
                      .length >=
                  4) {
                amount = formatter.format(double.tryParse(daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].amount
                    .toString()));
              } else {
                amount = daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].amount
                    .toString();
              }
              if (daytrip_controller
                      .dayTripList[arg_index].advance_lines![index].total_amount
                      .round()
                      .toString()
                      .length >=
                  4) {
                totalAmt = formatter.format(double.tryParse(daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].total_amount
                    .toString()));
              } else {
                totalAmt = daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].total_amount
                    .toString();
              }
              if (daytrip_controller
                      .dayTripList[arg_index].advance_lines![index].quantity
                      .round()
                      .toString()
                      .length >=
                  4) {
                quantity = formatter.format(double.tryParse(daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].quantity
                    .toString()));
              } else {
                quantity = daytrip_controller
                    .dayTripList[arg_index].advance_lines![index].quantity
                    .toInt()
                    .toString();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      advanceBottomSheet(
                          context,
                          daytrip_controller
                              .dayTripList[arg_index].advance_lines![index]);
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
                                  daytrip_controller
                                      .dayTripList[arg_index]
                                      .advance_lines![index]
                                      .expense_categ_id
                                      .name
                                      .toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                // width: 80,
                                child: Text(quantity.toString(),
                                    style: TextStyle(fontSize: 11)),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     // width: 80,
                          //     child: Text(amount
                          //         .toString()),
                          //   ),
                          // ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // width: 80,
                              child: Text(totalAmt.toString(),
                                  style: TextStyle(fontSize: 11)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                // width: 80,
                                child: Text(
                                    AppUtils.removeNullString(daytrip_controller
                                        .dayTripList[arg_index]
                                        .advance_lines![index]
                                        .remark),
                                    style: TextStyle(fontSize: 11)),
                              ),
                            ),
                          ),
                          daytrip_controller.dayTripList[arg_index].state ==
                                      "expense_claim" ||
                                  daytrip_controller
                                          .dayTripList[arg_index].state ==
                                      "close"
                              ? SizedBox()
                              : isDriver == true ||
                                      is_spare == true &&
                                          is_branch_manager == false
                                  ? Expanded(
                                      child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        daytrip_controller.deleteAdvanceLine(
                                            daytrip_controller
                                                .dayTripList[arg_index]
                                                .advance_lines![index]
                                                .id);
                                      },
                                    ))
                                  : SizedBox(),
                          Expanded(
                            flex: 1,
                            child: Container(
                              // width: 80,
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.more_horiz,
                                  size: 25,
                                ),
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

  Widget advanceContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);
    int fields;
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    labels!.expenseCategory,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      labels.quantity,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              //
              // Expanded(
              //     flex: 1,
              //     child: Text('Amount',style: TextStyle(color: backgroundIconColor),)),
              Expanded(
                  flex: 2,
                  child: Text(
                    labels!.totalAmount,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      labels.remark,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),

              daytrip_controller.dayTripList[arg_index].state == "close"
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
        daytrip_controller.dayTripList[arg_index].advance_lines!.length > 0
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: advnaceListWidget(context),
                ),
              )
            : new Container(),
        daytrip_controller.dayTripList[arg_index].state == 'open' &&
                    isDriver == true ||
                is_spare == true && is_branch_manager == false
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    var itemTotalAmount = 0.0;
                    daytrip_controller.dayTripList[arg_index].advance_lines
                        ?.forEach((element) {
                      itemTotalAmount += element.total_amount;
                    });
                    Get.to(AddAdvancePage(
                            "DayTrip",
                            controller.daytrip_id,
                            daytrip_controller
                                .dayTripList[arg_index].advancedRequest,
                            itemTotalAmount))
                        ?.then((value) {
                      //daytrip_controller.getDayTripList(daytrip_controller.current_page.value);
                      if (value != null) {
                        DayTripPlanTripGeneralController day_trip_controller =
                            Get.find();
                        daytrip_controller.dayTripList[arg_index].advance_lines!
                            .add(Advance_ids(
                                id: value,
                                expense_categ_id: ExpenseCategory_id(
                                    id: day_trip_controller
                                        .selectedExpenseCategory.id,
                                    name: day_trip_controller
                                        .selectedExpenseCategory.displayName),
                                quantity: double.tryParse(day_trip_controller
                                    .quantityTextController.text)!,
                                amount: double.tryParse(day_trip_controller
                                    .amountTextController.text)!,
                                total_amount: double.tryParse(day_trip_controller
                                    .totalAmountController.text)!,
                                remark:
                                    day_trip_controller.remarkTextController.text));
                      }
                    });
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
              )
            : new Container(),
      ],
    ));
  }

  Widget expenseContainer(BuildContext context) {
    final labels = AppLocalizations.of(context);
    int fields;
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    labels!.expense,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.description,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        labels.amount,
                        style:
                            TextStyle(color: backgroundIconColor, fontSize: 11),
                      ))),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        labels.attachment,
                        style:
                            TextStyle(color: backgroundIconColor, fontSize: 11),
                      ))),
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
            padding: const EdgeInsets.only(top: 5),
            child: expenseWidget(context),
          ),
        ),
        // SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(labels.total),
              ),
            ),
          ],
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
              // Obx(()=> Expanded(
              //   flex:1,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left:5.0),
              //     child: Text(AppUtils.addThousnadSperator(controller.expenseActualAmount.value)),
              //   ),
              // )),
              // Obx(()=> Expanded(
              //   flex:1,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left:5.0),
              //     child: Text(AppUtils.addThousnadSperator(controller.expenseOverAmount.value)),
              //   ),
              // )),
            ],
          ),
        ),
        daytrip_controller.dayTripList[arg_index].state == 'close' ||
                daytrip_controller.dayTripList[arg_index].state == 'decline' ||
                daytrip_controller.dayTripList[arg_index].state == 'submit' ||
                isDriver == false && is_spare == false ||
                is_branch_manager == true
            ? SizedBox()
            : daytrip_controller.dayTripList[arg_index].state == 'running'
                ? Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.to(ExpenseCreate())?.then((value) {
                          if (value != null) {
                            controller.isShowImage.value = false;
                            daytrip_controller.getDayTripList(
                                daytrip_controller.current_page.value);
                          }
                        });
                        //Get.to(() => ExpenseCreate());
                      },
                      mini: true,
                      child: Icon(Icons.add),
                    ),
                  )
                : SizedBox(),
      ],
    ));
  }

  Widget fuelConsumptionContainer(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      labels!.currentOdometer,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      labels.tripDistance,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.actualConsum,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      labels.average,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(''),
                  )),
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
            padding: const EdgeInsets.only(top: 5),
            child: consumptionListWidget(context),
          ),
        ),
        (daytrip_controller.dayTripList[arg_index].state == 'running' &&
                (isDriver == true || is_spare == true) &&
                is_branch_manager == false)
            ? Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    showFuelAddDialog(0, null);
                  },
                  mini: true,
                  child: Icon(Icons.add),
                ),
              )
            : SizedBox(),
      ],
    ));
  }

  Widget fuelInContainer(BuildContext context) {
    var label = AppLocalizations.of(context);
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    label!.date,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      label!.product,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      label.liter,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    label.unitPrice,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      label.amount,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              daytrip_controller.dayTripList[arg_index].state == "close"
                  ? SizedBox()
                  : Expanded(flex: 1, child: SizedBox()),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(''),
                  )),
            ],
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
          daytrip_controller.dayTripList[arg_index].state == 'decline' ||
                  daytrip_controller.dayTripList[arg_index].state == 'close' ||
                  daytrip_controller.dayTripList[arg_index].state == 'submit'
              ? SizedBox()
              : ((daytrip_controller.dayTripList[arg_index].state ==
                          'running' ||
                      isDriver == false && is_spare == false ||
                      is_branch_manager == true))
                  ? Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          Get.to(AddFuelDaytripPage(
                                  "DayTrip",
                                  controller.daytrip_id,
                                  daytrip_controller
                                      .dayTripList[arg_index].fromDatetime,
                                  daytrip_controller
                                      .dayTripList[arg_index].toDatetime,
                                  null))
                              ?.then((value) {
                            setState(() {
                              daytrip_controller.getDayTripList(
                                daytrip_controller.current_page.value);
                            });
                          });
                        },
                        mini: true,
                        child: Icon(Icons.add),
                      ),
                    )
                  : SizedBox(),
        ],
      ),
    ));
  }

  Widget productContainer(BuildContext context) {
    var labels = AppLocalizations.of(context);
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
                    labels!.name,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      labels.uom,
                      style:
                          TextStyle(color: backgroundIconColor, fontSize: 11),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    labels.quantity,
                    style: TextStyle(color: backgroundIconColor, fontSize: 11),
                  )),
              daytrip_controller.dayTripList[arg_index].state == 'running'
                  ? Expanded(flex: 1, child: SizedBox())
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35, right: 0, left: 0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: backgroundIconColor,
          ),
        ),
        daytrip_controller.dayTripList[arg_index].product_lines!.length > 0
            ? Padding(
                padding: const EdgeInsets.only(top: 45),
                child: productListWidget(context),
              )
            : new Container(),
      ],
    ));
  }

//   void showFuelAddDialog() {

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           var labels = AppLocalizations.of(context);
//           controller
//               .actualFuelLiterTextController.clear();
//           controller
//               .descriptionTextController.clear();
//           return AlertDialog(
//             content: Stack(
//               overflow: Overflow.visible,
//               children: <Widget>[
//                 Positioned(
//                   right: -40.0,
//                   top: -40.0,
//                   child: InkResponse(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: CircleAvatar(
//                       child: Icon(Icons.close),
//                       backgroundColor: Colors.red,
//                     ),
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [

//                       Text(labels.fuelConsumption,style: TextStyle(color: backgroundIconColor,fontSize: 18)),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                                 margin: EdgeInsets.only(
//                                     top: 20),
//                                 child: Theme(
//                                   data: new ThemeData(
//                                     primaryColor:
//                                     textFieldTapColor,
//                                   ),
//                                   child: TextField(
//                                     keyboardType: TextInputType.number,
//                                     controller: controller
//                                         .actualFuelLiterTextController,
//                                     decoration:
//                                     InputDecoration(
//                                       border:
//                                       OutlineInputBorder(),
//                                       hintText: labels.actualConsum,
//                                     ),
//                                     onChanged:
//                                         (text) {

//                                     },
//                                   ),
//                                 )),
//                           ),

//                         ],
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.only(top:20.0),
//                         child: Container(
//                           child: TextField(
//                             controller: controller
//                                 .descriptionTextController,
//                             enabled: true,
//                             style: TextStyle(
//                                 color: Colors.black
//                             ),
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               hintText: ((labels.description)),
//                             ),
//                             onChanged: (text) {},
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 20.0),
//                         child: GFButton(
//                           onPressed: () {
//                             controller.addFuelConsumption(dayTripModel);

//                           },
//                           text: labels.save,
//                           blockButton: true,
//                           size: GFSize.LARGE,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).then((value) {
//           if(value!=null){
//             daytrip_controller.getDayTripList(daytrip_controller.current_page.value);
//           }

//     });
//   }
// }

  void showFuelAddDialog(int lineID, Consumption_ids? consumption) {
    if (consumption != null) {
      controller.actualFuelLiterTextController.text =
          consumption.consumed_liter.toString();
      controller.descriptionTextController.text =
          consumption.description != null
              ? consumption.description.toString()
              : "";
    } else {
      controller.actualFuelLiterTextController.text = "";
      controller.descriptionTextController.text = "";
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var labels = AppLocalizations.of(context);
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
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
                      Text(labels!.fuelConsumption,
                          style: TextStyle(
                              color: backgroundIconColor, fontSize: 18)),
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
                                    controller: controller
                                        .actualFuelLiterTextController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: labels.actualConsum,
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
                              hintText: ((labels!.description)),
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GFButton(
                          onPressed: () {
                            controller.addFuelConsumption(dayTripModel, lineID);
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
        daytrip_controller
            .getDayTripList(daytrip_controller.current_page.value);
      }
    });
  }
}

String addThounsandSperator(String amount, String roundAmt) {
  var value = "";
  var formatter = NumberFormat(',000.0');
  if (roundAmt.length >= 4) {
    amount = formatter.format(double.tryParse(amount.toString()));
    //totalAmt = controller.fuel_list[index].amount.toString();
  } else {
    amount = amount.toString();
  }
  return value;
}

class ExpenseCreate extends StatefulWidget {
  @override
  _ExpenseCreateState createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final DayTripExpenseController controller = Get.find();
  var box = GetStorage();

  String image = '';
  String img64 = '';
  List<TravelLineListModel> datalist = [];
  DateTime selectedFromDate = DateTime.now();
  final picker = ImagePicker();
  TextEditingController qtyController = TextEditingController(text: "1");
  File? imageFile;
  String expenseValue = '';
  late Uint8List? bytes;
  bool show_image_container = true;
  @override
  void initState() {
    super.initState();
    bytes = null;
  }

  Future getCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    File compressedFile = await AppUtils.reduceImageFileSize(image);
    bytes = Io.File(compressedFile.path).readAsBytesSync();
    img64 = base64Encode(bytes!);
    controller.setCameraImage(compressedFile, img64);
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      File compressedFile = await AppUtils.reduceImageFileSize(image);
      bytes = Io.File(compressedFile.path).readAsBytesSync();
      img64 = base64Encode(bytes!);
      controller.setCameraImage(compressedFile, img64);
    }
  }

  showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          var labels = AppLocalizations.of(context);
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
                    Navigator.pop(context);
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

  Widget expenseCategoryDropDown(BuildContext context) {
    var labels = AppLocalizations.of(context);
    controller.selectedExpenseType = controller.expense_category_list[0];
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
                  border: Border.all(
                      color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Daytrip_expense>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.expense,
                              )),
                          value: controller.selectedExpenseType,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Daytrip_expense? value) {
                            controller.onChangeExpenseCategoryDropdown(value!);
                          },
                          items: controller.expense_category_list
                              .map((Daytrip_expense category) {
                            return DropdownMenuItem<Daytrip_expense>(
                              value: category,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  category.name,
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    controller.descriptionController.clear();
    controller.totalAmountController.clear();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: appbar(context, labels!.daytripExpenseForm, image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Column(
                children: [
                  // Align(
                  //     alignment: Alignment.center,
                  //     child: Obx(
                  //           () =>Container(
                  //           margin: EdgeInsets.symmetric(horizontal: 18),
                  //           child:  controller.totalAdvanceAmount.value > 0.0 ? Text('${labels?.total} Actual Amount : ${NumberFormat('#,###').format(controller.totalAdvanceAmount)}',style: TextStyle(fontSize: 20,color: Colors.deepPurple),) : SizedBox()),
                  //     )),
                  // SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: expenseCategoryDropDown(context)),
                      ),
                    ],
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
                          controller: controller.descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: labels?.description,
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
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
                          keyboardType: TextInputType.number,
                          controller: controller.totalAmountController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: labels?.amount,
                          ),
                          onChanged: (text) {
                            // setState(() {});
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => InkWell(
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
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.addExpense();
                },
                text: "Save",
                blockButton: true,
                size: GFSize.LARGE,
              )
              /*Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: RaisedButton(
                    color: textFieldTapColor,
                    onPressed: () {
                      if (index == null) {
                        if(controller.travelLineModel.length>0)
                          controller.createTravel();
                        else
                          AppUtils.showDialog('Warning!', 'You need expense line!');
                      } else {
                        controller.updateTravelLineExpense(
                          controllerList.travelExpenseList.value[index].id
                              .toString(),
                        );
                      }
                    },
                    child: index == null
                        ? Text(
                      ("Save"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                        : Text(
                      ("Update"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Text(
                ("Date"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // width: 80,
              child: Text(
                ("Expense Title"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                ("Amount"),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                // margin: EdgeInsets.only(left: 30),
                // width: 70,

                ),
          ),
        ],
      ),
    );
  }
}
