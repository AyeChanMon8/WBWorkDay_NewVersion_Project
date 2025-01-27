import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../models/travel_expense/pocket_model.dart';

class EditPocketModel {
  List<PockectModel> pocket_line;
  EditPocketModel({
    required this.pocket_line,
  });

  EditPocketModel copyWith({
    required List<PockectModel> pocket_line,
  }) {
    return EditPocketModel(
      pocket_line: pocket_line ?? this.pocket_line,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pocket_line': pocket_line?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory EditPocketModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EditPocketModel(
      pocket_line: List<PockectModel>.from(
          map['pocket_line']?.map((x) => PockectModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EditPocketModel.fromJson(String source) =>
      EditPocketModel.fromMap(json.decode(source));

  @override
  String toString() => 'EditPocketModel(pocket_line: $pocket_line)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EditPocketModel && listEquals(o.pocket_line, pocket_line);
  }

  @override
  int get hashCode => pocket_line.hashCode;
}
