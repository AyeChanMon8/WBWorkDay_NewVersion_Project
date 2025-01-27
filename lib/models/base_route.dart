import 'dart:convert';

class BaseRoute {
  int id;
  String name;
  double fuel_liter;
  String from_street;
  String to_street;
  List<Expense>? expenseIds;
  double duration_days;
  String code_ref = "";
  Branch_id? branch_id;
  Branch_id? company_id;
  List<Expense>? get _expenseIds => expenseIds;
  String get code => code_ref;
  Branch_id? get _branch_id => branch_id;
  Branch_id? get _company_id => company_id;
  BaseRoute(
      {this.id = 0,
      this.name = '',
      this.fuel_liter = 0.0,
      this.from_street = '',
      this.to_street = '',
      this.expenseIds,
      this.duration_days = 0.0,
      this.code_ref = '',
      this.branch_id,
      this.company_id});

  BaseRoute copyWith(
      {int? id,
      String? name,
      double? fuel_liter,
      String? from_street,
      String? to_street,
      required List<Expense> expenseIds,
      double? duration_days,
      String? code,
      Branch_id? branchId,
      Branch_id? companyId}) {
    return BaseRoute(
      id: id ?? this.id,
      name: name ?? this.name,
      fuel_liter: fuel_liter ?? this.fuel_liter,
      from_street: from_street ?? this.from_street,
      to_street: to_street ?? this.to_street,
      expenseIds: expenseIds ?? this.expenseIds,
      duration_days: duration_days ?? this.duration_days,
      code_ref: this.code,
      branch_id: this.branch_id,
      company_id: this.company_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'from_street': from_street,
      'to_street': to_street,
    };
  }

  factory BaseRoute.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return BaseRoute(
      id: map['id'],
      name: map['name'],
      fuel_liter:
          map['fuel_liter'] == null ? 0.0 : map['fuel_liter'].toDouble(),
      from_street: map['from_street'],
      to_street: map['to_street'],
      expenseIds: List<Expense>.from(
          map['expense_ids']?.map((x) => Expense.fromMap(x))),
      duration_days: map['duration_days'] == null ? 0.0 : map['duration_days'],
      code_ref: map['code'] == null ? '' : map['code'],
      branch_id: Branch_id.fromMap(map['branch_id']),
      company_id: Branch_id.fromMap(map['company_id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseRoute.fromJson(String source) =>
      BaseRoute.fromMap(json.decode(source));

  @override
  String toString() => 'BaseRoute(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BaseRoute && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class Expense {
//   String _name;
//   Route_Product_id _productId;
//   double _amount;
//   String _remark;

//   String get name => _name;
//   Route_Product_id get routeId => _productId;
//   double get amount => _amount;
//   String get remark => _remark;

//   Expense({
//     String name = '',
//     required Route_Product_id productId,
//     double amount = 0.0,
//     String remark = '',
//   }) {
//     _name = name;
//     _productId = productId;
//     _amount = amount;
//     _remark = remark;
//   }

//   Expense.fromJson(dynamic json) {
//     _name = json["name"];
//     _productId = json["product_id"] != null
//         ? Route_Product_id.fromJson(json["product_id"])
//         : null;
//     _amount = json["amount"] == null ? 0 : json["amount"];
//     _remark = json["remark"] == null ? '' : json["remark"];
//   }
// }

class Expense {
  String name;
  Route_Product_id? productId;
  double amount;
  String remark;
  Expense(
      {this.name = '', this.productId, this.amount = 0.0, this.remark = ''});

  Expense copyWith({
    String? name,
    required Route_Product_id productId,
    double? amount,
    String? remark,
  }) {
    return Expense(
        name: name ?? this.name,
        productId: productId ?? this.productId,
        amount: amount ?? this.amount,
        remark: remark ?? this.remark);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'productId': productId,
      'amount': amount,
      'remark': remark
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Expense(
        name: map['name'],
        productId: map['productId'] == null
            ? null
            : Route_Product_id.fromMap(map['productId']),
        amount: map['amount'],
        remark: map['remark'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));

  @override
  String toString() =>
      'AnnouncementPosition(name: $name, productId: $productId, amount: $amount, remark: $remark)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expense &&
        o.name == name &&
        o.productId == productId &&
        o.amount == amount &&
        o.remark == remark;
  }

  @override
  int get hashCode =>
      name.hashCode ^ productId.hashCode ^ amount.hashCode ^ remark.hashCode;
}

class Route_Product_id {
  int id;
  String name;
  Route_Product_id({
    this.id = 0,
    this.name = '',
  });

  Route_Product_id copyWith({
    int? id,
    String? name,
  }) {
    return Route_Product_id(
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

  factory Route_Product_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Route_Product_id(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Route_Product_id.fromJson(String source) =>
      Route_Product_id.fromMap(json.decode(source));

  @override
  String toString() => 'Route_Product_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Route_Product_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Branch_id {
  int id;
  String name;
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
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch_id.fromJson(String source) =>
      Branch_id.fromMap(json.decode(source));

  @override
  String toString() => 'Branch_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Branch_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
