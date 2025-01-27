import 'dart:convert';

class Fuel_tank {
  int id;
  String name;
  double? capacity;
  dynamic? location;
  dynamic? lastCleanDate;
  double liters;
  double averagePrice;
  dynamic? lastFillingDate;
  double lastFillingAmount;
  double lastFillingPriceLiter;
  List<Fuel_History>? fuleFillingHistoryIds;
  String percentageFuel;
  dynamic? lastFuelAddingDate;
  List<Fuel_History>? fuel_history;

  Fuel_tank(
      {this.id = 0,
      this.name = '',
      this.capacity,
      this.location,
      this.lastCleanDate,
      this.liters = 0.0,
      this.averagePrice = 0.0,
      this.lastFillingDate,
      this.lastFillingAmount = 0.0,
      this.lastFillingPriceLiter = 0.0,
      this.fuleFillingHistoryIds,
      this.percentageFuel = '',
      this.lastFuelAddingDate,
      this.fuel_history});

  Fuel_tank copyWith({
    int? id,
    String? name,
    double? capacity,
    dynamic? location,
    dynamic? lastCleanDate,
    double? liters,
    double? averagePrice,
    dynamic? lastFillingDate,
    double? lastFillingAmount,
    double? lastFillingPriceLiter,
    List<Fuel_History>? fuleFillingHistoryIds,
    String? percentageFuel,
    dynamic? lastFuelAddingDate,
    List<Fuel_History>? fuel_history,
  }) {
    return Fuel_tank(
        id: id ?? this.id,
        name: name ?? this.name,
        capacity: capacity ?? this.capacity,
        location: location ?? this.location,
        lastCleanDate: lastCleanDate ?? this.lastCleanDate,
        liters: liters ?? this.liters,
        averagePrice: averagePrice ?? this.averagePrice,
        lastFillingDate: lastFillingDate ?? this.lastFillingDate,
        lastFillingPriceLiter:
            lastFillingPriceLiter ?? this.lastFillingPriceLiter,
        fuleFillingHistoryIds:
            fuleFillingHistoryIds ?? this.fuleFillingHistoryIds,
        percentageFuel: percentageFuel ?? this.percentageFuel,
        lastFuelAddingDate: lastFuelAddingDate ?? this.lastFuelAddingDate,
        fuel_history: fuel_history ?? this.fuel_history);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'location': location,
      'last_clean_date': lastCleanDate,
      'liters': liters,
      'average_price': averagePrice,
      'last_filling_date': lastFillingDate,
      'last_filling_price_liter': lastFillingPriceLiter,
      'fule_filling_history_ids':
          fuleFillingHistoryIds?.map((x) => x?.toMap())?.toList(),
      'percentage_fuel': percentageFuel,
      'last_fuel_adding_date': lastFuelAddingDate,
    };
  }

  factory Fuel_tank.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuel_tank(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      capacity: map['capacity'],
      location: map['location'],
      lastCleanDate: map['last_clean_date'],
      liters: map['liters'],
      averagePrice: map['average_price'],
      lastFillingDate: map['last_filling_date'],
      lastFillingPriceLiter: map['last_filling_price_liter'],
      fuleFillingHistoryIds: map['fule_filling_history_ids'] == null ? null : List<Fuel_History>.from(
          map['fule_filling_history_ids']?.map((x) => Fuel_History.fromMap(x))),
      // fuleFillingHistoryIds: map['fule_filling_history_ids'],
      percentageFuel: map['percentage_fuel'],
      lastFuelAddingDate: map['last_fuel_adding_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuel_tank.fromJson(String source) =>
      Fuel_tank.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fuel_tank(id: $id, name: $name, capacity: $capacity,location: $location, lastCleanDate: $lastCleanDate, liters: $liters,averagePrice: $averagePrice, lastFillingDate: $lastFillingDate, lastFillingPriceLiter: $lastFillingPriceLiter, fuleFillingHistoryIds: $fuleFillingHistoryIds, percentageFuel: $percentageFuel, lastFuelAddingDate: $lastFuelAddingDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuel_tank && o.id == id && o.name == name && o.capacity == capacity
    && o.location == location && o.lastCleanDate == lastCleanDate && o.liters == liters && o.averagePrice == averagePrice
    && o.lastFillingDate == lastFillingDate && o.lastFillingPriceLiter == lastFillingPriceLiter && o.fuleFillingHistoryIds == fuleFillingHistoryIds && o.percentageFuel == percentageFuel
    && o.lastFuelAddingDate == lastFuelAddingDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ capacity.hashCode ^ location.hashCode
    ^ lastCleanDate.hashCode ^ liters.hashCode ^ averagePrice.hashCode ^ lastFillingDate.hashCode ^ lastFillingPriceLiter.hashCode ^ fuleFillingHistoryIds.hashCode ^ percentageFuel.hashCode ^ lastFuelAddingDate.hashCode;
  }
}

// class Fuel_tank {
//   int _id;
//   String _name;
//   double _capacity;
//   dynamic _location;
//   dynamic _lastCleanDate;
//   double _liters;
//   double _averagePrice;
//   dynamic _lastFillingDate;
//   double _lastFillingAmount;
//   double _lastFillingPriceLiter;
//   List<dynamic> _fuleFillingHistoryIds;
//   String _percentageFuel;
//   dynamic _lastFuelAddingDate;
//   List<Fuel_History> _fuel_history;

//   int get id => _id;
//   String get name => _name;
//   double get capacity => _capacity;
//   dynamic get location => _location;
//   dynamic get lastCleanDate => _lastCleanDate;
//   double get liters => _liters;
//   double get averagePrice => _averagePrice;
//   dynamic get lastFillingDate => _lastFillingDate;
//   double get lastFillingAmount => _lastFillingAmount;
//   double get lastFillingPriceLiter => _lastFillingPriceLiter;
//   List<dynamic> get fuleFillingHistoryIds => _fuleFillingHistoryIds;
//   String get percentageFuel => _percentageFuel;
//   dynamic get lastFuelAddingDate => _lastFuelAddingDate;
//   List<Fuel_History> get fuel_history => _fuel_history;

//   Fuel_tank(
//       {int id,
//       String name,
//       double capacity,
//       dynamic location,
//       dynamic lastCleanDate,
//       double liters,
//       double averagePrice,
//       dynamic lastFillingDate,
//       double lastFillingAmount,
//       double lastFillingPriceLiter,
//       List<dynamic> fuleFillingHistoryIds,
//       String percentageFuel,
//       dynamic lastFuelAddingDate}) {
//     _id = id;
//     _name = name;
//     _capacity = capacity;
//     _location = location;
//     _lastCleanDate = lastCleanDate;
//     _liters = liters;
//     _averagePrice = averagePrice;
//     _lastFillingDate = lastFillingDate;
//     _lastFillingAmount = lastFillingAmount;
//     _lastFillingPriceLiter = lastFillingPriceLiter;
//     _fuleFillingHistoryIds = fuleFillingHistoryIds;
//     _percentageFuel = percentageFuel;
//     _lastFuelAddingDate = lastFuelAddingDate;
//   }

//   Fuel_tank.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _capacity = json["capacity"];
//     _location = json["location"];
//     _lastCleanDate = json["last_clean_date"];
//     _liters = json["liters"];
//     _averagePrice = json["average_price"];
//     _lastFillingDate = json["last_filling_date"];
//     _lastFillingAmount = json["last_filling_amount"];
//     _lastFillingPriceLiter = json["last_filling_price_liter"];

//     _percentageFuel = json["percentage_fuel"];
//     _lastFuelAddingDate = json["last_fuel_adding_date"];

//     if (json["fule_filling_history_ids"] != null) {
//       _fuel_history = [];
//       json["fule_filling_history_ids"].forEach((v) {
//         _fuel_history.add(Fuel_History.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["capacity"] = _capacity;
//     map["location"] = _location;
//     map["last_clean_date"] = _lastCleanDate;
//     map["liters"] = _liters;
//     map["average_price"] = _averagePrice;
//     map["last_filling_date"] = _lastFillingDate;
//     map["last_filling_amount"] = _lastFillingAmount;
//     map["last_filling_price_liter"] = _lastFillingPriceLiter;
//     if (_fuleFillingHistoryIds != null) {
//       map["fule_filling_history_ids"] =
//           _fuleFillingHistoryIds.map((v) => v.toJson()).toList();
//     }
//     map["percentage_fuel"] = _percentageFuel;
//     map["last_fuel_adding_date"] = _lastFuelAddingDate;
//     return map;
//   }
// }

class Fuel_History {
  double fuel_liter;
  double price_per_liter;
  String filling_date;
  String source_doc;
  Fuel_History({
    this.fuel_liter = 0.0,
    this.price_per_liter = 0.0,
    this.filling_date = '',
    this.source_doc = ''
  });

  Fuel_History copyWith({
    double? fuel_liter,
  double? price_per_liter,
  String? filling_date,
  String? source_doc
  }) {
    return Fuel_History(
      fuel_liter: fuel_liter ?? this.fuel_liter,
      price_per_liter: price_per_liter ?? this.price_per_liter,
      filling_date: filling_date ?? this.filling_date,
      source_doc: source_doc ?? this.source_doc
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fuel_liter': fuel_liter,
      'price_per_liter': price_per_liter,
      'filling_date': filling_date,
      'source_doc': source_doc,
    };
  }

  factory Fuel_History.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Fuel_History(
      fuel_liter: map['fuel_liter'] ?? 0.0,
      price_per_liter: map['price_per_liter'] ?? 0.0,
      filling_date: map['filling_date'] ?? '',
      source_doc: map['source_doc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Fuel_History.fromJson(String source) =>
      Fuel_History.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Fuel_History(fuel_liter: $fuel_liter, price_per_liter: $price_per_liter,filling_date: $filling_date, source_doc: $source_doc)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Fuel_History && o.fuel_liter == fuel_liter && o.price_per_liter == price_per_liter && o.filling_date == filling_date && o.source_doc == source_doc;
  }

  @override
  int get hashCode {
    return fuel_liter.hashCode ^ price_per_liter.hashCode ^ filling_date.hashCode ^ source_doc.hashCode;
  }
}

// class Fuel_History {
//   double _fuel_liter;
//   double _price_per_liter;
//   String _filling_date;
//   String _source_doc;

//   double get fuel_liter => _fuel_liter;
//   double get price_per_liter => _price_per_liter;
//   String get filling_date => _filling_date;
//   String get source_doc => _source_doc;

//   Fuel_History({double fuel_liter, double price_per_liter}) {
//     _fuel_liter = fuel_liter;
//     _price_per_liter = price_per_liter;
//   }

//   Fuel_History.fromJson(dynamic json) {
//     _fuel_liter = json["fuel_liter"];
//     _price_per_liter = json["price_per_liter"];
//     _filling_date = json["filling_date"];
//     _source_doc = json["source_doc"];
//   }
// }
