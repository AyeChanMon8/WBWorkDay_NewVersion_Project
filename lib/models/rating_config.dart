
import 'dart:convert';

class RatingConfig {
  int id ;
  String rating_description;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  RatingConfig({
    this.id = 0,
    this.name = '',
    this.rating_description = ''
  });

  RatingConfig copyWith({
    int? id,
    String? name,
    String? description
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (rating_description == null || identical(rating_description, this.rating_description))) {
      return this;
    }

    return new RatingConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      rating_description: rating_description ?? this.rating_description
    );
  }

  @override
  String toString() {
    return 'RatingConfig{id: $id, name: $name,rating_description: $rating_description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RatingConfig &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rating_description == other.rating_description &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ rating_description.hashCode;

  factory RatingConfig.fromMap(Map<String, dynamic> map) {
    return new RatingConfig(
      id: map['id'] as int,
      name: map['name'] as String,
      rating_description: map['rating_description'] as String
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'rating_description': this.rating_description
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class RatingConfig {
//   int id ;
//   String rating_description;
//   String name;
//   RatingConfig({this.id,this.rating_description,this.name});

//   RatingConfig copyWith({
//     int id,
//     String rating_description,
//     String name
//   }) {
//     return RatingConfig(
//       id: id ?? this.id,
//       rating_description: rating_description ?? this.rating_description,
//       name: name ?? this.name
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'rating_description': rating_description,
//       'name': name
//     };
//   }

//   factory RatingConfig.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
  
//     return RatingConfig(
//       id: map['id']??0,
//       rating_description: map['rating_description']??'',
//       name: map['name']??''
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RatingConfig.fromJson(String source) => RatingConfig.fromMap(json.decode(source));

//   @override
//   String toString() => 'RatingConfig(id: $id, rating_description: $rating_description, name : $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;
  
//     return o is RatingConfig &&
//       o.id == id &&
//       o.rating_description == rating_description &&
//       o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ rating_description.hashCode ^ name.hashCode;
// }
