

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/busiess_travel_controller.dart';
import '../models/travel_expense/travel_expense_category.dart';
import '../models/travel_expense/travel_expense_product.dart';

class PlanDayTripExpenseCreate extends StatelessWidget {
  final BusinessTravelController controller = Get.put(BusinessTravelController());
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget expenseCategoryDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseCategory>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedExpenseCategory,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseCategory? value) {
                            print(value!.display_name);
                            print(value!.id);
                            controller.onChangeExpenseCategoryDropdown(value!);
                          },
                          items: controller.travel_expense_category_list
                              .map((TravelExpenseCategory travel) {
                            return DropdownMenuItem<TravelExpenseCategory>(
                              value: travel,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  travel.display_name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseProductDropDown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                        () => DropdownButtonHideUnderline(
                      child: DropdownButton<TravelExpenseProduct>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Expense Title",
                              )),
                          value: controller.selectedExpenseProduct,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (TravelExpenseProduct? value) {
                            print(value!.name);
                            print(value!.id);
                            controller.onChangeExpenseProductDropdown(value!);
                          },
                          items: controller.travel_expense_product_list
                              .map((TravelExpenseProduct product) {
                            return DropdownMenuItem<TravelExpenseProduct>(
                              value: product,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  product.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

