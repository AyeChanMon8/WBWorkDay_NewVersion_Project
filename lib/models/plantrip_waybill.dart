import 'dart:convert';

import 'fleet_model.dart';

class Plantrip_waybill {
  int id;
  dynamic name;
  String code;
  String state;
  String fromDatetime;
  String toDatetime;
  double duration;
  Vehicle_id? vehicleId;
  Create_uid? createUid;
  Driver_id? driverId;
  Trailer_id? trailerId;
  Spare_id? spareId;
  List<WayBill_Route_plan_ids>? routePlanIds;
  List<Waybill_ids>? waybillIds;
  List<WayBill_Expense_ids>? expenseIds;
  List<Consumption_ids>? consumptionIds;
  double lastOdometer;
  double currentOdometer;
  double tripDistance;
  int totalStandardLiter;
  double totalConsumedLiter;
  double avgCalculation;
  List<Commission_ids>? commissionIds;
  List<WayBill_Fuelin_ids>? fuelinIds;
  List<WayBill_Request_allowance_lines>? requestAllowanceLines;
  double totalAdvance;
  double duration_hours;
  String startTripResponsible;
  String endTripResponsible;
  Plantrip_waybill(
      {this.id = 0,
      this.name = '',
      this.code = '',
      this.state = '',
      this.fromDatetime = '',
      this.toDatetime = '',
      this.duration = 0.0,
      this.vehicleId,
      this.createUid,
      this.driverId,
      this.trailerId,
      this.spareId,
      this.routePlanIds,
      this.waybillIds,
      this.expenseIds,
      this.consumptionIds,
      this.lastOdometer = 0.0,
      this.currentOdometer = 0.0,
      this.tripDistance = 0.0,
      this.totalStandardLiter = 0,
      this.totalConsumedLiter = 0,
      this.avgCalculation = 0.0,
      this.commissionIds,
      this.fuelinIds,
      this.requestAllowanceLines,
      this.totalAdvance = 0.0,
      this.duration_hours = 0.0,
      this.startTripResponsible = '',
      this.endTripResponsible = ''});

  Plantrip_waybill copyWith(
      {int? id,
      dynamic? name,
      String? code,
      String? state,
      String? fromDatetime,
      String? toDatetime,
      double? duration,
      Vehicle_id? vehicleId,
      Create_uid? createUid,
      Driver_id? driverId,
      Trailer_id? trailerId,
      Spare_id? spareId,
      List<WayBill_Route_plan_ids>? routePlanIds,
      List<Waybill_ids>? waybillIds,
      List<WayBill_Expense_ids>? expenseIds,
      List<Consumption_ids>? consumptionIds,
      double? lastOdometer,
      double? currentOdometer,
      double? tripDistance,
      int? totalStandardLiter,
      double? totalConsumedLiter,
      double? avgCalculation,
      List<Commission_ids>? commissionIds,
      List<WayBill_Fuelin_ids>? fuelinIds,
      List<WayBill_Request_allowance_lines>? requestAllowanceLines,
      double? totalAdvance,
      double? duration_hours,
      String? startTripResponsible,
      String? endTripResponsible}) {
    return Plantrip_waybill(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      state: state ?? this.state,
      fromDatetime: fromDatetime ?? this.fromDatetime,
      toDatetime: toDatetime ?? this.toDatetime,
      duration: duration ?? this.duration,
      vehicleId: vehicleId ?? this.vehicleId,
      createUid: createUid ?? this.createUid,
      driverId: driverId ?? this.driverId,
      trailerId: trailerId ?? this.trailerId,
      spareId: spareId ?? this.spareId,
      routePlanIds: routePlanIds ?? this.routePlanIds,
      waybillIds: waybillIds ?? this.waybillIds,
      expenseIds: expenseIds ?? this.expenseIds,
      consumptionIds: consumptionIds ?? this.consumptionIds,
      lastOdometer: lastOdometer ?? this.lastOdometer,
      currentOdometer: currentOdometer ?? this.currentOdometer,
      tripDistance: tripDistance ?? this.tripDistance,
      totalStandardLiter: totalStandardLiter ?? this.totalStandardLiter,
      totalConsumedLiter: totalConsumedLiter ?? this.totalConsumedLiter,
      avgCalculation: avgCalculation ?? this.avgCalculation,
      commissionIds: commissionIds ?? this.commissionIds,
      fuelinIds: fuelinIds ?? this.fuelinIds,
      requestAllowanceLines:
          requestAllowanceLines ?? this.requestAllowanceLines,
      totalAdvance: totalAdvance ?? this.totalAdvance,
      duration_hours: duration_hours ?? this.duration_hours,
      startTripResponsible: startTripResponsible ?? this.startTripResponsible,
      endTripResponsible: endTripResponsible ?? this.endTripResponsible
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'state': state,
      'from_datetime': fromDatetime,
      'to_datetime': toDatetime,
      'duration': duration,
      'vehicle_id': vehicleId?.toMap(),
      'create_uid': createUid?.toMap(),
      'driver_id': driverId?.toMap(),
      'trailer_id': trailerId?.toMap(),
      'spare_id': spareId?.toMap(),
      'route_plan_ids': routePlanIds?.map((x) => x?.toMap())?.toList(),
      'waybill_ids': waybillIds?.map((x) => x?.toMap())?.toList(),
      'expense_ids': expenseIds?.map((x) => x?.toMap())?.toList(),
      'consumption_ids': consumptionIds?.map((x) => x?.toMap())?.toList(),
      'last_odometer': lastOdometer,
      'current_odometer': currentOdometer,
      'trip_distance': tripDistance,
      'total_standard_liter': totalStandardLiter,
      'total_consumed_liter': totalConsumedLiter,
      'avg_calculation': avgCalculation,
      'commission_ids': commissionIds?.map((x) => x?.toMap())?.toList(),
      'fuelin_ids': fuelinIds?.map((x) => x?.toMap())?.toList(),
      'request_allowance_lines':
          requestAllowanceLines?.map((x) => x?.toMap())?.toList(),
      'advance_allowed': totalAdvance,
      'start_trip_responsible': startTripResponsible,
      'end_trip_responsible': endTripResponsible,
      // 'name': name,
    };
  }

  factory Plantrip_waybill.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_waybill(
      id: map['id'] ?? 0,
      name: map['name'],
      code: map['code'] ?? "",
      fromDatetime: map['from_datetime'] ?? "",
      toDatetime: map['to_datetime'] ?? "",
      duration: map['duration'] ?? 0.0,
      state: map['state'] ?? "",
      vehicleId: Vehicle_id.fromMap(map['vehicle_id']),
      createUid: Create_uid.fromMap(map['create_uid']),
      driverId: Driver_id.fromMap(map['driver_id']),
      trailerId: Trailer_id.fromMap(map['trailer_id']),
      spareId: Spare_id.fromMap(map['spare_id']),
      routePlanIds: List<WayBill_Route_plan_ids>.from(
          map['route_plan_ids']?.map((x) => WayBill_Route_plan_ids.fromMap(x))),
      waybillIds: List<Waybill_ids>.from(
          map['waybill_ids']?.map((x) => Waybill_ids.fromMap(x))),
      expenseIds: List<WayBill_Expense_ids>.from(
          map['expense_ids']?.map((x) => WayBill_Expense_ids.fromMap(x))),
      consumptionIds: List<Consumption_ids>.from(
          map['consumption_ids']?.map((x) => Consumption_ids.fromMap(x))),
      lastOdometer: map['last_odometer'] ?? 0.0,
      currentOdometer: map['current_odometer'] ?? 0.0,
      tripDistance: map['trip_distance'] ?? 0.0,
      totalStandardLiter: map['total_standard_liter'] ?? 0,
      totalConsumedLiter: map['total_consumed_liter'] ?? 0.0,
      avgCalculation: map['avg_calculation'] ?? 0.0,
      fuelinIds: List<WayBill_Fuelin_ids>.from(
          map['fuelin_ids']?.map((x) => WayBill_Fuelin_ids.fromMap(x))),
      commissionIds: List<Commission_ids>.from(
          map['commission_ids']?.map((x) => Commission_ids.fromMap(x))),
      requestAllowanceLines: List<WayBill_Request_allowance_lines>.from(
          map['request_allowance_lines']
              ?.map((x) => WayBill_Request_allowance_lines.fromMap(x))),
      totalAdvance: map['advance_allowed'] ?? 0.0,
      startTripResponsible: map['start_trip_responsible'] ?? '',
      endTripResponsible: map['end_trip_responsible'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_waybill.fromJson(String source) =>
      Plantrip_waybill.fromMap(json.decode(source));

  @override
  String toString() =>
      'Plantrip_waybill(id: $id, name: $name,code: $code, fromDatetime: $fromDatetime,toDatetime: $toDatetime, vehicleId: $vehicleId,createUid: $createUid, driverId: $driverId,trailerId: $trailerId, spareId: $spareId,routePlanIds: $routePlanIds, waybillIds: $waybillIds,expenseIds: $expenseIds, consumptionIds: $consumptionIds,lastOdometer: $lastOdometer, currentOdometer: $currentOdometer,tripDistance: $tripDistance, totalStandardLiter: $totalStandardLiter,totalConsumedLiter: $totalConsumedLiter, avgCalculation: $avgCalculation,commissionIds: $commissionIds, fuelinIds: $fuelinIds,requestAllowanceLines: $requestAllowanceLines, totalAdvance: $totalAdvance,state: $state,startTripResponsible: $startTripResponsible, endTripResponsible: $endTripResponsible)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_waybill &&
        o.id == id &&
        o.name == name &&
        o.state == state &&
        o.code == code &&
        o.fromDatetime == fromDatetime &&
        o.toDatetime == toDatetime &&
        o.vehicleId == vehicleId &&
        o.createUid == createUid &&
        o.driverId == driverId &&
        o.trailerId == trailerId &&
        o.spareId == spareId &&
        o.routePlanIds == routePlanIds &&
        o.waybillIds == waybillIds &&
        o.expenseIds == expenseIds &&
        o.consumptionIds == consumptionIds &&
        o.lastOdometer == lastOdometer &&
        o.currentOdometer == currentOdometer &&
        o.tripDistance == tripDistance &&
        o.totalStandardLiter == totalStandardLiter &&
        o.totalConsumedLiter == totalConsumedLiter &&
        o.avgCalculation == avgCalculation &&
        o.commissionIds == commissionIds &&
        o.fuelinIds == fuelinIds &&
        o.requestAllowanceLines == requestAllowanceLines &&
        o.totalAdvance == totalAdvance &&
        o.startTripResponsible == startTripResponsible &&
        o.endTripResponsible == endTripResponsible;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      state.hashCode ^
      fromDatetime.hashCode ^
      toDatetime.hashCode ^
      vehicleId.hashCode ^
      createUid.hashCode ^
      driverId.hashCode ^
      trailerId.hashCode ^
      spareId.hashCode ^
      routePlanIds.hashCode ^
      waybillIds.hashCode ^
      expenseIds.hashCode ^
      consumptionIds.hashCode ^
      lastOdometer.hashCode ^
      currentOdometer.hashCode ^
      tripDistance.hashCode ^
      totalStandardLiter.hashCode ^
      totalConsumedLiter.hashCode ^
      avgCalculation.hashCode ^
      commissionIds.hashCode ^
      fuelinIds.hashCode ^
      requestAllowanceLines.hashCode ^
      totalAdvance.hashCode ^
      startTripResponsible.hashCode ^
      endTripResponsible.hashCode;
}

// class Plantrip_waybill {
//   int _id;
//   dynamic _name;
//   String _code;
//   String _state;
//   String _fromDatetime;
//   String _toDatetime;
//   double _duration;
//   Vehicle_id _vehicleId;
//   Create_uid _createUid;
//   Driver_id _driverId;
//   Trailer_id _trailerId;
//   Spare_id _spareId;
//   List<WayBill_Route_plan_ids> _routePlanIds;
//   List<Waybill_ids> _waybillIds;
//   List<WayBill_Expense_ids> _expenseIds;
//   List<Consumption_ids> _consumptionIds;
//   double _lastOdometer;
//   double _currentOdometer;
//   double _tripDistance;
//   int _totalStandardLiter;
//   double _totalConsumedLiter;
//   double _avgCalculation;
//   List<Commission_ids> _commissionIds;
//   List<WayBill_Fuelin_ids> _fuelinIds;
//   List<WayBill_Request_allowance_lines> _requestAllowanceLines;
//   double _totalAdvance;
//   double _duration_hours;

//   int get id => _id;
//   String get name => _name;
//   String get code => _code;
//   String get state => _state;
//   String get fromDatetime => _fromDatetime;
//   String get toDatetime => _toDatetime;
//   double get duration => _duration;
//   double get duration_hours => _duration_hours;
//   Vehicle_id get vehicleId => _vehicleId;
//   Create_uid get createUid => _createUid;
//   Driver_id get driverId => _driverId;
//   Trailer_id get trailerId => _trailerId;
//   Spare_id get spareId => _spareId;
//   List<WayBill_Route_plan_ids> get routePlanIds => _routePlanIds;
//   List<Waybill_ids> get waybillIds => _waybillIds;
//   List<WayBill_Expense_ids> get expenseIds => _expenseIds;
//   List<Consumption_ids> get consumptionIds => _consumptionIds;
//   double get lastOdometer => _lastOdometer;
//   double get currentOdometer => _currentOdometer;
//   double get tripDistance => _tripDistance;
//   int get totalStandardLiter => _totalStandardLiter;
//   double get totalConsumedLiter => _totalConsumedLiter;
//   double get avgCalculation => _avgCalculation;
//   List<Commission_ids> get commissionIds => _commissionIds;
//   List<WayBill_Fuelin_ids> get fuelinIds => _fuelinIds;
//   List<WayBill_Request_allowance_lines> get requestAllowanceLines =>
//       _requestAllowanceLines;
//   double get totalAdvance => _totalAdvance;

//   Plantrip_waybill(
//       {int id,
//       dynamic name,
//       String code,
//       String state,
//       String fromDatetime,
//       String toDatetime,
//       double duration,
//       Vehicle_id vehicleId,
//       Create_uid createUid,
//       Driver_id driverId,
//       Trailer_id trailerId,
//       Spare_id spareId,
//       List<WayBill_Route_plan_ids> routePlanIds,
//       List<Waybill_ids> waybillIds,
//       List<WayBill_Expense_ids> expenseIds,
//       List<Consumption_ids> consumptionIds,
//       double lastOdometer,
//       double currentOdometer,
//       double tripDistance,
//       int totalStandardLiter,
//       double totalConsumedLiter,
//       double avgCalculation,
//       List<Commission_ids> commissionIds,
//       List<WayBill_Fuelin_ids> fuelinIds,
//       List<WayBill_Request_allowance_lines> requestAllowanceLines,
//       double totalAdvance}) {
//     _id = id;
//     _name = name;
//     _code = code;
//     _state = state;
//     _fromDatetime = fromDatetime;
//     _toDatetime = toDatetime;
//     _duration = duration;
//     _vehicleId = vehicleId;
//     _createUid = createUid;
//     _driverId = driverId;
//     _trailerId = trailerId;
//     _spareId = spareId;
//     _routePlanIds = routePlanIds;
//     _waybillIds = waybillIds;
//     _expenseIds = expenseIds;
//     _consumptionIds = consumptionIds;
//     _lastOdometer = lastOdometer;
//     _currentOdometer = currentOdometer;
//     _tripDistance = tripDistance;
//     _totalStandardLiter = totalStandardLiter;
//     _totalConsumedLiter = totalConsumedLiter;
//     _avgCalculation = avgCalculation;
//     _commissionIds = commissionIds;
//     _fuelinIds = fuelinIds;
//     _requestAllowanceLines = requestAllowanceLines;
//     _totalAdvance = totalAdvance;
//   }

//   Plantrip_waybill.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _code = json["code"];
//     _state = json["state"];
//     _fromDatetime = DateTime.parse(json["from_datetime"])
//         .add(Duration(hours: 6, minutes: 30))
//         .toString()
//         .replaceAll('.000', '');
//     _toDatetime = DateTime.parse(json["to_datetime"])
//         .add(Duration(hours: 6, minutes: 30))
//         .toString()
//         .replaceAll('.000', '');
//     _duration = json["duration"];
//     _duration_hours = json["duration_hrs"];
//     _vehicleId = json["vehicle_id"] != null
//         ? Vehicle_id.fromJson(json["vehicle_id"])
//         : null;
//     _createUid = json["create_uid"] != null
//         ? Create_uid.fromJson(json["create_uid"])
//         : null;
//     _driverId = json["driver_id"] != null
//         ? Driver_id.fromJson(json["driver_id"])
//         : null;
//     _trailerId = json["trailer_id"] != null
//         ? Trailer_id.fromJson(json["trailer_id"])
//         : null;
//     _spareId =
//         json["spare_id"] != null ? Spare_id.fromJson(json["spare_id"]) : null;
//     if (json["route_plan_ids"] != null) {
//       _routePlanIds = [];
//       json["route_plan_ids"].forEach((v) {
//         _routePlanIds.add(WayBill_Route_plan_ids.fromJson(v));
//       });
//     }
//     if (json["waybill_ids"] != null) {
//       _waybillIds = [];
//       json["waybill_ids"].forEach((v) {
//         _waybillIds.add(Waybill_ids.fromJson(v));
//       });
//     }
//     if (json["expense_ids"] != null) {
//       _expenseIds = [];
//       json["expense_ids"].forEach((v) {
//         _expenseIds.add(WayBill_Expense_ids.fromJson(v));
//       });
//     }
//     if (json["consumption_ids"] != null) {
//       _consumptionIds = [];
//       json["consumption_ids"].forEach((v) {
//         _consumptionIds.add(Consumption_ids.fromJson(v));
//       });
//     }
//     _lastOdometer = json["last_odometer"];
//     _currentOdometer = json["current_odometer"];
//     _tripDistance = json["trip_distance"];
//     _totalStandardLiter = json["total_standard_liter"];
//     _totalConsumedLiter = json["total_consumed_liter"];
//     _avgCalculation = json["avg_calculation"];
//     if (json["commission_ids"] != null) {
//       _commissionIds = [];
//       json["commission_ids"].forEach((v) {
//         _commissionIds.add(Commission_ids.fromJson(v));
//       });
//     }
//     if (json["fuelin_ids"] != null) {
//       _fuelinIds = [];
//       json["fuelin_ids"].forEach((v) {
//         _fuelinIds.add(WayBill_Fuelin_ids.fromJson(v));
//       });
//     }
//     if (json["request_allowance_lines"] != null) {
//       _requestAllowanceLines = [];
//       json["request_allowance_lines"].forEach((v) {
//         _requestAllowanceLines.add(WayBill_Request_allowance_lines.fromJson(v));
//       });
//     }
//     _totalAdvance = json["advance_allowed"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["code"] = _code;
//     map["state"] = _state;
//     map["from_datetime"] = _fromDatetime;
//     map["to_datetime"] = _toDatetime;
//     map["duration"] = _duration;
//     if (_vehicleId != null) {
//       map["vehicle_id"] = _vehicleId.toJson();
//     }
//     if (_createUid != null) {
//       map["create_uid"] = _createUid.toJson();
//     }
//     if (_driverId != null) {
//       map["driver_id"] = _driverId.toJson();
//     }
//     if (_trailerId != null) {
//       map["trailer_id"] = _trailerId.toJson();
//     }
//     if (_spareId != null) {
//       map["spare_id"] = _spareId.toJson();
//     }
//     if (_routePlanIds != null) {
//       map["route_plan_ids"] = _routePlanIds.map((v) => v.toJson()).toList();
//     }
//     if (_waybillIds != null) {
//       map["waybill_ids"] = _waybillIds.map((v) => v.toJson()).toList();
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
//     if (_commissionIds != null) {
//       map["commission_ids"] = _commissionIds.map((v) => v.toJson()).toList();
//     }
//     if (_fuelinIds != null) {
//       map["fuelin_ids"] = _fuelinIds.map((v) => v.toJson()).toList();
//     }
//     if (_requestAllowanceLines != null) {
//       map["request_allowance_lines"] =
//           _requestAllowanceLines.map((v) => v.toJson()).toList();
//     }
//     map["total_advance"] = _totalAdvance;
//     return map;
//   }
// }

/// expense_categ_id : {"id":7,"name":"Transportation"}
/// quantity : 1.0
/// amount : 3900.0
/// total_amount : 3900.0
/// remark : "erererere"

class WayBill_Request_allowance_lines {
  WayBill_Expense_categ_id? expenseCategId;
  double quantity;
  double amount;
  double totalAmount;
  String remark;
  int id;
  WayBill_Request_allowance_lines({
    this.expenseCategId,
    this.quantity = 0.0,
    this.amount = 0.0,
    this.totalAmount = 0.0,
    this.remark = '',
    this.id = 0,
  });

  WayBill_Request_allowance_lines copyWith({
    WayBill_Expense_categ_id? expenseCategId,
    double? quantity,
    double? amount,
    double? totalAmount,
    String? remark,
    int? id,
  }) {
    return WayBill_Request_allowance_lines(
        expenseCategId: expenseCategId ?? this.expenseCategId,
        quantity: quantity ?? this.quantity,
        amount: amount ?? this.amount,
        totalAmount: totalAmount ?? this.totalAmount,
        remark: remark ?? this.remark,
        id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {
      'expense_categ_id': expenseCategId?.toMap(),
      'quantity': quantity,
      'amount': amount,
      'total_amount': totalAmount,
      'remark': remark,
      'id': id,
    };
  }

  factory WayBill_Request_allowance_lines.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WayBill_Request_allowance_lines(
        expenseCategId:
            WayBill_Expense_categ_id.fromMap(map['expense_categ_id']),
        quantity: map['quantity'],
        amount: map['amount'],
        totalAmount: map['total_amount'],
        remark: map['remark'] ?? "",
        id: map['id']);
  }

  String toJson() => json.encode(toMap());

  factory WayBill_Request_allowance_lines.fromJson(String source) =>
      WayBill_Request_allowance_lines.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WayBill_Request_allowance_lines(expenseCategId: $expenseCategId, quantity: $quantity, amount: $amount, totalAmount: $totalAmount, remark: $remark, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WayBill_Request_allowance_lines &&
        o.expenseCategId == expenseCategId &&
        o.quantity == quantity &&
        o.amount == amount &&
        o.totalAmount == totalAmount &&
        o.remark == remark &&
        o.id == id;
  }

  @override
  int get hashCode {
    return expenseCategId.hashCode ^
        quantity.hashCode ^
        amount.hashCode ^
        totalAmount.hashCode ^
        remark.hashCode ^
        id.hashCode;
  }
}

// class WayBill_Request_allowance_lines {
//   WayBill_Expense_categ_id _expenseCategId;
//   double _quantity;
//   double _amount;
//   double _totalAmount;
//   String _remark;
//   int _id;

//   WayBill_Expense_categ_id get expenseCategId => _expenseCategId;
//   double get quantity => _quantity;
//   double get amount => _amount;
//   double get totalAmount => _totalAmount;
//   String get remark => _remark;
//   int get id => _id;
//   WayBill_Request_allowance_lines(
//       {WayBill_Expense_categ_id expenseCategId,
//       double quantity,
//       double amount,
//       double totalAmount,
//       String remark,
//       int id}) {
//     _expenseCategId = expenseCategId;
//     _quantity = quantity;
//     _amount = amount;
//     _totalAmount = totalAmount;
//     _remark = remark;
//     _id = id;
//   }

//   WayBill_Request_allowance_lines.fromJson(dynamic json) {
//     _expenseCategId = json["expense_categ_id"] != null
//         ? WayBill_Expense_categ_id.fromJson(json["expense_categ_id"])
//         : null;
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

/// id : 7
/// name : "Transportation"

class WayBill_Expense_categ_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const WayBill_Expense_categ_id({
    this.id = 0,
    this.name = '',
  });

  WayBill_Expense_categ_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new WayBill_Expense_categ_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'WayBill_Expense_categ_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WayBill_Expense_categ_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory WayBill_Expense_categ_id.fromMap(Map<String, dynamic> map) {
    return new WayBill_Expense_categ_id(
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

// class WayBill_Expense_categ_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   WayBill_Expense_categ_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   WayBill_Expense_categ_id.fromJson(dynamic json) {
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

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Location_id({
    this.id = 0,
    this.name = '',
  });

  Location_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Location_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Location_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Location_id.fromMap(Map<String, dynamic> map) {
    return new Location_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? ""
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

// class Location_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Location_id({int id, String name}) {
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

/// date : "2021-03-19"
/// shop : "wwwww"
/// product_id : {"id":null,"name":null}
/// slip_no : "22222"
/// liter : 1.0
/// price_unit : 30000.0
/// amount : 30000.0

class WayBill_Fuelin_ids {
  String date;
  String shop;
  WayBill_Product_id? productId;
  String slipNo;
  double liter;
  double priceUnit;
  double amount;
  Location_id? location_id;
  int id;
  bool add_from_office;
  WayBill_Fuelin_ids(
      {this.date = '',
      this.shop = '',
      this.productId,
      this.slipNo = '',
      this.liter = 0.0,
      this.priceUnit = 0.0,
      this.amount = 0.0,
      this.location_id,
      this.id = 0,
      this.add_from_office = false});

  WayBill_Fuelin_ids copyWith({
    String? date,
    String? shop,
    WayBill_Product_id? productId,
    String? slipNo,
    double? liter,
    double? priceUnit,
    double? amount,
    Location_id? location_id,
    int? id,
    bool? add_from_office,
  }) {
    return WayBill_Fuelin_ids(
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
      'location_id': location_id?.toMap(),
      'id': id,
      'add_from_office': add_from_office
    };
  }

  factory WayBill_Fuelin_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WayBill_Fuelin_ids(
        date: map['date'],
        shop: map['shop'] ?? "",
        productId: WayBill_Product_id.fromMap(map['product_id']),
        slipNo: map['slip_no'] ?? "",
        liter: map['liter'],
        priceUnit: map['price_unit'],
        location_id: Location_id.fromMap(map['location_id']),
        id: map['id'],
        add_from_office: map['add_from_office'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory WayBill_Fuelin_ids.fromJson(String source) =>
      WayBill_Fuelin_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'WayBill_Fuelin_ids(date: $date, shop: $shop, productId: $productId,slipNo: $slipNo, liter: $liter,priceUnit: $priceUnit, location_id: $location_id,id: $id, add_from_office: $add_from_office)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WayBill_Fuelin_ids &&
        o.date == date &&
        o.shop == shop &&
        o.productId == productId &&
        o.slipNo == slipNo &&
        o.liter == liter &&
        o.priceUnit == priceUnit &&
        o.location_id == location_id &&
        o.id == id &&
        o.add_from_office == add_from_office;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      shop.hashCode ^
      productId.hashCode ^
      slipNo.hashCode ^
      liter.hashCode ^
      slipNo.hashCode ^
      liter.hashCode ^
      priceUnit.hashCode ^
      location_id.hashCode ^
      id.hashCode ^
      add_from_office.hashCode;
}

// class WayBill_Fuelin_ids {
//   String _date;
//   String _shop;
//   WayBill_Product_id _productId;
//   String _slipNo;
//   double _liter;
//   double _priceUnit;
//   double _amount;
//   Location_id _location_id;
//   int _id;
//   bool _add_from_office;

//   String get date => _date;
//   String get shop => _shop;
//   WayBill_Product_id get productId => _productId;
//   String get slipNo => _slipNo;
//   double get liter => _liter;
//   double get priceUnit => _priceUnit;
//   double get amount => _amount;
//   Location_id get location_id => _location_id;
//   bool get add_from_office => _add_from_office;
//   int get id => _id;

//   WayBill_Fuelin_ids(
//       {String date,
//       String shop,
//       WayBill_Product_id productId,
//       String slipNo,
//       double liter,
//       double priceUnit,
//       double amount,
//       int id,
//       Location_id location_id}) {
//     _date = date;
//     _shop = shop;
//     _productId = productId;
//     _slipNo = slipNo;
//     _liter = liter;
//     _priceUnit = priceUnit;
//     _amount = amount;
//     _id = id;
//     _location_id = location_id;
//   }

//   WayBill_Fuelin_ids.fromJson(dynamic json) {
//     _date = json["date"];
//     _shop = json["shop"];
//     _productId = json["product_id"] != null
//         ? WayBill_Product_id.fromJson(json["product_id"])
//         : null;
//     _slipNo = json["slip_no"];
//     _liter = json["liter"];
//     _priceUnit = json["price_unit"];
//     _amount = json["amount"];
//     _location_id = json["location_id"] != null
//         ? Location_id.fromJson(json["location_id"])
//         : null;
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

/// id : null
/// name : null

class WayBill_Product_id {
  int id;
  String name;
  WayBill_Product_id({this.id = 0, this.name = ''});

  WayBill_Product_id copyWith({int? id, String? name}) {
    return WayBill_Product_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory WayBill_Product_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WayBill_Product_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WayBill_Product_id.fromJson(String source) =>
      WayBill_Product_id.fromMap(json.decode(source));

  @override
  String toString() => 'WayBill_Product_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WayBill_Product_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class WayBill_Product_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   WayBill_Product_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   WayBill_Product_id.fromJson(dynamic json) {
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

/// route_id : {"id":15,"name":"Mandalay - Yangon"}
/// commission_driver : 10000
/// commission_spare : 0

class Commission_ids {
  Route_id? routeId;
  int commissionDriver;
  int commissionSpare;
  Commission_ids(
      {this.routeId, this.commissionDriver = 0, this.commissionSpare = 0});

  Commission_ids copyWith(
      {Route_id? routeId, int? commissionDriver, int? commissionSpare}) {
    return Commission_ids(
      routeId: routeId ?? this.routeId,
      commissionDriver: commissionDriver ?? this.commissionDriver,
      commissionSpare: commissionSpare ?? this.commissionSpare,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'route_id': routeId?.toMap(),
      'commission_driver': commissionDriver,
      'commission_spare': commissionSpare
    };
  }

  factory Commission_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Commission_ids(
      routeId: Route_id.fromMap(map['route_id']),
      commissionDriver: map['commission_driver'],
      commissionSpare: map['commission_spare'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Commission_ids.fromJson(String source) =>
      Commission_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Commission_ids(routeId: $routeId, commissionDriver: $commissionDriver, commissionSpare: $commissionSpare)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Commission_ids &&
        o.routeId == routeId &&
        o.commissionDriver == commissionDriver &&
        o.commissionSpare == commissionSpare;
  }

  @override
  int get hashCode =>
      routeId.hashCode ^ commissionDriver.hashCode ^ commissionSpare.hashCode;
}

// class Commission_ids {
//   Route_id _routeId;
//   int _commissionDriver;
//   int _commissionSpare;

//   Route_id get routeId => _routeId;
//   int get commissionDriver => _commissionDriver;
//   int get commissionSpare => _commissionSpare;

//   Commission_ids(
//       {Route_id routeId, int commissionDriver, int commissionSpare}) {
//     _routeId = routeId;
//     _commissionDriver = commissionDriver;
//     _commissionSpare = commissionSpare;
//   }

//   Commission_ids.fromJson(dynamic json) {
//     _routeId =
//         json["route_id"] != null ? Route_id.fromJson(json["route_id"]) : null;
//     _commissionDriver = json["commission_driver"];
//     _commissionSpare = json["commission_spare"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_routeId != null) {
//       map["route_id"] = _routeId.toJson();
//     }
//     map["commission_driver"] = _commissionDriver;
//     map["commission_spare"] = _commissionSpare;
//     return map;
//   }
// }

/// id : 15
/// name : "Mandalay - Yangon"

class Route_id {
  int id;
  String name;
  String code;
  Route_id({this.id = 0, this.name = '',this.code = ''});

  Route_id copyWith({int? id, String? name}) {
    return Route_id(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'code': code};
  }

  factory Route_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Route_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      code: map['code'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Route_id.fromJson(String source) =>
      Route_id.fromMap(json.decode(source));

  @override
  String toString() => 'Route_id(id: $id, name: $name,code: $code)';

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

//   Route_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

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

/// is_required : null
/// route_id : {"id":15,"name":"Mandalay - Yangon"}
/// standard_liter : 100
/// consumed_liter : 0
/// description : null

class Consumption_ids {
  dynamic? isRequired;
  Route_id? routeId;
  dynamic? standardLiter;
  double consumedLiter;
  dynamic? description;
  int id;
  Consumption_ids(
      {this.isRequired,
      this.routeId,
      this.standardLiter,
      this.consumedLiter = 0.0,
      this.description,
      this.id = 0});

  Consumption_ids copyWith(
      {dynamic? isRequired,
      Route_id? routeId,
      dynamic? standardLiter,
      double? consumedLiter,
      dynamic? description,
      int? id}) {
    return Consumption_ids(
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

  factory Consumption_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Consumption_ids(
      isRequired: map['is_required'],
      routeId: Route_id.fromMap(map['route_id']),
      standardLiter: map['standard_liter'],
      consumedLiter: map['consumed_liter'],
      description: map['description'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Consumption_ids.fromJson(String source) =>
      Consumption_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Consumption_ids(isRequired: $isRequired, routeId: $routeId,standardLiter: $standardLiter, consumedLiter: $consumedLiter,description: $description, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Consumption_ids &&
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
// class Consumption_ids {
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
//   dynamic get description => _description;
//   int get id => _id;
//   Consumption_ids(
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

//   Consumption_ids.fromJson(dynamic json) {
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

/// route_expense_id : {"id":8,"name":"Toll Gate"}
/// standard_amount : 5000.0
/// actual_amount : 0.0

class WayBill_Expense_ids {
  Route_expense_id? routeExpenseId;
  ERoute_id? eRouteId;
  double standardAmount;
  double actualAmount;
  double overAmount;
  int id;
  String description;
  String attachement;
  WayBill_Expense_ids(
      {this.routeExpenseId,
      this.eRouteId,
      this.standardAmount = 0.0,
      this.actualAmount = 0.0,
      this.overAmount = 0.0,
      this.id = 0,
      this.description = '',
      this.attachement = ''});

  WayBill_Expense_ids copyWith(
      {Route_expense_id? routeExpenseId,
      ERoute_id? eRouteId,
      double? standardAmount,
      double? actualAmount,
      double? overAmount,
      int? id,
      String? description,
      String? attachement}) {
    return WayBill_Expense_ids(
      routeExpenseId: routeExpenseId ?? this.routeExpenseId,
      eRouteId: eRouteId ?? this.eRouteId,
      standardAmount: standardAmount ?? this.standardAmount,
      actualAmount: actualAmount ?? this.actualAmount,
      overAmount: overAmount ?? this.overAmount,
      id: id ?? this.id,
      description: description ?? this.description,
      attachement: attachement ?? this.attachement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'route_expense_id': routeExpenseId?.toMap(),
      'route_id': eRouteId?.toMap(),
      'standard_amount': standardAmount,
      'actual_amount': actualAmount,
      'over_amount': overAmount,
      'description': description,
      'id': id,
      'attached_file': attachement,
    };
  }

  factory WayBill_Expense_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WayBill_Expense_ids(
      routeExpenseId: Route_expense_id.fromMap(map['route_expense_id']),
      eRouteId: ERoute_id.fromMap(map['route_id']),
      standardAmount: map['standard_amount'],
      actualAmount: map['actual_amount'],
      overAmount: map['over_amount'],
      description: map['description'] ?? "",
      id: map['id'],
      attachement: map['attached_file'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WayBill_Expense_ids.fromJson(String source) =>
      WayBill_Expense_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'WayBill_Expense_ids(routeExpenseId: $routeExpenseId, eRouteId: $eRouteId,standardAmount: $standardAmount, actualAmount: $actualAmount,overAmount: $overAmount, description: $description, id: $id, attachement: $attachement)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WayBill_Expense_ids &&
        o.routeExpenseId == routeExpenseId &&
        o.eRouteId == eRouteId &&
        o.standardAmount == standardAmount &&
        o.actualAmount == actualAmount &&
        o.overAmount == overAmount &&
        o.description == description &&
        o.id == id &&
        o.attachement == attachement;
  }

  @override
  int get hashCode =>
      routeExpenseId.hashCode ^
      eRouteId.hashCode ^
      standardAmount.hashCode ^
      actualAmount.hashCode ^
      overAmount.hashCode ^
      description.hashCode ^
      id.hashCode ^
      attachement.hashCode;
}
// class WayBill_Expense_ids {
//   Route_expense_id _routeExpenseId;
//   ERoute_id _eRouteId;
//   double _standardAmount;
//   double _actualAmount;
//   double _overAmount;
//   int _id;
//   String _description;
//   String _attachement;
//   Route_expense_id get routeExpenseId => _routeExpenseId;
//   ERoute_id get eRouteId => _eRouteId;
//   double get standardAmount => _standardAmount;
//   double get actualAmount => _actualAmount;
//   double get overAmount => _overAmount;
//   int get id => _id;
//   String get attachement => _attachement;
//   String get description => _description;
//   WayBill_Expense_ids(
//       {Route_expense_id routeExpenseId,
//       ERoute_id eRouteId,
//       double standardAmount,
//       double actualAmount}) {
//     _routeExpenseId = routeExpenseId;
//     _standardAmount = standardAmount;
//     _actualAmount = actualAmount;
//   }

//   WayBill_Expense_ids.fromJson(dynamic json) {
//     _routeExpenseId = json["route_expense_id"] != null
//         ? Route_expense_id.fromJson(json["route_expense_id"])
//         : null;
//     _eRouteId =
//         json["route_id"] != null ? ERoute_id.fromJson(json["route_id"]) : null;
//     _standardAmount = json["standard_amount"];
//     _actualAmount = json["actual_amount"];
//     _overAmount = json["over_amount"];
//     _id = json["id"];
//     _attachement = json["attached_file"];
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
//     map["attached_file"] = _attachement;

//     return map;
//   }
// }

/// id : 8
/// name : "Toll Gate"

class Route_expense_id {
  int id = 0;
  String name = "";
  Route_expense_id({
    this.id = 0,
    this.name = '',
  });

  Route_expense_id copyWith({
    int? id,
    String? name,
  }) {
    return Route_expense_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Route_expense_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Route_expense_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Route_expense_id.fromJson(String source) =>
      Route_expense_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Route_expense_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Route_expense_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
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

class ERoute_id {
  int id = 0;
  String name = "";
  ERoute_id({
    this.id = 0,
    this.name = '',
  });

  ERoute_id copyWith({
    int? id,
    String? name,
  }) {
    return ERoute_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory ERoute_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ERoute_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ERoute_id.fromJson(String source) =>
      ERoute_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ERoute_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ERoute_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
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

/// account_move_id : {"id":null,"name":null}
/// partner_id : {"id":null,"name":null}
/// date : null
/// amount : 0.0
/// state : null

class Waybill_ids {
  Account_move_id? accountMoveId;
  Partner_id? partnerId;
  dynamic? date;
  double amount;
  dynamic? state;
  Waybill_ids(
      {this.accountMoveId,
      this.partnerId,
      this.date,
      this.amount = 0.0,
      this.state});

  Waybill_ids copyWith({
    Account_move_id? accountMoveId,
    Partner_id? partnerId,
    dynamic? date,
    double? amount,
    dynamic? state,
  }) {
    return Waybill_ids(
        accountMoveId: accountMoveId ?? this.accountMoveId,
        partnerId: partnerId ?? this.partnerId,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        state: state ?? this.state);
  }

  Map<String, dynamic> toMap() {
    return {
      'route_expense_id': accountMoveId?.toMap(),
      'partner_id': partnerId?.toMap(),
      'date': date,
      'amount': amount,
      'state': state
    };
  }

  factory Waybill_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Waybill_ids(
      accountMoveId: Account_move_id.fromMap(map['account_move_id']),
      partnerId: Partner_id.fromMap(map['partner_id']),
      date: map['date'],
      amount: map['amount'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Waybill_ids.fromJson(String source) =>
      Waybill_ids.fromMap(json.decode(source));

  @override
  String toString() =>
      'Waybill_ids(accountMoveId: $accountMoveId, partnerId: $partnerId,date: $date, amount: $amount,state: $state)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Waybill_ids &&
        o.accountMoveId == accountMoveId &&
        o.partnerId == partnerId &&
        o.date == date &&
        o.amount == amount &&
        o.state == state;
  }

  @override
  int get hashCode =>
      accountMoveId.hashCode ^
      partnerId.hashCode ^
      date.hashCode ^
      amount.hashCode ^
      state.hashCode;
}

// class Waybill_ids {
//   Account_move_id _accountMoveId;
//   Partner_id _partnerId;
//   dynamic _date;
//   double _amount;
//   dynamic _state;

//   Account_move_id get accountMoveId => _accountMoveId;
//   Partner_id get partnerId => _partnerId;
//   dynamic get date => _date;
//   double get amount => _amount;
//   dynamic get state => _state;

//   Waybill_ids(
//       {Account_move_id accountMoveId,
//       Partner_id partnerId,
//       dynamic date,
//       double amount,
//       dynamic state}) {
//     _accountMoveId = accountMoveId;
//     _partnerId = partnerId;
//     _date = date;
//     _amount = amount;
//     _state = state;
//   }

//   Waybill_ids.fromJson(dynamic json) {
//     _accountMoveId = json["account_move_id"] != null
//         ? Account_move_id.fromJson(json["account_move_id"])
//         : null;
//     _partnerId = json["partner_id"] != null
//         ? Partner_id.fromJson(json["partner_id"])
//         : null;
//     _date = json["date"];
//     _amount = json["amount"];
//     _state = json["state"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_accountMoveId != null) {
//       map["account_move_id"] = _accountMoveId.toJson();
//     }
//     if (_partnerId != null) {
//       map["partner_id"] = _partnerId.toJson();
//     }
//     map["date"] = _date;
//     map["amount"] = _amount;
//     map["state"] = _state;
//     return map;
//   }
// }

/// id : null
/// name : null

class Partner_id {
  int id = 0;
  String name = "";
  Partner_id({
    this.id = 0,
    this.name = '',
  });

  Partner_id copyWith({
    int? id,
    String? name,
  }) {
    return Partner_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Partner_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Partner_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner_id.fromJson(String source) =>
      Partner_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Partner_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Partner_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Partner_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Partner_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Partner_id.fromJson(dynamic json) {
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

class Account_move_id {
  int id = 0;
  String name = "";
  Account_move_id({
    this.id = 0,
    this.name = '',
  });

  Account_move_id copyWith({
    int? id,
    String? name,
  }) {
    return Account_move_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Account_move_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Account_move_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Account_move_id.fromJson(String source) =>
      Account_move_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account_move_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account_move_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Account_move_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Account_move_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Account_move_id.fromJson(dynamic json) {
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

/// route_id : {"id":15,"name":"Mandalay - Yangon"}

class WayBill_Route_plan_ids {
  dynamic id;
  Route_id routeId;
  dynamic startActualDate;
  dynamic endActualDate;
  dynamic status;
  dynamic fuelBalInputByDriver;
  dynamic routeConsumedFuel;
  List<WRouteAttach> attachment_ids;
  WayBill_Route_plan_ids(
      {this.id,
      required this.routeId,
      this.startActualDate,
      this.endActualDate,
      this.fuelBalInputByDriver,
      this.status,
      required this.attachment_ids,
      this.routeConsumedFuel});

  WayBill_Route_plan_ids copyWith({
    dynamic id,
    required Route_id routeId,
    dynamic startActualDate,
    dynamic endActualDate,
    dynamic status,
    dynamic fuelBalInputByDriver,
    List<WRouteAttach>? attachment_ids,
    dynamic routeConsumedFuel,
  }) {
    return WayBill_Route_plan_ids(
        id: id ?? this.id,
        routeId: routeId ?? this.routeId,
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
      'route_id': routeId.toMap(),
      'start_actual_date': startActualDate,
      'end_actual_date': endActualDate,
      'status': status,
      'fuel_bal_input_by_driver': fuelBalInputByDriver,
      "route_consumed_fuel": routeConsumedFuel,
      'attachment_ids': attachment_ids?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory WayBill_Route_plan_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WayBill_Route_plan_ids(
        id: map['id'] ?? 0,
        routeId: Route_id.fromMap(map['route_id']),
        startActualDate: map['start_actual_date'],
        endActualDate: map['end_actual_date'],
        status: map['status'],
        fuelBalInputByDriver: map["fuel_bal_input_by_driver"],
        routeConsumedFuel: map["route_consumed_fuel"],
        attachment_ids: (map['attachment_ids'] is List)
    ? List<WRouteAttach>.from(
        (map['attachment_ids'] as List)
            .where((x) => x is Map<String, dynamic>) // Only keep maps
            .map((x) => WRouteAttach.fromMap(x as Map<String, dynamic>))
      )
    : [],
        );
  }

  String toJson() => json.encode(toMap());

  factory WayBill_Route_plan_ids.fromJson(String source) =>
      WayBill_Route_plan_ids.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WayBill_Route_plan_ids(id: $id, routeId: $routeId, startActualDate: $startActualDate, endActualDate: $endActualDate, status: $status,fuelBalInputByDriver :$fuelBalInputByDriver,attachment_ids: $attachment_ids,routeConsumedFuel: $routeConsumedFuel)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WayBill_Route_plan_ids &&
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
  int get hashCode {
    return id.hashCode ^
        routeId.hashCode ^
        startActualDate.hashCode ^
        endActualDate.hashCode ^ 
        status.hashCode ^
        fuelBalInputByDriver.hashCode ^
        attachment_ids.hashCode ^
        routeConsumedFuel.hashCode;
  }
}

// class WayBill_Route_plan_ids {
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

//   WayBill_Route_plan_ids(
//       {dynamic id,
//       Route_id routeId,
//       dynamic startActualDate,
//       dynamic endActualDate,
//       dynamic status}) {
//     _id = id;
//     _routeId = routeId;
//     _startActualDate = startActualDate;
//     _endActualDate = endActualDate;
//     _status = status;
//   }

//   WayBill_Route_plan_ids.fromJson(dynamic json) {
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

/// id : 5155
/// name : "Ar Kar Kyaw"

class Spare_id {
  int id = 0;
  String name = "";
  Spare_id({
    this.id = 0,
    this.name = '',
  });

  Spare_id copyWith({
    int? id,
    String? name,
  }) {
    return Spare_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Spare_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Spare_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Spare_id.fromJson(String source) =>
      Spare_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Spare_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Spare_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Spare_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Spare_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Spare_id.fromJson(dynamic json) {
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

/// id : 1
/// name : "Trailer A"

class Trailer_id {
  int id = 0;
  String name = "";
  Trailer_id({
    this.id = 0,
    this.name = '',
  });

  Trailer_id copyWith({
    int? id,
    String? name,
  }) {
    return Trailer_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Trailer_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Trailer_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Trailer_id.fromJson(String source) =>
      Trailer_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Trailer_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Trailer_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Trailer_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Trailer_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Trailer_id.fromJson(dynamic json) {
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

class Driver_id {
  int id = 0;
  String name = "";
  Driver_id({
    this.id = 0,
    this.name = '',
  });

  Driver_id copyWith({
    int? id,
    String? name,
  }) {
    return Driver_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Driver_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Driver_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver_id.fromJson(String source) =>
      Driver_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Driver_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Driver_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Driver_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Driver_id({dynamic id, dynamic name}) {
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

/// id : 1
/// name : "OdooBot"

class Create_uid {
  int id = 0;
  String name = "";
  Create_uid({
    this.id = 0,
    this.name = '',
  });

  Create_uid copyWith({
    int? id,
    String? name,
  }) {
    return Create_uid(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Create_uid.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Create_uid(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Create_uid.fromJson(String source) =>
      Create_uid.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Create_uid(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Create_uid && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Create_uid {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Create_uid({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Create_uid.fromJson(dynamic json) {
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

/// id : 8
/// name : "Daung Feng/2020/5R/7234"

class Vehicle_id {
  int id;
  String name;
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
      name: map['name'] ?? '',
      inchargeId: Incharge_id.fromMap(map['incharge_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle_id(id: $id, name: $name, inchargeId: $inchargeId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id &&
        o.id == id &&
        o.name == name &&
        o.inchargeId == inchargeId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ inchargeId.hashCode;
  }
}

// class Vehicle_id {
//   int _id;
//   String _name;
//   Incharge_id _inchargeId;

//   int get id => _id;
//   String get name => _name;
//   Incharge_id get inchargeId => _inchargeId;

//   Vehicle_id({int id, String name, Incharge_id inchargeId}) {
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
class WRouteAttach {
  String name;
  String datas;
  WRouteAttach({
    this.name = '',
    this.datas = '',
  });


  WRouteAttach copyWith({
    String? name,
    String? datas,
  }) {
    return WRouteAttach(
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

  factory WRouteAttach.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return WRouteAttach(
      name: map['name'] ?? "",
      datas: map['datas'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WRouteAttach.fromJson(String source) => WRouteAttach.fromMap(json.decode(source));

  @override
  String toString() => 'WRouteAttach(name: $name, datas: $datas)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WRouteAttach &&
      o.name == name &&
      o.datas == datas;
  }

  @override
  int get hashCode => name.hashCode ^ datas.hashCode;
}
