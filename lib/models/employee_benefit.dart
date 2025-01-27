import 'dart:convert';

import 'package:winbrother_hr_app/models/insurancemodel.dart';

import 'employee_promotion.dart';

class EmployeeBenefit {
  int id;
  String description;
  double quantity;
  String state;
  Benefit benefit_id;
  Company_id company_id;
  Branch_id branch_id;
  Job_id job_id;
  Department_id department_id;
  String hand_over_date;
  String date;
  String onhand_date;
  List<Attachments> attachment_ids;

  EmployeeBenefit(
      {this.id = 0,
      this.description = '',
      this.quantity = 0.0,
      this.state = '',
      required this.benefit_id,
      this.hand_over_date = '',
      this.date = '',
      required this.job_id,
      required this.company_id,
      required this.department_id,
      required this.branch_id,
      this.onhand_date = '',
      required this.attachment_ids});

  EmployeeBenefit copyWith(
      {int? id,
      String? description,
      double? quantity,
      String? state,
      Benefit? benefit_id,
      String? hand_over_date,
      String? date,
      Job_id? job_id,
      Company_id? company_id,
      Department_id? department_id,
      Branch_id? branch_id,
      String? onhand_date,
      List<Attachments>? attachment_ids}) {
    return EmployeeBenefit(
        id: id ?? this.id,
        description: description ?? this.description,
        quantity: quantity ?? this.quantity,
        state: state ?? this.state,
        benefit_id: benefit_id ?? this.benefit_id,
        hand_over_date: hand_over_date ?? this.hand_over_date,
        date: date ?? this.date,
        job_id: job_id ?? this.job_id,
        company_id: company_id ?? this.company_id,
        department_id: department_id ?? this.department_id,
        branch_id: branch_id ?? this.branch_id,
        onhand_date: onhand_date ?? this.onhand_date,
        attachment_ids: attachment_ids ?? this.attachment_ids);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'quantity': quantity,
      'state': state,
      'benefit': benefit_id?.toMap(),
      'hand_over_date': hand_over_date,
      'date': date,
      'job_id': job_id?.toMap(),
      'companyId': company_id?.toMap(),
      'departmentId': department_id?.toMap(),
      'branchId': branch_id?.toMap(),
      'onhand_date': onhand_date,
      'attachment_ids': attachment_ids?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory EmployeeBenefit.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return EmployeeBenefit(
      id: map['id'],
      description: map['description'],
      quantity: map['quantity'],
      state: map['state'],
      benefit_id: Benefit.fromMap(map['benefit_id']),
      hand_over_date: map['hand_over_date'] ?? "",
      date: map['date'] ?? "",
      job_id: Job_id.fromMap(map['job_id']),
      company_id: Company_id.fromMap(map['company_id']),
      department_id:Department_id.fromMap( map['department_id'] ),
      branch_id:Branch_id.fromMap( map['branch_id']),
      onhand_date: map['onhand_date']??"",
      attachment_ids: List<Attachments>.from(
          map['attachment_ids']?.map((x) => Attachments.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeBenefit.fromJson(String source) =>
      EmployeeBenefit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeBenefit(id: $id, description: $description, quantity: $quantity, state: $state, benefit_id: $benefit_id, hand_over_date: $hand_over_date, date: $date,job_id: $job_id, company_id: $company_id, department_id: $department_id, branch_id: $branch_id, onhand_date: $onhand_date,attachment_ids: $attachment_ids)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmployeeBenefit &&
        o.id == id &&
        o.description == description &&
        o.quantity == quantity &&
        o.state == state &&
        o.benefit_id == benefit_id &&
        o.hand_over_date == hand_over_date &&
        o.date == date &&
        o.job_id == job_id &&
        o.company_id == company_id &&
        o.department_id == department_id &&
        o.branch_id == branch_id &&
        o.onhand_date == onhand_date &&
        o.attachment_ids == attachment_ids;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        state.hashCode ^
        benefit_id.hashCode ^
        hand_over_date.hashCode ^
        date.hashCode ^
        job_id.hashCode ^
        company_id.hashCode ^
        department_id.hashCode ^
        branch_id.hashCode ^
        onhand_date.hashCode ^
        attachment_ids.hashCode;
  }
}

class Benefit {
  int id = 0;
  String name = "";
  Benefit({
    this.id = 0,
    this.name = '',
  });

  Benefit copyWith({
    int? id,
    String? name,
  }) {
    return Benefit(
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

  factory Benefit.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Benefit(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Benefit.fromJson(String source) =>
      Benefit.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Benefit(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Benefit && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Company_id {
  int id = 0;
  String name = "";
  Company_id({
    this.id = 0,
    this.name = '',
  });

  Company_id copyWith({
    int? id,
    String? name,
  }) {
    return Company_id(
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

  factory Company_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Company_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Company_id.fromJson(String source) =>
      Company_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Job_id {
  int id = 0;
  String name = "";
  Job_id({
    this.id = 0,
    this.name = '',
  });

  Job_id copyWith({
    int? id,
    String? name,
  }) {
    return Job_id(
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

  factory Job_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Job_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Job_id.fromJson(String source) => Job_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Job_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Branch_id {
  int id = 0;
  String name = "";
  Branch_id({
    this.id = 0,
    this.name = '',
  });

  Branch_id copyWith({
    int? id,
    String? name,
  }) {
    return Branch_id(
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

  factory Branch_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Branch_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) =>
      Branch_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Branch_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Department_id {
  int id = 0;
  String name = "";
  Department_id({
    this.id = 0,
    this.name = '',
  });

  Department_id copyWith({
    int? id,
    String? name,
  }) {
    return Department_id(
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

  factory Department_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Department_id(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Department_id.fromJson(String source) =>
      Department_id.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Department_id(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Department_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode;
  }
}

class Attachments {
  int id;
  String name;
  String type;
  String url;
  String datas;
  String mimetype;
  String index_content;
  Attachments({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.url = '',
    this.datas = '',
    this.mimetype = '',
    this.index_content = '',
  });

  Attachments copyWith({
    int? id,
    String? name,
    String? type,
    String? url,
    String? datas,
    String? mimetype,
    String? index_content,
  }) {
    return Attachments(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      datas: datas ?? this.datas,
      mimetype: mimetype ?? this.mimetype,
      index_content: index_content ?? this.index_content,
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
      'index_content': index_content,
    };
  }

  factory Attachments.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attachments(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      url: map['url'],
      datas: map['datas'],
      mimetype: map['mimetype'],
      index_content: map['index_content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachments.fromJson(String source) =>
      Attachments.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attachments(id: $id, name: $name, type: $type, url: $url, datas: $datas, mimetype: $mimetype, index_content: $index_content)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attachments &&
        o.id == id &&
        o.name == name &&
        o.type == type &&
        o.url == url &&
        o.datas == datas &&
        o.mimetype == mimetype &&
        o.index_content == index_content;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        url.hashCode ^
        datas.hashCode ^
        mimetype.hashCode ^
        index_content.hashCode;
  }
}
