

import 'dart:convert';

// class LoanLine {
//   String date;
//   String state;
//   double amount;
//   LoanLine({
//     this.date,
//     this.state,
//     this.amount,
//   });

//   LoanLine copyWith({
//     String date,
//     String state,
//     double amount,
//   }) {
//     return LoanLine(
//       date: date ?? this.date,
//       state: state ?? this.state,
//       amount: amount ?? this.amount,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'date': date,
//       'state': state,
//       'amount': amount,
//     };
//   }

//   factory LoanLine.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return LoanLine(
//       date: map['date'],
//       state: map['state'],
//       amount: map['amount'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LoanLine.fromJson(String source) => LoanLine.fromMap(json.decode(source));

//   @override
//   String toString() => 'LoanLine(date: $date, state: $state, amount: $amount)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is LoanLine &&
//       o.date == date &&
//       o.state == state &&
//       o.amount == amount;
//   }

//   @override
//   int get hashCode => date.hashCode ^ state.hashCode ^ amount.hashCode;
// }

class LoanLine {

  String date;
  String state;
  double amount;
  LoanLine({
    this.date = '',
    this.state = '',
    this.amount = 0.0,
  });

  LoanLine copyWith({
    String? date,
  String? state,
  double? amount,
  }) {
    return LoanLine(
      date: date ?? this.date,
      state: state ?? this.state,
      amount: amount ?? this.amount
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'state': state,
      'amount': amount
    };
  }

  factory LoanLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LoanLine(
      date: map['date'],
      state: map['state'],
      amount: map['amount']
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanLine.fromJson(String source) =>
      LoanLine.fromMap(json.decode(source));

  @override
  String toString() => 'LoanLine(date: $date, state: $state,amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoanLine && o.date == date && o.state == state && o.amount == amount;
  }

  @override
  int get hashCode => date.hashCode ^ state.hashCode ^ amount.hashCode;
}
