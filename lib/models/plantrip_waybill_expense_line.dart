

import 'dart:convert';

/// trip_waybill_id : 4
/// route_expense_id : 6
/// actual_amount : 4500
/// description : "Business Trip"

class Plantrip_waybill_expense_line {
 int tripWaybillId;
  int routeExpenseId;
  double actualAmount;
  String description;
  String image;

  Plantrip_waybill_expense_line({this.tripWaybillId = 0, this.routeExpenseId = 0,
  this.actualAmount = 0.0, this.description = '', 
  this.image = ''});

  Plantrip_waybill_expense_line copyWith({int? id, String? name}) {
    return Plantrip_waybill_expense_line(
      tripWaybillId: tripWaybillId ?? this.tripWaybillId,
      routeExpenseId: routeExpenseId ?? this.routeExpenseId,
      actualAmount: actualAmount ?? this.actualAmount,
      description: description ?? this.description,
      image: image ?? this.image
    );
  }

  Map<String, dynamic> toMap() {
    return {'trip_waybill_id': tripWaybillId, 
    'route_expense_id': routeExpenseId,
    'actual_amount': actualAmount, 
    'description': description,
    'attached_file': image,
    };
  }

  factory Plantrip_waybill_expense_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_waybill_expense_line(
      tripWaybillId: map['trip_waybill_id'],
      routeExpenseId: map['route_expense_id'],
      actualAmount: map['actual_amount'],
      description: map['description'],
      image: map['attached_file'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_waybill_expense_line.fromJson(String source) =>
      Plantrip_waybill_expense_line.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_waybill_expense_line(tripWaybillId: $tripWaybillId, routeExpenseId: $routeExpenseId,actualAmount: $actualAmount, description: $description, image: $image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_waybill_expense_line && o.tripWaybillId == tripWaybillId && o.routeExpenseId == routeExpenseId && o.actualAmount == actualAmount && o.description == description
    && o.image == image;
  }

  @override
  int get hashCode => tripWaybillId.hashCode ^ routeExpenseId.hashCode ^ actualAmount.hashCode ^ description.hashCode ^ image.hashCode;
}


// class Plantrip_waybill_expense_line {
//   int _tripWaybillId;
//   int _routeExpenseId;
//   double _actualAmount;
//   String _description;
//   String _image;

//   int get tripWaybillId => _tripWaybillId;
//   int get routeExpenseId => _routeExpenseId;
//   double get actualAmount => _actualAmount;
//   String get description => _description;
//   String get image => _image;

//   Plantrip_waybill_expense_line({
//       int tripWaybillId, 
//       int routeExpenseId, 
//       double actualAmount,
//       String description,String image}){
//     _tripWaybillId = tripWaybillId;
//     _routeExpenseId = routeExpenseId;
//     _actualAmount = actualAmount;
//     _description = description;
//     _image = image;
// }

//   Plantrip_waybill_expense_line.fromJson(dynamic json) {
//     _tripWaybillId = json["trip_waybill_id"];
//     _routeExpenseId = json["route_expense_id"];
//     _actualAmount = json["actual_amount"];
//     _description = json["description"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//   //  map["trip_waybill_id"] = _tripWaybillId;
//     map["route_expense_id"] = _routeExpenseId;
//     map["actual_amount"] = _actualAmount;
//     map["description"] = _description;
//     map["attached_file"] = _image;
//     return map;
//   }

// }