import 'dart:convert';

/// id : 1
/// vehicle_id : {"id":1,"name":"Audi/A6/s3333"}
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// odometer : 1000.0
/// previous_odometer : 0.0
/// liter : 10.0
/// fuel_tank_id : {"id":null,"name":null}
/// price_per_liter : 520.0
/// amount : 5200.0
/// date : "2020-08-26"
/// inv_ref : null
/// shop : null

class Fuel_log_model {
  int id;
  Vehicle_id? vehicleId;
  Employee_id? employeeId;
  double odometer;
  double previousOdometer;
  double liter;
  Fuel_tank_id? fuelTankId;
  double pricePerLiter;
  double amount;
  String date;
  dynamic? invRef;
  dynamic? shop;
  Fuel_log_model(
      {this.id = 0,
      this.vehicleId,
      this.employeeId,
      this.odometer = 0.0,
      this.previousOdometer = 0.0,
      this.liter = 0.0,
      this.fuelTankId,
      this.pricePerLiter = 0.0,
      this.amount = 0.0,
      this.date = '',
      this.invRef,
      this.shop});

  Fuel_log_model copyWith(
      {int? id,
      Vehicle_id? vehicleId,
      Employee_id? employeeId,
      double? odometer,
      double? previousOdometer,
      double? liter,
      Fuel_tank_id? fuelTankId,
      double? pricePerLiter,
      double? amount,
      String? date,
      dynamic? invRef,
      dynamic? shop}) {
    return Fuel_log_model(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      employeeId: employeeId ?? this.employeeId,
      odometer: odometer ?? this.odometer,
      previousOdometer: previousOdometer ?? this.previousOdometer,
      liter: liter ?? this.liter,
      fuelTankId: fuelTankId ?? this.fuelTankId,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      invRef: invRef ?? this.invRef,
      shop: shop ?? this.shop,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'employee_id': employeeId,
      'odometer': odometer,
      'previous_odometer': previousOdometer,
      'liter': liter,
      'fuel_tank_id': fuelTankId,
      'price_per_liter': pricePerLiter,
      'amount': amount,
      'date': date,
      'inv_ref': invRef,
      'shop': shop,
    };
  }

  factory Fuel_log_model.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuel_log_model(
      id: map['id'] ?? 0,
      vehicleId: Vehicle_id.fromMap(map['vehicle_id']),
      employeeId: Employee_id.fromMap(map['employee_id']),
      odometer: map['odometer'],
      previousOdometer: map['previous_odometer'],
      fuelTankId: Fuel_tank_id.fromMap(map['fuel_tank_id']),
      pricePerLiter: map['price_per_liter'],
      liter: map['liter'],
      amount: map['amount'],
      date: map['date'],
      invRef: map['inv_ref'],
      shop: map['shop'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuel_log_model.fromJson(String source) =>
      Fuel_log_model.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fuel_log_model(id: $id, vehicleId: $vehicleId, employeeId: $employeeId, odometer: $odometer, previousOdometer: $previousOdometer, fuelTankId: $fuelTankId, pricePerLiter: $pricePerLiter, amount: $amount, date: $date, invRef: $invRef, shop: $shop,liter: $liter)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuel_log_model && o.id == id && o.vehicleId == vehicleId && o.employeeId == employeeId && o.odometer == odometer &&
    o.previousOdometer == previousOdometer && o.fuelTankId == fuelTankId && 
    o.pricePerLiter == pricePerLiter && o.amount == amount &&
    o.date == date && o.invRef == invRef && o.shop == shop && o.liter == liter;
  }

  @override
  int get hashCode {
    return id.hashCode ^ vehicleId.hashCode ^ employeeId.hashCode ^ odometer.hashCode ^ previousOdometer.hashCode
    ^ fuelTankId.hashCode ^ pricePerLiter.hashCode ^ amount.hashCode ^ date.hashCode ^ invRef.hashCode ^ shop.hashCode ^ liter.hashCode;
  }
}

// class Fuel_log_model {
//   int _id;
//   Vehicle_id _vehicleId;
//   Employee_id _employeeId;
//   double _odometer;
//   double _previousOdometer;
//   double _liter;
//   Fuel_tank_id _fuelTankId;
//   double _pricePerLiter;
//   double _amount;
//   String _date;
//   dynamic _invRef;
//   dynamic _shop;

//   int get id => _id;
//   Vehicle_id get vehicleId => _vehicleId;
//   Employee_id get employeeId => _employeeId;
//   double get odometer => _odometer;
//   double get previousOdometer => _previousOdometer;
//   double get liter => _liter;
//   Fuel_tank_id get fuelTankId => _fuelTankId;
//   double get pricePerLiter => _pricePerLiter;
//   double get amount => _amount;
//   String get date => _date;
//   dynamic get invRef => _invRef;
//   dynamic get shop => _shop;

//   Fuel_log_model(
//       {int id,
//       Vehicle_id vehicleId,
//       Employee_id employeeId,
//       double odometer,
//       double previousOdometer,
//       double liter,
//       Fuel_tank_id fuelTankId,
//       double pricePerLiter,
//       double amount,
//       String date,
//       dynamic invRef,
//       dynamic shop}) {
//     _id = id;
//     _vehicleId = vehicleId;
//     _employeeId = employeeId;
//     _odometer = odometer;
//     _previousOdometer = previousOdometer;
//     _liter = liter;
//     _fuelTankId = fuelTankId;
//     _pricePerLiter = pricePerLiter;
//     _amount = amount;
//     _date = date;
//     _invRef = invRef;
//     _shop = shop;
//   }

//   Fuel_log_model.fromJson(dynamic json) {
//     _id = json["id"];
//     _vehicleId = json["vehicle_id"] != null
//         ? Vehicle_id.fromJson(json["vehicle_id"])
//         : null;
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _odometer = json["odometer"];
//     _previousOdometer = json["previous_odometer"];
//     _liter = json["liter"];
//     _fuelTankId = json["fuel_tank_id"] != null
//         ? Fuel_tank_id.fromJson(json["fuel_tank_id"])
//         : null;
//     _pricePerLiter = json["price_per_liter"];
//     _amount = json["amount"];
//     _date = json["date"];
//     _invRef = json["inv_ref"];
//     _shop = json["shop"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_vehicleId != null) {
//       map["vehicle_id"] = _vehicleId.toJson();
//     }
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.toJson();
//     }
//     map["odometer"] = _odometer;
//     map["previous_odometer"] = _previousOdometer;
//     map["liter"] = _liter;
//     if (_fuelTankId != null) {
//       map["fuel_tank_id"] = _fuelTankId.toJson();
//     }
//     map["price_per_liter"] = _pricePerLiter;
//     map["amount"] = _amount;
//     map["date"] = _date;
//     map["inv_ref"] = _invRef;
//     map["shop"] = _shop;
//     return map;
//   }
// }

/// id : null
/// name : null

class Fuel_tank_id {
  int id = 0;
  String name = "";
  Fuel_tank_id({
    this.id = 0,
    this.name = '',
  });

  Fuel_tank_id copyWith({
    int? id,
    String? name,
  }) {
    return Fuel_tank_id(
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

  factory Fuel_tank_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuel_tank_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuel_tank_id.fromJson(String source) =>
      Fuel_tank_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fuel_tank_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuel_tank_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

/// id : 6115
/// name : "Ahr Yu"

class Employee_id {
  int id = 0;
  String name = "";
  Employee_id({
    this.id = 0,
    this.name = '',
  });

  Employee_id copyWith({
    int? id,
    String? name,
  }) {
    return Employee_id(
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

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

/// id : 1
/// name : "Audi/A6/s3333"

class Vehicle_id {
  int id = 0;
  String name = "";
  Vehicle_id({
    this.id = 0,
    this.name = '',
  });

  Vehicle_id copyWith({
    int? id,
    String? name,
  }) {
    return Vehicle_id(
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

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Vehicle_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}
