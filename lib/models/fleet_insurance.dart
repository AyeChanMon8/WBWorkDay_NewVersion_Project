
import 'dart:convert';

/// id : 1
/// vehicle_id : {"id":7,"name":"Mitsubishi /Canter/3H/2417"}
/// insurance_type_id : {"id":1,"name":"FULL COVER"}
/// insurance_company : "GGI"
/// start_date : "2021-01-01"
/// end_date : "2021-12-31"
/// contact_person : "PHYO"
/// contact_phone : "09425014884"
/// by : "ABC"
/// attachment_id : [{"id":32957,"name":"Invoice_703411077.pdf","type":"binary","url":null,"datas":"image","mimetype":"application/pdf","index_content":"application"}]

class Fleet_insurance {

  int id;
  Vehicle_id vehicleId;
  Insurance_type_id insuranceTypeId;
  String insuranceCompany;
  String startDate;
  String endDate;
  String contactPerson;
  String contactPhone;
  String by;
  List<Attachment_id> attachmentId;
  Fleet_insurance({
    this.id = 0,
    required this.vehicleId,
    required this.insuranceTypeId,
    this.insuranceCompany = '',
    this.startDate = '',
    this.endDate = '',
    this.contactPerson = '',
    this.contactPhone = '',
    this.by = '',
    required this.attachmentId
  });

  Fleet_insurance copyWith({
    int? id,
    Vehicle_id? vehicleId,
    Insurance_type_id? insuranceTypeId,
    String? insuranceCompany,
    String? startDate,
    String? endDate,
    String? contactPerson,
    String? contactPhone,
    String? by,
    List<Attachment_id>? attachmentId
  }) {
    return Fleet_insurance(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      insuranceTypeId: insuranceTypeId ?? this.insuranceTypeId,
      insuranceCompany: insuranceCompany ?? this.insuranceCompany,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      contactPerson: contactPerson ?? this.contactPerson,
      contactPhone: contactPhone ?? this.contactPhone,
      by: by ?? this.by,
      attachmentId: attachmentId ?? this.attachmentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'insuranceTypeId': insuranceTypeId,
      'insuranceCompany': insuranceCompany,
      'startDate': startDate,
      'endDate': endDate,
      'contactPerson': contactPerson,
      'contactPhone': contactPhone,
      'by': by,
      'attachmentId': attachmentId
    };
  }

  factory Fleet_insurance.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fleet_insurance(
      id: map['id'],
      vehicleId: map['vehicle_id'],
      insuranceTypeId: map['insurance_type_id'],
      insuranceCompany: map['insurance_company'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      contactPerson: map['contact_person'],
      contactPhone: map['contact_phone'],
      by: map['by'],
      attachmentId: map['attachment_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fleet_insurance.fromJson(String source) =>
      Fleet_insurance.fromMap(json.decode(source));

  @override
  String toString() => 'Fleet_insurance(id: $id, vehicleId: $vehicleId, insuranceTypeId: $insuranceTypeId, insuranceCompany: $insuranceCompany, startDate: $startDate, endDate: $endDate, contactPerson: $contactPerson, contactPhone: $contactPhone, by: $by, attachmentId: $attachmentId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fleet_insurance && o.id == id && o.vehicleId == vehicleId && o.insuranceTypeId == insuranceTypeId && o.insuranceCompany == insuranceCompany && o.startDate == startDate && o.endDate == endDate && o.contactPerson == contactPerson && o.contactPhone == contactPhone && o.by == by && o.attachmentId == attachmentId;
  }

  @override
  int get hashCode => id.hashCode ^ vehicleId.hashCode ^ insuranceTypeId.hashCode ^ insuranceCompany.hashCode ^ startDate.hashCode ^ endDate.hashCode ^ contactPerson.hashCode  ^ contactPhone.hashCode  ^ by.hashCode ^ attachmentId.hashCode;
}

// class Fleet_insurance {
//   int _id;
//   Vehicle_id _vehicleId;
//   Insurance_type_id _insuranceTypeId;
//   String _insuranceCompany;
//   String _startDate;
//   String _endDate;
//   String _contactPerson;
//   String _contactPhone;
//   String _by;
//   List<Attachment_id> _attachmentId;

//   int get id => _id;
//   Vehicle_id get vehicleId => _vehicleId;
//   Insurance_type_id get insuranceTypeId => _insuranceTypeId;
//   String get insuranceCompany => _insuranceCompany;
//   String get startDate => _startDate;
//   String get endDate => _endDate;
//   String get contactPerson => _contactPerson;
//   String get contactPhone => _contactPhone;
//   String get by => _by;
//   List<Attachment_id> get attachmentId => _attachmentId;

//   Fleet_insurance({
//       int id, 
//       Vehicle_id vehicleId, 
//       Insurance_type_id insuranceTypeId, 
//       String insuranceCompany, 
//       String startDate, 
//       String endDate, 
//       String contactPerson, 
//       String contactPhone, 
//       String by, 
//       List<Attachment_id> attachmentId}){
//     _id = id;
//     _vehicleId = vehicleId;
//     _insuranceTypeId = insuranceTypeId;
//     _insuranceCompany = insuranceCompany;
//     _startDate = startDate;
//     _endDate = endDate;
//     _contactPerson = contactPerson;
//     _contactPhone = contactPhone;
//     _by = by;
//     _attachmentId = attachmentId;
// }

//   Fleet_insurance.fromJson(dynamic json) {
//     _id = json["id"];
//     _vehicleId = json["vehicle_id"] != null ? Vehicle_id.fromJson(json["vehicle_id"]) : null;
//     _insuranceTypeId = json["insurance_type_id"] != null ? Insurance_type_id.fromJson(json["insurance_type_id"]) : null;
//     _insuranceCompany = json["insurance_company"];
//     _startDate = json["start_date"];
//     _endDate = json["end_date"];
//     _contactPerson = json["contact_person"];
//     _contactPhone = json["contact_phone"];
//     _by = json["by"];
//     if (json["attachment_id"] != null) {
//       _attachmentId = [];
//       json["attachment_id"].forEach((v) {
//         _attachmentId.add(Attachment_id.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     if (_vehicleId != null) {
//       map["vehicle_id"] = _vehicleId.toJson();
//     }
//     if (_insuranceTypeId != null) {
//       map["insurance_type_id"] = _insuranceTypeId.toJson();
//     }
//     map["insurance_company"] = _insuranceCompany;
//     map["start_date"] = _startDate;
//     map["end_date"] = _endDate;
//     map["contact_person"] = _contactPerson;
//     map["contact_phone"] = _contactPhone;
//     map["by"] = _by;
//     if (_attachmentId != null) {
//       map["attachment_id"] = _attachmentId.map((v) => v.toJson()).toList();
//     }
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
  Attachment_id({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.url = '',
    this.datas = '',
    this.mimetype = '',
    this.indexContent = ''
  });

  Attachment_id copyWith({
    int? id,
    String? name,
    String? type,
    dynamic? url,
    String? datas,
    String? mimetype,
    String? indexContent,
  }) {
    return Attachment_id(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      datas: datas ?? this.datas,
      mimetype: mimetype ?? this.mimetype,
      indexContent: indexContent ?? this.indexContent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'datas': datas,
      'mimetype': mimetype,
      'index_content': indexContent
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
      indexContent: map['index_content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment_id.fromJson(String source) =>
      Attachment_id.fromMap(json.decode(source));

  @override
  String toString() => 'Attachment_id(id: $id, name: $name, type: $type, url: $url, datas: $datas, mimetype: $mimetype, indexContent: $indexContent)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attachment_id && o.id == id && o.name == name && o.type == type && o.url == url && o.datas == datas && o.mimetype == mimetype && o.indexContent == indexContent;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ type.hashCode ^ url.hashCode ^ datas.hashCode ^ mimetype.hashCode ^ indexContent.hashCode;
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

//   Attachment_id({
//       int id, 
//       String name, 
//       String type, 
//       dynamic url, 
//       String datas, 
//       String mimetype, 
//       String indexContent}){
//     _id = id;
//     _name = name;
//     _type = type;
//     _url = url;
//     _datas = datas;
//     _mimetype = mimetype;
//     _indexContent = indexContent;
// }

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

/// id : 1
/// name : "FULL COVER"

// class Insurance_type_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Insurance_type_id({
//       int id, 
//       String name}){
//     _id = id;
//     _name = name;
// }

//   Insurance_type_id.fromJson(dynamic json) {
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

class Insurance_type_id {

  int id;
  String name;
  Insurance_type_id({
    this.id = 0,
    this.name = ''
  });

  Insurance_type_id copyWith({
    int? id,
    String? name
  }) {
    return Insurance_type_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }

  factory Insurance_type_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance_type_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance_type_id.fromJson(String source) =>
      Insurance_type_id.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance_type_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance_type_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 7
/// name : "Mitsubishi /Canter/3H/2417"

class Vehicle_id {

  int id;
  String name;
  Vehicle_id({
    this.id = 0,
    this.name = ''
  });

  Vehicle_id copyWith({
    int? id,
    String? name
  }) {
    return Vehicle_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }

  factory Vehicle_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Vehicle_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle_id.fromJson(String source) =>
      Vehicle_id.fromMap(json.decode(source));

  @override
  String toString() => 'Vehicle_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Vehicle_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Vehicle_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Vehicle_id({
//       int id, 
//       String name}){
//     _id = id;
//     _name = name;
// }

//   Vehicle_id.fromJson(dynamic json) {
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