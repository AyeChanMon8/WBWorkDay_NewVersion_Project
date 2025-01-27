import 'dart:convert';

class TravelLineModel {
  int id;
  String date;
  int categ_id;
  String expense_category;
  int product_id;
  String description;
  double qty;
  double price_unit;
  double price_subtotal;
  String attached_file;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String image6;
  String image7;
  String image8;
  String image9;
  String attached_filename;
  int vehicle_id;
  bool attachment_include;
  TravelLineModel(
      {this.id = 0,
      this.date = '',
      this.categ_id = 0,
      this.expense_category = '',
      this.product_id = 0,
      this.description = '',
      this.qty = 0.0,
      this.price_unit = 0.0,
      this.price_subtotal = 0.0,
      this.attached_file = '',
      this.image1 = '',
      this.image2 = '',
      this.image3 = '',
      this.image4 = '',
      this.image5 = '',
      this.image6 = '',
      this.image7 = '',
      this.image8 = '',
      this.image9 = '',
      this.attached_filename = '',
      this.vehicle_id = 0,
      this.attachment_include = false});

  TravelLineModel copyWith({
    int? id,
    String? date,
    int? categ_id,
    String? expense_category,
    int? product_id,
    String? description,
    double? qty,
    double? price_unit,
    double? price_subtotal,
    String? attached_file,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    String? image6,
    String? image7,
    String? image8,
    String? image9,
    String? attached_filename,
    int? vehicle_id,
  }) {
    return TravelLineModel(
        id: id ?? this.id,
        date: date ?? this.date,
        categ_id: categ_id ?? this.categ_id,
        expense_category: expense_category ?? this.expense_category,
        product_id: product_id ?? this.product_id,
        description: description ?? this.description,
        qty: qty ?? this.qty,
        price_unit: price_unit ?? this.price_unit,
        price_subtotal: price_subtotal ?? this.price_subtotal,
        attached_file: attached_file ?? this.attached_file,
        image1: image1 ?? this.image1,
        image2: image2 ?? this.image2,
        image3: image3 ?? this.image3,
        image4: image4 ?? this.image4,
        image5: image5 ?? this.image5,
        image6: image6 ?? this.image6,
        image7: image7 ?? this.image7,
        image8: image8 ?? this.image8,
        image9: image9 ?? this.image9,
        attached_filename: attached_filename ?? this.attached_filename,
        vehicle_id: vehicle_id ?? this.vehicle_id,
        attachment_include: this.attachment_include);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'categ_id': categ_id,
      // 'expense_category': expense_category,
      'product_id': product_id,
      'description': description,
      'qty': qty,
      'price_unit': price_unit,
      'price_subtotal': price_subtotal,
      'attached_file': attached_file,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'image5': image5,
      'image6': image6,
      'image7': image7,
      'image8': image8,
      'image9': image9,
      'attached_filename': attached_filename,
      'vehicle_id': vehicle_id,
      'image1_filename': '',
      'image2_filename': '',
      'image3_filename': '',
      'image4_filename': '',
      'image5_filename': '',
      'image6_filename': '',
      'image7_filename': '',
      'image8_filename': '',
      'image9_filename': '',
      'attachment_include': attachment_include,
    };
  }

  factory TravelLineModel.fromMap(Map<String, dynamic> map) {
    return TravelLineModel(
      id: map['id'],
      date: map['date'],
      categ_id: map['categ_id'],
      // expense_category: map['expense_category'],
      product_id: map['product_id'],
      description: map['description'],
      qty: map['qty'],
      price_unit: map['price_unit'],
      price_subtotal: map['price_subtotal'],
      attached_file: map['attached_file'],
      image1: map['image1'],
      image2: map['image2'],
      image3: map['image3'],
      image4: map['image4'],
      image5: map['image5'],
      image6: map['image6'],
      image7: map['image7'],
      image8: map['image8'],
      image9: map['image9'],
      attached_filename: map['attached_filename'],
      vehicle_id: map['vehicle_id'],
      attachment_include: map['attachment_include'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelLineModel.fromJson(String source) =>
      TravelLineModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TravelLineModel(id: $id, date: $date, categ_id: $categ_id, expense_category: $expense_category, product_id: $product_id, description: $description, qty: $qty, price_unit: $price_unit, price_subtotal: $price_subtotal, attached_file: $attached_file, image1: $image1, image2: $image2, image3: $image3, image4: $image4, image5: $image5, image6: $image6, image7: $image7, image8: $image8, image9: $image9, attached_filename: $attached_filename, vehicle_id: $vehicle_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TravelLineModel &&
        other.id == id &&
        other.date == date &&
        other.categ_id == categ_id &&
        other.expense_category == expense_category &&
        other.product_id == product_id &&
        other.description == description &&
        other.qty == qty &&
        other.price_unit == price_unit &&
        other.price_subtotal == price_subtotal &&
        other.attached_file == attached_file &&
        other.image1 == image1 &&
        other.image2 == image2 &&
        other.image3 == image3 &&
        other.image4 == image4 &&
        other.image5 == image5 &&
        other.image6 == image6 &&
        other.image7 == image7 &&
        other.image8 == image8 &&
        other.image9 == image9 &&
        other.attached_filename == attached_filename &&
        other.vehicle_id == vehicle_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        categ_id.hashCode ^
        expense_category.hashCode ^
        product_id.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        price_unit.hashCode ^
        price_subtotal.hashCode ^
        attached_file.hashCode ^
        image1.hashCode ^
        image2.hashCode ^
        image3.hashCode ^
        image4.hashCode ^
        image5.hashCode ^
        image6.hashCode ^
        image7.hashCode ^
        image8.hashCode ^
        image9.hashCode ^
        attached_filename.hashCode ^
        vehicle_id.hashCode;
  }
}

class Vehicle_id {
  int _id = 0;
  String _name = '';

  int get id => _id;
  String get name => _name;

  Vehicle_id({int id = 0, String name = ''}) {
    _id = id;
    _name = name;
  }

  Vehicle_id.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}
