import 'package:flutter/material.dart';
import 'package:flutter_mdetect/flutter_mdetect.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

class MyTheme {
  MyTheme._();
  static String mmText(String text) {
    if (MDetect.isUnicode()) {
    } else {}
    return MDetect.isUnicode() ? text : Rabbit.uni2zg(text);
  }
}
