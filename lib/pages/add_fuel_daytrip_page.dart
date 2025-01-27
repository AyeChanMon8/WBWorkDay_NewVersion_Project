import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/day_trip_expense_controller.dart';
import '../controllers/daytrip_plantrip_fuel_advance_controller.dart';
import '../localization.dart';
import '../models/day_trip_model.dart';
import '../models/daytrip_expense.dart';
import '../models/plan_trip_product.dart';
import '../models/plantrip_waybill.dart';
import '../models/stock_location.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFuelDaytripPage extends StatelessWidget {
  //final DayTripExpenseController day_trip_controller = Get.find();
  DayTripPlanTripGeneralController day_trip_controller =
      Get.put(DayTripPlanTripGeneralController());
  var arg_id = 0;
  var from_where = "";
  var from_date = "";
  var to_date = "";
  var line_id = 0;
  AddFuelDaytripPage(String from, int daytrip_id, String fromDatetime,
      String toDateTime, FuelIn_ids? fuelInId) {
    day_trip_controller.getProductForFuelTab();
    day_trip_controller.getAddFuelLocation();
    arg_id = daytrip_id;
    from_where = from;
    from_date = fromDatetime;
    to_date = toDateTime;
    if (fuelInId != null) {
      day_trip_controller.dateTextController.text = fuelInId.date;
      day_trip_controller.shopNameTextController.text = fuelInId.shop;
      day_trip_controller.slipNoTextController.text = fuelInId.slip_no;
      day_trip_controller.qtyController.text = fuelInId.liter.toString();
      day_trip_controller.priceController.text = fuelInId.price_unit.toString();
      day_trip_controller.totalFuelInAmtController.text =
          fuelInId.amount.toString();
      day_trip_controller.selectedProduct = null;
      day_trip_controller.selectedLocation = null;
      if (fuelInId.productId != null) {
        day_trip_controller.selectedProductId = fuelInId.productId.id;
        day_trip_controller.getProductForFuelTabId(fuelInId.productId.id);
      }
      if (fuelInId.location_id != null) {
        day_trip_controller.selectedLocationId = fuelInId.location_id.id;
        day_trip_controller.getAddFuelLocationID(fuelInId.location_id.id);
      }
      line_id = fuelInId.id;
    } else {
      day_trip_controller.dateTextController.clear();
      day_trip_controller.shopNameTextController.clear();
      day_trip_controller.slipNoTextController.clear();
      day_trip_controller.qtyController.clear();
      day_trip_controller.priceController.clear();
      day_trip_controller.totalFuelInAmtController.clear();
      day_trip_controller.selectedProduct = null;
      day_trip_controller.selectedProductId = 0;
      day_trip_controller.selectedLocation = null;
      day_trip_controller.selectedLocationId = 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    var labels = AppLocalizations.of(context);

    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: const Size.fromHeight(8.0),
      //     child: appbar(context, 'Add Fuel', '')),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, "Add Fuel", "")),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: TextField(
                        enabled: false,
                        textInputAction: TextInputAction.none,
                        controller: day_trip_controller.dateTextController,
                         decoration: InputDecoration(
                    hintText: (("Choose Date")),
                    border: OutlineInputBorder(),
                  ),
                        onChanged: (text) {},
                      ),
                    )),
              ),
              // Container(
              //           margin: EdgeInsets.only(right: 10, top: 10),
              //           child: Theme(
              //             data: new ThemeData(
              //               primaryColor: textFieldTapColor,
              //             ),
              //             child: InkWell(
              //   onTap: () {
              //     _selectDate(context);
              //   },
              //   child: TextField(
              //     enabled: false,
              //     keyboardType: TextInputType.visiblePassword,
              //     textInputAction: TextInputAction.none,
              //     controller: day_trip_controller.dateTextController,
              //     style: TextStyle(color: Colors.black),
              //     decoration: InputDecoration(
              //       hintText: (("Choose Date")),
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              //           )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      enabled: true,
                      controller: day_trip_controller.shopNameTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Shop Name")),
                      ),
                      onChanged: (text) {},
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              productDropDown(),
              SizedBox(
                height: 20,
              ),
              locationDropDown(),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      enabled: true,
                      controller: day_trip_controller.slipNoTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Slip No")),
                      ),
                      onChanged: (text) {},
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            enabled: true,
                            controller: day_trip_controller.qtyController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: (("Liter")),
                            ),
                            onChanged: (text) {
                              day_trip_controller.calculateAmount();
                            },
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            enabled: true,
                            controller: day_trip_controller.priceController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: (("Price")),
                            ),
                            onChanged: (text) {
                              day_trip_controller.calculateAmount();
                            },
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: textFieldTapColor,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      enabled: true,
                      controller: day_trip_controller.totalFuelInAmtController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: (("Total Amount")),
                      ),
                      onChanged: (text) {
                        day_trip_controller.calculatePriceUnit();
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GFButton(
                  color: textFieldTapColor,
                  onPressed: () {
                    day_trip_controller.addFuel(from_where, arg_id, line_id);
                  },
                  text: "Save",
                  blockButton: true,
                  size: GFSize.LARGE,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationDropDown() {
    // day_trip_controller.selectedLocation = day_trip_controller.location_list[0];
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
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
                      child: DropdownButton<Stock_location>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Location",
                              )),
                          value: day_trip_controller.selectedLocation.id==0 ? null :day_trip_controller.selectedLocation,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Stock_location? value) {
                            day_trip_controller
                                .onChangeLocationDropdown(value!);
                          },
                          items: day_trip_controller.location_list
                              .map((Stock_location category) {
                            return DropdownMenuItem<Stock_location>(
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

  Widget productDropDown() {
    //day_trip_controller.selectedProduct = day_trip_controller.product_list[0];
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
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
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Product",
                              )),
                          value: day_trip_controller.selectedProduct.id==0 ? null : day_trip_controller.selectedProduct,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Daytrip_expense? value) {
                            day_trip_controller.onChangeProductDropdown(value!);
                          },
                          items: day_trip_controller.product_list
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(from_date),
      firstDate: DateTime.parse(from_date),
      lastDate: DateTime.parse(to_date),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Color.fromRGBO(60, 47, 126, 1),
            datePickerTheme: const DatePickerThemeData(
                headerForegroundColor: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none),
                headerBackgroundColor: Color.fromRGBO(60, 47, 126, 1)),
            colorScheme: ColorScheme.light(
              primary: const Color.fromRGBO(60, 47, 126, 1),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),

            highlightColor: Colors.grey[400],
            // textSelectionColor: Colors.grey,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      var formatter = new DateFormat('yyyy-MM-dd');
      String date = formatter.format(picked);
      day_trip_controller.dateTextController.text = date;
      print('selected date : $date');
    }
  }
}
