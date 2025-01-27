

import 'dart:convert';

class LeaveBalance {

  String name;
  double entitle;
  double taken;
  double balance;
  LeaveBalance({
    this.name = '',
    this.entitle = 0.0,
    this.taken = 0.0,
    this.balance = 0.0
  });

  LeaveBalance copyWith({
    String? name,
    double? entitle,
    double? taken,
    double? balance,
  }) {
    return LeaveBalance(
      name: name ?? this.name,
      entitle: entitle ?? this.entitle,
      taken: taken ?? this.taken,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'entitle': entitle,
      'taken': taken,
      'balance': balance
    };
  }

  factory LeaveBalance.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return LeaveBalance(
      name: map['name'],
      entitle: map['entitle'],
      taken: map['taken'],
      balance: map['balance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaveBalance.fromJson(String source) =>
      LeaveBalance.fromMap(json.decode(source));

  @override
  String toString() => 'LeaveBalance(name: $name, entitle: $entitle,taken: $taken, balance: $balance)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LeaveBalance && o.name == name && o.entitle == entitle && o.taken == taken && o.balance == balance;
  }

  @override
  int get hashCode => name.hashCode ^ entitle.hashCode ^ taken.hashCode ^ balance.hashCode;
}

// class LeaveBalance {
//   String name;
//   double entitle;
//   double taken;
//   double balance;
//   LeaveBalance({
//     this.name,
//     this.entitle,
//     this.taken,
//     this.balance,
//   });
  

//   LeaveBalance copyWith({
//     String name,
//     double entitle,
//     double taken,
//     double balance,
//   }) {
//     return LeaveBalance(
//       name: name ?? this.name,
//       entitle: entitle ?? this.entitle,
//       taken: taken ?? this.taken,
//       balance: balance ?? this.balance,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'entitle': entitle,
//       'taken': taken,
//       'balance': balance,
//     };
//   }

//   factory LeaveBalance.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return LeaveBalance(
//       name: map['name'],
//       entitle: map['entitle'],
//       taken: map['taken'],
//       balance: map['balance'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LeaveBalance.fromJson(String source) => LeaveBalance.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'LeaveBalance(name: $name, entitle: $entitle, taken: $taken, balance: $balance)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is LeaveBalance &&
//       o.name == name &&
//       o.entitle == entitle &&
//       o.taken == taken &&
//       o.balance == balance;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//       entitle.hashCode ^
//       taken.hashCode ^
//       balance.hashCode;
//   }
// }
