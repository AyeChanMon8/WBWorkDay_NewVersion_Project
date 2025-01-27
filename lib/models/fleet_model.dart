import 'dart:convert';

import 'package:winbrother_hr_app/models/insurancemodel.dart';

class Fleet_model {
  int id;
  String name;
  Model_id? modelId;
  String licensePlate;
  List<Tag_ids>? tagIds;
  dynamic lastEngineOff;
  String ? image128;
  Driver_id? driverId;
  double odometer;
  String odometerUnit;
  dynamic fuelType;
  String acquisitionDate;
  int horsepower;
  dynamic vinSn;
  dynamic traccarUniqueID;
  dynamic color;
  Company_id? companyId;
  Branch_id? branchId;
  Incharge_id? inchargeId;
  FuelTank? fuelTank;
  List<ConsumptionAverageHistory>? consumption_average_history;
  List<TypredHistory>? tire_history;
  bool? dayTripAccess;
  bool? planTripProductAccess;
  bool? planTripWaybillAccess;
  bool? outOfPocketAccess;
  bool? travelExpenseAccess;

  Fleet_model(
      {this.id = 0,
      this.name = '',
      this.modelId,
      this.licensePlate = '',
      this.tagIds,
      this.lastEngineOff,
      this.image128 = '',
      this.driverId,
      this.odometer = 0.0,
      this.odometerUnit = '',
      this.fuelType,
      this.acquisitionDate = '',
      this.horsepower = 0,
      this.vinSn,
      this.traccarUniqueID,
      this.color,
      this.companyId,
      this.branchId,
      this.inchargeId,
      this.fuelTank,
      this.consumption_average_history,
      this.tire_history,
      this.dayTripAccess,
      this.outOfPocketAccess,
      this.planTripProductAccess,
      this.planTripWaybillAccess,
      this.travelExpenseAccess
      });

  Fleet_model copyWith(
      {int? id,
      String? name,
      Model_id? modelId,
      String? licensePlate,
      List<Tag_ids>? tagIds,
      dynamic? lastEngineOff,
      String? image128,
      Driver_id? driverId,
      double? odometer,
      String? odometerUnit,
      dynamic? fuelType,
      String? acquisitionDate,
      int? horsepower,
      dynamic? vinSn,
      dynamic? traccarUniqueID,
      dynamic? color,
      Company_id? companyId,
      Branch_id? branchId,
      Incharge_id? inchargeId,
      FuelTank? fuelTank,
      required List<ConsumptionAverageHistory> consumption_average_history,
      required List<TypredHistory> tire_history,
      bool? dayTripAccess,
      bool? planTripProductAccess,
      bool? planTripWaybillAccess,
      bool? outOfPocketAccess,
      bool? travelExpenseAccess}) {
    return Fleet_model(
      id: id ?? this.id,
      name: name ?? this.name,
      modelId: modelId ?? this.modelId,
      licensePlate: licensePlate ?? this.licensePlate,
      tagIds: tagIds ?? this.tagIds,
      lastEngineOff: lastEngineOff ?? this.lastEngineOff,
      image128: image128 ?? this.image128,
      driverId: driverId ?? this.driverId,
      odometer: odometer ?? this.odometer,
      odometerUnit: odometerUnit ?? this.odometerUnit,
      fuelType: fuelType ?? this.fuelType,
      acquisitionDate: acquisitionDate ?? this.acquisitionDate,
      horsepower: horsepower ?? this.horsepower,
      vinSn: vinSn ?? this.vinSn,
      traccarUniqueID: traccarUniqueID ?? this.traccarUniqueID,
      color: color ?? this.color,
      companyId: companyId ?? this.companyId,
      branchId: branchId ?? this.branchId,
      inchargeId: inchargeId ?? this.inchargeId,
      fuelTank: fuelTank ?? this.fuelTank,
      consumption_average_history:
          consumption_average_history ?? this.consumption_average_history,
      tire_history: tire_history ?? this.tire_history,
      dayTripAccess: dayTripAccess ?? this.dayTripAccess,
      planTripProductAccess : planTripProductAccess ?? this.planTripProductAccess,
      planTripWaybillAccess : planTripWaybillAccess ?? this.planTripWaybillAccess,
      outOfPocketAccess: outOfPocketAccess ?? this.outOfPocketAccess,
      travelExpenseAccess : travelExpenseAccess ?? this.travelExpenseAccess
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'model_id': modelId?.toMap(),
      'license_plate': licensePlate,
      'tag_ids': tagIds?.map((x) => x?.toMap())?.toList(),
      'last_engine_off': lastEngineOff,
      'image_128': image128,
      'driver_id': driverId?.toMap(),
      'odometer': odometer,
      'odometer_unit': odometerUnit,
      'fuel_type': fuelType,
      'acquisition_date': acquisitionDate,
      'horsepower': horsepower,
      'vin_sn': vinSn,
      'traccar_uniqueID': traccarUniqueID,
      'color': color,
      'company_id': companyId?.toMap(),
      'branch_id': branchId?.toMap(),
      'incharge_id': inchargeId?.toMap(),
      'fuel_tank': fuelTank?.toMap(),
      'consumption_average_history_ids':
          consumption_average_history?.map((x) => x?.toMap())?.toList(),
      'fleet_tyre_history_ids': tire_history?.map((x) => x?.toMap())?.toList(),
      'day_trip_access': dayTripAccess,
      'plan_trip_product_access': planTripProductAccess,
      'plan_trip_waybill_access': planTripWaybillAccess,
      'out_of_pocket_access': outOfPocketAccess,
      'travel_expense_access': travelExpenseAccess,
    };
  }

  factory Fleet_model.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fleet_model(
      id: map['id'],
      name: map['name'],
      modelId: Model_id.fromMap(map['model_id']),
      licensePlate: map['license_plate'],
      tagIds:
          List<Tag_ids>.from(map['tag_ids']?.map((x) => Tag_ids.fromMap(x))),
      lastEngineOff: map['last_engine_off'],
      image128: map['image_128']?? "",
      driverId: Driver_id.fromMap(map['driver_id']),
      odometer: map['odometer'],
      odometerUnit: map['odometer_unit'],
      fuelType: map['fuel_type'],
      acquisitionDate: map['acquisition_date'],
      horsepower: map['horsepower'],
      vinSn: map['vin_sn'],
      traccarUniqueID: map['traccar_uniqueID'],
      color: map['color'],
      companyId: Company_id.fromMap(map['company_id']),
      branchId: Branch_id.fromMap(map['branch_id']),
      inchargeId: Incharge_id.fromMap(map['incharge_id']),
      fuelTank: FuelTank.fromMap(map['fuel_tank']),
      consumption_average_history: List<ConsumptionAverageHistory>.from(
          map['consumption_average_history_ids']
              ?.map((x) => ConsumptionAverageHistory.fromMap(x))),
      tire_history: List<TypredHistory>.from(
          map['fleet_tyre_history_ids']?.map((x) => TypredHistory.fromMap(x))),
      dayTripAccess: map['day_trip_access'],
      planTripProductAccess: map['plan_trip_product_access'],
      planTripWaybillAccess: map['plan_trip_waybill_access'],
      outOfPocketAccess: map['out_of_pocket_access'],
      travelExpenseAccess: map['travel_expense_access'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fleet_model.fromJson(String source) =>
      Fleet_model.fromMap(json.decode(source));

  @override
  String toString() =>
      'Fleet_model(id: $id, name: $name,modelId: $modelId, licensePlate: $licensePlate,lastEngineOff: $lastEngineOff, image128: $image128,driverId: $driverId, odometer: $odometer, odometerUnit: $odometerUnit, fuelType: $fuelType, acquisitionDate: $acquisitionDate, horsepower: $horsepower, vinSn: $vinSn, traccarUniqueID: $traccarUniqueID, color: $color, companyId: $companyId, branchId: $branchId, inchargeId: $inchargeId, fuelTank: $fuelTank, consumption_average_history: $consumption_average_history, tire_history: $tire_history,dayTripAccess: $dayTripAccess,planTripProductAccess: $planTripProductAccess, planTripWaybillAccess: $planTripWaybillAccess, outOfPocketAccess: $outOfPocketAccess, travelExpenseAccess: $travelExpenseAccess)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fleet_model &&
        o.id == id &&
        o.name == name &&
        o.modelId == modelId &&
        o.licensePlate == licensePlate &&
        o.lastEngineOff == lastEngineOff &&
        o.image128 == image128 &&
        o.driverId == driverId &&
        o.odometer == odometer &&
        o.odometerUnit == odometerUnit &&
        o.fuelType == fuelType &&
        o.acquisitionDate == acquisitionDate &&
        o.horsepower == horsepower &&
        o.vinSn == vinSn &&
        o.traccarUniqueID == traccarUniqueID &&
        o.color == color &&
        o.companyId == companyId &&
        o.branchId == branchId &&
        o.inchargeId == inchargeId &&
        o.fuelTank == fuelTank &&
        o.consumption_average_history == consumption_average_history &&
        o.tire_history == tire_history &&
        o.dayTripAccess == dayTripAccess &&
        o.planTripProductAccess == planTripProductAccess &&
        o.planTripWaybillAccess ==  planTripWaybillAccess &&
        o.outOfPocketAccess == outOfPocketAccess &&
        o.travelExpenseAccess == travelExpenseAccess;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      modelId.hashCode ^
      licensePlate.hashCode ^
      lastEngineOff.hashCode ^
      image128.hashCode ^
      driverId.hashCode ^
      odometer.hashCode ^
      odometerUnit.hashCode ^
      fuelType.hashCode ^
      acquisitionDate.hashCode ^
      horsepower.hashCode ^
      vinSn.hashCode ^
      traccarUniqueID.hashCode ^
      color.hashCode ^
      companyId.hashCode ^
      branchId.hashCode ^
      inchargeId.hashCode ^
      fuelTank.hashCode ^
      consumption_average_history.hashCode ^
      tire_history.hashCode ^
      dayTripAccess.hashCode ^
      planTripProductAccess.hashCode ^
      planTripWaybillAccess.hashCode ^
      outOfPocketAccess.hashCode ^
      travelExpenseAccess.hashCode;
}

// class Fleet_model {
//   int _id;
//   String _name;
//   Model_id _modelId;
//   String _licensePlate;
//   List<Tag_ids> _tagIds;
//   dynamic _lastEngineOff;
//   String _image128;
//   Driver_id _driverId;
//   double _odometer;
//   String _odometerUnit;
//   dynamic _fuelType;
//   String _acquisitionDate;
//   int _horsepower;
//   dynamic _vinSn;
//   dynamic _traccarUniqueID;
//   dynamic _color;
//   Company_id _companyId;
//   Branch_id _branchId;
//   Incharge_id _inchargeId;
//   FuelTank _fuelTank;
//   List<ConsumptionAverageHistory> _consumption_average_history;
//   List<TypredHistory> _tire_history;
//   int get id => _id;
//   String get name => _name;
//   Model_id get modelId => _modelId;
//   String get licensePlate => _licensePlate;
//   List<Tag_ids> get tagIds => _tagIds;
//   dynamic get lastEngineOff => _lastEngineOff;
//   String get image128 => _image128;
//   Driver_id get driverId => _driverId;
//   double get odometer => _odometer;
//   String get odometerUnit => _odometerUnit;
//   dynamic get fuelType => _fuelType;
//   String get acquisitionDate => _acquisitionDate;
//   int get horsepower => _horsepower;
//   dynamic get vinSn => _vinSn;
//   dynamic get traccarUniqueID => _traccarUniqueID ?? '';
//   dynamic get color => _color;
//   Company_id get companyId => _companyId;
//   Branch_id get branchId => _branchId;
//   Incharge_id get inchargeId => _inchargeId;
//   FuelTank get fuelTank => _fuelTank;
//   List<TypredHistory> get tire_history => _tire_history;

//   List<ConsumptionAverageHistory> get consumption_average_history =>
//       _consumption_average_history;
//   Fleet_model(
//       {int id,
//       String name,
//       Model_id modelId,
//       String licensePlate,
//       List<Tag_ids> tagIds,
//       dynamic lastEngineOff,
//       String image128,
//       Driver_id driverId,
//       double odometer,
//       String odometerUnit,
//       dynamic fuelType,
//       String acquisitionDate,
//       int horsepower,
//       dynamic vinSn,
//       dynamic traccarUniqueID,
//       dynamic color}) {
//     _id = id;
//     _name = name;
//     _modelId = modelId;
//     _licensePlate = licensePlate;
//     _tagIds = tagIds;
//     _lastEngineOff = lastEngineOff;
//     _image128 = image128;
//     _driverId = driverId;
//     _odometer = odometer;
//     _odometerUnit = odometerUnit;
//     _fuelType = fuelType;
//     _acquisitionDate = acquisitionDate;
//     _horsepower = horsepower;
//     _vinSn = vinSn;
//     _traccarUniqueID = traccarUniqueID;
//     _color = color;
//   }

//   Fleet_model.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _modelId =
//         json["model_id"] != null ? Model_id.fromJson(json["model_id"]) : null;
//     _licensePlate = json["license_plate"];
//     if (json["tag_ids"] != null) {
//       _tagIds = [];
//       json["tag_ids"].forEach((v) {
//         _tagIds.add(Tag_ids.fromJson(v));
//       });
//     }
//     _lastEngineOff = json["last_engine_off"];
//     _image128 = json["image_128"];
//     _driverId = json["driver_id"] != null
//         ? Driver_id.fromJson(json["driver_id"])
//         : null;
//     _odometer = json["odometer"];
//     _odometerUnit = json["odometer_unit"];
//     _fuelType = json["fuel_type"];
//     _acquisitionDate = json["acquisition_date"];
//     _horsepower = json["horsepower"];
//     _vinSn = json["vin_sn"];
//     _traccarUniqueID = json["traccar_uniqueID"];
//     _color = json["color"];
//     _companyId = json["company_id"] != null
//         ? Company_id.fromJson(json["company_id"])
//         : null;
//     _branchId = json["branch_id"] != null
//         ? Branch_id.fromJson(json["branch_id"])
//         : null;
//     _inchargeId = json["incharge_id"] != null
//         ? Incharge_id.fromJson(json["incharge_id"])
//         : null;
//     _fuelTank =
//         json["fuel_tank"] != null ? FuelTank.fromJson(json["fuel_tank"]) : null;
//     if (json["consumption_average_history_ids"] != null) {
//       _consumption_average_history = [];
//       json["consumption_average_history_ids"].forEach((v) {
//         _consumption_average_history.add(ConsumptionAverageHistory.fromJson(v));
//       });
//     }
//     if (json["fleet_tyre_history_ids"] != null) {
//       _tire_history = [];
//       json["fleet_tyre_history_ids"].forEach((v) {
//         _tire_history.add(TypredHistory.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     if (_modelId != null) {
//       map["model_id"] = _modelId.toJson();
//     }
//     map["license_plate"] = _licensePlate;
//     if (_tagIds != null) {
//       map["tag_ids"] = _tagIds.map((v) => v.toJson()).toList();
//     }
//     map["last_engine_off"] = _lastEngineOff;
//     map["image_128"] = _image128;
//     if (_driverId != null) {
//       map["driver_id"] = _driverId.toJson();
//     }
//     map["odometer"] = _odometer;
//     map["odometer_unit"] = _odometerUnit;
//     map["fuel_type"] = _fuelType;
//     map["acquisition_date"] = _acquisitionDate;
//     map["horsepower"] = _horsepower;
//     map["vin_sn"] = _vinSn;
//     map["traccar_uniqueID"] = _traccarUniqueID;
//     map["color"] = _color;
//     return map;
//   }
// }

/// id : null
/// name : null

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

class Company_id {
  int id = 0;
  String name = "";
  Company_id({
    this.id = 0,
    this.name = '',
  });

  Company_id copyWith({
    int? id,
    String? name,
  }) {
    return Company_id(
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

  factory Company_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Company_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Company_id.fromJson(String source) =>
      Company_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Company_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Company_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Company_id.fromJson(dynamic json) {
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

class Branch_id {
  int id = 0;
  String name = "";
  Branch_id({
    this.id = 0,
    this.name = '',
  });

  Branch_id copyWith({
    int? id,
    String? name,
  }) {
    return Branch_id(
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

  factory Branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Branch_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) =>
      Branch_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Branch_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Branch_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Branch_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Branch_id.fromJson(dynamic json) {
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

class FuelTank {
  int id = 0;
  String name = "";
  FuelTank({
    this.id = 0,
    this.name = '',
  });

  FuelTank copyWith({
    int? id,
    String? name,
  }) {
    return FuelTank(
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

  factory FuelTank.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return FuelTank(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelTank.fromJson(String source) =>
      FuelTank.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelTank(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FuelTank && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class FuelTank {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   FuelTank({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   FuelTank.fromJson(dynamic json) {
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

class ConsumptionAverageHistory {
  String modified_date;
  double consumption_liter;
  double odometer;
  double great_average;
  String source_doc;
  ConsumptionAverageHistory(
      {this.modified_date = '',
      this.consumption_liter = 0.0,
      this.odometer = 0.0,
      this.great_average = 0.0,
      this.source_doc = ''});

  ConsumptionAverageHistory copyWith(
      {String? modified_date,
      double? consumption_liter,
      double? odometer,
      double? great_average,
      String? source_doc}) {
    return ConsumptionAverageHistory(
      modified_date: modified_date ?? this.modified_date,
      consumption_liter: consumption_liter ?? this.consumption_liter,
      odometer: odometer ?? this.odometer,
      great_average: great_average ?? this.great_average,
      source_doc: source_doc ?? this.source_doc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'modified_date': modified_date,
      'consumption_liter': consumption_liter,
      'odometer': odometer,
      'great_average': great_average,
      'source_doc': source_doc
    };
  }

  factory ConsumptionAverageHistory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ConsumptionAverageHistory(
      modified_date: map['modified_date'] ?? '',
      consumption_liter: map['consumption_liter'] ?? 0.0,
      odometer: map['odometer'] ?? 0.0,
      great_average: map['great_average'] ?? 0.0,
      source_doc: map['source_doc'] ?? 0.0
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsumptionAverageHistory.fromJson(String source) =>
      ConsumptionAverageHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsumptionAverageHistory(modified_date: $modified_date, consumption_liter: $consumption_liter, odometer: $odometer, great_average: $great_average, source_doc: $source_doc)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConsumptionAverageHistory && o.modified_date == modified_date && o.consumption_liter == consumption_liter
     && o.odometer == odometer  && o.great_average == great_average  && o.source_doc == source_doc;
  }

  @override
  int get hashCode {
    return modified_date.hashCode ^ consumption_liter.hashCode ^ odometer.hashCode ^ great_average.hashCode ^ source_doc.hashCode;
  }
}

// class ConsumptionAverageHistory {
//   String _modified_date;
//   double _consumption_liter;
//   double _odometer;
//   double _great_average;
//   String _source_doc;

//   String get modified_date => _modified_date;
//   double get consumption_liter => _consumption_liter;
//   double get odometer => _odometer;
//   double get great_average => _great_average;
//   String get source_doc => _source_doc;

//   ConsumptionAverageHistory.fromJson(dynamic json) {
//     _modified_date = json["modified_date"];
//     _consumption_liter =
//         json["consumption_liter"] != null ? json["consumption_liter"] : 0.0;
//     _odometer = json["odometer"] != null ? json["odometer"] : 0.0;
//     _great_average = json["great_average"];
//     _source_doc = json["source_doc"];
//   }
// }

class TypredHistory {
  String note;
  double used_points;
  String date;
  String source_doc;
  TypredHistory({
    this.note = '',
    this.used_points = 0.0,
    this.date = '',
    this.source_doc = ''
  });

  TypredHistory copyWith({
    String? note,
  double? used_points,
  String? date,
  String? source_doc,
  }) {
    return TypredHistory(
      note: note ?? this.note,
      used_points: used_points ?? this.used_points,
      date: date ?? this.date,
      source_doc: source_doc ?? this.source_doc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'used_points': used_points,
      'date': date,
      'source_doc': source_doc,
    };
  }

  factory TypredHistory.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return TypredHistory(
      note: map['note'] ?? '',
      used_points: map['used_points'] ?? 0.0,
      date: map['date'] ?? '',
      source_doc: map['source_doc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypredHistory.fromJson(String source) =>
      TypredHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TypredHistory(note: $note, used_points: $used_points,date: $date, source_doc: $source_doc)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TypredHistory && o.note == note && o.used_points == used_points && o.date == date && o.source_doc == source_doc;
  }

  @override
  int get hashCode {
    return note.hashCode ^ used_points.hashCode ^ date.hashCode ^ source_doc.hashCode ;
  }
}

// class TypredHistory {
//   String _note;
//   double _used_points;
//   String _date;
//   String _source_doc;

//   double get used_points => _used_points;
//   String get date => _date;
//   String get source_doc => _source_doc;
//   String get note => _note;

//   TypredHistory.fromJson(dynamic json) {
//     _date = json["date"];
//     _used_points = json["used_points"] != null ? json["used_points"] : 0.0;
//     _note = json["noted"];
//     _source_doc = json["source_doc"];
//   }
// }

class Incharge_id {
  int id = 0;
  String name = "";
  Incharge_id({
    this.id = 0,
    this.name = '',
  });

  Incharge_id copyWith({
    int? id,
    String? name,
  }) {
    return Incharge_id(
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

  factory Incharge_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Incharge_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Incharge_id.fromJson(String source) =>
      Incharge_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Incharge_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Incharge_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Incharge_id {
//   final int id;
//   final String name;
//   Incharge_id({
//     this.id = 0,
//     this.name = '',
//   });

//   Incharge_id copyWith({
//     int? id,
//     String? name,
//   }) {
//     return Incharge_id(
//       id: id ?? this.id,
//       name: name ?? this.name,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }

//   factory Incharge_id.fromMap(Map<String, dynamic> map) {
//     // if (map == null) return null;

//     return Incharge_id(
//       id: map['id'],
//       name: map['name'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Incharge_id.fromJson(String source) =>
//       Incharge_id.fromMap(json.decode(source));

//   @override
//   String toString() => 'Incharge_id(id: $id, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Incharge_id && o.id == id && o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;
// }

/// id : 3
/// name : "Management"


class Tag_ids {
  int id = 0;
  String name = "";
  Tag_ids({
    this.id = 0,
    this.name = '',
  });

  Tag_ids copyWith({
    int? id,
    String? name,
  }) {
    return Tag_ids(
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

  factory Tag_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Tag_ids(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag_ids.fromJson(String source) =>
      Tag_ids.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tag_ids(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Tag_ids && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Tag_ids {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Tag_ids({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Tag_ids.fromJson(dynamic json) {
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

/// id : 12
/// name : "Ampera"

class Model_id {
  int id = 0;
  String name = "";
  Model_id({
    this.id = 0,
    this.name = '',
  });

  Model_id copyWith({
    int? id,
    String? name,
  }) {
    return Model_id(
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

  factory Model_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Model_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Model_id.fromJson(String source) =>
      Model_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Model_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Model_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

// class Model_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Model_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Model_id.fromJson(dynamic json) {
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
