import 'dart:convert';

import '../models/fleet_model.dart';

import 'daytrip_expense.dart';
import 'stock_location.dart';

class Plan_trip_product {
  int id;
  String name;
  String state;
  String fromDatetime;
  String toDatetime;
  double duration;
  double duration_hours;
  Vehicle_id? vehicleId;
  Driver_id? driverId;
  Spare1_id? spare1Id;
  Spare2_id? spare2Id;
  List<Route_plan_ids>? routePlanIds;
  List<Expense_ids>? expenseIds;
  List<PlanTrip_Consumption_ids>? consumptionIds;
  double lastOdometer;
  double currentOdometer;
  double tripDistance;
  int totalStandardLiter;
  double totalConsumedLiter;
  double avgCalculation;
  List<Fuelin_ids>? fuelinIds;
  List<Advanced_ids>? advancedIds;
  List<Request_allowance_lines>? requestAllowanceLines;
  double totalAdvance;
  List<Product_ids>? productIds;
  String startTripResponsible;
  String endTripResponsible;
  String code;
  Plan_trip_product(
      {this.id = 0,
      this.name = '',
      this.state = '',
      this.code = '',
      this.fromDatetime = '',
      this.toDatetime = '',
      this.duration = 0.0,
      this.duration_hours = 0.0,
      this.vehicleId,
      this.driverId,
      this.spare1Id,
      this.spare2Id,
      this.routePlanIds,
      this.expenseIds,
      this.consumptionIds,
      this.lastOdometer = 0.0,
      this.currentOdometer = 0.0,
      this.tripDistance = 0.0,
      this.totalStandardLiter = 0,
      this.totalConsumedLiter = 0.0,
      this.avgCalculation = 0.0,
      this.fuelinIds,
      this.advancedIds,
      this.requestAllowanceLines,
      this.totalAdvance = 0.0,
      this.productIds,
      this.startTripResponsible = '',
      this.endTripResponsible = ''});

  Plan_trip_product copyWith({
    int? id,
    String? name,
    String? state,
    String? fromDatetime,
    String? toDatetime,
    double? duration,
    double? duration_hours,
    Vehicle_id? vehicleId,
    Driver_id? driverId,
    Spare1_id? spare1Id,
    Spare2_id? spare2Id,
    List<Route_plan_ids>? routePlanIds,
    List<Expense_ids>? expenseIds,
    List<PlanTrip_Consumption_ids>? consumptionIds,
    double? lastOdometer,
    double? currentOdometer,
    double? tripDistance,
    int? totalStandardLiter,
    double? totalConsumedLiter,
    double? avgCalculation,
    List<Fuelin_ids>? fuelinIds,
    List<Advanced_ids>? advancedIds,
    List<Request_allowance_lines>? requestAllowanceLines,
    double? totalAdvance,
    List<Product_ids>? productIds,
    String? startTripResponsible,
    String? code,
    String? endTripResponsible,
  }) {
    return Plan_trip_product(
        id: id ?? this.id,
        name: name ?? this.name,
        state: state ?? this.state,
        fromDatetime: fromDatetime ?? this.fromDatetime,
        toDatetime: toDatetime ?? this.toDatetime,
        duration: duration ?? this.duration,
        duration_hours: duration_hours ?? this.duration_hours,
        vehicleId: vehicleId ?? this.vehicleId,
        driverId: driverId ?? this.driverId,
        spare1Id: spare1Id ?? this.spare1Id,
        spare2Id: spare2Id ?? this.spare2Id,
        routePlanIds: routePlanIds ?? this.routePlanIds,
        expenseIds: expenseIds ?? this.expenseIds,
        consumptionIds: consumptionIds ?? this.consumptionIds,
        lastOdometer: lastOdometer ?? this.lastOdometer,
        currentOdometer: currentOdometer ?? this.currentOdometer,
        tripDistance: tripDistance ?? this.tripDistance,
        totalStandardLiter: totalStandardLiter ?? this.totalStandardLiter,
        totalConsumedLiter: totalConsumedLiter ?? this.totalConsumedLiter,
        avgCalculation: avgCalculation ?? this.avgCalculation,
        fuelinIds: fuelinIds ?? this.fuelinIds,
        advancedIds: advancedIds ?? this.advancedIds,
        requestAllowanceLines:
            requestAllowanceLines ?? this.requestAllowanceLines,
        totalAdvance: totalAdvance ?? this.totalAdvance,
        productIds: productIds ?? this.productIds,
        startTripResponsible: startTripResponsible ?? this.startTripResponsible,
        code: code ?? this.code,
        endTripResponsible: endTripResponsible ?? this.endTripResponsible);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'from_datetime': fromDatetime,
      'to_datetime': toDatetime,
      'duration': duration,
      'duration_hrs': duration_hours,
      'vehicle_id': vehicleId?.toMap(),
      'driver_id': driverId?.toMap(),
      'spare1_id': spare1Id?.toMap(),
      'spare2_id': spare2Id?.toMap(),
      'route_plan_ids': routePlanIds?.map((x) => x?.toMap())?.toList(),
      'expense_ids': expenseIds?.map((x) => x?.toMap())?.toList(),
      'consumption_ids': consumptionIds?.map((x) => x?.toMap())?.toList(),
      'last_odometer': lastOdometer,
      'current_odometer': currentOdometer,
      'trip_distance': tripDistance,
      'total_standard_liter': totalStandardLiter,
      'total_consumed_liter': totalConsumedLiter,
      'avg_calculation': avgCalculation,
      'fuelin_ids': fuelinIds?.map((x) => x?.toMap())?.toList(),
      'advanced_ids': advancedIds?.map((x) => x?.toMap())?.toList(),
      'request_allowance_lines':
          requestAllowanceLines?.map((x) => x?.toMap())?.toList(),
      'advance_allowed': totalAdvance,
      'product_ids': productIds?.map((x) => x?.toMap())?.toList(),
      'start_trip_responsible': startTripResponsible,
      'code': code,
      'end_trip_responsible': endTripResponsible,
    };
  }

  factory Plan_trip_product.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plan_trip_product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      state: map['state'] ?? '',
      fromDatetime: map['from_datetime'] ?? "",
      toDatetime: map['to_datetime'] ?? "",
      duration: map['duration'] ?? 0.0,
      duration_hours: map['duration_hrs'] ?? 0.0,
      vehicleId: Vehicle_id.fromMap(map['vehicle_id']),
      driverId: Driver_id.fromMap(map['driver_id']),
      spare1Id: Spare1_id.fromMap(map['spare1_id']),
      spare2Id: Spare2_id.fromMap(map['spare2_id']),
      routePlanIds: List<Route_plan_ids>.from(
          map['route_plan_ids']?.map((x) => Route_plan_ids.fromMap(x))),
      expenseIds: List<Expense_ids>.from(
          map['expense_ids']?.map((x) => Expense_ids.fromMap(x))),
      consumptionIds: List<PlanTrip_Consumption_ids>.from(map['consumption_ids']
          ?.map((x) => PlanTrip_Consumption_ids.fromMap(x))),
      lastOdometer: map['last_odometer'] ?? 0.0,
      currentOdometer: map['current_odometer'] ?? 0.0,
      tripDistance: map['trip_distance'] ?? 0.0,
      totalStandardLiter: map['total_standard_liter'] ?? 0,
      totalConsumedLiter: map['total_consumed_liter'] ?? 0.0,
      avgCalculation: map['avg_calculation'] ?? 0.0,
      fuelinIds: List<Fuelin_ids>.from(
          map['fuelin_ids']?.map((x) => Fuelin_ids.fromMap(x))),
      advancedIds: List<Advanced_ids>.from(
          map['advanced_ids']?.map((x) => Advanced_ids.fromMap(x))),
      requestAllowanceLines: List<Request_allowance_lines>.from(
          map['request_allowance_lines']
              ?.map((x) => Request_allowance_lines.fromMap(x))),
      totalAdvance: map['advance_allowed'] ?? 0.0,
      productIds: List<Product_ids>.from(
          map['product_ids']?.map((x) => Product_ids.fromMap(x))),
      startTripResponsible: map['start_trip_responsible'] ?? '',
      endTripResponsible: map['end_trip_responsible'] ?? '',
      code: map['code'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan_trip_product.fromJson(String source) =>
      Plan_trip_product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plan_trip_product(id: $id, name: $name,state: $state,fromDatetime: $fromDatetime,toDatetime: $toDatetime,duration: $duration,duration_hours: $duration_hours,vehicleId: $vehicleId,driverId: $driverId,spare1Id: $spare1Id,spare2Id: $spare2Id,routePlanIds: $routePlanIds,expenseIds: $expenseIds,consumptionIds: $consumptionIds,lastOdometer: $lastOdometer,currentOdometer: $currentOdometer,tripDistance: $tripDistance,totalStandardLiter: $totalStandardLiter,totalConsumedLiter: $totalConsumedLiter,avgCalculation: $avgCalculation,fuelinIds: $fuelinIds,advancedIds: $advancedIds,requestAllowanceLines: $requestAllowanceLines,totalAdvance: $totalAdvance,productIds: $productIds,startTripResponsible: $startTripResponsible,code: $code, endTripResponsible: $endTripResponsible)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plan_trip_product &&
        o.id == id &&
        o.name == name &&
        o.state == state &&
        o.fromDatetime == fromDatetime &&
        o.toDatetime == toDatetime &&
        o.duration == duration &&
        o.duration_hours == duration_hours &&
        o.vehicleId == vehicleId &&
        o.driverId == driverId &&
        o.spare1Id == spare1Id &&
        o.spare2Id == spare2Id &&
        o.routePlanIds == routePlanIds &&
        o.expenseIds == expenseIds &&
        o.consumptionIds == consumptionIds &&
        o.lastOdometer == lastOdometer &&
        o.currentOdometer == currentOdometer &&
        o.tripDistance == tripDistance &&
        o.totalStandardLiter == totalStandardLiter &&
        o.totalConsumedLiter == totalConsumedLiter &&
        o.avgCalculation == avgCalculation &&
        o.fuelinIds == fuelinIds &&
        o.advancedIds == advancedIds &&
        o.requestAllowanceLines == requestAllowanceLines &&
        o.totalAdvance == totalAdvance &&
        o.productIds == productIds &&
        o.startTripResponsible == startTripResponsible &&
        o.code == code &&
        o.endTripResponsible == endTripResponsible;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        id.hashCode ^
        state.hashCode ^
        fromDatetime.hashCode ^
        toDatetime.hashCode ^
        duration.hashCode ^
        duration_hours.hashCode ^
        vehicleId.hashCode ^
        driverId.hashCode ^
        spare1Id.hashCode ^
        spare2Id.hashCode ^
        routePlanIds.hashCode ^
        expenseIds.hashCode ^
        consumptionIds.hashCode ^
        lastOdometer.hashCode ^
        currentOdometer.hashCode ^
        tripDistance.hashCode ^
        totalStandardLiter.hashCode ^
        totalConsumedLiter.hashCode ^
        avgCalculation.hashCode ^
        fuelinIds.hashCode ^
        advancedIds.hashCode ^
        requestAllowanceLines.hashCode ^
        totalAdvance.hashCode ^
        productIds.hashCode ^
        startTripResponsible.hashCode ^
        code.hashCode ^
        endTripResponsible.hashCode;
  }
}

// class Plan_trip_product {
//   int _id;
//   String _name;
//   String _state;
//   String _fromDatetime;
//   String _toDatetime;
//   double _duration;
//   double _duration_hours;
//   Vehicle_id _vehicleId;
//   Driver_id _driverId;
//   Spare1_id _spare1Id;
//   Spare2_id _spare2Id;
//   List<Route_plan_ids> _routePlanIds;
//   List<Expense_ids> _expenseIds;
//   List<PlanTrip_Consumption_ids> _consumptionIds;
//   double _lastOdometer;
//   double _currentOdometer;
//   double _tripDistance;
//   int _totalStandardLiter;
//   double _totalConsumedLiter;
//   double _avgCalculation;
//   List<Fuelin_ids> _fuelinIds;
//   List<Advanced_ids> _advancedIds;
//   List<Request_allowance_lines> _requestAllowanceLines;
//   double _totalAdvance;
//   List<Product_ids> _productIds;

//   int get id => _id;
//   String get name => _name;
//   String get state => _state;
//   String get fromDatetime => _fromDatetime;
//   String get toDatetime => _toDatetime;
//   double get duration => _duration;
//   double get duration_hours => _duration_hours;
//   Vehicle_id get vehicleId => _vehicleId;
//   Driver_id get driverId => _driverId;
//   Spare1_id get spare1Id => _spare1Id;
//   Spare2_id get spare2Id => _spare2Id;
//   List<Route_plan_ids> get routePlanIds => _routePlanIds;
//   List<Expense_ids> get expenseIds => _expenseIds;
//   List<PlanTrip_Consumption_ids> get consumptionIds => _consumptionIds;
//   double get lastOdometer => _lastOdometer;
//   double get currentOdometer => _currentOdometer;
//   double get tripDistance => _tripDistance;
//   int get totalStandardLiter => _totalStandardLiter;
//   double get totalConsumedLiter => _totalConsumedLiter;
//   double get avgCalculation => _avgCalculation;
//   List<Fuelin_ids> get fuelinIds => _fuelinIds;
//   List<Advanced_ids> get advancedIds => _advancedIds;
//   List<Request_allowance_lines> get requestAllowanceLines => _requestAllowanceLines;
//   double get totalAdvance => _totalAdvance;
//   List<Product_ids> get productIds => _productIds;

//   Plan_trip_product({
//       int id,
//       String name,
//       String state,
//       String fromDatetime,
//       String toDatetime,
//       double duration,
//       Vehicle_id vehicleId,
//       Driver_id driverId,
//       Spare1_id spare1Id,
//       Spare2_id spare2Id,
//       List<Route_plan_ids> routePlanIds,
//       List<Expense_ids> expenseIds,
//       List<PlanTrip_Consumption_ids> consumptionIds,
//       double lastOdometer,
//       double currentOdometer,
//       double tripDistance,
//       int totalStandardLiter,
//       double totalConsumedLiter,
//       double avgCalculation,
//       List<Fuelin_ids> fuelinIds,
//       List<Advanced_ids> advancedIds,
//       List<Request_allowance_lines> requestAllowanceLines,
//       double totalAdvance,
//       List<Product_ids> productIds,double duration_hours}){
//     _id = id;
//     _name = name;
//     _state = state;
//     _fromDatetime = fromDatetime;
//     _toDatetime = toDatetime;
//     _duration = duration;
//     _vehicleId = vehicleId;
//     _driverId = driverId;
//     _spare1Id = spare1Id;
//     _spare2Id = spare2Id;
//     _routePlanIds = routePlanIds;
//     _expenseIds = expenseIds;
//     _consumptionIds = consumptionIds;
//     _lastOdometer = lastOdometer;
//     _currentOdometer = currentOdometer;
//     _tripDistance = tripDistance;
//     _totalStandardLiter = totalStandardLiter;
//     _totalConsumedLiter = totalConsumedLiter;
//     _avgCalculation = avgCalculation;
//     _fuelinIds = fuelinIds;
//     _advancedIds = advancedIds;
//     _requestAllowanceLines = requestAllowanceLines;
//     _totalAdvance = totalAdvance;
//     _productIds = productIds;
//     _duration_hours = duration_hours;
// }

//   Plan_trip_product.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["code"];
//     _state = json["state"];
//     _fromDatetime = DateTime.parse(json["from_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
//     _toDatetime = DateTime.parse(json["to_datetime"]).add(Duration(hours: 6,minutes: 30)).toString().replaceAll('.000', '');
//     _duration = json["duration"];
//     _duration_hours = json["duration_hrs"];
//     _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
//     _driverId = json["driver_id"] != null ? Driver_id.fromJson(json["driver_id"]) : null;
//     _spare1Id = json["spare1_id"] != null ? Spare1_id.fromJson(json["spare1_id"]) : null;
//     _spare2Id = json["spare2_id"] != null ? Spare2_id.fromJson(json["spare2_id"]) : null;
//     if (json["route_plan_ids"] != null) {
//       _routePlanIds = [];
//       json["route_plan_ids"].forEach((v) {
//         _routePlanIds.add(Route_plan_ids.fromJson(v));
//       });
//     }
//     if (json["expense_ids"] != null) {
//       _expenseIds = [];
//       json["expense_ids"].forEach((v) {
//         _expenseIds.add(Expense_ids.fromJson(v));
//       });
//     }
//     if (json["consumption_ids"] != null) {
//       _consumptionIds = [];
//       json["consumption_ids"].forEach((v) {
//         _consumptionIds.add(PlanTrip_Consumption_ids.fromJson(v));
//       });
//     }
//     _lastOdometer = json["last_odometer"];
//     _currentOdometer = json["current_odometer"];
//     _tripDistance = json["trip_distance"];
//     _totalStandardLiter = json["total_standard_liter"];
//     _totalConsumedLiter = json["total_consumed_liter"];
//     _avgCalculation = json["avg_calculation"];
//     if (json["fuelin_ids"] != null) {
//       _fuelinIds = [];
//       json["fuelin_ids"].forEach((v) {
//         _fuelinIds.add(Fuelin_ids.fromJson(v));
//       });
//     }
//     if (json["advanced_ids"] != null) {
//       _advancedIds = [];
//       json["advanced_ids"].forEach((v) {
//         _advancedIds.add(Advanced_ids.fromJson(v));
//       });
//     }
//     if (json["request_allowance_lines"] != null) {
//       _requestAllowanceLines = [];
//       json["request_allowance_lines"].forEach((v) {
//         _requestAllowanceLines.add(Request_allowance_lines.fromJson(v));
//       });
//     }
//     _totalAdvance = json["advance_allowed"];

//     if (json["product_ids"] != null) {
//       _productIds = [];
//       json["product_ids"].forEach((v) {
//         _productIds.add(Product_ids.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["state"] = _state;
//     map["from_datetime"] = _fromDatetime;
//     map["to_datetime"] = _toDatetime;
//     map["duration"] = _duration;
//     if (_vehicleId != null) {
//       map["vehicle_id"] = _vehicleId.toJson();
//     }
//     if (_driverId != null) {
//       map["driver_id"] = _driverId.toJson();
//     }
//     if (_spare1Id != null) {
//       map["spare1_id"] = _spare1Id.toJson();
//     }
//     if (_spare2Id != null) {
//       map["spare2_id"] = _spare2Id.toJson();
//     }
//     if (_routePlanIds != null) {
//       map["route_plan_ids"] = _routePlanIds.map((v) => v.toJson()).toList();
//     }
//     if (_expenseIds != null) {
//       map["expense_ids"] = _expenseIds.map((v) => v.toJson()).toList();
//     }
//     if (_consumptionIds != null) {
//       map["consumption_ids"] = _consumptionIds.map((v) => v.toJson()).toList();
//     }
//     map["last_odometer"] = _lastOdometer;
//     map["current_odometer"] = _currentOdometer;
//     map["trip_distance"] = _tripDistance;
//     map["total_standard_liter"] = _totalStandardLiter;
//     map["total_consumed_liter"] = _totalConsumedLiter;
//     map["avg_calculation"] = _avgCalculation;
//     if (_fuelinIds != null) {
//       map["fuelin_ids"] = _fuelinIds.map((v) => v.toJson()).toList();
//     }
//     if (_advancedIds != null) {
//       map["advanced_ids"] = _advancedIds.map((v) => v.toJson()).toList();
//     }
//     if (_requestAllowanceLines != null) {
//       map["request_allowance_lines"] = _requestAllowanceLines.map((v) => v.toJson()).toList();
//     }
//     map["total_advance"] = _totalAdvance;
//     if (_productIds != null) {
//       map["product_ids"] = _productIds.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

/// product_id : {"id":null,"name":null}
/// quantity : 1.0
/// price_unit : 1.0

class Product_ids {
  Product_id? productId;
  double quantity;
  double priceUnit;
  int id;
  Product_uom? productUom;
  Product_ids(
      {this.productId,
      this.quantity = 0.0,
      this.priceUnit = 0.0,
      this.id = 0,
      this.productUom});

  Product_ids copyWith(
      {Product_id? productId,
      double? quantity,
      double? priceUnit,
      int? id,
      Product_uom? productUom}) {
    return Product_ids(
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        priceUnit: priceUnit ?? this.priceUnit,
        id: id ?? this.id,
        productUom: productUom ?? this.productUom);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId?.toMap(),
      'quantity': quantity,
      'price_unit': priceUnit,
      'id': id,
      'product_uom': productUom?.toMap(),
      // 'name': name,
    };
  }

  factory Product_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Product_ids(
      productId: Product_id.fromMap(map['product_id']),
      quantity: map['quantity'] ?? 0.0,
      priceUnit: map['price_unit'] ?? 0.0,
      id: map['id'] ?? 0,
      productUom: Product_uom.fromMap(map['product_uom']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product_ids.fromJson(String source) =>
      Product_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Product_ids(productId: $productId, quantity: $quantity,  priceUnit: $priceUnit,  id: $id,  productUom: $productUom)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product_ids &&
        o.productId == productId &&
        o.quantity == quantity &&
        o.priceUnit == priceUnit &&
        o.id == id &&
        o.productUom == productUom;
  }

  @override
  int get hashCode =>
      productId.hashCode ^
      quantity.hashCode ^
      priceUnit.hashCode ^
      id.hashCode ^
      productUom.hashCode;
}

// class Product_ids {
//   Product_id _productId;
//   double _quantity;
//   double _priceUnit;
//   int _id;
//   Product_uom _productUom;

//   Product_id get productId => _productId;
//   double get quantity => _quantity;
//   double get priceUnit => _priceUnit;
//   int get id => _id;
//   Product_uom get productUom => _productUom;
//   void setQuantity(double qty){
//     _quantity = qty;
//   }
//   Product_ids({
//       Product_id productId,
//       double quantity,
//       double priceUnit}){
//     _productId = productId;
//     _quantity = quantity;
//     _priceUnit = priceUnit;
// }

//   Product_ids.fromJson(dynamic json) {
//     _productId = json["product_id"] != null ? Product_id.fromJson(json["product_id"]) : null;
//     _quantity = json["quantity"];
//     _priceUnit = json["price_unit"];
//     _id = json["id"];
//     _productUom = json["product_uom"] != null ? Product_uom.fromJson(json["product_uom"]) : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_productId != null) {
//       map["product_id"] = _productId.toJson();
//     }
//     map["quantity"] = _quantity;
//     map["price_unit"] = _priceUnit;
//     return map;
//   }

// }
/// id : null
/// name : null
class Product_uom {
  int id;
  String name;
  Product_uom({this.id = 0, this.name = ''});

  Product_uom copyWith({int? id, String? name}) {
    return Product_uom(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Product_uom.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Product_uom(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Product_uom.fromJson(String source) =>
      Product_uom.fromMap(json.decode(source));

  @override
  String toString() => 'Product_uom(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product_uom && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Product_uom {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Product_uom({
//     int id,
//     String name}){
//     _id = id;
//     _name = name;
//   }

//   Product_uom.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

// }
/// id : null
/// name : null

class Product_id {
  int id;
  String name;
  Product_id({this.id = 0, this.name = ''});

  Product_id copyWith({int? id, String? name}) {
    return Product_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Product_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Product_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product_id.fromJson(String source) =>
      Product_id.fromMap(json.decode(source));

  @override
  String toString() => 'Product_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Product_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Product_id({
//     int id,
//     String name}){
//     _id = id;
//     _name = name;
// }

//   Product_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

// }

/// expense_categ_id : {"id":8,"name":"Meal and Entertainment"}
/// quantity : 1.0
/// amount : 1000.0
/// total_amount : 1000.0
/// remark : "dddddd"

class Request_allowance_lines {
  Expense_categ_id? expenseCategId;
  double quantity;
  double amount;
  double totalAmount;
  String remark;
  int id;
  Request_allowance_lines(
      {this.expenseCategId,
      this.quantity = 0.0,
      this.amount = 0.0,
      this.totalAmount = 0.0,
      this.remark = '',
      this.id = 0});

  Request_allowance_lines copyWith({
    Expense_categ_id? expenseCategId,
    double? quantity,
    double? amount,
    double? totalAmount,
    String? remark,
    int? id,
  }) {
    return Request_allowance_lines(
      expenseCategId: expenseCategId ?? this.expenseCategId,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
      remark: remark ?? this.remark,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_categ_id': expenseCategId?.toMap(),
      'quantity': quantity,
      'amount': amount,
      'total_amount': totalAmount,
      'remark': remark,
      'id': id
    };
  }

  factory Request_allowance_lines.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Request_allowance_lines(
      expenseCategId: Expense_categ_id.fromMap(map['expense_categ_id']),
      quantity: map['quantity'] ?? 0.0,
      amount: map['amount'] ?? 0.0,
      totalAmount: map['total_amount'] ?? 0.0,
      remark: map['remark'] ?? "",
      id: map['id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Request_allowance_lines.fromJson(String source) =>
      Request_allowance_lines.fromMap(json.decode(source));

  @override
  String toString() =>
      'Request_allowance_lines(expenseCategId: $expenseCategId, quantity: $quantity, amount: $amount, totalAmount: $totalAmount, remark: $remark, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Request_allowance_lines &&
        o.expenseCategId == expenseCategId &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.totalAmount == totalAmount &&
        o.remark == remark &&
        o.id == id;
  }

  @override
  int get hashCode =>
      expenseCategId.hashCode ^
      quantity.hashCode ^
      amount.hashCode ^
      totalAmount.hashCode ^
      remark.hashCode ^
      id.hashCode;
}

// class Request_allowance_lines {
//   Expense_categ_id _expenseCategId;
//   double _quantity;
//   double _amount;
//   double _totalAmount;
//   String _remark;
//   int _id;

//   Expense_categ_id get expenseCategId => _expenseCategId;
//   double get quantity => _quantity;
//   double get amount => _amount;
//   double get totalAmount => _totalAmount;
//   String get remark => _remark;
//   int get id => _id;

//   Request_allowance_lines({
//       Expense_categ_id expenseCategId,
//       double quantity,
//       double amount,
//       double totalAmount,
//       String remark,int id}){
//     _expenseCategId = expenseCategId;
//     _quantity = quantity;
//     _amount = amount;
//     _totalAmount = totalAmount;
//     _remark = remark;
//     _id = id;
// }

//   Request_allowance_lines.fromJson(dynamic json) {
//     _expenseCategId = json["expense_categ_id"] != null ? Expense_categ_id.fromJson(json["expense_categ_id"]) : null;
//     _quantity = json["quantity"];
//     _amount = json["amount"];
//     _totalAmount = json["total_amount"];
//     _remark = json["remark"];
//     _id = json["id"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_expenseCategId != null) {
//       map["expense_categ_id"] = _expenseCategId.toJson();
//     }
//     map["quantity"] = _quantity;
//     map["amount"] = _amount;
//     map["total_amount"] = _totalAmount;
//     map["remark"] = _remark;
//     return map;
//   }

// }

/// id : 8
/// name : "Meal and Entertainment"

class Expense_categ_id {
  int id;
  String name;
  Expense_categ_id({this.id = 0, this.name = ''});

  Expense_categ_id copyWith({int? id, String? name}) {
    return Expense_categ_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory Expense_categ_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Expense_categ_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense_categ_id.fromJson(String source) =>
      Expense_categ_id.fromMap(json.decode(source));

  @override
  String toString() => 'Expense_categ_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expense_categ_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Expense_categ_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Expense_categ_id({
//       int id,
//       String name}){
//     _id = id;
//     _name = name;
// }

//   Expense_categ_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

// }

/// route_id : {"id":14,"name":"Yangon - Mandalay"}
/// approved_advance : 100000.0

class Advanced_ids {
  Route_id? routeId;
  double approvedAdvance;
  Advanced_ids({this.routeId, this.approvedAdvance = 0.0});

  Advanced_ids copyWith({Route_id? routeId, double? approvedAdvance}) {
    return Advanced_ids(
      routeId: routeId ?? this.routeId,
      approvedAdvance: approvedAdvance ?? this.approvedAdvance,
    );
  }

  Map<String, dynamic> toMap() {
    return {'route_id': routeId?.toMap(), 'approved_advance': approvedAdvance};
  }

  factory Advanced_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Advanced_ids(
      routeId: Route_id.fromMap(map['route_id']),
      approvedAdvance: map['approved_advance'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Advanced_ids.fromJson(String source) =>
      Advanced_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Advanced_ids(routeId: $routeId, approvedAdvance: $approvedAdvance)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Advanced_ids &&
        o.routeId == routeId &&
        o.approvedAdvance == approvedAdvance;
  }

  @override
  int get hashCode => routeId.hashCode ^ approvedAdvance.hashCode;
}

// class Advanced_ids {
//   Route_id _routeId;
//   double _approvedAdvance;

//   Route_id get routeId => _routeId;
//   double get approvedAdvance => _approvedAdvance;

//   Advanced_ids({
//       Route_id routeId,
//       double approvedAdvance}){
//     _routeId = routeId;
//     _approvedAdvance = approvedAdvance;
// }

//   Advanced_ids.fromJson(dynamic json) {
//     _routeId = json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
//     _approvedAdvance = json["approved_advance"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_routeId != null) {
//       map["route_id"] = _routeId.toJson();
//     }
//     map["approved_advance"] = _approvedAdvance;
//     return map;
//   }

// }

/// id : 14
/// name : "Yangon - Mandalay"

class Route_id {
  final int id;
  final String name;
  final String code;
  Route_id({
    this.id = 0,
    this.name = '',
    this.code = ''
  });

  Route_id copyWith({
    int? id,
    String? name,
    String? code
  }) {
    return Route_id(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code
    };
  }

  factory Route_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Route_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      code: map['code'] ?? ""
    );
  }

  String toJson() => json.encode(toMap());

  factory Route_id.fromJson(String source) =>
      Route_id.fromMap(json.decode(source));

  @override
  String toString() => 'Route_id(id: $id, name: $name, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Route_id && o.id == id && o.name == name && o.code == code;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;
}

// class Route_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Route_id({
//       int id,
//       String name}){
//     _id = id;
//     _name = name;
// }

//   Route_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

// }
class Location_id {
  final int id;
  final String name;
  Location_id({
    this.id = 0,
    this.name = '',
  });

  Location_id copyWith({
    int? id,
    String? name,
  }) {
    return Location_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'name': name,
    };
  }

  factory Location_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Location_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
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

// class Location_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Location_id({
//     int id,
//     String name}){
//     _id = id;
//     _name = name;
//   }

//   Location_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }

// }
/// date : "2020-12-31"
/// shop : "Max Energy"
/// product_id : {"id":null,"name":null}
/// slip_no : null
/// liter : 30.0
/// price_unit : 500.0
/// amount : 15000.0

class Fuelin_ids {
  String date;
  String shop;
  Product_id? productId;
  dynamic? slipNo;
  double liter;
  double priceUnit;
  double amount;
  Stock_location? location_id;
  int id;
  bool add_from_office;
  Fuelin_ids(
      {this.date = '',
      this.shop = '',
      this.productId,
      this.slipNo,
      this.liter = 0.0,
      this.priceUnit = 0.0,
      this.amount = 0.0,
      this.location_id,
      this.id = 0,
      this.add_from_office = false});

  Fuelin_ids copyWith({
    String? date,
    String? shop,
    Product_id? productId,
    dynamic? slipNo,
    double? liter,
    double? priceUnit,
    double? amount,
    Stock_location? location_id,
    int? id,
    bool? add_from_office,
  }) {
    return Fuelin_ids(
      date: date ?? this.date,
      shop: shop ?? this.shop,
      productId: productId ?? this.productId,
      slipNo: slipNo ?? this.slipNo,
      liter: liter ?? this.liter,
      priceUnit: priceUnit ?? this.priceUnit,
      amount: amount ?? this.amount,
      location_id: location_id ?? this.location_id,
      id: id ?? this.id,
      add_from_office: add_from_office ?? this.add_from_office,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'shop': shop,
      'product_id': productId?.toMap(),
      'slip_no': slipNo,
      'liter': liter,
      'price_unit': priceUnit,
      'amount': amount,
      'location_id': location_id?.toMap(),
      'id': id,
      'add_from_office': add_from_office,
      // 'name': name,
    };
  }

  factory Fuelin_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuelin_ids(
      date: map['date'],
      shop: map['shop'],
      productId: Product_id.fromMap(map['product_id']),
      slipNo: map['slip_no'],
      liter: map['liter'],
      priceUnit: map['price_unit'],
      amount: map['amount'],
      location_id: Stock_location.fromMap(map['location_id']),
      id: map['id'],
      add_from_office: map['add_from_office'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuelin_ids.fromJson(String source) =>
      Fuelin_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Fuelin_ids(date: $date, shop: $shop,productId: $productId, slipNo: $slipNo,liter: $liter, priceUnit: $priceUnit,amount: $amount, location_id: $location_id,id: $id, add_from_office: $add_from_office)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuelin_ids &&
        o.date == date &&
        o.shop == shop &&
        o.id == id &&
        o.productId == productId &&
        o.slipNo == slipNo &&
        o.liter == liter &&
        o.priceUnit == priceUnit &&
        o.amount == amount &&
        o.location_id == location_id &&
        o.id == id &&
        o.add_from_office == add_from_office;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      shop.hashCode ^
      id.hashCode ^
      productId.hashCode ^
      slipNo.hashCode ^
      liter.hashCode ^
      priceUnit.hashCode ^
      amount.hashCode ^
      location_id.hashCode ^
      id.hashCode ^
      add_from_office.hashCode;
}

// class Fuelin_ids {
//   String _date;
//   String _shop;
//   Product_id _productId;
//   dynamic _slipNo;
//   double _liter;
//   double _priceUnit;
//   double _amount;
//   Stock_location _location_id;
//   int _id;
//   bool _add_from_office;

//   String get date => _date;
//   String get shop => _shop;
//   Product_id get productId => _productId;
//   dynamic get slipNo => _slipNo;
//   double get liter => _liter;
//   double get priceUnit => _priceUnit;
//   double get amount => _amount;
//   Stock_location get location_id => _location_id;
//   int get id => _id;
//   bool get add_from_office => _add_from_office;

//   Fuelin_ids({
//       String date,
//       String shop,
//       Product_id productId,
//       dynamic slipNo,
//       double liter,
//       double priceUnit,
//       double amount,int id,
//       Stock_location location_id}){
//     _date = date;
//     _shop = shop;
//     _productId = productId;
//     _slipNo = slipNo;
//     _liter = liter;
//     _priceUnit = priceUnit;
//     _amount = amount;
//     _id = id;
//     _location_id= location_id;
// }

//   Fuelin_ids.fromJson(dynamic json) {
//     _date = json["date"];
//     _shop = json["shop"];
//     _productId = json["product_id"] != null ? Product_id.fromJson(json["product_id"]) : null;
//     _slipNo = json["slip_no"];
//     _liter = json["liter"];
//     _priceUnit = json["price_unit"];
//     _amount = json["amount"];
//     _location_id = json["location_id"]!= null ? Stock_location.fromJson(json["location_id"]) : null;
//     _id = json["id"];
//     _add_from_office = json["add_from_office"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["date"] = _date;
//     map["shop"] = _shop;
//     if (_productId != null) {
//       map["product_id"] = _productId.toJson();
//     }
//     if (_location_id != null) {
//       map["location_id"] = _location_id.toJson();
//     }
//     map["slip_no"] = _slipNo;
//     map["liter"] = _liter;
//     map["price_unit"] = _priceUnit;
//     map["amount"] = _amount;
//     return map;
//   }

// }

/// is_required : null
/// route_id : {"id":null,"name":null}
/// standard_liter : 0
/// consumed_liter : 0
/// description : null

class PlanTrip_Consumption_ids {
  dynamic? isRequired;
  Route_id? routeId;
  dynamic? standardLiter;
  double consumedLiter;
  dynamic? description;
  int id;
  PlanTrip_Consumption_ids({
    this.isRequired,
    this.routeId,
    this.standardLiter,
    this.consumedLiter = 0.0,
    this.description,
    this.id = 0,
  });

  PlanTrip_Consumption_ids copyWith({
    dynamic? isRequired,
    Route_id? routeId,
    dynamic? standardLiter,
    double? consumedLiter,
    dynamic? description,
    int? id,
  }) {
    return PlanTrip_Consumption_ids(
      isRequired: isRequired ?? this.isRequired,
      routeId: routeId ?? this.routeId,
      standardLiter: standardLiter ?? this.standardLiter,
      consumedLiter: consumedLiter ?? this.consumedLiter,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_required': isRequired,
      'route_id': routeId?.toMap(),
      'standard_liter': standardLiter,
      'consumed_liter': consumedLiter,
      'description': description,
      'id': id,
    };
  }

  factory PlanTrip_Consumption_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PlanTrip_Consumption_ids(
      isRequired: map['is_required'],
      routeId: Route_id.fromMap(map['route_id']),
      standardLiter: map['standard_liter'],
      consumedLiter: map['consumed_liter'],
      description: map['description'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanTrip_Consumption_ids.fromJson(String source) =>
      PlanTrip_Consumption_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlanTrip_Consumption_ids(isRequired: $isRequired, routeId: $routeId,standardLiter: $standardLiter, consumedLiter: $consumedLiter,description: $description, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PlanTrip_Consumption_ids &&
        o.isRequired == isRequired &&
        o.routeId == routeId &&
        o.standardLiter == standardLiter &&
        o.consumedLiter == consumedLiter &&
        o.description == description &&
        o.id == id;
  }

  @override
  int get hashCode =>
      isRequired.hashCode ^
      routeId.hashCode ^
      standardLiter.hashCode ^
      consumedLiter.hashCode ^
      description.hashCode ^
      id.hashCode;
}

// class PlanTrip_Consumption_ids {
//   dynamic _isRequired;
//   Route_id _routeId;
//   dynamic _standardLiter;
//   double _consumedLiter;
//   dynamic _description;
//   int _id;

//   dynamic get isRequired => _isRequired;
//   Route_id get routeId => _routeId;
//   dynamic get standardLiter => _standardLiter;
//   double get consumedLiter => _consumedLiter;
//   int get id => _id;
//   dynamic get description => _description;

//   PlanTrip_Consumption_ids(
//       {dynamic isRequired,
//       Route_id routeId,
//       int standardLiter,
//       double consumedLiter,
//       dynamic description}) {
//     _isRequired = isRequired;
//     _routeId = routeId;
//     _standardLiter = standardLiter;
//     _consumedLiter = consumedLiter;
//     _description = description;
//   }

//   PlanTrip_Consumption_ids.fromJson(dynamic json) {
//     _isRequired = json["is_required"];
//     _routeId =
//         json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
//     _standardLiter = json["standard_liter"];
//     _consumedLiter = json["consumed_liter"];
//     _description = json["description"];
//     _id = json["id"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["is_required"] = _isRequired;
//     if (_routeId != null) {
//       map["route_id"] = _routeId.toJson();
//     }
//     map["standard_liter"] = _standardLiter;
//     map["consumed_liter"] = _consumedLiter;
//     map["description"] = _description;
//     return map;
//   }
// }

/// route_expense_id : {"id":6,"name":"Toll Gate"}
/// standard_amount : 2000.0
/// actual_amount : 0.0

class Expense_ids {
  Route_expense_id? routeExpenseId;
  ERoute_id? eRouteId;
  double standardAmount;
  double actualAmount;
  double overAmount;
  int id;
  String attachement_image;
  String description;
  Expense_ids(
      {this.routeExpenseId,
      this.eRouteId,
      this.standardAmount = 0.0,
      this.actualAmount = 0.0,
      this.overAmount = 0.0,
      this.id = 0,
      this.attachement_image = '',
      this.description = ''});

  Expense_ids copyWith({
    Route_expense_id? routeExpenseId,
    ERoute_id? eRouteId,
    double? standardAmount,
    double? actualAmount,
    double? overAmount,
    int? id,
    String? attachement_image,
    String? description,
  }) {
    return Expense_ids(
      routeExpenseId: routeExpenseId ?? this.routeExpenseId,
      eRouteId: eRouteId ?? this.eRouteId,
      standardAmount: standardAmount ?? this.standardAmount,
      actualAmount: actualAmount ?? this.actualAmount,
      overAmount: overAmount ?? this.overAmount,
      id: id ?? this.id,
      attachement_image: attachement_image ?? this.attachement_image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'route_expense_id': routeExpenseId?.toMap(),
      'route_id': eRouteId?.toMap(),
      'standard_amount': standardAmount,
      'actual_amount': actualAmount,
      'over_amount': overAmount,
      'id': id,
      'attached_file': attachement_image,
      'description': description,
    };
  }

  factory Expense_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Expense_ids(
      routeExpenseId: Route_expense_id.fromMap(map['route_expense_id']),
      eRouteId: ERoute_id.fromMap(map['route_id']),
      standardAmount: map['standard_amount'],
      actualAmount: map['actual_amount'],
      overAmount: map['over_amount'],
      id: map['id'],
      attachement_image: map['attached_file'] ?? "",
      description: map['description'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense_ids.fromJson(String source) =>
      Expense_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Expense_ids(routeExpenseId: $routeExpenseId, eRouteId: $eRouteId,standardAmount: $standardAmount, actualAmount: $actualAmount,overAmount: $overAmount, id: $id,attachement_image: $attachement_image, description: $description)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expense_ids &&
        o.routeExpenseId == routeExpenseId &&
        o.eRouteId == eRouteId &&
        o.standardAmount == standardAmount &&
        o.actualAmount == actualAmount &&
        o.overAmount == overAmount &&
        o.id == id &&
        o.attachement_image == attachement_image &&
        o.description == description;
  }

  @override
  int get hashCode =>
      routeExpenseId.hashCode ^
      eRouteId.hashCode ^
      standardAmount.hashCode ^
      actualAmount.hashCode ^
      overAmount.hashCode ^
      id.hashCode ^
      attachement_image.hashCode ^
      description.hashCode;
}

// class Expense_ids {
//   Route_expense_id _routeExpenseId;
//   ERoute_id _eRouteId;
//   double _standardAmount;
//   double _actualAmount;
//   double _overAmount;
//   int _id;
//   String _attachement_image;
//   String _description;

//   Route_expense_id get routeExpenseId => _routeExpenseId;
//   ERoute_id get eRouteId => _eRouteId;
//   double get standardAmount => _standardAmount;
//   double get actualAmount => _actualAmount;
//   double get overAmount => _overAmount;
//   int get id => _id;
//   String get attachement_image => _attachement_image;
//   String get description => _description;

//   Expense_ids(
//       {Route_expense_id routeExpenseId,
//       ERoute_id eRouteId,
//       double standardAmount,
//       double actualAmount}) {
//     _routeExpenseId = routeExpenseId;
//     _standardAmount = standardAmount;
//     _actualAmount = actualAmount;
//   }

//   Expense_ids.fromJson(dynamic json) {
//     _routeExpenseId = json["route_expense_id"] != null
//         ? Route_expense_id.fromJson(json["route_expense_id"])
//         : null;
//     _eRouteId =
//         json["route_id"] != null ? ERoute_id.fromJson(json["route_id"]) : null;
//     _standardAmount = json["standard_amount"];
//     _actualAmount = json["actual_amount"];
//     _overAmount = json["over_amount"];
//     _id = json['id'];
//     _attachement_image = json['attached_file'];
//     _description = json['description'] != null ? json['description'] : '';
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_routeExpenseId != null) {
//       map["route_expense_id"] = _routeExpenseId.toJson();
//     }
//     if (_eRouteId != null) {
//       map["route_id"] = _eRouteId.toJson();
//     }
//     map["standard_amount"] = _standardAmount;
//     map["actual_amount"] = _actualAmount;
//     return map;
//   }
// }

/// id : 6
/// name : "Toll Gate"

class Route_expense_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Route_expense_id({
    this.id = 0,
    this.name = '',
  });

  Route_expense_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Route_expense_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Route_expense_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Route_expense_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Route_expense_id.fromMap(Map<String, dynamic> map) {
    return new Route_expense_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Route_expense_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Route_expense_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Route_expense_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// route_id : {"id":14,"name":"Yangon - Mandalay"}

class Route_plan_ids {
  dynamic id;
  Route_id routeId;
  dynamic startActualDate;
  dynamic endActualDate;
  dynamic status;
  dynamic fuelBalInputByDriver;
  dynamic routeConsumedFuel;
  List<RouteAttach> attachment_ids;
  Route_plan_ids(
      {this.id,
      required this.routeId,
      this.startActualDate,
      this.endActualDate,
      this.fuelBalInputByDriver,
      this.status,
      required this.attachment_ids,
      this.routeConsumedFuel});

  Route_plan_ids copyWith({
    dynamic id,
    required Route_id routeId,
    dynamic startActualDate,
    dynamic endActualDate,
    dynamic status,
    dynamic fuelBalInputByDriver,
    List<RouteAttach>? attachment_ids,
    dynamic routeConsumedFuel,
  }) {
    return Route_plan_ids(
        id: id ?? this.id,
        routeId: routeId,
        startActualDate: startActualDate ?? this.startActualDate,
        endActualDate: endActualDate ?? this.endActualDate,
        status: status ?? this.status,
        fuelBalInputByDriver:
            fuelBalInputByDriver ?? this.fuelBalInputByDriver,
        attachment_ids: attachment_ids ?? this.attachment_ids,
        routeConsumedFuel: routeConsumedFuel ?? this.routeConsumedFuel);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'route_id': routeId,
      'start_actual_date': startActualDate,
      'end_actual_date': endActualDate,
      'status': status,
      "fuel_bal_input_by_driver": fuelBalInputByDriver,
      "route_consumed_fuel": routeConsumedFuel,
      'attachment_ids': attachment_ids?.map((x) => x?.toMap())?.toList(),
      // 'name': name,
    };
  }

  factory Route_plan_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Route_plan_ids(
        id: map['id'],
        routeId: Route_id.fromMap(map['route_id']),
        startActualDate: map['start_actual_date'],
        endActualDate: map['end_actual_date'],
        status: map['status'],
        fuelBalInputByDriver: map["fuel_bal_input_by_driver"],
        routeConsumedFuel: map["route_consumed_fuel"],
//         attachment_ids: List<PMSAttach>.from(
//   (map['attachment_ids'] as List<dynamic>? ?? []).map((x) => PMSAttach.fromMap(x))
// ),
attachment_ids: (map['attachment_ids'] is List)
    ? List<RouteAttach>.from(
        (map['attachment_ids'] as List)
            .where((x) => x is Map<String, dynamic>) // Only keep maps
            .map((x) => RouteAttach.fromMap(x as Map<String, dynamic>))
      )
    : [],
);
  }

  String toJson() => json.encode(toMap());

  factory Route_plan_ids.fromJson(String source) =>
      Route_plan_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Route_plan_ids(id: $id, routeId: $routeId,startActualDate: $startActualDate, endActualDate: $endActualDate,status: $status,fuelBalInputByDriver: $fuelBalInputByDriver,attachment_ids: $attachment_ids,routeConsumedFuel: $routeConsumedFuel)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Route_plan_ids &&
        o.id == id &&
        o.routeId == routeId &&
        o.startActualDate == startActualDate &&
        o.endActualDate == endActualDate &&
        o.status == status &&
        o.fuelBalInputByDriver == fuelBalInputByDriver &&
        o.attachment_ids == attachment_ids &&
        o.routeConsumedFuel == routeConsumedFuel;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      routeId.hashCode ^
      startActualDate.hashCode ^
      endActualDate.hashCode ^
      status.hashCode ^
      fuelBalInputByDriver.hashCode ^
      attachment_ids.hashCode ^
      routeConsumedFuel.hashCode;
}

// class Route_plan_ids {
//   dynamic _id;
//   Route_id _routeId;
//   dynamic _startActualDate;
//   dynamic _endActualDate;
//   dynamic _status;

//   dynamic get id => _id;
//   Route_id get routeId => _routeId;
//   dynamic get startActualDate => _startActualDate;
//   dynamic get endActualDate => _endActualDate;
//   dynamic get status => _status;

//   Route_plan_ids({Route_id routeId}) {
//     _id = id;
//     _routeId = routeId;
//     _startActualDate = startActualDate;
//     _endActualDate = endActualDate;
//     _status = status;
//   }

//   Route_plan_ids.fromJson(dynamic json) {
//     _id = json["id"];
//     _routeId =
//         json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
//     _startActualDate = json["start_actual_date"];
//     _endActualDate = json["end_actual_date"];
//     _status = json["status"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_routeId != null) {
//       map["route_id"] = _routeId.toJson();
//     }
//     map["start_actual_date"] = _startActualDate;
//     map["end_actual_date"] = _endActualDate;
//     map['status'] = _status;
//     return map;
//   }
// }

/// id : null
/// name : null

class Spare2_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Spare2_id({
    this.id = 0,
    this.name = '',
  });

  Spare2_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Spare2_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Spare2_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spare2_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Spare2_id.fromMap(Map<String, dynamic> map) {
    return new Spare2_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Spare2_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Spare2_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Spare2_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 5053
/// name : "Akar Phyo"

class Spare1_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Spare1_id({
    this.id = 0,
    this.name = '',
  });

  Spare1_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Spare1_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Spare1_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spare1_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Spare1_id.fromMap(Map<String, dynamic> map) {
    return new Spare1_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Spare1_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Spare1_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Spare1_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 5162
/// name : "Aung Myo#1"

class Driver_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Driver_id({
    this.id = 0,
    this.name = '',
  });

  Driver_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Driver_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Driver_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Driver_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Driver_id.fromMap(Map<String, dynamic> map) {
    return new Driver_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Driver_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Driver_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Driver_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 2
/// name : "Opel/Ampera/9a-2786"

class Vehicle_id {
  int id;
  String name;
  dynamic? inchargeId;
  Vehicle_id({this.id = 0, this.name = '', this.inchargeId});

  Vehicle_id copyWith({int? id, String? name, dynamic? inchargeId}) {
    return Vehicle_id(
        id: id ?? this.id,
        name: name ?? this.name,
        inchargeId: inchargeId ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'incharge_id': inchargeId?.toMap(),
      // 'name': name,
    };
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
        id: map['id'],
        name: map['name'],
        inchargeId: Incharge_id.fromMap(map['incharge_id']));
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
        inchargeId.name == inchargeId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ inchargeId.hashCode;
}

// class Vehicle_id {
//   int _id;
//   String _name;
//   dynamic _inchargeId;

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

class ERoute_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const ERoute_id({
    this.id = 0,
    this.name = '',
  });

  ERoute_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new ERoute_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'ERoute_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ERoute_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory ERoute_id.fromMap(Map<String, dynamic> map) {
    return new ERoute_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class ERoute_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   ERoute_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   ERoute_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

class RouteAttach {
  String name;
  String datas;
  RouteAttach({
    this.name = '',
    this.datas = '',
  });


  RouteAttach copyWith({
    String? name,
    String? datas,
  }) {
    return RouteAttach(
      name: name ?? this.name,
      datas: datas ?? this.datas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'datas': datas,
      // 'name': name,
    };
  }

  factory RouteAttach.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RouteAttach(
      name: map['name'] ?? "",
      datas: map['datas'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteAttach.fromJson(String source) => RouteAttach.fromMap(json.decode(source));

  @override
  String toString() => 'RouteAttach(name: $name, datas: $datas)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RouteAttach &&
      o.name == name &&
      o.datas == datas;
  }

  @override
  int get hashCode => name.hashCode ^ datas.hashCode;
}
