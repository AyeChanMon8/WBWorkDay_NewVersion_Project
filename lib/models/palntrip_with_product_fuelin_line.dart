

import 'dart:convert';

class Palntrip_with_product_fuelin_line {

  int tripProductId;
  String date;
  String shop;
  int productId;
  int locationId;
  String slipNo;
  double liter;
  int priceUnit;
  double amount;
  String status;
  Palntrip_with_product_fuelin_line({
    this.tripProductId = 0,
    this.date = '',
    this.shop = '',
    this.productId = 0,
    this.locationId = 0,
    this.slipNo = '',
    this.liter = 0.0,
    this.priceUnit = 0,
    this.amount = 0.0,
    this.status = ''
  });

  Palntrip_with_product_fuelin_line copyWith({
    int? tripProductId,
  String? date,
  String? shop,
  int? productId,
  int? locationId,
  String? slipNo,
  double? liter,
  int? priceUnit,
  double? amount,
  String? status,
  }) {
    return Palntrip_with_product_fuelin_line(
      tripProductId: tripProductId ?? this.tripProductId,
      date: date ?? this.date,
      shop: shop ?? this.shop,
      productId: productId ?? this.productId,
      locationId: locationId ?? this.locationId,
      slipNo: slipNo ?? this.slipNo,
      liter: liter ?? this.liter,
      priceUnit: priceUnit ?? this.priceUnit,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parent_id': tripProductId,
      'date': date,
      'shop': shop,
      'product_id': productId,
      'location_id': locationId,
      'slip_no': slipNo,
      'liter': liter,
      'price_unit': priceUnit,
      'amount': amount,
      'status': status
    };
  }

  factory Palntrip_with_product_fuelin_line.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Palntrip_with_product_fuelin_line(
      tripProductId: map['parent_id'],
      date: map['name'],
      shop: map['id'],
      productId: map['product_id'],
      locationId: map['location_id'],
      slipNo: map['slip_no'],
      liter: map['liter'],
      priceUnit: map['price_unit'],
      amount: map['amount'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Palntrip_with_product_fuelin_line.fromJson(String source) =>
      Palntrip_with_product_fuelin_line.fromMap(json.decode(source));

  @override
  String toString() => 'Palntrip_with_product_fuelin_line(tripProductId: $tripProductId, date: $date,shop: $shop, productId: $productId,locationId: $locationId, slipNo: $slipNo,liter: $liter, priceUnit: $priceUnit,amount: $amount, status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Palntrip_with_product_fuelin_line && o.tripProductId == tripProductId && o.date == date && o.shop == shop && o.productId == productId && o.locationId == locationId && o.slipNo == slipNo && o.liter == liter && o.priceUnit == priceUnit && o.amount == amount && o.status == status;
  }

  @override
  int get hashCode => tripProductId.hashCode ^ date.hashCode ^ shop.hashCode ^ productId.hashCode
  ^locationId.hashCode ^ slipNo.hashCode ^ liter.hashCode ^ priceUnit.hashCode ^ amount.hashCode ^ status.hashCode;
}

// class Palntrip_with_product_fuelin_line {
//   int _tripProductId;
//   String _date;
//   String _shop;
//   int _productId;
//   int _locationId;
//   String _slipNo;
//   double _liter;
//   int _priceUnit;
//   double _amount;
//   String _status;

//   int get tripProductId => _tripProductId;
//   String get date => _date;
//   String get shop => _shop;
//   int get productId => _productId;
//   int get locationId => _locationId;
//   String get slipNo => _slipNo;
//   double get liter => _liter;
//   int get priceUnit => _priceUnit;

//   Palntrip_with_product_fuelin_line({
//       int tripProductId, 
//       String date, 
//       String shop, 
//       int productId, 
//       int locationId, 
//       String slipNo, 
//       double liter,
//       int priceUnit,double amount,String status}){
//     _tripProductId = tripProductId;
//     _date = date;
//     _shop = shop;
//     _productId = productId;
//     _locationId = locationId;
//     _slipNo = slipNo;
//     _liter = liter;
//     _priceUnit = priceUnit;
//     _amount = amount;
//     _status = status;
// }

//   Palntrip_with_product_fuelin_line.fromJson(dynamic json) {
//     _tripProductId = json["trip_product_id"];
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
//       'parent_id':_tripProductId,
//       'date': _date,
//       'shop': _shop,
//       'product_id': _productId,
//       'location_id': _locationId,
//       'slip_no': _slipNo,
//       'liter': _liter,
//       'price_unit': _priceUnit,
//       'status':_status

//     };
//   }

// }