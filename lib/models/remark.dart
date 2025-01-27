

import 'dart:convert';

// class Remark {
//  String remark;
//   String state;
//   String remark_line;

// //<editor-fold desc="Data Methods" defaultstate="collapsed">

//   Remark({
//     this.remark = '',
//     this.state = '',
//     this.remark_line = ''
//   });

//   Remark copyWith({
//     String? remark,
//     String? state,
//     String? remark_line
//   }) {
//     if ((remark == null || identical(remark, this.remark)) &&
//         (state == null || identical(state, this.state)) &&
//         (remark_line == null || identical(remark_line, this.remark_line))) {
//       return this;
//     }

//     return new Remark(
//       remark: remark ?? this.remark,
//       state: state ?? this.state,
//       remark_line: remark_line ?? this.remark_line
//     );
//   }

//   @override
//   String toString() {
//     return 'Remark{remark: $remark, state: $state,remark_line: $remark_line}';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is Remark &&
//           runtimeType == other.runtimeType &&
//           remark == other.remark &&
//           state == other.state &&
//           remark_line == other.remark_line);

//   @override
//   int get hashCode => remark.hashCode ^ state.hashCode ^ remark_line.hashCode;

//   factory Remark.fromMap(Map<String, dynamic> map) {
//     return new Remark(
//       remark: map['remark'] as String,
//       state: map['state'] as String,
//       remark_line: map['remark_line'] as String
//     );
//   }

//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'remark': this.remark,
//       'state': this.state,
//       'remark_line': this.remark_line
//     } as Map<String, dynamic>;
//   }

// //</editor-fold>
// }

class Remark {
  String remark;
  String state;
  String remark_line;
  Remark({
    this.remark = '',
    this.state = '',
    this.remark_line = '',
  });

  Remark copyWith({
    String? remark,
    String? state,
    String? remark_line,
  }) {
    return Remark(
      remark: remark ?? this.remark,
      state: state ?? this.state,
      remark_line: remark_line ?? this.remark_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'remark': remark,
      'state': state,
      'remark_line': remark_line,
    };
  }

  factory Remark.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
  
    return Remark(
      remark: map['remark'],
      state: map['state'],
      remark_line: map['remark_line'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Remark.fromJson(String source) => Remark.fromMap(json.decode(source));

  @override
  String toString() => 'Remark(remark: $remark, state: $state, remark_line: $remark_line)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Remark &&
      o.remark == remark &&
      o.state == state &&
      o.remark_line == remark_line;
  }

  @override
  int get hashCode => remark.hashCode ^ state.hashCode ^ remark_line.hashCode;
}
