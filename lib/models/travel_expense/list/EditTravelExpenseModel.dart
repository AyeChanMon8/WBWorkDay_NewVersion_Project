import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../create/travel_line_model.dart';

class EditTravelExpenseModel {
  List<TravelLineModel> travel_line;
  EditTravelExpenseModel({
    required this.travel_line,
  });

  EditTravelExpenseModel copyWith({
    List<TravelLineModel>? travel_line,
  }) {
    return EditTravelExpenseModel(
      travel_line: travel_line ?? this.travel_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'travel_line': travel_line?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory EditTravelExpenseModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EditTravelExpenseModel(
      travel_line: List<TravelLineModel>.from(
          map['travel_line']?.map((x) => TravelLineModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EditTravelExpenseModel.fromJson(String source) =>
      EditTravelExpenseModel.fromMap(json.decode(source));

  @override
  String toString() => 'EditTravelExpenseModel(travel_line: $travel_line)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EditTravelExpenseModel &&
        listEquals(o.travel_line, travel_line);
  }

  @override
  int get hashCode => travel_line.hashCode;
}
