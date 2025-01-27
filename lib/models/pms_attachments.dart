import 'dart:convert';

class PMSattachments {
  String name;
  String datas;
  PMSattachments({
    this.name = '',
    this.datas = '',
  });

  PMSattachments copyWith({
    String? name,
    String? datas,
  }) {
    return PMSattachments(
      name: name ?? this.name,
      datas: datas ?? this.datas,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'datas': datas,
      // 'name': name,
    };
  }

  factory PMSattachments.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PMSattachments(
      name: map['name'] ?? "",
      datas: map['datas']??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSattachments.fromJson(String source) =>
      PMSattachments.fromMap(json.decode(source));

  @override
  String toString() => 'PMSattachments(name: $name, datas: $datas)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PMSattachments && o.name == name && o.datas == datas;
  }

  @override
  int get hashCode => name.hashCode ^ datas.hashCode;
}
// class PMSattachments {
//   String _name;
//   String _datas;
  
//   String get name => _name;
//   String get datas => _datas;

//   PMSattachments({
//       String name,
//       String datas}){
//     _name = name;
//     _datas = datas;
// }

//   PMSattachments.fromJson(dynamic json) {
//     _name = json["name"];
//     _datas = json["datas"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = _name;
//     map["datas"] = _datas;
//     return map;
//   }

// }