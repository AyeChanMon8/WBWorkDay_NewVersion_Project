import 'dart:convert';

class AttendanceRequest {
  final String fingerprint_id;
  final int employee_id;
  final String check_in;
  final double latitude;
  final double longitude;
  AttendanceRequest({
    this.fingerprint_id = '',
    this.employee_id = 0,
    this.check_in = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  AttendanceRequest copyWith({
    String? fingerprint_id,
    int? employee_id,
    String? check_in,
  }) {
    return AttendanceRequest(
      fingerprint_id: fingerprint_id ?? this.fingerprint_id,
      employee_id: employee_id ?? this.employee_id,
      check_in: check_in ?? this.check_in,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fingerprint_id': fingerprint_id,
      'employee_id': employee_id,
      'check_in': check_in,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AttendanceRequest.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return AttendanceRequest(
      fingerprint_id: map['fingerprint_id'],
      employee_id: map['employee_id'],
      check_in: map['check_in'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceRequest.fromJson(String source) =>
      AttendanceRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AttendanceRequest(fingerprint_id: $fingerprint_id, employee_id: $employee_id, check_in: $check_in)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AttendanceRequest &&
        o.fingerprint_id == fingerprint_id &&
        o.employee_id == employee_id &&
        o.check_in == check_in;
  }

  @override
  int get hashCode =>
      fingerprint_id.hashCode ^ employee_id.hashCode ^ check_in.hashCode;
}
