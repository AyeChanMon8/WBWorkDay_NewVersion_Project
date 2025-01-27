import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DayTripAddFuelController extends GetxController{
  TextEditingController dateTextController = TextEditingController();
  TextEditingController shopNameTextController = TextEditingController();
  TextEditingController literTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  TextEditingController totalAmountTextController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    dateTextController = TextEditingController();
    shopNameTextController = TextEditingController();
    literTextController = TextEditingController();
    priceTextController = TextEditingController();
    totalAmountTextController =TextEditingController();
  }

}