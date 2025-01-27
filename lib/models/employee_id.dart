import 'dart:convert';

class EmployeeID {
  final int id;
  final String name;
  final String image_128;
  final String work_email;
  EmployeeID(
      {this.id = 0, this.name = '', this.image_128 = '', this.work_email = ''});

  EmployeeID copyWith(
      {int? id, String? name, String? image_128, String? work_email}) {
    return EmployeeID(
        id: id ?? this.id,
        name: name ?? this.name,
        image_128: image_128 ?? this.image_128,
        work_email: work_email ?? this.work_email);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_128': image_128,
      'work_email': work_email
    };
  }

  factory EmployeeID.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EmployeeID(
      id: map['id'],
      name: map['name'] ?? "",
      image_128: map['image_128'] ?? "",
      work_email: map['work_email'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeID.fromJson(String source) =>
      EmployeeID.fromMap(json.decode(source));

  @override
  String toString() =>
      'EmployeeID(id: $id, name: $name, image_128: $image_128, work_email: $work_email)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmployeeID &&
        o.id == id &&
        o.name == name &&
        o.image_128 == image_128 &&
        o.work_email == work_email;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ image_128.hashCode ^ work_email.hashCode;
}
