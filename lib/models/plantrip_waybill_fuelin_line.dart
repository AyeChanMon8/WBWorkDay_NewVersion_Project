

import 'dart:convert';

/// trip_waybill_id : 1
/// date : "2021-03-19"
/// shop : "Max Energy"
/// product_id : 23
/// location_id : 102
/// slip_no : "S0011"
/// liter : 2
/// price_unit : 4500

class Plantrip_waybill_fuelin_line {
  int tripWaybillId;
  String date;
  String shop;
  int productId;
  int locationId;
  String slipNo;
  double liter;
  int priceUnit;
  double amount;

  Plantrip_waybill_fuelin_line({this.tripWaybillId = 0, this.date = '',
  this.shop = '', this.productId = 0, 
  this.locationId = 0, this.slipNo = '', this.liter = 0.0, this.priceUnit = 0,
  this.amount = 0.0 });

  Plantrip_waybill_fuelin_line copyWith({int? id, String? name}) {
    return Plantrip_waybill_fuelin_line(
      tripWaybillId: tripWaybillId ?? this.tripWaybillId,
      date: date ?? this.date,
      shop: shop ?? this.shop,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      slipNo: slipNo ?? this.slipNo,
      liter: liter ?? this.liter,
      priceUnit: priceUnit ?? this.priceUnit,
      amount: amount ?? this.amount
    );
  }

  Map<String, dynamic> toMap() {
    return {'trip_waybill_id': tripWaybillId, 
    'date': date,
    'shop': shop, 
    'product_id': productId,
    'location_id': locationId,
    'slip_no': slipNo,
    'liter': liter, 
    'price_unit': priceUnit,
    'amount': amount,
    };
  }

  factory Plantrip_waybill_fuelin_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Plantrip_waybill_fuelin_line(
      tripWaybillId: map['trip_waybill_id'],
      date: map['date'],
      shop: map['shop'],
      productId: map['product_id'],
      locationId: map['location_id'],
      slipNo: map['slip_no'],
      liter: map['liter'],
      priceUnit: map['price_unit'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip_waybill_fuelin_line.fromJson(String source) =>
      Plantrip_waybill_fuelin_line.fromMap(json.decode(source));

  @override
  String toString() => 'Plantrip_waybill_fuelin_line(tripWaybillId: $tripWaybillId, date: $date,shop: $shop, productId: $productId, locationId: $locationId, slipNo: $slipNo,liter: $liter, priceUnit: $priceUnit, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Plantrip_waybill_fuelin_line && o.tripWaybillId == tripWaybillId && o.date == date && o.shop == shop && o.productId == productId
    && o.locationId == locationId && o.slipNo == slipNo && o.liter == liter && o.priceUnit == priceUnit
    && o.amount == amount;
  }

  @override
  int get hashCode => tripWaybillId.hashCode ^ date.hashCode ^ shop.hashCode ^ productId.hashCode ^ locationId.hashCode
   ^ slipNo.hashCode ^ liter.hashCode ^ priceUnit.hashCode ^ amount.hashCode;
}


// class Plantrip_waybill_fuelin_line {
//   int _tripWaybillId;
//   String _date;
//   String _shop;
//   int _productId;
//   int _locationId;
//   String _slipNo;
//   double _liter;
//   int _priceUnit;
//   double _amount;

//   int get tripWaybillId => _tripWaybillId;
//   String get date => _date;
//   String get shop => _shop;
//   int get productId => _productId;
//   int get locationId => _locationId;
//   String get slipNo => _slipNo;
//   double get liter => _liter;
//   int get priceUnit => _priceUnit;

//   Plantrip_waybill_fuelin_line({
//       int tripWaybillId, 
//       String date, 
//       String shop, 
//       int productId, 
//       int locationId, 
//       String slipNo, 
//       double liter,
//       int priceUnit,double amount}){
//     _tripWaybillId = tripWaybillId;
//     _date = date;
//     _shop = shop;
//     _productId = productId;
//     _locationId = locationId;
//     _slipNo = slipNo;
//     _liter = liter;
//     _priceUnit = priceUnit;
//     _amount = amount;
// }

//   Plantrip_waybill_fuelin_line.fromJson(dynamic json) {
//     _tripWaybillId = json["trip_waybill_id"];
//     _date = json["date"];
//     _shop = json["shop"];
//     _productId = json["product_id"];
//     _locationId = json["location_id"];
//     _slipNo = json["slip_no"];
//     _liter = json["liter"];
//     _priceUnit = json["price_unit"];
//   }

//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() {
//     return {
//       'trip_waybill_id':_tripWaybillId,
//       'date': _date,
//       'shop': _shop,
//       'product_id': _productId,
//       'location_id': _locationId,
//       'slip_no': _slipNo,
//       'liter': _liter,
//       'price_unit': _priceUnit,
//       'amount': _amount
//     };
//   }

// }