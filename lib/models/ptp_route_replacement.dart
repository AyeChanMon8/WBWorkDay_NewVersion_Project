import 'dart:convert';

import 'fleet_model.dart';

class PTPRouteReplacemnt {
  int id;
  dynamic name;
  String state;
  String fromDatetime;
  String toDatetime;
  String replaceableOldRouteIdsTxt;
  PlanTripProductReplacement? planTripProductId;
  PlanTripWaybillReplacement? planTripWaybillId;
  CompanyId? companyID;
  BranchId? branchID;
  Vehicle_id? vehicleId;
  Driver_id? driverId;
  List<NewRouteIDs>? newRouteIDs;
  PTPRouteReplacemnt(
      {this.id = 0,
      this.name = '',
      this.state = '',
      this.fromDatetime = '',
      this.toDatetime = '',
      this.replaceableOldRouteIdsTxt = '',
      this.planTripProductId,
      this.planTripWaybillId,
      this.companyID,
      this.branchID,
      this.vehicleId,
      this.driverId,
      this.newRouteIDs});

  PTPRouteReplacemnt copyWith(
      {int? id,
  dynamic? name,
  String? state,
  String? fromDatetime,
  String? toDatetime,
  String? replaceableOldRouteIdsTxt,
  PlanTripProductReplacement? planTripProductId,
  PlanTripWaybillReplacement? planTripWaybillId,
  CompanyId? companyID,
  BranchId? branchID,
  Vehicle_id? vehicleId,
  Driver_id? driverId,
  List<NewRouteIDs>? newRouteIDs}) {
    return PTPRouteReplacemnt(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      fromDatetime: fromDatetime ?? this.fromDatetime,
      toDatetime: toDatetime ?? this.toDatetime,
      replaceableOldRouteIdsTxt: replaceableOldRouteIdsTxt ?? this.replaceableOldRouteIdsTxt,
      vehicleId: vehicleId ?? this.vehicleId,
      planTripProductId: planTripProductId ?? this.planTripProductId,
      driverId: driverId ?? this.driverId,
      newRouteIDs: newRouteIDs ?? this.newRouteIDs,
      companyID: companyID ?? this.companyID,
      planTripWaybillId: planTripWaybillId ?? this.planTripWaybillId,
      branchID: branchID ?? this.branchID
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'from_datetime': fromDatetime,
      'to_datetime': toDatetime,
      'branch_id': branchID,
      'replaceable_old_route_ids_txt': replaceableOldRouteIdsTxt,
      'vehicle_id': vehicleId?.toMap(),
      'plan_trip_product_id': planTripProductId?.toMap(),
      'plan_trip_waybill_id': planTripWaybillId?.toMap(),
      'driver_id': driverId?.toMap(),
      'company_id': companyID?.toMap(),
      'new_route_ids': newRouteIDs?.map((x) => x?.toMap())?.toList(),
      // 'name': name,
    };
  }

  factory PTPRouteReplacemnt.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PTPRouteReplacemnt(
      id: map['id'],
      name: map['name'] ?? "",
      fromDatetime: map['from_datetime'] ?? "",
      toDatetime: map['to_datetime'] ?? "",
      replaceableOldRouteIdsTxt: map['replaceable_old_route_ids_txt'] ?? "",
      state: map['state'] ?? "",
      vehicleId: Vehicle_id.fromMap(map['vehicle_id']),
      companyID: CompanyId.fromMap(map['company_id']),
      driverId: Driver_id.fromMap(map['driver_id']),
      branchID: BranchId.fromMap(map['branch_id']),
      planTripProductId: PlanTripProductReplacement.fromMap(map['plan_trip_product_id']),
      planTripWaybillId: PlanTripWaybillReplacement.fromMap(map['plan_trip_waybill_id']),
      newRouteIDs: List<NewRouteIDs>.from(
          map['new_route_ids']?.map((x) => NewRouteIDs.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PTPRouteReplacemnt.fromJson(String source) =>
      PTPRouteReplacemnt.fromMap(json.decode(source));

  @override
  String toString() =>
      'PTPRouteReplacemnt(id: $id, name: $name, state: $state,fromDatetime: $fromDatetime, toDatetime: $toDatetime,replaceableOldRouteIdsTxt: $replaceableOldRouteIdsTxt, driverId: $driverId,vehicleId: $vehicleId, companyID: $companyID,branchID: $branchID, planTripProductId: $planTripProductId,planTripWaybillId: $planTripWaybillId, newRouteIDs: $newRouteIDs)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PTPRouteReplacemnt &&
        o.id == id &&
        o.name == name &&
        o.state == state &&
        o.fromDatetime == fromDatetime &&
        o.toDatetime == toDatetime &&
        o.vehicleId == vehicleId &&
        o.companyID == companyID &&
        o.driverId == driverId &&
        o.branchID == branchID &&
        o.planTripProductId == planTripProductId &&
        o.planTripWaybillId == planTripWaybillId &&
        o.newRouteIDs == newRouteIDs;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      state.hashCode ^
      fromDatetime.hashCode ^
      toDatetime.hashCode ^
      vehicleId.hashCode ^
      companyID.hashCode ^
      driverId.hashCode ^
      branchID.hashCode ^
      planTripProductId.hashCode ^
      planTripWaybillId.hashCode ^
      newRouteIDs.hashCode;
}

class NewRouteIDs {
  CompanyId? companyId;
  int id;
  RouteId? routeId;
  NewRouteIDs({
    this.companyId,
    this.id = 0,
    this.routeId,
  });

  NewRouteIDs copyWith({
    CompanyId? companyId,
    int? id,
    RouteId? routeId
  }) {
    return NewRouteIDs(
        companyId: companyId ?? this.companyId,
        id: id ?? this.id,
        routeId: routeId ?? this.routeId);
  }

  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId?.toMap(),
      'id': id,
      'route_id': routeId?.toMap()
    };
  }

  factory NewRouteIDs.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return NewRouteIDs(
        companyId:
            CompanyId.fromMap(map['company_id']),
        id: map['id'] ?? 0,
        routeId:
            RouteId.fromMap(map['route_id']));
  }

  String toJson() => json.encode(toMap());

  factory NewRouteIDs.fromJson(String source) =>
      NewRouteIDs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewRouteIDs(companyId: $companyId, id: $id, routeId: $routeId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NewRouteIDs &&
        o.companyId == companyId &&
        o.id == id &&
        o.routeId == routeId;
  }

  @override
  int get hashCode {
    return companyId.hashCode ^
        id.hashCode ^
        routeId.hashCode;
  }
}

class RouteId {
  final int id;
  final String name;
  final String code;

  const RouteId({
    this.id = 0,
    this.name = '',
    this.code = ''
  });

  RouteId copyWith({
    int? id,
    String? name,
    String? code
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (code == null || identical(code, this.code))) {
      return this;
    }

    return new RouteId(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code
    );
  }

  @override
  String toString() {
    return 'RouteId{id: $id, name: $name,code: $code}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RouteId &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;

  factory RouteId.fromMap(Map<String, dynamic> map) {
    return new RouteId(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      code: map['code'] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code
    } as Map<String, dynamic>;
  }
}

class CompanyId {
  final int id;
  final String name;

  const CompanyId({
    this.id = 0,
    this.name = '',
  });

  CompanyId copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new CompanyId(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'CompanyId{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyId &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory CompanyId.fromMap(Map<String, dynamic> map) {
    return new CompanyId(
      id: map['id'] ?? 0,
      name: map['name'] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }
}


class BranchId {
  int id;
  String name;
  BranchId({this.id = 0, this.name = ''});

  BranchId copyWith({int? id, String? name}) {
    return BranchId(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  factory BranchId.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return BranchId(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchId.fromJson(String source) =>
      BranchId.fromMap(json.decode(source));

  @override
  String toString() => 'BranchId(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BranchId && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class PlanTripProductReplacement {
  int? id;
  dynamic? name;
  String? code;
  PlanTripProductReplacement(
      {this.id, this.name = '', this.code = ""});

  PlanTripProductReplacement copyWith(
      {int? id, dynamic? name, String? code}) {
    return PlanTripProductReplacement(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code
    };
  }

  factory PlanTripProductReplacement.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PlanTripProductReplacement(
      id: map['id'] ?? 0,
      name: map['name'],
      code: map['code'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanTripProductReplacement.fromJson(String source) =>
      PlanTripProductReplacement.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlanTripProductReplacement(id: $id, name: $name, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PlanTripProductReplacement &&
        o.id == id &&
        o.name == name &&
        o.code == code;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ code.hashCode;
}

class PlanTripWaybillReplacement {
  int? id;
  dynamic? name;
  String? code;
  PlanTripWaybillReplacement(
      {this.id, this.name = '', this.code = ""});

  PlanTripWaybillReplacement copyWith(
      {int? routeId, dynamic? name, String? code}) {
    return PlanTripWaybillReplacement(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code
    };
  }

  factory PlanTripWaybillReplacement.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PlanTripWaybillReplacement(
      id: map['id'] ?? 0,
      name: map['name'],
      code: map['code'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanTripWaybillReplacement.fromJson(String source) =>
      PlanTripWaybillReplacement.fromMap(json.decode(source));

  @override
  String toString() =>
      'PlanTripWaybillReplacement(id: $id, name: $name, code: $code)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PlanTripWaybillReplacement &&
        o.id == id &&
        o.name == name &&
        o.code == code;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ code.hashCode;
}

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

class VehicleManager {
  int id = 0;
  String name = "";
  VehicleManager({
    this.id = 0,
    this.name = '',
  });

  VehicleManager copyWith({
    int? id,
    String? name,
  }) {
    return VehicleManager(
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

  factory VehicleManager.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return VehicleManager(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleManager.fromJson(String source) =>
      VehicleManager.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehicleManager(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VehicleManager && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Vehicle_id {
  int id;
  String name;
  VehicleManager? vehicleManager;
  Vehicle_id({this.id = 0, this.name = '', this.vehicleManager});

  Vehicle_id copyWith({int? id, String? name, VehicleManager? vehicleManager}) {
    return Vehicle_id(
        id: id ?? this.id,
        name: name ?? this.name,
        vehicleManager: vehicleManager ?? this.vehicleManager);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'vehicle_manager': vehicleManager?.toMap(),
    };
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      vehicleManager: VehicleManager.fromMap(map['vehicle_manager']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle_id(id: $id, name: $name, vehicleManager: $vehicleManager)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id &&
        o.id == id &&
        o.name == name &&
        o.vehicleManager == vehicleManager;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ vehicleManager.hashCode;
  }
}
