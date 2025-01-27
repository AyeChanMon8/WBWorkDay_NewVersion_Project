import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 63, 51, 128),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide.none),
        foregroundColor: Colors.white),
    primaryColor: Color.fromARGB(255, 63, 51, 128),
    brightness: Brightness.light,
    // accentColor: Color.fromARGB(255, 63, 51, 128),
    splashColor: Color.fromARGB(255, 63, 51, 128),
    highlightColor: Color.fromARGB(255, 63, 51, 128),
    fontFamily: 'zawgyi',
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Color.fromARGB(255, 63, 51, 128),
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey,
    ),
    cardTheme: const CardTheme(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 63, 51, 128),
        iconTheme: IconThemeData(color: Colors.white)),
    
    timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        inputDecorationTheme: InputDecorationTheme(border: InputBorder.none)));

ThemeData firstTD() => ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.white as MaterialColor,
      brightness: Brightness.light,
    );
ThemeData secondTD() => ThemeData(
    fontFamily: 'Roboto',
    primarySwatch: Colors.white as MaterialColor,
    brightness: Brightness.dark);
