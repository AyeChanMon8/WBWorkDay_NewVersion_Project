

import 'dart:convert';

class AssessmentStructure {
  int? id ;
  String? description;
  String? name;
  AssessmentStructure({this.id,this.description,this.name});

  AssessmentStructure copyWith({
    int? id,
    String? description,
    String? name
  }) {
    return AssessmentStructure(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'name': name
    };
  }

  factory AssessmentStructure.fromMap(Map<String, dynamic> map) {
    
  
    return AssessmentStructure(
      id: map['id']??0,
      description: map['description']??'',
      name: map['name']??''
    );
  }

  String toJson() => json.encode(toMap());

  factory AssessmentStructure.fromJson(String source) => AssessmentStructure.fromMap(json.decode(source));

  @override
  String toString() => 'AssessmentStructure(id: $id, description: $description, name : $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is AssessmentStructure &&
      o.id == id &&
      o.description == description &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ name.hashCode;
}
