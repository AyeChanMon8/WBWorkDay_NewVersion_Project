

// class Attachment {
//   String _type;
//   String _data;

//   String get type => _type;

//   String get data => _data;

//   Attachment({
//     String type = '',
//     String data = ''}) {
//     _type = type;
//     _data = data;
//   }

//   Attachment.fromJson(dynamic json) {
//     _type = json['type'];
//     _data = json['data'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['type'] = _type;
//     map['data'] = _data;
//     return map;
//   }
// }


import 'dart:convert';

/// id : 1
class Attachment {

  final String type;
  final String data;
  Attachment({
    this.type = '',
    this.data = ''
  });

  Attachment copyWith({
    String? type,
    String? data,
  }) {
    return Attachment(
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attachment(
      type: map['type'],
      data: map['data']
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));

  @override
  String toString() => 'Attachment(type: $type, data: $data)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attachment && o.type == type && o.data == data;
  }

  @override
  int get hashCode => type.hashCode ^ data.hashCode;
}
