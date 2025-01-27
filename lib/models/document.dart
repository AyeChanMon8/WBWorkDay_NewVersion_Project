import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/document_attachment.dart';
import '../models/document_employee.dart';
import '../models/document_type.dart';

class Documents {
  final dynamic documentId;
  final dynamic documentName;
  final dynamic folderId;
  final dynamic folderName;
  final dynamic file_type;

  Documents({
    this.documentId,
    this.documentName,
    this.folderId,
    this.folderName,this.file_type
  });

  Documents copyWith({
    dynamic? documentId,
    dynamic? documentName,
    dynamic? folderId,
    dynamic? folderName
  }) {
    return Documents(
      documentId: documentId ?? this.documentId,
      documentName: documentName ?? this.documentName,
      folderId : folderId ?? this.folderId,
      folderName: folderName ?? this.folderName
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'document_id': documentId?.toMap(),
      'document_name': documentName?.toMap(),
      'folder_id' : folderId?.toMap(),
      'folder_name': folderName?.toMap()
    };
  }

  factory Documents.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Documents(
      documentId: map['document_id'],
      documentName: map['document_name'],
      folderId: map['folder_id'],
      folderName: map['folder_name'],
      file_type: map['file_type']
    );
  }

  String toJson() => json.encode(toMap());

  factory Documents.fromJson(String source) =>
      Documents.fromMap(json.decode(source));

  @override
  String toString() =>
      'Documents(document_id: $documentId, document_name: $documentName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Documents &&
        o.documentId == documentId &&
        o.documentName == documentName;
  }

  @override
  int get hashCode => documentId.hashCode ^ documentName.hashCode;
}
/*int id;
String name;
DocumentEmployee employee_ref;
DocumentType document_type;
List<DocAttachment> doc_attachment_id;
String issue_date;
String expiry_date;
String notification_type;
int before_days;
String description;
Documents({
  this.id,
  this.name,
  this.employee_ref,
  this.document_type,
  this.doc_attachment_id,
  this.issue_date,
  this.expiry_date,
  this.notification_type,
  this.before_days,
  this.description,
});

Documents copyWith({
  int id,
  String name,
  DocumentEmployee employee_ref,
  DocumentType document_type,
  List<DocAttachment> doc_attachment_id,
  String issue_date,
  String expiry_date,
  String notification_type,
  int before_days,
  String description,
}) {
  return Documents(
    id: id ?? this.id,
    name: name ?? this.name,
    employee_ref: employee_ref ?? this.employee_ref,
    document_type: document_type ?? this.document_type,
    doc_attachment_id: doc_attachment_id ?? this.doc_attachment_id,
    issue_date: issue_date ?? this.issue_date,
    expiry_date: expiry_date ?? this.expiry_date,
    notification_type: notification_type ?? this.notification_type,
    before_days: before_days ?? this.before_days,
    description: description ?? this.description,
  );
}

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'employee_ref': employee_ref?.toMap(),
    'document_type': document_type?.toMap(),
    'doc_attachment_id': doc_attachment_id?.map((x) => x?.toMap())?.toList(),
    'issue_date': issue_date,
    'expiry_date': expiry_date,
    'notification_type': notification_type,
    'before_days': before_days,
    'description': description,
  };
}

factory Documents.fromMap(Map<String, dynamic> map) {
  if (map == null) return null;
  
  return Documents(
    id: map['id'],
    name: map['name'],
    employee_ref: DocumentEmployee.fromMap(map['employee_ref']),
    document_type: DocumentType.fromMap(map['document_type']),
    doc_attachment_id: List<DocAttachment>.from(map['doc_attachment_id']?.map((x) => DocAttachment.fromMap(x))),
    issue_date: map['issue_date'],
    expiry_date: map['expiry_date'],
    notification_type: map['notification_type'],
    before_days: map['before_days'],
    description: map['description'],
  );
}

String toJson() => json.encode(toMap());

factory Documents.fromJson(String source) => Documents.fromMap(json.decode(source));

@override
String toString() {
  return 'Documents(id: $id, name: $name, employee_ref: $employee_ref, document_type: $document_type, doc_attachment_id: $doc_attachment_id, issue_date: $issue_date, expiry_date: $expiry_date, notification_type: $notification_type, before_days: $before_days, description: $description)';
}

@override
bool operator ==(Object o) {
  if (identical(this, o)) return true;
  
  return o is Documents &&
    o.id == id &&
    o.name == name &&
    o.employee_ref == employee_ref &&
    o.document_type == document_type &&
    listEquals(o.doc_attachment_id, doc_attachment_id) &&
    o.issue_date == issue_date &&
    o.expiry_date == expiry_date &&
    o.notification_type == notification_type &&
    o.before_days == before_days &&
    o.description == description;
}

@override
int get hashCode {
  return id.hashCode ^
    name.hashCode ^
    employee_ref.hashCode ^
    document_type.hashCode ^
    doc_attachment_id.hashCode ^
    issue_date.hashCode ^
    expiry_date.hashCode ^
    notification_type.hashCode ^
    before_days.hashCode ^
    description.hashCode;
}*/
