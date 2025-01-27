import 'dart:convert';

/// id : 8
/// name : "P001_WB Employee Information"
/// employee_ref : {"id":5098,"name":"Kham Nandar Phe"}
/// document_type : {"id":6,"name":"WB Employee Information"}
/// issue_date : "2020-12-10"
/// expiry_date : null
/// notification_type : null
/// before_days : 0
/// description : null

class Employee_document {
  int id;
  String name;
  Employee_ref employeeRef;
  Document_type documentType;
  String issueDate;
  dynamic expiryDate;
  dynamic notificationType;
  int beforeDays;
  dynamic description;
  Employee_document(
      {this.id = 0,
      this.name = '',
      required this.employeeRef,
      required this.documentType,
      this.issueDate = '',
      this.expiryDate = '',
      this.notificationType = '',
      this.beforeDays = 0,
      this.description = ''});

  Employee_document copyWith({
    int? id,
    String? name,
    Employee_ref? employeeRef,
    Document_type? documentType,
    String? issueDate,
    dynamic? expiryDate,
    dynamic? notificationType,
    int? beforeDays,
    dynamic? description,
  }) {
    return Employee_document(
        id: id ?? this.id,
        name: name ?? this.name,
        employeeRef: employeeRef ?? this.employeeRef,
        documentType: documentType ?? this.documentType,
        issueDate: issueDate ?? this.issueDate,
        expiryDate: expiryDate ?? this.expiryDate,
        notificationType: notificationType ?? this.notificationType,
        beforeDays: beforeDays ?? this.beforeDays,
        description: description ?? this.description,);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employee_ref': employeeRef?.toMap(),
      'document_type': documentType?.toMap(),
      'issue_date': issueDate,
      'expiry_date': expiryDate,
      'notification_type': notificationType,
      'before_days': beforeDays,
      'description': description
    };
  }

  factory Employee_document.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_document(
        id: map['id'],
        name: map['name'],
        employeeRef: Employee_ref.fromMap(map['employee_ref']),
        documentType: Document_type.fromMap(map['document_type']),
        issueDate: map['issue_date'],
        expiryDate: map['expiry_date'],
        notificationType: map['notification_type'],
        beforeDays: map['before_days'],
        description: map['description']);
  }

  String toJson() => json.encode(toMap());

  factory Employee_document.fromJson(String source) =>
      Employee_document.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee_document(id: $id, name: $name, employeeRef: $employeeRef, documentType: $documentType, issueDate: $issueDate, expiryDate: $expiryDate, notificationType: $notificationType, beforeDays: $beforeDays, description: $description)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_document &&
        o.id == id &&
        o.name == name &&
        o.employeeRef == employeeRef &&
        o.documentType == documentType &&
        o.issueDate == issueDate &&
        o.expiryDate == expiryDate &&
        o.notificationType == notificationType &&
        o.beforeDays == beforeDays &&
        o.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        employeeRef.hashCode ^
        documentType.hashCode ^
        issueDate.hashCode ^
        expiryDate.hashCode ^
        notificationType.hashCode ^
        beforeDays.hashCode ^
        description.hashCode;
  }
}

/// id : 6
/// name : "WB Employee Information"

class Document_type {
  final int id;
  final String name;
  Document_type({
    this.id = 0,
    this.name = '',
  });

  Document_type copyWith({
    int? id,
    String? name,
  }) {
    return Document_type(
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

  factory Document_type.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Document_type(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Document_type.fromJson(String source) =>
      Document_type.fromMap(json.decode(source));

  @override
  String toString() => 'Document_type(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Document_type && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// id : 5098
/// name : "Kham Nandar Phe"

class Employee_ref {
  final int id;
  final String name;
  Employee_ref({
    this.id = 0,
    this.name = '',
  });

  Employee_ref copyWith({
    int? id,
    String? name,
  }) {
    return Employee_ref(
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

  factory Employee_ref.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_ref(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_ref.fromJson(String source) =>
      Employee_ref.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_ref(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_ref && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
