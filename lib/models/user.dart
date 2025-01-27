

import 'dart:convert';
import 'dart:ffi';

class User {
  int uid = 1;
  int company_id = 1;
  String access_token;
  int expires_in = 0;
  String refresh_token;
  int refresh_expires_in = 0;
  User({
    this.uid = 0,
    this.company_id = 0,
    this.access_token = '',
    this.expires_in = 0,
    this.refresh_token = '',
    this.refresh_expires_in = 0
  });


  User copyWith({
    int? uid,
  int? company_id,
  String? access_token,
  int? expires_in,
  String? refresh_token,
  int? refresh_expires_in
  }) {
    return User(
      uid: uid ?? this.uid,
      company_id: company_id ?? this.company_id,
      access_token: access_token ?? this.access_token,
      expires_in: expires_in ?? this.expires_in,
      refresh_token: refresh_token ?? this.refresh_token,
      refresh_expires_in: refresh_expires_in ?? this.refresh_expires_in
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'company_id': company_id,
      'access_token': access_token,
      'expires_in': expires_in,
      'refresh_token': refresh_token,
      'refresh_expires_in': refresh_expires_in,
      // 'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return User(
      uid: map['uid'],
      company_id: map['company_id'],
      access_token: map['access_token'],
      expires_in: map['expires_in'],
      refresh_token: map['refresh_token'],
      refresh_expires_in: map['refresh_expires_in'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(uid: $uid, company_id: $company_id, access_token: $access_token,expires_in: $expires_in, refresh_token: $refresh_token, refresh_expires_in: $refresh_expires_in)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
      o.uid == uid &&
      o.company_id == company_id &&
      o.access_token == access_token &&
      o.expires_in == expires_in &&
      o.refresh_token == refresh_token &&
      o.refresh_expires_in == refresh_expires_in;
  }

  @override
  int get hashCode => uid.hashCode ^ company_id.hashCode ^ expires_in.hashCode ^ refresh_token.hashCode ^ refresh_expires_in.hashCode;
}

// class User {
//   int uid = 1;
//   int company_id = 1;
//   String access_token;
//   int expires_in = 0;
//   String refresh_token;
//   int refresh_expires_in = 0;
//   User({
//     this.uid = 1,
//     this.company_id = 1,
//     this.access_token = '',
//     this.expires_in = 0,
//     this.refresh_token = '',
//     this.refresh_expires_in = 0,
//   });

//   User copyWith({
//     int uid,
//     int company_id,
//     String access_token,
//     double expires_in,
//     String refresh_token,
//     double refresh_expires_in,
//   }) {
//     return User(
//       uid: uid ?? this.uid,
//       company_id: company_id ?? this.company_id,
//       access_token: access_token ?? this.access_token,
//       expires_in: expires_in ?? this.expires_in,
//       refresh_token: refresh_token ?? this.refresh_token,
//       refresh_expires_in: refresh_expires_in ?? this.refresh_expires_in,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'company_id': company_id,
//       'access_token': access_token,
//       'expires_in': expires_in,
//       'refresh_token': refresh_token,
//       'refresh_expires_in': refresh_expires_in,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return User(
//       uid: map['uid'] ?? 0,
//       company_id: map['company_id'] ?? 0,
//       access_token: map['access_token'] ?? '',
//       expires_in: map['expires_in'] ?? 0.0,
//       refresh_token: map['refresh_token'] ?? '',
//       refresh_expires_in: map['refresh_expires_in'] ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'User(uid: $uid, company_id: $company_id, access_token: $access_token, expires_in: $expires_in, refresh_token: $refresh_token, refresh_expires_in: $refresh_expires_in)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is User &&
//         o.uid == uid &&
//         o.company_id == company_id &&
//         o.access_token == access_token &&
//         o.expires_in == expires_in &&
//         o.refresh_token == refresh_token &&
//         o.refresh_expires_in == refresh_expires_in;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^
//     company_id.hashCode ^
//     access_token.hashCode ^
//     expires_in.hashCode ^
//     refresh_token.hashCode ^
//     refresh_expires_in.hashCode;
//   }
// }
