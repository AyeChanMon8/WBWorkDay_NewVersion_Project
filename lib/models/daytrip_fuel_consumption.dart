import 'dart:convert';

import 'package:flutter/material.dart';

class Daytrip_fuel_consumption {

  final int dayTripId;
  final int lineId;
  final double consumedLiter;
  final String description;
  final int vehicleId;
  final int employeeId;
  final String sourceDoc;
  final String date;
  final int fillingLiter;
  Daytrip_fuel_consumption({
    this.dayTripId = 0,
    this.lineId = 0,
    this.consumedLiter = 0.0,
    this.description = "",
    this.vehicleId = 0,
    this.employeeId = 0,
    this.sourceDoc = '',
    this.date = '',
    this.fillingLiter = 0,
  });

  Daytrip_fuel_consumption copyWith({
    int? dayTripId,
    int? lineId,
    double? consumedLiter,
    String? description,
    int? vehicleId,
    int? employeeId,
    String? sourceDoc,
    String? date,
    int? fillingLiter
  }) {
    return Daytrip_fuel_consumption(
      dayTripId: dayTripId ?? this.dayTripId,
      lineId: lineId ?? this.lineId,
      consumedLiter: consumedLiter ?? this.consumedLiter,
      description: description ?? this.description,
      vehicleId: vehicleId ?? this.vehicleId,
      employeeId: employeeId ?? this.employeeId,
      sourceDoc: sourceDoc ?? this.sourceDoc,
      date: date ?? this.date,
      fillingLiter: fillingLiter ?? this.fillingLiter
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day_trip_id': dayTripId,
      'line_id': lineId,
      'consumed_liter': consumedLiter,
      'description': description,
      'employee_id': employeeId,
      'date': date,
    };
  }

  factory Daytrip_fuel_consumption.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Daytrip_fuel_consumption(
      dayTripId: map['day_trip_id'],
      lineId: map['line_id'],
      consumedLiter: map['consumed_liter'],
      description: map['description'],
      employeeId: map['employee_id'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Daytrip_fuel_consumption.fromJson(String source) =>
      Daytrip_fuel_consumption.fromMap(json.decode(source));

  @override
  String toString() => 'Daytrip_fuel_consumption(dayTripId: $dayTripId, lineId: $lineId,consumedLiter: $consumedLiter, description: $description,employeeId: $employeeId, date: $date)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Daytrip_fuel_consumption && o.dayTripId == dayTripId && o.lineId == lineId && o.consumedLiter == consumedLiter && o.description == description && o.employeeId == employeeId && o.date == date;
  }

  @override
  int get hashCode => dayTripId.hashCode ^ lineId.hashCode ^ consumedLiter.hashCode ^ description.hashCode ^ employeeId.hashCode ^ date.hashCode;
}


