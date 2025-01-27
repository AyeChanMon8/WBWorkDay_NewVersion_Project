

import 'dart:convert';

class Leave {
  final DateTime? start_date;
  final DateTime? end_date;
  final String city_from;
  final String city_to;
  Leave({
    this.start_date,
    this.end_date,
    this.city_from = '',
    this.city_to = ''
  });


  Leave copyWith({
    DateTime? start_date,
    DateTime? end_date,
    String? city_from,
    String? city_to,
  }) {
    return Leave(
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      city_from: city_from ?? this.city_from,
      city_to: city_to ?? this.city_to
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start_date': start_date,
      'end_date': end_date,
      'city_from': city_from,
      'city_to': city_to,
      // 'name': name,
    };
  }

  factory Leave.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Leave(
      start_date: map['start_date'],
      end_date: map['end_date'],
      city_from: map['city_from'],
      city_to: map['city_to'],
    
    );
  }

  String toJson() => json.encode(toMap());

  factory Leave.fromJson(String source) => Leave.fromMap(json.decode(source));

  @override
  String toString() => 'Leave(start_date: $start_date, end_date: $end_date, city_from: $city_from, city_to: $city_to)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Leave &&
      o.start_date == start_date &&
      o.end_date == end_date &&
      o.city_from == city_from &&
      o.city_to == city_to;
  }

  @override
  int get hashCode => start_date.hashCode ^ end_date.hashCode ^ city_from.hashCode ^ city_to.hashCode;
}

// class Leave {
//   final DateTime start_date;
//   final DateTime end_date;
//   final String city_from;
//   final String city_to;
//   Leave({
//     this.start_date,
//     this.end_date,
//     this.city_from,
//     this.city_to,
//   });

//   Leave copyWith({
//     DateTime start_date,
//     DateTime end_date,
//     String city_from,
//     String city_to,
//   }) {
//     return Leave(
//       start_date: start_date ?? this.start_date,
//       end_date: end_date ?? this.end_date,
//       city_from: city_from ?? this.city_from,
//       city_to: city_to ?? this.city_to,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'start_date': start_date?.millisecondsSinceEpoch,
//       'end_date': end_date?.millisecondsSinceEpoch,
//       'city_from': city_from,
//       'city_to': city_to,
//     };
//   }

//   factory Leave.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Leave(
//       start_date: DateTime.fromMillisecondsSinceEpoch(map['start_date']),
//       end_date: DateTime.fromMillisecondsSinceEpoch(map['end_date']),
//       city_from: map['city_from'],
//       city_to: map['city_to'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Leave.fromJson(String source) => Leave.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Leave(start_date: $start_date, end_date: $end_date, city_from: $city_from, city_to: $city_to)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Leave &&
//         o.start_date == start_date &&
//         o.end_date == end_date &&
//         o.city_from == city_from &&
//         o.city_to == city_to;
//   }

//   @override
//   int get hashCode {
//     return start_date.hashCode ^
//         end_date.hashCode ^
//         city_from.hashCode ^
//         city_to.hashCode;
//   }
// }
