// import 'dart:convert';

// class DocAttachment {
//   int id;
//   String name;
//   String type;
//   String datas;
//   String mimetype;
//   DocAttachment({
//     this.id,
//     this.name,
//     this.type,
//     this.datas,
//     this.mimetype,
//   });

//   DocAttachment copyWith({
//     int id,
//     String name,
//     String type,
//     String datas,
//     String mimetype,
//   }) {
//     return DocAttachment(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       type: type ?? this.type,
//       datas: datas ?? this.datas,
//       mimetype: mimetype ?? this.mimetype,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'type': type,
//       'datas': datas,
//       'mimetype': mimetype,
//     };
//   }

//   factory DocAttachment.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return DocAttachment(
//       id: map['id'],
//       name: map['name'],
//       type: map['type'],
//       datas: map['datas'],
//       mimetype: map['mimetype'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DocAttachment.fromJson(String source) =>
//       DocAttachment.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'DocAttachment(id: $id, name: $name, type: $type, datas: $datas, mimetype: $mimetype)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is DocAttachment &&
//         o.id == id &&
//         o.name == name &&
//         o.type == type &&
//         o.datas == datas &&
//         o.mimetype == mimetype;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         type.hashCode ^
//         datas.hashCode ^
//         mimetype.hashCode;
//   }
// }

import 'dart:convert';

class DocAttachment {

  final int id;
  final String name;
  final String type;
  final String datas;
  final String mimetype;
  DocAttachment({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.datas = '',
    this.mimetype = ''
  });

  DocAttachment copyWith({
    int? id,
    String? name,
    String? type,
    String? datas,
    String? mimetype
  }) {
    return DocAttachment(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      datas: datas ?? this.datas,
      mimetype: mimetype ?? this.mimetype,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'datas': datas,
      'mimetype': mimetype,
    };
  }

  factory DocAttachment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return DocAttachment(
      id: map['id'],
      name: map['name'],
       type: map['type'],
      datas: map['datas'],
       mimetype: map['mimetype'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocAttachment.fromJson(String source) =>
      DocAttachment.fromMap(json.decode(source));

  @override
  String toString() => 'DocAttachment(id: $id, name: $name,type: $type, datas: $datas,mimetype: $mimetype)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DocAttachment && o.id == id && o.name == name && o.type == type && o.datas == datas && o.mimetype == mimetype;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ id.hashCode ^ type.hashCode ^ datas.hashCode ^ mimetype.hashCode;
}

