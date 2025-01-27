import 'dart:convert';

class Daytrip_advance_expense_category {
  int id;
  String displayName;
  dynamic outOfPocketExpense;
  bool travelExpense;
  dynamic tripExpense;

  // final int id;
  // final String name;
  Daytrip_advance_expense_category(
      {this.id = 0,
      this.displayName = '',
      this.outOfPocketExpense = null,
      this.travelExpense = false,
      this.tripExpense = null});

  Daytrip_advance_expense_category copyWith({
    int? id,
    String? displayName,
    dynamic? outOfPocketExpense,
    bool? travelExpense,
    dynamic? tripExpense,
  }) {
    return Daytrip_advance_expense_category(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        outOfPocketExpense: outOfPocketExpense ?? this.outOfPocketExpense,
        travelExpense: travelExpense ?? this.travelExpense,
        tripExpense: tripExpense ?? this.tripExpense);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'display_name': displayName,
      'out_of_pocket_expense': outOfPocketExpense,
      'travel_expense': travelExpense,
      'trip_expense': tripExpense
    };
  }

  factory Daytrip_advance_expense_category.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Daytrip_advance_expense_category(
        id: map['id'],
        displayName: map['display_name'],
        outOfPocketExpense: map['out_of_pocket_expense'],
        travelExpense: map['travel_expense'] ?? false,
        tripExpense: map['trip_expense']);
  }

  String toJson() => json.encode(toMap());

  factory Daytrip_advance_expense_category.fromJson(String source) =>
      Daytrip_advance_expense_category.fromMap(json.decode(source));

  @override
  String toString() =>
      'Daytrip_advance_expense_category(id: $id, displayName: $displayName, outOfPocketExpense : $outOfPocketExpense, travelExpense: $travelExpense, tripExpense: $tripExpense )';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Daytrip_advance_expense_category &&
        o.id == id &&
        o.displayName == displayName &&
        o.outOfPocketExpense == outOfPocketExpense &&
        o.travelExpense == travelExpense &&
        o.tripExpense == tripExpense;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      displayName.hashCode ^
      outOfPocketExpense.hashCode ^
      travelExpense.hashCode ^
      tripExpense.hashCode;
}
