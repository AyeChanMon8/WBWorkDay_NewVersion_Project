import 'dart:convert';

/// id : 1
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// insurance_type_id : {"id":2,"policy_type":"Testing"}
/// insurance_id : {"id":null,"name":null}
/// date : "2021-04-01"
/// description : "Test"
/// claim_amount : 100000.0
/// coverage_amount : 0.0
/// balance : -100000.0
/// attachment_id : [{"id":32964,"name":"MicrosoftTeams-image (8).png","type":"binary","url":null,"datas":"image","mimetype":"image/png","index_content":"image"}]

// class Claiminsurancemodel {
//   int _id;
//   Employee_id _employeeId;
//   Insurance_type_id _insuranceTypeId;
//   Insurance_id _insuranceId;
//   String _date;
//   String _description;
//   double _claimAmount;
//   double _coverageAmount;
//   double _balance;
//   String _attached_file;
//   List<Insurance_id> _insurance_ids;

//   int get id => _id;
//   Employee_id get employeeId => _employeeId;
//   Insurance_type_id get insuranceTypeId => _insuranceTypeId;
//   Insurance_id get insuranceId => _insuranceId;
//   String get date => _date;
//   String get description => _description;
//   double get claimAmount => _claimAmount;
//   double get coverageAmount => _coverageAmount;
//   double get balance => _balance;
//   String get attachmentId => _attached_file;
//   List<Insurance_id> get insurance_ids => _insurance_ids;

//   Claiminsurancemodel(
//       {int id,
//       Employee_id employeeId,
//       Insurance_type_id insuranceTypeId,
//       Insurance_id insuranceId,
//       String date,
//       String description,
//       double claimAmount,
//       double coverageAmount,
//       double balance,
//       String attachmentId}) {
//     _id = id;
//     _employeeId = employeeId;
//     _insuranceTypeId = insuranceTypeId;
//     _insuranceId = insuranceId;
//     _date = date;
//     _description = description;
//     _claimAmount = claimAmount;
//     _coverageAmount = coverageAmount;
//     _balance = balance;
//     _attached_file = attachmentId;
//   }

//   Claiminsurancemodel.fromJson(dynamic json) {
//     _id = json["id"];
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _insuranceTypeId = json["insurance_type_id"] != null
//         ? Insurance_type_id.fromJson(json["insurance_type_id"])
//         : null;
//     _insuranceId = json["insurance_id"] != null
//         ? Insurance_id.fromJson(json["insurance_id"])
//         : null;
//     _date = json["date"];
//     _description = json["description"];
//     _claimAmount = json["claim_amount"];
//     _coverageAmount = json["coverage_amount"];
//     _balance = json["balance"];
//     _attached_file = json["attached_file"];
//     if (json["insurance_ids"] != null) {
//       _insurance_ids = [];
//       json["insurance_ids"].forEach((v) {
//         _insurance_ids.add(Insurance_id.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.toJson();
//     }
//     if (_insuranceTypeId != null) {
//       map["insurance_type_id"] = _insuranceTypeId.toJson();
//     }
//     if (_insuranceId != null) {
//       map["insurance_id"] = _insuranceId.toJson();
//     }
//     map["date"] = _date;
//     map["description"] = _description;
//     map["claim_amount"] = _claimAmount;
//     map["coverage_amount"] = _coverageAmount;
//     map["balance"] = _balance;
//     map["attached_file"] = _attached_file;
//     return map;
//   }
// }

/// id : 32964
/// name : "MicrosoftTeams-image (8).png"
/// type : "binary"
/// url : null
/// datas : "image"
/// mimetype : "image/png"
/// index_content : "image"

class Claiminsurancemodel {
  int id;
  Employee_id employeeId;
  Insurance_type_id insuranceTypeId;
  Insurance_id insuranceId;
  String date;
  String description;
  double claimAmount;
  double coverageAmount;
  double balance;
  String attached_file;
  List<Insurance_id> insurance_ids;
  Claiminsurancemodel(
      {this.id = 0,
      required this.employeeId,
      required this.insuranceTypeId,
      required this.insuranceId,
      this.date = '',
      this.description = '',
      this.claimAmount = 0.0,
      this.coverageAmount = 0.0,
      this.balance = 0.0,
      this.attached_file = '',
      required this.insurance_ids});

  Claiminsurancemodel copyWith(
      {int? id,
      required Employee_id employeeId,
      required Insurance_type_id insuranceTypeId,
      required Insurance_id insuranceId,
      String? date,
      String? description,
      double? claimAmount,
      double? coverageAmount,
      double? balance,
      String? attached_file,
      required List<Insurance_id> insurance_ids}) {
    return Claiminsurancemodel(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        insuranceTypeId: insuranceTypeId ?? this.insuranceTypeId,
        insuranceId: insuranceId ?? this.insuranceId,
        date: date ?? this.date,
        description: description ?? this.description,
        claimAmount: claimAmount ?? this.claimAmount,
        balance: balance ?? this.balance,
        attached_file: attached_file ?? this.attached_file,
        insurance_ids: insurance_ids ?? this.insurance_ids);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId?.toMap(),
      'insurance_type_id': insuranceTypeId?.toMap(),
      'insurance_id': insuranceId?.toMap(),
      'date': date,
      'description': description,
      'claimAmount': claimAmount,
      'coverageAmount': coverageAmount,
      'balance': balance,
      'insurance_ids': insurance_ids?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Claiminsurancemodel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Claiminsurancemodel(
      id: map['id'],
      employeeId: map['employee_id'],
      insuranceTypeId: map['insurance_type_id'],
      insuranceId: map['insurance_id'],
      date: map['date'],
      description: map['description'],
      claimAmount: map['claimAmount'],
      coverageAmount: map['coverageAmount'],
      balance: map['balance'],
      insurance_ids: List<Insurance_id>.from(
          map['insurance_ids']?.map((x) => Insurance_id.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Claiminsurancemodel.fromJson(String source) =>
      Claiminsurancemodel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Claiminsurancemodel(id: $id, employeeId: $employeeId, insuranceTypeId: $insuranceTypeId, insuranceId: $insuranceId, date: $date, description: $description, claimAmount: $claimAmount, coverageAmount: $coverageAmount, balance: $balance, insurance_ids: $insurance_ids)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Claiminsurancemodel &&
        o.id == id &&
        o.employeeId == employeeId &&
        o.insuranceTypeId == insuranceTypeId &&
        o.insuranceId == insuranceId &&
        o.date == date &&
        o.description == description &&
        o.claimAmount == claimAmount &&
        o.coverageAmount == coverageAmount &&
        o.balance == balance &&
        o.insurance_ids == insurance_ids;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      employeeId.hashCode ^
      insuranceTypeId.hashCode ^
      insuranceId.hashCode ^
      date.hashCode ^
      description.hashCode ^
      claimAmount.hashCode ^
      coverageAmount.hashCode ^
      balance.hashCode ^
      insurance_ids.hashCode;
}

// class Attachment_id {
//   int _id;
//   String _name;
//   String _type;
//   dynamic _url;
//   String _datas;
//   String _mimetype;
//   String _indexContent;

//   int get id => _id;
//   String get name => _name;
//   String get type => _type;
//   dynamic get url => _url;
//   String get datas => _datas;
//   String get mimetype => _mimetype;
//   String get indexContent => _indexContent;

//   Attachment_id(
//       {int id,
//       String name,
//       String type,
//       dynamic url,
//       String datas,
//       String mimetype,
//       String indexContent}) {
//     _id = id;
//     _name = name;
//     _type = type;
//     _url = url;
//     _datas = datas;
//     _mimetype = mimetype;
//     _indexContent = indexContent;
//   }

//   Attachment_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _type = json["type"];
//     _url = json["url"];
//     _datas = json["datas"];
//     _mimetype = json["mimetype"];
//     _indexContent = json["index_content"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["type"] = _type;
//     map["url"] = _url;
//     map["datas"] = _datas;
//     map["mimetype"] = _mimetype;
//     map["index_content"] = _indexContent;
//     return map;
//   }
// }

class Attachment_id {
  int id;
  String name;
  String type;
  dynamic url;
  String datas;
  String mimetype;
  String indexContent;
  Attachment_id(
      {this.id = 0,
      this.name = '',
      this.type = '',
      this.url = '',
      this.datas = '',
      this.mimetype = '',
      this.indexContent = ''});

  Attachment_id copyWith({
    int? id,
    String? policyType,
  }) {
    return Attachment_id(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        url: url ?? this.url,
        datas: datas ?? this.datas,
        mimetype: mimetype ?? this.mimetype,
        indexContent: indexContent ?? this.indexContent);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'datas': datas,
      'mimetype': mimetype,
      'indexContent': indexContent
    };
  }

  factory Attachment_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attachment_id(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      url: map['url'],
      datas: map['datas'],
      mimetype: map['mimetype'],
      indexContent: map['indexContent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment_id.fromJson(String source) =>
      Attachment_id.fromMap(json.decode(source));

  @override
  String toString() =>
      'Attachment_id(id: $id, name: $name, type: $type, url: $url, datas: $datas, mimetype: $mimetype, indexContent: $indexContent)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attachment_id &&
        o.id == id &&
        o.name == name &&
        o.type == type &&
        o.url == url &&
        o.datas == datas &&
        o.mimetype == mimetype &&
        o.indexContent == indexContent;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      url.hashCode ^
      datas.hashCode ^
      mimetype.hashCode ^
      indexContent.hashCode;
}

/// id : null
/// name : null

// class Insurance_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Insurance_id({dynamic id, dynamic name}) {
//     _id = id;
//     _name = name;
//   }

//   Insurance_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

class Insurance_id {
  int id;
  String name;
  Insurance_id({
    this.id = 0,
    this.name = '',
  });

  Insurance_id copyWith({
    int? id,
    String? policyType,
  }) {
    return Insurance_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Insurance_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance_id.fromJson(String source) =>
      Insurance_id.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 2
/// policy_type : "Testing"

// class Insurance_type_id {
//   int _id;
//   String _policyType;

//   int get id => _id;
//   String get policyType => _policyType;

//   Insurance_type_id({int id, String policyType}) {
//     _id = id;
//     _policyType = policyType;
//   }

//   Insurance_type_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _policyType = json["policy_type"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["policy_type"] = _policyType;
//     return map;
//   }
// }

class Insurance_type_id {
  int id;
  String policyType;
  Insurance_type_id({
    this.id = 0,
    this.policyType = '',
  });

  Insurance_type_id copyWith({
    int? id,
    String? policyType,
  }) {
    return Insurance_type_id(
      id: id ?? this.id,
      policyType: policyType ?? this.policyType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'policyType': policyType,
    };
  }

  factory Insurance_type_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance_type_id(
      id: map['id'],
      policyType: map['policyType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance_type_id.fromJson(String source) =>
      Insurance_type_id.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance_type_id(id: $id, policyType: $policyType)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance_type_id && o.id == id && o.policyType == policyType;
  }

  @override
  int get hashCode => id.hashCode ^ policyType.hashCode;
}

/// id : 6115
/// name : "Ahr Yu"

// class Employee_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Employee_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

class Employee_id {
  int id;
  String name;
  Employee_id({
    this.id = 0,
    this.name = '',
  });

  Employee_id copyWith({
    int? id,
    String? name,
  }) {
    return Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_id.fromJson(String source) =>
      Employee_id.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
