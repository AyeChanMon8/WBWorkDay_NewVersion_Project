
import 'dart:convert';

class Maintenance_product_category_model {

  int id;
  String name;
  String displayName;
  Parent_id? parentId;
  dynamic? delivery;
  dynamic? fuel;
  dynamic? dayTrip;
  dynamic? planTrip;
  dynamic? outOfPocketExpense;
  dynamic? travelExpense;
  dynamic? tripExpense;
  dynamic? vehicleCost;
  bool maintenance;
  dynamic? hr;
  dynamic? admin;
  dynamic? purchase;
  String propertyCostMethod;
  String propertyValuation;
  Maintenance_product_category_model({
    this.id = 0,
    this.name = '',
    this.displayName = '',
    this.parentId,
    this.delivery,
    this.fuel,
    this.dayTrip,
    this.planTrip,
    this.outOfPocketExpense,
    this.travelExpense,
    this.tripExpense,
    this.vehicleCost,
    this.maintenance = false,
    this.hr,
    this.admin,
    this.purchase,
    this.propertyCostMethod = '',
    this.propertyValuation = ''
  });

  Maintenance_product_category_model copyWith({
    int? id,
  String? name,
  String? displayName,
  Parent_id? parentId,
  dynamic? delivery,
  dynamic? fuel,
  dynamic? dayTrip,
  dynamic? planTrip,
  dynamic? outOfPocketExpense,
  dynamic? travelExpense,
  dynamic? tripExpense,
  dynamic? vehicleCost,
  bool? maintenance,
  dynamic? hr,
  dynamic? admin,
  dynamic? purchase,
  String? propertyCostMethod,
  String? propertyValuation,
  }) {
    return Maintenance_product_category_model(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      parentId: parentId ?? this.parentId,
      delivery: delivery ?? this.delivery,
      fuel: fuel ?? this.fuel,
      dayTrip: dayTrip ?? this.dayTrip,
      planTrip: planTrip ?? this.planTrip,
      outOfPocketExpense: outOfPocketExpense ?? this.outOfPocketExpense,
      travelExpense: travelExpense ?? this.travelExpense,
      tripExpense: tripExpense ?? this.tripExpense,
      vehicleCost: vehicleCost ?? this.vehicleCost,
      maintenance: maintenance ?? this.maintenance,
      hr: hr ?? this.hr,
      admin: admin ?? this.admin,
      purchase: purchase ?? this.purchase,
      propertyCostMethod: propertyCostMethod ?? this.propertyCostMethod,
      propertyValuation: propertyValuation ?? this.propertyValuation
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'display_name': displayName,
      'parent_id': parentId,
      'delivery': delivery,
      'fuel': fuel,
      'day_trip': dayTrip,
      'plan_trip': planTrip,
      'out_of_pocket_expense': outOfPocketExpense,
      'travel_expense': travelExpense,
      'trip_expense': tripExpense,
      'vehicle_cost': vehicleCost,
      'maintenance': maintenance,
      'hr': hr,
      'admin': admin,
      'purchase': purchase,
      'property_cost_method': propertyCostMethod,
      'property_valuation': propertyValuation
    };
  }

  factory Maintenance_product_category_model.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Maintenance_product_category_model(
      id: map['id'],
      name: map['name'],
      displayName: map['display_name'],
      parentId:Parent_id.fromMap(map['parent_id']),
      delivery: map['delivery'],
      fuel: map['fuel'],
      dayTrip: map['day_trip'],
      planTrip: map['plan_trip'],
      outOfPocketExpense: map['out_of_pocket_expense'],
      travelExpense: map['travel_expense'],
      tripExpense: map['trip_expense'],
      vehicleCost: map['vehicle_cost'],
      maintenance: map['maintenance'],
      hr: map['hr'],
      admin: map['admin'],
      purchase: map['purchase'],
      propertyCostMethod: map['property_cost_method'],
      propertyValuation: map['property_valuation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Maintenance_product_category_model.fromJson(String source) =>
      Maintenance_product_category_model.fromMap(json.decode(source));

  @override
  String toString() => 'Maintenance_product_category_model(id: $id, name: $name,displayName: $displayName,parentId: $parentId, delivery: $delivery,fuel: $fuel,dayTrip: $dayTrip, planTrip: $planTrip,outOfPocketExpense: $outOfPocketExpense,travelExpense: $travelExpense, tripExpense: $tripExpense,vehicleCost: $vehicleCost,maintenance: $maintenance, hr: $hr,admin: $admin,purchase: $purchase, propertyCostMethod: $propertyCostMethod,propertyValuation: $propertyValuation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Maintenance_product_category_model && o.id == id && o.name == name && o.displayName == displayName && o.parentId == parentId && o.delivery == delivery
     && o.fuel == fuel && o.dayTrip == dayTrip  && o.planTrip == planTrip && o.outOfPocketExpense == outOfPocketExpense
     && o.travelExpense == travelExpense && o.tripExpense == tripExpense  && o.vehicleCost == vehicleCost && o.maintenance == maintenance
     && o.hr == hr && o.admin == admin  && o.purchase == purchase && o.propertyCostMethod == propertyCostMethod
     && o.propertyValuation == propertyValuation;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ displayName.hashCode ^ parentId.hashCode ^ delivery.hashCode ^ fuel.hashCode
  ^ dayTrip.hashCode ^ planTrip.hashCode ^ outOfPocketExpense.hashCode ^ travelExpense.hashCode ^ tripExpense.hashCode ^ vehicleCost.hashCode
  ^ maintenance.hashCode ^ hr.hashCode ^ admin.hashCode ^ purchase.hashCode ^ propertyCostMethod.hashCode ^ propertyValuation.hashCode;
}

// class Maintenance_product_category_model {
//   int _id;
//   String _name;
//   String _displayName;
//   Parent_id _parentId;
//   dynamic _delivery;
//   dynamic _fuel;
//   dynamic _dayTrip;
//   dynamic _planTrip;
//   dynamic _outOfPocketExpense;
//   dynamic _travelExpense;
//   dynamic _tripExpense;
//   dynamic _vehicleCost;
//   bool _maintenance;
//   dynamic _hr;
//   dynamic _admin;
//   dynamic _purchase;
//   String _propertyCostMethod;
//   String _propertyValuation;

//   int get id => _id;
//   String get name => _name;
//   String get displayName => _displayName;
//   Parent_id get parentId => _parentId;
//   dynamic get delivery => _delivery;
//   dynamic get fuel => _fuel;
//   dynamic get dayTrip => _dayTrip;
//   dynamic get planTrip => _planTrip;
//   dynamic get outOfPocketExpense => _outOfPocketExpense;
//   dynamic get travelExpense => _travelExpense;
//   dynamic get tripExpense => _tripExpense;
//   dynamic get vehicleCost => _vehicleCost;
//   bool get maintenance => _maintenance;
//   dynamic get hr => _hr;
//   dynamic get admin => _admin;
//   dynamic get purchase => _purchase;
//   String get propertyCostMethod => _propertyCostMethod;
//   String get propertyValuation => _propertyValuation;

//   Maintenance_product_category_model({
//       int id, 
//       String name, 
//       String displayName, 
//       Parent_id parentId, 
//       dynamic delivery, 
//       dynamic fuel, 
//       dynamic dayTrip, 
//       dynamic planTrip, 
//       dynamic outOfPocketExpense, 
//       dynamic travelExpense, 
//       dynamic tripExpense, 
//       dynamic vehicleCost, 
//       bool maintenance, 
//       dynamic hr, 
//       dynamic admin, 
//       dynamic purchase, 
//       String propertyCostMethod, 
//       String propertyValuation}){
//     _id = id;
//     _name = name;
//     _displayName = displayName;
//     _parentId = parentId;
//     _delivery = delivery;
//     _fuel = fuel;
//     _dayTrip = dayTrip;
//     _planTrip = planTrip;
//     _outOfPocketExpense = outOfPocketExpense;
//     _travelExpense = travelExpense;
//     _tripExpense = tripExpense;
//     _vehicleCost = vehicleCost;
//     _maintenance = maintenance;
//     _hr = hr;
//     _admin = admin;
//     _purchase = purchase;
//     _propertyCostMethod = propertyCostMethod;
//     _propertyValuation = propertyValuation;
// }

//   Maintenance_product_category_model.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _displayName = json["display_name"];
//     _parentId = json["parent_id"] != null ? Parent_id.fromJson(json["parent_id"]) : null;
//     _delivery = json["delivery"];
//     _fuel = json["fuel"];
//     _dayTrip = json["day_trip"];
//     _planTrip = json["plan_trip"];
//     _outOfPocketExpense = json["out_of_pocket_expense"];
//     _travelExpense = json["travel_expense"];
//     _tripExpense = json["trip_expense"];
//     _vehicleCost = json["vehicle_cost"];
//     _maintenance = json["maintenance"];
//     _hr = json["hr"];
//     _admin = json["admin"];
//     _purchase = json["purchase"];
//     _propertyCostMethod = json["property_cost_method"];
//     _propertyValuation = json["property_valuation"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["display_name"] = _displayName;
//     if (_parentId != null) {
//       map["parent_id"] = _parentId.toJson();
//     }
//     map["delivery"] = _delivery;
//     map["fuel"] = _fuel;
//     map["day_trip"] = _dayTrip;
//     map["plan_trip"] = _planTrip;
//     map["out_of_pocket_expense"] = _outOfPocketExpense;
//     map["travel_expense"] = _travelExpense;
//     map["trip_expense"] = _tripExpense;
//     map["vehicle_cost"] = _vehicleCost;
//     map["maintenance"] = _maintenance;
//     map["hr"] = _hr;
//     map["admin"] = _admin;
//     map["purchase"] = _purchase;
//     map["property_cost_method"] = _propertyCostMethod;
//     map["property_valuation"] = _propertyValuation;
//     return map;
//   }

// }


// /// id : null
// /// name : null

class Parent_id {

  int id;
  String name;
  Parent_id({
    this.id = 0,
    this.name = ''
  });

  Parent_id copyWith({
    int? id,
    String? name
  }) {
    return Parent_id(
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

  factory Parent_id.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Parent_id(
      id: map['id']?? 0,
      name: map['name']?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Parent_id.fromJson(String source) =>
      Parent_id.fromMap(json.decode(source));

  @override
  String toString() => 'Parent_id(id: $id, name: $name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Parent_id && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
// class Parent_id {
//   dynamic _id;
//   dynamic _name;

//   dynamic get id => _id;
//   dynamic get name => _name;

//   Parent_id({
//       dynamic id, 
//       dynamic name}){
//     _id = id;
//     _name = name;
// }

//   Parent_id.fromJson(dynamic json) {
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