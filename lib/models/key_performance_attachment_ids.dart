

import 'dart:convert';

// class KeyPerformanceAttachmentIds {
//   int id;
//   String name;
//   String attached_file;
//   String mimetype;

//   KeyPerformanceAttachmentIds({
//     this.id,
//     this.name,
//     this.attached_file,
//     this.mimetype,
//   });

//   KeyPerformanceAttachmentIds copyWith({
//     int id,
//     String name,
//     String attached_file,
//     String mimetype,
//   }) {
//     return KeyPerformanceAttachmentIds(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       attached_file: attached_file ?? this.attached_file,
//       mimetype: mimetype ?? this.mimetype,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'attached_file': attached_file,
//       'mimetype': mimetype
//     };
//   }

//   factory KeyPerformanceAttachmentIds.fromMap(Map<String, dynamic> map) {
//     return KeyPerformanceAttachmentIds(
//       id: map['id']?.toInt() ?? 0,
//       name: map['name'] ?? '',
//       attached_file: map['attached_file'] ?? '',
//       mimetype: map['mimetype'] ?? ''
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory KeyPerformanceAttachmentIds.fromJson(String source) =>
//       KeyPerformanceAttachmentIds.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'KeyPerformanceAttachmentIds(id: $id, name: $name, attached_file: $attached_file, mimetype: $mimetype)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is KeyPerformanceAttachmentIds &&
//         other.id == id &&
//         other.name == name &&
//         other.attached_file == attached_file &&
//         other.mimetype == mimetype;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ attached_file.hashCode ^ mimetype.hashCode;
// }

class KeyPerformanceAttachmentIds {

  int id;
  String name;
  String attached_file;
  String mimetype;
  KeyPerformanceAttachmentIds({
    this.id = 0,
    this.name = '',
    this.attached_file = '',
    this.mimetype = ''
  });

  KeyPerformanceAttachmentIds copyWith({
    int? id,
    String? name,
    String? attached_file,
    String? mimetype
  }) {
    return KeyPerformanceAttachmentIds(
      id: id ?? this.id,
      name: name ?? this.name,
      attached_file: attached_file ?? this.attached_file,
      mimetype: mimetype ?? this.mimetype,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'attached_file': attached_file,
      'mimetype': mimetype
    };
  }

  factory KeyPerformanceAttachmentIds.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return KeyPerformanceAttachmentIds(
      id: map['id'],
      name: map['name'],
      attached_file: map['attached_file'],
      mimetype: map['mimetype'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KeyPerformanceAttachmentIds.fromJson(String source) =>
      KeyPerformanceAttachmentIds.fromMap(json.decode(source));

  @override
  String toString() => 'KeyPerformanceAttachmentIds(id: $id, name: $name,attached_file: $attached_file, mimetype: $mimetype)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is KeyPerformanceAttachmentIds && o.id == id && o.name == name && o.attached_file == attached_file && o.mimetype == mimetype;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ attached_file.hashCode ^ mimetype.hashCode;
}
