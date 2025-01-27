

import 'dart:convert';

/// trip_product_id : 4
/// route_expense_id : 6
/// actual_amount : 4500
/// description : "business trip"

class Plantrip_product_expense_line {
  int tripProductId;
  int routeExpenseId;
  double actualAmount;
  String description;
  int id;
  String image;

  Plantrip_product_expense_line({this.tripProductId = 0, this.routeExpenseId = 0,
  this.actualAmount = 0.0, this.description = '', this.id = 0,
  this.image = ''});

  Plantrip_product_expense_line copyWith({int? id, String? name}) {
    return Plantrip_product_expense_line(
      tripProductId: tripProductId ?? this.tripProductId,
      routeExpenseId: routeExpenseId ?? this.routeExpenseId,
      actualAmount: actualAmount ?? this.actualAmount,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image
    );
  }

  Map<String, dynamic> toMap() {
    return {'trip_product_id': tripProductId, 
    'route_expense_id': routeExpenseId,
    'actual_amount': actualAmount, 
    'description': description,
    'id': id,
    'attached_file': image,
    };
  }

  factory Plantrip_product_expense_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_product_expense_line(
      tripProductId: map['trip_product_id'],
      routeExpenseId: map['route_expense_id'],
      actualAmount: map['actual_amount'],
      description: map['description'],
      id: map['id'],
      image: map['attached_file'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_product_expense_line.fromJson(String source) =>
      Plantrip_product_expense_line.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_product_expense_line(tripProductId: $tripProductId, routeExpenseId: $routeExpenseId,actualAmount: $actualAmount, description: $description,id: $id, image: $image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_product_expense_line && o.tripProductId == tripProductId && o.routeExpenseId == routeExpenseId && o.actualAmount == actualAmount && o.description == description
    && o.id == id && o.image == image;
  }

  @override
  int get hashCode => tripProductId.hashCode ^ routeExpenseId.hashCode ^ actualAmount.hashCode ^ description.hashCode ^ id.hashCode ^ image.hashCode;
}


// class Plantrip_product_expense_line {
//   int _tripProductId;
//   int _routeExpenseId;
//   double _actualAmount;
//   String _description;
//   int _id;
//   String _image;

//   int get tripProductId => _tripProductId;
//   int get routeExpenseId => _routeExpenseId;
//   double get actualAmount => _actualAmount;
//   String get description => _description;

//   Plantrip_product_expense_line({
//       int tripProductId, 
//       int routeExpenseId, 
//       double actualAmount,
//       String description,int id,String image}){
//    // _tripProductId = tripProductId;
//     _routeExpenseId = routeExpenseId;
//     _actualAmount = actualAmount;
//     _description = description;
//     _id = id;
//     _image = image;
// }

//   Plantrip_product_expense_line.fromJson(dynamic json) {
//     _tripProductId = json["trip_product_id"];
//     _routeExpenseId = json["route_expense_id"];
//     _actualAmount = json["actual_amount"];
//     _description = json["description"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//    // map["trip_product_id"] = _tripProductId;
//     map["route_expense_id"] = _routeExpenseId;
//     map["actual_amount"] = _actualAmount;
//     map["description"] = _description;
//     map["attached_file"] = _image;
//     return map;
//   }

// }