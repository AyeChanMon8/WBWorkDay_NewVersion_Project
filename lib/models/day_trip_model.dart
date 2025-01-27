import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'fleet_model.dart';

/// id : 2
/// name : "Ygn - Mdy"
/// state : "draft"
/// from_datetime : "2021-01-30 02:39:53"
/// to_datetime : "2021-01-30 16:39:53"
/// duration : 0.5
/// vehicle_id : {"id":4,"name":"Opel/Corsa/4Q/5478"}
/// fuel_type : null
/// odometer : 0
/// odometer_unit : "kilometers"
/// driver_id : {"id":7,"name":"BE GROUP"}
/// spare1_id : {"id":6282,"name":"Shine Aung Kyaw"}
/// spare2_id : {"id":6277,"name":"Sitt Oo"}
/// advanced_request : 100000
/// expense_ids : [{"product_id":{"id":24,"name":"Fuel Expense"},"name":"Fuel Expense","amount":50000}]

class DayTripModel {
  int id;
  String code;
  String state;
  String fromDatetime;
  String toDatetime;
  double duration;
  Vehicle_id? vehicleId;
  dynamic fuelType;
  double odometer;
  String odometerUnit;
  Driver_id? driverId;
  Spare1_id? spare1Id;
  Spare2_id? spare2Id;
  double advancedRequest;
  List<DayTrip_Expense_ids>? expenseIds;
  List<FuelIn_ids>? fuelInIds;
  List<Product_ids>? product_lines;
  List<Advance_ids>? advance_lines;
  List<Consumption_ids>? consumption_ids;
  String startTripResponsible;
  String endTripResponsible;

  DayTripModel(
      {this.id = 0,
      this.code = '',
      this.state = '',
      this.fromDatetime = '',
      this.toDatetime = '',
      this.duration = 0.0,
      this.vehicleId,
      this.fuelType,
      this.odometer = 0.0,
      this.odometerUnit = '',
      this.driverId,
      this.spare1Id,
      this.spare2Id,
      this.advancedRequest = 0.0,
      this.expenseIds,
      this.fuelInIds,
      this.product_lines,
      this.advance_lines,
      this.consumption_ids,
      this.startTripResponsible =  '',
      this.endTripResponsible = ''});

  DayTripModel copyWith(
      {int? id,
      String? code,
      String? state,
      String? fromDatetime,
      String? toDatetime,
      double? duration,
      required Vehicle_id vehicleId,
      required dynamic fuelType,
      double? odometer,
      String? odometerUnit,
      required Driver_id driverId,
      required Spare1_id spare1Id,
      required Spare2_id spare2Id,
      double? advancedRequest,
      required List<DayTrip_Expense_ids> expenseIds,
      required List<FuelIn_ids> fuelInIds,
      required List<Product_ids> product_lines,
      required List<Advance_ids> advance_lines,
      required List<Consumption_ids> consumption_ids,
      String? startTripResponsible,
      String? endTripResponsible}) {
    return DayTripModel(
        id: id ?? this.id,
        code: code ?? this.code,
        state: state ?? this.state,
        fromDatetime: fromDatetime ?? this.fromDatetime,
        toDatetime: toDatetime ?? this.toDatetime,
        duration: duration ?? this.duration,
        vehicleId: vehicleId ?? this.vehicleId,
        fuelType: fuelType ?? this.fuelType,
        odometer: odometer ?? this.odometer,
        odometerUnit: odometerUnit ?? this.odometerUnit,
        driverId: driverId ?? this.driverId,
        spare1Id: spare1Id ?? this.spare1Id,
        spare2Id: spare2Id ?? this.spare2Id,
        advancedRequest: advancedRequest ?? this.advancedRequest,
        expenseIds: expenseIds ?? this.expenseIds,
        fuelInIds: fuelInIds ?? this.fuelInIds,
        product_lines: product_lines ?? this.product_lines,
        advance_lines: advance_lines ?? this.advance_lines,
        consumption_ids: consumption_ids ?? this.consumption_ids,
        startTripResponsible: startTripResponsible ?? this.startTripResponsible,
        endTripResponsible: endTripResponsible ?? this.endTripResponsible);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'state': state,
      'fromDatetime': fromDatetime,
      'toDatetime': toDatetime,
      'duration': duration,
      'vehicle_id': vehicleId?.toMap(),
      'fuel_type': fuelType,
      'odometer': odometer,
      'odometer_unit': odometerUnit,
      'driver_id': driverId?.toMap(),
      'spare1_id': spare1Id?.toMap(),
      'spare2_id': spare2Id?.toMap(),
      'advanced_request': advancedRequest,
      'expense_ids': expenseIds?.map((x) => x?.toMap())?.toList(),
      'fuelin_ids': fuelInIds?.map((x) => x?.toMap())?.toList(),
      'product_lines': product_lines?.map((x) => x?.toMap())?.toList(),
      'request_allowance_lines':
          advance_lines?.map((x) => x?.toMap())?.toList(),
      'consumption_ids': consumption_ids?.map((x) => x?.toMap())?.toList(),
      'start_trip_responsible': startTripResponsible,
      'end_trip_responsible': endTripResponsible,
    };
  }

  factory DayTripModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DayTripModel(
      id: map['id'],
      code: map['code'],
      state: map['state'],
      fromDatetime: map['from_datetime'],
      toDatetime: map['to_datetime'],
      duration: map['duration'],
      vehicleId: Vehicle_id.fromMap(map['vehicle_id']),
      fuelType: map['fuel_type'],
      odometer: map['odometer'],
      odometerUnit: map['odometer_unit'],
      driverId: Driver_id.fromMap(map['driver_id']),
      spare1Id: Spare1_id.fromMap(map['spare1_id']),
      spare2Id: Spare2_id.fromMap(map['spare2_id']),
      advancedRequest: map['advanced_request'] ?? 0.0,
      expenseIds: List<DayTrip_Expense_ids>.from(
          map['expense_ids']?.map((x) => DayTrip_Expense_ids.fromMap(x))),
      fuelInIds: List<FuelIn_ids>.from(
          map['fuelin_ids']?.map((x) => FuelIn_ids.fromMap(x))),
      product_lines: List<Product_ids>.from(
          map['product_lines']?.map((x) => Product_ids.fromMap(x))),
      advance_lines: List<Advance_ids>.from(
          map['request_allowance_lines']?.map((x) => Advance_ids.fromMap(x))),
      consumption_ids: List<Consumption_ids>.from(
          map['consumption_ids']?.map((x) => Consumption_ids.fromMap(x))),
      startTripResponsible: map['start_trip_responsible'] ?? '',
      endTripResponsible: map['end_trip_responsible'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory DayTripModel.fromJson(String source) =>
      DayTripModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DayTripModel(id: $id, code: $code, state: $state, fromDatetime: $fromDatetime, toDatetime: $toDatetime, duration: $duration, vehicleId: $vehicleId, fuelType: $fuelType, odometer: $odometer, odometerUnit: $odometerUnit, driverId: $driverId, spare1Id: $spare1Id, spare2Id: $spare2Id, advanceRequest: $advancedRequest, expenseIds: $expenseIds, fuelInIds: $fuelInIds, product_lines: $product_lines, advance_lines: $advance_lines, consumption_ids: $consumption_ids, startTripResponsible: $startTripResponsible,endTripResponsible: $endTripResponsible)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayTripModel &&
        o.id == id &&
        o.code == code &&
        o.state == state &&
        o.fromDatetime == fromDatetime &&
        o.toDatetime == toDatetime &&
        o.duration == duration &&
        o.vehicleId == vehicleId &&
        o.fuelType == fuelType &&
        o.odometer == odometer &&
        o.odometerUnit == odometerUnit &&
        o.driverId == driverId &&
        o.spare1Id == spare1Id &&
        o.spare2Id == spare2Id &&
        o.advancedRequest == advancedRequest &&
        o.expenseIds == expenseIds &&
        o.fuelInIds == fuelInIds &&
        o.product_lines == product_lines &&
        o.advance_lines == advance_lines &&
        o.consumption_ids == consumption_ids &&
        o.startTripResponsible == startTripResponsible &&
        o.endTripResponsible == endTripResponsible;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        id.hashCode ^
        code.hashCode ^
        state.hashCode ^
        fromDatetime.hashCode ^
        toDatetime.hashCode ^
        duration.hashCode ^
        vehicleId.hashCode ^
        fuelType.hashCode ^
        odometer.hashCode ^
        odometerUnit.hashCode ^
        driverId.hashCode ^
        spare1Id.hashCode ^
        spare2Id.hashCode ^
        advancedRequest.hashCode ^
        expenseIds.hashCode ^
        fuelInIds.hashCode ^
        product_lines.hashCode ^
        advance_lines.hashCode ^
        consumption_ids.hashCode ^
        startTripResponsible.hashCode ^
        endTripResponsible.hashCode;
  }
}

class DayTrip_Expense_ids {
  DayTrip_Product_id productId;
  String name;
  double amount;
  int id;
  String attachement_image;
  DayTrip_Expense_ids(
      {required this.productId,
      this.name = '',
      this.amount = 0.0,
      this.id = 0,
      this.attachement_image = ''});

  DayTrip_Expense_ids copyWith(
      {required DayTrip_Product_id employeeId,
      String? name,
      double? amount,
      int? id,
      String? attachement_image}) {
    return DayTrip_Expense_ids(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        id: id ?? this.id,
        attachement_image: attachement_image ?? this.attachement_image);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId?.toMap(),
      'name': name,
      'amount': amount,
      'id': id,
      'attachement_image': attachement_image
    };
  }

  factory DayTrip_Expense_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DayTrip_Expense_ids(
        productId: DayTrip_Product_id.fromMap(map['product_id']),
        name: map['name'] ?? "",
        amount: map['amount'],
        id: map['id'],
        attachement_image: map['attachement_image'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory DayTrip_Expense_ids.fromJson(String source) =>
      DayTrip_Expense_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'DayTrip_Expense_ids(productId: $productId, name: $name, amount: $amount, id: $id, attachement_image: $attachement_image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayTrip_Expense_ids &&
        o.productId == productId &&
        o.name == name &&
        o.amount == amount &&
        o.id == id &&
        o.attachement_image == attachement_image;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      name.hashCode ^
      amount.hashCode ^
      id.hashCode ^
      attachement_image.hashCode;
}

class FuelIn_ids {
  DayTrip_Product_id productId;
  String date;
  String shop;
  double amount;
  Location_id location_id;
  String slip_no;
  double liter;
  double price_unit;
  int id;
  bool add_from_office;

  FuelIn_ids(
      {required this.productId,
      this.date = '',
      this.shop = '',
      this.amount = 0.0,
      required this.location_id,
      this.slip_no = '',
      this.liter = 0.0,
      this.price_unit = 0.0,
      this.id = 0,
      this.add_from_office = false});

  FuelIn_ids copyWith(
      {required DayTrip_Product_id productId,
      String? date,
      String? shop,
      double? amount,
      required Location_id location_id,
      String? slip_no,
      double? liter,
      double? price_unit,
      int? id,
      bool? add_from_office}) {
    return FuelIn_ids(
        productId: productId ?? this.productId,
        date: date ?? this.date,
        shop: shop ?? this.shop,
        amount: amount ?? this.amount,
        location_id: location_id ?? this.location_id,
        slip_no: slip_no ?? this.slip_no,
        liter: liter ?? this.liter,
        price_unit: price_unit ?? this.price_unit,
        id: id ?? this.id,
        add_from_office: add_from_office ?? this.add_from_office);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId?.toMap(),
      'date': date,
      'shop': shop,
      'amount': amount,
      'location_id': location_id?.toMap(),
      'slip_no': slip_no,
      'liter': liter,
      'price_unit': price_unit,
      'id': id,
      'add_from_office': add_from_office
    };
  }

  factory FuelIn_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return FuelIn_ids(
        productId: DayTrip_Product_id.fromMap(map['product_id']),
        date: map['date'],
        shop: map['shop'],
        amount: map['amount'],
        location_id: Location_id.fromMap(map['location_id']),
        slip_no: map['slip_no']??"",
        liter: map['liter'],
        price_unit: map['price_unit'],
        id: map['id'],
        add_from_office: map['add_from_office'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory FuelIn_ids.fromJson(String source) =>
      FuelIn_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'FuelIn_ids(productId: $productId, date: $date, shop: $shop, amount: $amount, location_id: $location_id, slip_no: $slip_no, liter: $liter, price_unit: $price_unit, id: $id, add_from_office: $add_from_office)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FuelIn_ids &&
        o.productId == productId &&
        o.date == date &&
        o.shop == shop &&
        o.amount == amount &&
        o.location_id == location_id &&
        o.liter == liter &&
        o.price_unit == price_unit &&
        o.id == id &&
        o.add_from_office == add_from_office;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      date.hashCode ^
      shop.hashCode ^
      amount.hashCode ^
      location_id.hashCode ^
      liter.hashCode ^
      price_unit.hashCode ^
      id.hashCode ^
      add_from_office.hashCode;
}

class Product_ids {
  DayTrip_Product_id productId;
  double quantity;
  int id;
  DayTrip_uom uom;

  Product_ids(
      {required this.productId,
      this.quantity = 0.0,
      this.id = 0,
      required this.uom});

  Product_ids copyWith(
      {required DayTrip_Product_id productId,
      double? quantity,
      int? id,
      required DayTrip_uom uom}) {
    return Product_ids(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        id: id ?? this.id,
        uom: uom ?? this.uom);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId?.toMap(),
      'quantity': quantity,
      'id': id,
      'product_uom': uom?.toMap()
    };
  }

  factory Product_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Product_ids(
        productId: DayTrip_Product_id.fromMap(map['product_id']),
        quantity: map['quantity'],
        id: map['id'],
        uom: DayTrip_uom.fromMap(map['product_uom']));
  }

  String toJson() => json.encode(toMap());

  factory Product_ids.fromJson(String source) =>
      Product_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Product_ids(productId: $productId, quantity: $quantity, id: $id, uom: $uom)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product_ids &&
        o.productId == productId &&
        o.quantity == quantity &&
        o.id == id &&
        o.uom == uom;
  }

  @override
  int get hashCode =>
      productId.hashCode ^ quantity.hashCode ^ id.hashCode ^ uom.hashCode;
}

class DayTrip_uom {
  int id;
  String name;

  DayTrip_uom({this.id = 0, this.name = ''});

  DayTrip_uom copyWith({int? id, String? name}) {
    return DayTrip_uom(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory DayTrip_uom.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DayTrip_uom(id: map['id'] ?? 0, name: map['name'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory DayTrip_uom.fromJson(String source) =>
      DayTrip_uom.fromMap(json.decode(source));

  @override
  String toString() => 'DayTrip_uom(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayTrip_uom && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class DayTrip_Product_id {
  int id;
  String name;

  DayTrip_Product_id({this.id = 0, this.name = ''});

  DayTrip_Product_id copyWith({int? id, String? name}) {
    return DayTrip_Product_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory DayTrip_Product_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DayTrip_Product_id(id: map['id'] ?? 0, name: map['name'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory DayTrip_Product_id.fromJson(String source) =>
      DayTrip_Product_id.fromMap(json.decode(source));

  @override
  String toString() => 'DayTrip_Product_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DayTrip_Product_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Location_id {
  int id;
  String name;

  Location_id({this.id = 0, this.name = ''});

  Location_id copyWith({int? id, String? name}) {
    return Location_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Location_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Location_id(id: map['id']??0, name: map['name']??"");
  }

  String toJson() => json.encode(toMap());

  factory Location_id.fromJson(String source) =>
      Location_id.fromMap(json.decode(source));

  @override
  String toString() => 'Location_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Location_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Spare2_id {
  int id;
  String name;

  Spare2_id({this.id = 0, this.name = ''});

  Spare2_id copyWith({int? id, String? name}) {
    return Spare2_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Spare2_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Spare2_id(id: map['id'] ?? 0, name: map['name'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Spare2_id.fromJson(String source) =>
      Spare2_id.fromMap(json.decode(source));

  @override
  String toString() => 'Spare2_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Spare2_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Spare1_id {
  int id;
  String name;

  Spare1_id({this.id = 0, this.name = ''});

  Spare1_id copyWith({int? id, String? name}) {
    return Spare1_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Spare1_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Spare1_id(id: map['id'] ?? 0, name: map['name'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Spare1_id.fromJson(String source) =>
      Spare1_id.fromMap(json.decode(source));

  @override
  String toString() => 'Spare1_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Spare1_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Driver_id {
  int id;
  String name;

  Driver_id({this.id = 0, this.name = ''});

  Driver_id copyWith({int? id, String? name}) {
    return Driver_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Driver_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Driver_id(id: map['id'], name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory Driver_id.fromJson(String source) =>
      Driver_id.fromMap(json.decode(source));

  @override
  String toString() => 'Driver_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Driver_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 4
/// name : "Opel/Corsa/4Q/5478"

// class Vehicle_id {
//   int _id;
//   String _name;
//   Incharge_id _inchargeId;

//   int get id => _id;
//   String get name => _name;
//   dynamic get inchargeId => _inchargeId;

//   Vehicle_id({int id, String name, dynamic inchargeId}) {
//     _id = id;
//     _name = name;
//     _inchargeId = inchargeId;
//   }

//   Vehicle_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _inchargeId = json["incharge_id"] != null
//         ? Incharge_id.fromJson(json["incharge_id"])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     if (_inchargeId != null) {
//       map["incharge_id"] = _inchargeId.toJson();
//     }
//     return map;
//   }
// }

class Vehicle_id {
  final int id;
  final String name;
  Incharge_id? inchargeId;
  Vehicle_id({this.id = 0, this.name = '', this.inchargeId});

  Vehicle_id copyWith({int? id, String? name, Incharge_id? inchargeId}) {
    return Vehicle_id(
        id: id ?? this.id,
        name: name ?? this.name,
        inchargeId: inchargeId ?? this.inchargeId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'incharge_id': inchargeId?.toMap(),
    };
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
        id: map['id'] ?? 0,
        name: map['name'] ?? "",
        inchargeId: map['incharge_id'] == null
            ? null
            : Incharge_id.fromMap(map['incharge_id']));
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() =>
      'Vehicle_id(id: $id, name: $name, inchargeId: $inchargeId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id &&
        o.id == id &&
        o.name == name &&
        o.inchargeId == inchargeId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ inchargeId.hashCode;
}

class Consumption_ids {
  double last_odometer;
  double current_odometer;
  double trip_distance;
  int standard_liter;
  double consumed_liter;
  double avg_calculation;
  dynamic description;
  int id;

  Consumption_ids(
      {this.last_odometer = 0.0,
      this.current_odometer = 0.0,
      this.trip_distance = 0.0,
      this.standard_liter = 0,
      this.consumed_liter = 0.0,
      this.avg_calculation = 0.0,
      this.description = "",
      this.id = 0});

  Consumption_ids copyWith(
      {double? last_odometer,
      double? current_odometer,
      double? trip_distance,
      int? standard_liter,
      double? consumed_liter,
      double? avg_calculation,
      dynamic? description,
      int? id}) {
    return Consumption_ids(
        last_odometer: last_odometer ?? this.last_odometer,
        current_odometer: current_odometer ?? this.current_odometer,
        trip_distance: trip_distance ?? this.trip_distance,
        standard_liter: standard_liter ?? this.standard_liter,
        consumed_liter: consumed_liter ?? this.consumed_liter,
        avg_calculation: avg_calculation ?? this.avg_calculation,
        description: description ?? this.description,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'last_odometer': last_odometer,
      'current_odometer': current_odometer,
      'trip_distance': trip_distance,
      'standard_liter': standard_liter,
      'consumed_liter': consumed_liter,
      'avg_calculation': avg_calculation,
      'description': description,
      'id': id,
    };
  }

  factory Consumption_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Consumption_ids(
      last_odometer: map['last_odometer'],
      current_odometer: map['current_odometer'],
      trip_distance: map['trip_distance'],
      standard_liter: map['standard_liter'],
      consumed_liter: map['consumed_liter'],
      avg_calculation: map['avg_calculation'],
      description: map['description'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Consumption_ids.fromJson(String source) =>
      Consumption_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Consumption_ids(last_odometer: $last_odometer, current_odometer: $current_odometer, trip_distance: $trip_distance, standard_liter: $standard_liter, consumed_liter: $consumed_liter, avg_calculation: $avg_calculation, description: $description, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Consumption_ids &&
        o.last_odometer == last_odometer &&
        o.current_odometer == current_odometer &&
        o.trip_distance == trip_distance &&
        o.standard_liter == standard_liter &&
        o.consumed_liter == consumed_liter &&
        o.avg_calculation == avg_calculation &&
        o.description == description &&
        o.id == id;
  }

  @override
  int get hashCode =>
      last_odometer.hashCode ^
      current_odometer.hashCode ^
      trip_distance.hashCode ^
      standard_liter.hashCode ^
      consumed_liter.hashCode ^
      avg_calculation.hashCode ^
      description.hashCode ^
      id.hashCode;
}

class Advance_ids {
  ExpenseCategory_id expense_categ_id;
  double quantity;
  double amount;
  double total_amount;
  String remark;
  int id;

  Advance_ids(
      {required this.expense_categ_id,
      this.quantity = 0.0,
      this.amount = 0.0,
      this.total_amount = 0,
      this.remark = "",
      this.id = 0});

  Advance_ids copyWith(
      {required ExpenseCategory_id expense_categ_id,
      double? quantity,
      double? amount,
      double? total_amount,
      String? remark,
      int? id}) {
    return Advance_ids(
        expense_categ_id: expense_categ_id ?? this.expense_categ_id,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        total_amount: total_amount ?? this.total_amount,
        remark: remark ?? this.remark,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_categ_id': expense_categ_id?.toMap(),
      'quantity': quantity,
      'amount': amount,
      'total_amount': total_amount,
      'remark': remark,
      'id': id,
    };
  }

  factory Advance_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Advance_ids(
        expense_categ_id:ExpenseCategory_id.fromMap(map['expense_categ_id']) ,
        quantity: map['quantity'],
        amount: map['amount'],
        total_amount: map['total_amount'],
        remark: map['remark'] ?? "",
        id: map['id']);
  }

  String toJson() => json.encode(toMap());

  factory Advance_ids.fromJson(String source) =>
      Advance_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Advance_ids(expense_categ_id: $expense_categ_id, quantity: $quantity, amount: $amount, total_amount: $total_amount, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Advance_ids &&
        o.expense_categ_id == expense_categ_id &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.total_amount == total_amount &&
        o.id == id;
  }

  @override
  int get hashCode =>
      expense_categ_id.hashCode ^
      quantity.hashCode ^
      amount.hashCode ^
      total_amount.hashCode ^
      id.hashCode;
}

class ExpenseCategory_id {
  int id;
  String name;

  ExpenseCategory_id({this.id = 0, this.name = ''});

  ExpenseCategory_id copyWith({int? id, String? name}) {
    return ExpenseCategory_id(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory ExpenseCategory_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ExpenseCategory_id(id: map['id'], name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory ExpenseCategory_id.fromJson(String source) =>
      ExpenseCategory_id.fromMap(json.decode(source));

  @override
  String toString() => 'Driver_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpenseCategory_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
