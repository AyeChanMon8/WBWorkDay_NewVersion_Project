

import 'dart:convert';

/// date : "2021-03-16"
/// shop : "Trip"
/// product_id : 24
/// location_id : 22
/// slip_no : "SN-0001"
/// liter : 2
/// price_unit : 2500
/// day_trip_id : 2

class Fuelin_line {
  String date;
  String shop;
  int productId;
  int locationId;
  String slipNo;
  double liter;
  double priceUnit;
  int parentId;
  String status;
  int employeeId;
  int lineId;
  Fuelin_line({
    this.date = '',
    this.shop = '',
    this.productId = 0,
    this.locationId = 0,
    this.slipNo = '',
    this.liter = 0.0,
    this.priceUnit = 0.0,
    this.parentId = 0,
    this.status = '',
    this.employeeId = 0,
    this.lineId = 0
  });

  Fuelin_line copyWith({
    String? date,
  String? shop,
  int? productId,
  int? locationId,
  String? slipNo,
  double? liter,
  double? priceUnit,
  int? parentId,
  String? status,
  int? employeeId,
  int? lineId
  }) {
    return Fuelin_line(
      date: date ?? this.date,
      shop: shop ?? this.shop,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      slipNo: slipNo ?? this.slipNo,
      liter: liter ?? this.liter,
      priceUnit: priceUnit ?? this.priceUnit,
      parentId: parentId ?? this.parentId,
      status: status ?? this.status,
      employeeId: employeeId ?? this.employeeId,
      lineId: lineId ?? this.lineId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'shop': shop,
      'product_id': productId,
      'location_id': locationId,
      'slip_no': slipNo,
      'liter': liter,
      'price_unit': priceUnit,
      'parent_id': parentId,
      'status': status,
      'employee_id': employeeId,
      'line_id': lineId,
    };
  }

  factory Fuelin_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuelin_line(
      date: map['date'] ?? '',
      shop: map['shop'] ?? '',
      productId: map['product_id'] ?? 0,
      locationId: map['location_id'] ?? 0,
      slipNo: map['slip_no'] ?? 0,
      liter: map['liter'] ?? 0.0,
      priceUnit: map['price_unit'] ?? 0.0,
      parentId: map['parent_id'] ?? 0,
      status: map['status'] ?? '',
      employeeId: map['employee_id'] ?? 0,
      lineId: map['line_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuelin_line.fromJson(String source) =>
      Fuelin_line.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fuelin_line(date: $date, shop: $shop,productId: $productId, locationId: $locationId,slipNo: $slipNo, liter: $liter,priceUnit: $priceUnit, parentId: $parentId,status: $status, employeeId: $employeeId,lineId: $lineId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuelin_line && o.date == date && o.shop == shop && o.productId == productId && o.locationId == locationId
    && o.slipNo == slipNo && o.liter == liter && o.priceUnit == priceUnit && o.parentId == parentId && o.status == status && o.employeeId == employeeId
    && o.lineId == lineId;
  }

  @override
  int get hashCode {
    return date.hashCode ^ shop.hashCode ^ productId.hashCode ^ locationId.hashCode ^
    slipNo.hashCode ^ liter.hashCode ^ priceUnit.hashCode ^ parentId.hashCode ^ status.hashCode ^ employeeId.hashCode ^
    lineId.hashCode;
  }
}


// class Fuelin_line {
//   String _date;
//   String _shop;
//   int _productId;
//   int _locationId;
//   String _slipNo;
//   double _liter;
//   double _priceUnit;
//   int _dayTripId;
//   String _status;
//   int _employeeId;
//   int _lineId;

//   String get date => _date;
//   String get shop => _shop;
//   int get productId => _productId;
//   int get locationId => _locationId;
//   String get slipNo => _slipNo;
//   double get liter => _liter;
//   double get priceUnit => _priceUnit;
//   int get dayTripId => _dayTripId;
//   int get employeeId => _employeeId;
//   int get lineId => _lineId;

//   Fuelin_line({
//       String date, 
//       String shop, 
//       int productId, 
//       int locationId, 
//       String slipNo, 
//       double liter,
//       double priceUnit, 
//       int dayTripId,String status,
//       int employeeId, int lineId}){
//     _date = date;
//     _shop = shop;
//     _productId = productId;
//     _locationId = locationId;
//     _slipNo = slipNo;
//     _liter = liter;
//     _priceUnit = priceUnit;
//     _dayTripId = dayTripId;
//     _status = status;
//     _employeeId = employeeId;
//     _lineId = lineId;
// }

//   Fuelin_line.fromJson(dynamic json) {
//     _date = json["date"];
//     _shop = json["shop"];
//     _productId = json["product_id"];
//     _locationId = json["location_id"];
//     _slipNo = json["slip_no"];
//     _liter = json["liter"];
//     _priceUnit = json["price_unit"];
//     _dayTripId = json["day_trip_id"];
//     _employeeId = json["employee_id"];
//     _lineId = json["line_id"];
//   }

//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'date': _date,
//       'shop': _shop,
//       'product_id': _productId,
//       'location_id': _locationId,
//       'slip_no': _slipNo,
//       'liter': _liter,
//       'price_unit': _priceUnit,
//       'parent_id': _dayTripId,
//       'status':_status,
//       'employee_id': _employeeId,
//       'line_id':_lineId
//     };
//   }

// }