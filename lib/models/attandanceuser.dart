import 'dart:convert';

class Attandanceuser {
  int employee_id;
  String employee_name;
  int count;
  String search_date;
  String status;
  Attandanceuser({
    this.employee_id = 0,
    this.employee_name = '',
    this.count = 0,
    this.search_date = '',
    this.status = '',
  });

  Attandanceuser copyWith({
    int? employee_id,
    String? employee_name,
    int? count,
    String? search_date,
  }) {
    return Attandanceuser(
      employee_id: employee_id ?? this.employee_id,
      employee_name: employee_name ?? this.employee_name,
      count: count ?? this.count,
      search_date: search_date ?? this.search_date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id,
      'employee_name': employee_name,
      'count': count,
      'search_date': search_date,
    };
  }

  factory Attandanceuser.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attandanceuser(
      employee_id: map['employee_id'],
      employee_name: map['employee_name'],
      count: map['count'],
      search_date: map['search_date'],
      status: map['status']??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory Attandanceuser.fromJson(String source) =>
      Attandanceuser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attandanceuser(employee_id: $employee_id, employee_name: $employee_name, count: $count, search_date: $search_date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attandanceuser &&
        o.employee_id == employee_id &&
        o.employee_name == employee_name &&
        o.count == count &&
        o.search_date == search_date;
  }

  @override
  int get hashCode {
    return employee_id.hashCode ^
        employee_name.hashCode ^
        count.hashCode ^
        search_date.hashCode;
  }
}
