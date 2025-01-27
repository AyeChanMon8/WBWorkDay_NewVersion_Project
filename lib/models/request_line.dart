import 'dart:convert';

import '../models/employee_id.dart';

class RequestLine {
  EmployeeID? employee_id;
  String email;
  String state;
  String remark_line;
  bool mail_sent;
  RequestLine(
      {this.employee_id,
      this.email = '',
      this.state = '',
      this.remark_line = '',
      this.mail_sent = false});

  RequestLine copyWith(
      {EmployeeID? employee_id,
      String? email,
      String? state,
      String? remark_line,
      bool? mail_sent}) {
    return RequestLine(
        employee_id: employee_id ?? this.employee_id,
        email: email ?? this.email,
        state: state ?? this.state,
        remark_line: remark_line ?? this.remark_line,
        mail_sent: mail_sent ?? this.mail_sent);
  }

  Map<String, dynamic> toMap() {
    return {
      'employee_id': employee_id?.toMap(),
      'email': email,
      'state': state,
      'remark_line': remark_line,
      'mail_sent': mail_sent,
      // 'name': name,
    };
  }

  factory RequestLine.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RequestLine(
      employee_id: EmployeeID.fromMap(map['employee_id']),
      email: map['email'] ?? "",
      state: map['state'] ?? "",
      remark_line: map['remark_line'] ?? "",
      mail_sent: map['mail_sent'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestLine.fromJson(String source) =>
      RequestLine.fromMap(json.decode(source));

  @override
  String toString() =>
      'RequestLine(employee_id: $employee_id, email: $email,state: $state,remark_line: $remark_line,mail_sent: $mail_sent)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestLine &&
        o.employee_id == employee_id &&
        o.email == email &&
        o.state == state &&
        o.remark_line == remark_line &&
        o.mail_sent == mail_sent;
  }

  @override
  int get hashCode =>
      employee_id.hashCode ^
      email.hashCode ^
      state.hashCode ^
      remark_line.hashCode ^
      mail_sent.hashCode;
}



// class RequestLine {
//   EmployeeID employee_id;
//   String email;
//   String state;
//   String remark_line;
//   bool mail_sent;
//   RequestLine({
//     this.employee_id,
//     this.email,
//     this.state,
//     this.remark_line,
//     this.mail_sent,
//   });

//   RequestLine copyWith({
//     EmployeeID employee_id,
//     String email,
//     String state,
//     String remark_line,
//     bool mail_sent,
//   }) {
//     return RequestLine(
//       employee_id: employee_id ?? this.employee_id,
//       email: email ?? this.email,
//       state: state ?? this.state,
//       remark_line: remark_line ?? this.remark_line,
//       mail_sent: mail_sent ?? this.mail_sent,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'employee_id': employee_id?.toMap(),
//       'email': email,
//       'state': state,
//       'remark_line': remark_line,
//       'mail_sent': mail_sent,
//     };
//   }

//   factory RequestLine.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return RequestLine(
//       employee_id: EmployeeID.fromMap(map['employee_id']),
//       email: map['email'],
//       state: map['state'],
//       remark_line: map['remark_line'],
//       mail_sent: map['mail_sent'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RequestLine.fromJson(String source) => RequestLine.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'RequestLine(employee_id: $employee_id, email: $email, state: $state, remark_line: $remark_line, mail_sent: $mail_sent)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is RequestLine &&
//       o.employee_id == employee_id &&
//       o.email == email &&
//       o.state == state &&
//       o.remark_line == remark_line &&
//       o.mail_sent == mail_sent;
//   }

//   @override
//   int get hashCode {
//     return employee_id.hashCode ^
//       email.hashCode ^
//       state.hashCode ^
//       remark_line.hashCode ^
//       mail_sent.hashCode;
//   }
// }
