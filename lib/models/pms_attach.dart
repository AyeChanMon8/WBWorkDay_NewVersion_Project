

import 'dart:convert';

class PMSAttach {
  String name;
  String attachment_file;
  PMSAttach({
    this.name = '',
    this.attachment_file = '',
  });


  PMSAttach copyWith({
    String? name,
    String? attachment_file,
  }) {
    return PMSAttach(
      name: name ?? this.name,
      attachment_file: attachment_file ?? this.attachment_file,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'attachment_file': attachment_file,
      // 'name': name,
    };
  }

  factory PMSAttach.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PMSAttach(
      name: map['name'] ?? "",
      attachment_file: map['attachment_file'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSAttach.fromJson(String source) => PMSAttach.fromMap(json.decode(source));

  @override
  String toString() => 'PMSAttach(name: $name, attachment_file: $attachment_file)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PMSAttach &&
      o.name == name &&
      o.attachment_file == attachment_file;
  }

  @override
  int get hashCode => name.hashCode ^ attachment_file.hashCode;
}

// class PMSAttach {
//   String _name;
//   String _attachment_file;

//   String get name => _name;
//   String get attachment_file => _attachment_file;

//   PMSAttach({
//     String name,
//     String attachment_file}){
//     _name = name;
//     _attachment_file = attachment_file;
//   }


//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["attachment_file"] = _attachment_file;
//     map["name"] = _name;
//     return map;
//   }

// }
