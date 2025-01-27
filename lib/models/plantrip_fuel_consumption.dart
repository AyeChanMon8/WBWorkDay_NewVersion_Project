

import 'dart:convert';

/// plan_trip_id : 2
/// consumed_liter : 500
/// description : "Testing"

class Plantrip_fuel_consumption {
  int planTripId;
  double consumedLiter;
  String description;
  int route_id;
  int vehicleId;
  int employeeId;
  String sourceDoc;
  String date;
  int fillingLiter;
  int line_id;
  Plantrip_fuel_consumption({this.planTripId = 0, this.consumedLiter = 0.0,
  this.description = '', this.route_id = 0, this.vehicleId = 0,
  this.employeeId = 0,this.sourceDoc = '', this.date = '',
  this.fillingLiter = 0, this.line_id = 0});

  Plantrip_fuel_consumption copyWith({int? id, String? name}) {
    return Plantrip_fuel_consumption(
      planTripId: planTripId ?? this.planTripId,
      consumedLiter: consumedLiter ?? this.consumedLiter,
      description: description ?? this.description,
      route_id: route_id ?? this.route_id,
      vehicleId: vehicleId ?? this.vehicleId,
      employeeId: employeeId ?? this.employeeId,
      sourceDoc: sourceDoc ?? this.sourceDoc,
      date: date ?? this.date,
      fillingLiter: fillingLiter ?? this.fillingLiter,
      line_id: line_id ?? this.line_id
    );
  }

  Map<String, dynamic> toMap() {
    return {'plan_trip_id': planTripId, 
    'consumed_liter': consumedLiter,
    'description': description, 
    'route_id': route_id,
    'vehicle_id': vehicleId,
    'employee_id': employeeId,
    'source_doc': sourceDoc,
    'date': date,
    'filling_liter': fillingLiter,
    'line_id': line_id
    };
  }

  factory Plantrip_fuel_consumption.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_fuel_consumption(
      planTripId: map['plan_trip_id'],
      consumedLiter: map['consumed_liter'],
      description: map['description'],
      route_id: map['route_id'],
      vehicleId: map['vehicle_id'],
      employeeId: map['employee_id'],
      sourceDoc: map['source_doc'],
      date: map['date'],
      fillingLiter: map['filling_liter'],
      line_id: map['line_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_fuel_consumption.fromJson(String source) =>
      Plantrip_fuel_consumption.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_fuel_consumption(planTripId: $planTripId, consumedLiter: $consumedLiter,description: $description, route_id: $route_id,vehicleId: $vehicleId, employeeId: $employeeId,sourceDoc: $sourceDoc, date: $date,fillingLiter: $fillingLiter, line_id: $line_id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_fuel_consumption && o.planTripId == planTripId && o.consumedLiter == consumedLiter && o.description == description && o.route_id == route_id
    && o.vehicleId == vehicleId && o.employeeId == employeeId && o.sourceDoc == sourceDoc && o.date == date && o.fillingLiter == fillingLiter && o.line_id == line_id;
  }

  @override
  int get hashCode => planTripId.hashCode ^ consumedLiter.hashCode ^ description.hashCode ^ route_id.hashCode ^ vehicleId.hashCode ^ employeeId.hashCode
  ^ sourceDoc.hashCode ^ date.hashCode ^ fillingLiter.hashCode ^ line_id.hashCode;
}

// class Plantrip_fuel_consumption {
//   int _planTripId;
//   double _consumedLiter;
//   String _description;
//   int _route_id;
//   int _vehicleId;
//   int _employeeId;
//   String _sourceDoc;
//   String _date;
//   int _fillingLiter;
//   int _line_id;

//   int get planTripId => _planTripId;
//   double get consumedLiter => _consumedLiter;
//   String get description => _description;
//   int get vehicleId => _vehicleId;
//   int get employeeId=> _employeeId;
//   String get sourceDoc => _sourceDoc;
//   String get fillingDate => _date;
//   int get fillingLiter => _fillingLiter;

//   Plantrip_fuel_consumption({
//       int planTripId, 
//       double consumedLiter,
//       String description,
//       int route_id,
//     int vehicleId,
//     int employeeId,
//     String sourceDoc,
//     String date,
//     int fillingLiter,
//     int line_id
//   }){
//     _planTripId = planTripId;
//     _consumedLiter = consumedLiter;
//     _description = description;
//     _route_id = route_id;
//     _vehicleId = vehicleId;
//     _employeeId = employeeId;
//     _sourceDoc = sourceDoc;
//     _date = date;
//     _fillingLiter = fillingLiter;
//     _line_id = line_id;

// }

//   Plantrip_fuel_consumption.fromJson(dynamic json) {
//     _planTripId = json["plan_trip_id"];
//     _consumedLiter = json["consumed_liter"];
//     _description = json["description"];
//     _vehicleId = json["vehicle_id"];
//     _employeeId = json["employee_id"];
//     _sourceDoc = json['source_doc'];
//     _date = json['filling_date'];
//     _fillingLiter = json['filling_liter'];
//   }

//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'plan_trip_id':_planTripId,
//       'consumed_liter': _consumedLiter,
//       'description': _description,
//       'route_id': _route_id,
//       // 'vehicle_id' : _vehicleId,
//      'employee_id' : _employeeId,
//       // 'source_doc' : _sourceDoc,
//       'date' : _date,
//        'line_id' : _line_id,
//     };
//   }
// }