import 'package:flutter/material.dart';
class HomeFunction{
  IconData iconData;
  String label;
  String routeName;
  bool check;

  HomeFunction(this.iconData, this.label, this.routeName, this.check);
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['iconData'] = iconData;
    m['label'] = label;
    m['routeName']= routeName;
    m['check'] = check;
    return m;
  }
}

class HomeFunctionList{
  List<HomeFunction>? items;

  HomeFunctionList() {
    items = [];
  }

  toJSONEncodable() {
    return items!.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}