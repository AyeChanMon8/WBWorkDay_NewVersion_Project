import 'dart:convert';

import 'package:flutter/foundation.dart';

/// travel : [{"employee_id":6115,"start_date":"2021-01-29","end_date":"2021-01-29","name":"ff"}]
/// leave : []
/// training : []
/// trip_product : []
/// trip_bill : [{"employee_id":6115,"start_date":"2021-02-05","end_date":"2021-02-16","name":"Hello"}]

// class CalendarData {
//   List<Travel> _travel;
//   List<Travel> _leave;
//   List<Travel> _training;
//   List<Travel> _tripProduct;
//   List<Travel> _tripBill;
//   List<Travel> _calendar;
//   List<Travel> _pms;
//   List<Travel> _attendance;
//   List<Travel> _dayTrip;

//   List<Travel> get travel => _travel;
//   List<Travel> get leave => _leave;
//   List<Travel> get training => _training;
//   List<Travel> get tripProduct => _tripProduct;
//   List<Travel> get tripBill => _tripBill;
//   List<Travel> get calendar => _calendar;
//   List<Travel> get pms => _pms;
//   List<Travel> get attendance => _attendance;
//   List<Travel> get dayTrip => _dayTrip;

//   CalendarData({
//     List<Travel> travel,
//     List<Travel> leave,
//     List<Travel> training,
//     List<Travel> tripProduct,
//     List<Travel> tripBill,
//     List<Travel> calendar,
//     List<Travel> pms,
//     List<Travel> attendance,
//     List<Travel> dayTrip,
//   }) {
//     _travel = travel;
//     _leave = leave;
//     _training = training;
//     _tripProduct = tripProduct;
//     _tripBill = tripBill;
//     _calendar = calendar;
//     _pms = pms;
//     _attendance = attendance;
//     _dayTrip = dayTrip;
//   }

//   CalendarData.fromJson(dynamic json) {
//     if (json["travel"] != null) {
//       _travel = [];
//       json["travel"].forEach((v) {
//         _travel.add(Travel.fromJson(v));
//       });
//     }
//     if (json["leave"] != null) {
//       _leave = [];
//       json["leave"].forEach((v) {
//         _leave.add(Travel.fromJson(v));
//       });
//     }
//     if (json["training"] != null) {
//       _training = [];
//       json["training"].forEach((v) {
//         _training.add(Travel.fromJson(v));
//       });
//     }
//     if (json["trip_product"] != null) {
//       _tripProduct = [];
//       json["trip_product"].forEach((v) {
//         _tripProduct.add(Travel.fromJson(v));
//       });
//     }
//     if (json["trip_bill"] != null) {
//       _tripBill = [];
//       json["trip_bill"].forEach((v) {
//         _tripBill.add(Travel.fromJson(v));
//       });
//     }
//     if (json["calendar"] != null) {
//       _calendar = [];
//       json["calendar"].forEach((v) {
//         _calendar.add(Travel.fromJson(v));
//       });
//     }
//     if (json["pms"] != null) {
//       _pms = [];
//       json["pms"].forEach((v) {
//         _pms.add(Travel.fromJson(v));
//       });
//     }
//     if (json["attendance"] != null) {
//       _attendance = [];
//       json["attendance"].forEach((v) {
//         _attendance.add(Travel.fromJson(v));
//       });
//     }
//     if (json["day_trip"] != null) {
//       _dayTrip = [];
//       json["day_trip"].forEach((v) {
//         _dayTrip.add(Travel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (_travel != null) {
//       map["travel"] = _travel.map((v) => v.toJson()).toList();
//     }
//     if (_leave != null) {
//       map["leave"] = _leave.map((v) => v.toJson()).toList();
//     }
//     if (_training != null) {
//       map["training"] = _training.map((v) => v.toJson()).toList();
//     }
//     if (_tripProduct != null) {
//       map["trip_product"] = _tripProduct.map((v) => v.toJson()).toList();
//     }
//     if (_tripBill != null) {
//       map["trip_bill"] = _tripBill.map((v) => v.toJson()).toList();
//     }
//     if (_tripBill != null) {
//       map["calendar"] = _calendar.map((v) => v.toJson()).toList();
//     }
//     if (_pms != null) {
//       map["pms"] = _pms.map((v) => v.toJson()).toList();
//     }
//     if (_attendance != null) {
//       map["attendance"] = _attendance.map((v) => v.toJson()).toList();
//     }
//     if (_dayTrip != null) {
//       map["day_trip"] = _dayTrip.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

class CalendarData {
  List<Travel>? travel;
  List<Travel>? leave;
  List<Travel>? tripProduct;
  List<Travel>? tripBill;
  List<Travel>? calendar;
  List<Travel>? pms;
  List<Travel>? attendance;
  List<Travel>? dayTrip;
  List<Travel>? training;
  CalendarData({
    this.travel,
    this.leave,
    this.tripProduct,
    this.tripBill,
    this.calendar,
    this.pms,
    this.attendance,
    this.dayTrip,
    this.training
  });

  CalendarData copyWith({
    required List<Travel> travel,
    required List<Travel> leave,
    required List<Travel> tripProduct,
    required List<Travel> tripBill,
    required List<Travel> calendar,
    required List<Travel> pms,
    required List<Travel> attendance,
    required List<Travel> dayTrip,
    List<Travel>? training,
  }) {
    return CalendarData(
      travel: travel ?? this.travel,
      leave: leave ?? this.leave,
      tripProduct: tripProduct ?? this.tripProduct,
      tripBill: tripBill ?? this.tripBill,
      calendar: calendar ?? this.calendar,
      pms: pms ?? this.pms,
      attendance: attendance ?? this.attendance,
      dayTrip: dayTrip ?? this.dayTrip,
      training: training ?? this.training,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'travel': travel?.map((x) => x?.toMap())?.toList(),
      'leave': leave?.map((x) => x?.toMap())?.toList(),
      'trip_product': tripProduct?.map((x) => x?.toMap())?.toList(),
      'trip_bill': tripBill?.map((x) => x?.toMap())?.toList(),
      'calendar': calendar?.map((x) => x?.toMap())?.toList(),
      'pms': pms?.map((x) => x?.toMap())?.toList(),
      'day_trip': dayTrip?.map((x) => x?.toMap())?.toList(),
      'attendance': attendance?.map((x) => x?.toMap())?.toList(),
      'training': training?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CalendarData.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return CalendarData(
      travel: List<Travel>.from(map['travel']?.map((x) => Travel.fromMap(x))),
      leave: List<Travel>.from(map['leave']?.map((x) => Travel.fromMap(x))),
      tripProduct:
          List<Travel>.from(map['trip_product']?.map((x) => Travel.fromMap(x))),
      tripBill:
          List<Travel>.from(map['trip_bill']?.map((x) => Travel.fromMap(x))),
      calendar:
          List<Travel>.from(map['calendar']?.map((x) => Travel.fromMap(x))),
      pms: List<Travel>.from(map['pms']?.map((x) => Travel.fromMap(x))),
      dayTrip:
          List<Travel>.from(map['day_trip']?.map((x) => Travel.fromMap(x))),
      attendance:
          List<Travel>.from(map['attendance']?.map((x) => Travel.fromMap(x))),
      training:
          List<Travel>.from(map['training']?.map((x) => Travel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarData.fromJson(String source) =>
      CalendarData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CalendarData(travel: $travel, leave: $leave, tripProduct: $tripProduct, tripBill: $tripBill, calendar: $calendar, pms: $pms, dayTrip: $dayTrip, attendance: $attendance,training: $training)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CalendarData &&
        listEquals(o.travel, travel) &&
        listEquals(o.leave, leave) &&
        listEquals(o.tripProduct, tripProduct) &&
        listEquals(o.tripBill, tripBill) &&
        listEquals(o.calendar, calendar) &&
        listEquals(o.pms, pms) &&
        listEquals(o.dayTrip, dayTrip) &&
        listEquals(o.attendance, attendance) &&
        listEquals(o.training, training);
  }

  @override
  int get hashCode {
    return travel.hashCode ^
        leave.hashCode ^
        tripProduct.hashCode ^
        tripBill.hashCode ^
        calendar.hashCode ^
        pms.hashCode ^
        dayTrip.hashCode ^
        attendance.hashCode ^
        training.hashCode;
  }
}

/// employee_id : 6115
/// start_date : "2021-01-29"
/// end_date : "2021-01-29"
/// name : "ff"
// class Travel {
//   int _employeeId;
//   String _startDate;
//   String _endDate;
//   String _name;
//   String _purpose;

//   int get employeeId => _employeeId;
//   String get startDate => _startDate;
//   String get endDate => _endDate;
//   String get name => _name;
//   String get purpose => _purpose;

//   Travel({int employeeId, String startDate, String endDate, String name}) {
//     _employeeId = employeeId;
//     _startDate = startDate;
//     _endDate = endDate;
//     _name = name;
//   }

//   Travel.fromJson(dynamic json) {
//     _employeeId = json["employee_id"];
//     _startDate = json["start_date"];
//     _endDate = json["end_date"];
//     _name = json["name"];
//     _purpose = json["description"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["employee_id"] = _employeeId;
//     map["start_date"] = _startDate;
//     map["end_date"] = _endDate;
//     map["name"] = _name;
//     return map;
//   }
// }

class Travel {
  int employeeId;
  String startDate;
  String endDate;
  String name;
  String purpose;

  Travel(
      {this.employeeId = 0,
      this.startDate = '',
      this.endDate = '',
      this.name = '',
      this.purpose = ''});

  Travel copyWith(
      {int? employeeId,
      String? startDate,
      String? endDate,
      String? name,
      String? purpose}) {
    return Travel(
        employeeId: employeeId ?? this.employeeId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        name: name ?? this.name,
        purpose: purpose ?? this.purpose);
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employeeId,
      'start_date': startDate,
      'end_date': endDate,
      'name': name,
      'purpose': purpose
    };
  }

  factory Travel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Travel(
        employeeId: map['employee_id'],
        startDate: map['start_date'],
        endDate: map['end_date'],
        name: map['name'],
        purpose: map['purpose']??"");
  }

  String toJson() => json.encode(toMap());

  factory Travel.fromJson(String source) => Travel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Travel(employeeId: $employeeId, startDate: $startDate, endDate: $endDate, name: $name, purpose: $purpose)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Travel &&
        o.employeeId == employeeId &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.name == name &&
        o.purpose == purpose;
  }

  @override
  int get hashCode {
    return employeeId.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        name.hashCode ^
        purpose.hashCode;
  }
}
