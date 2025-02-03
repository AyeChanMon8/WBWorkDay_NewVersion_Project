import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/business_travel_list.dart';
import '../pages/out_of_pocket_list.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpenseTabBar extends StatefulWidget {
  @override
  _StateExpenseTabbar createState() => _StateExpenseTabbar();
}

class _StateExpenseTabbar extends State<ExpenseTabBar> {
  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tabLength = 0;
    final outofpocket = box.read("allow_out_of_pocket");
    final travel_expense = box.read("allow_travel_expense");
    if (outofpocket != null && travel_expense != null && outofpocket==true && travel_expense==true) {
      tabLength = 2;
    } else {
      tabLength = 1;
    }
    final index = Get.arguments;
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      initialIndex: index == "travel_expense" ? 1 : 0,
      length: tabLength,
      child: Scaffold(
          appBar: AppBar(
              shadowColor: Colors.white,
              title: Text(labels!.expenseReports, style: appbarTextStyle()),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                    //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                  }),
              backgroundColor: backgroundIconColor,
              actions: <Widget>[],
              automaticallyImplyLeading: true,
              bottom: tabLength == 2
                  ? TabBar(
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                      indicatorWeight: 5,
                      tabs: [
                        Tab(
                          text: labels?.outOfPocket,
                        ),
                        Tab(text: labels?.travelExpense),
                      ],
                    )
                  : (outofpocket != null && outofpocket == true)
                      ? TabBar(
                          labelColor: Colors.white,
                          indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                          indicatorWeight: 5,
                          tabs: [
                            Tab(
                              text: labels?.outOfPocket,
                            ),
                          ],
                        )
                      : TabBar(
                          labelColor: Colors.white,
                          indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                          indicatorWeight: 5,
                          tabs: [
                            Tab(text: 'Travel Expense'),
                          ],
                        )),
          // appBar: GradientAppBar(
          //   gradient: LinearGradient(
          //     colors: [backgroundIconColor, backgroundIconColor],
          //   ),
          //   title: Text(labels?.createExpenseReport, style: appbarTextStyle()),
          //   actions: <Widget>[],
          //   automaticallyImplyLeading: true,
          //   bottom: TabBar(
          //     labelColor: Colors.white,
          //     indicatorColor: Color.fromRGBO(216, 181, 0, 1),
          //     indicatorWeight: 5,
          //     tabs: [
          //       Tab(
          //         text: labels?.outOfPocket,
          //       ),
          //       Tab(text: "Travel Expense"),
          //     ],
          //   ),
          // ),
          body: tabLength == 2
              ? TabBarView(
                  children: [
                    OutOfPocketList(),
                    BusinessTravelList(),
                  ],
                )
              : outofpocket != null && outofpocket != false
                  ? TabBarView(
                      children: [
                        OutOfPocketList(),
                      ],
                    )
                  : TabBarView(
                      children: [
                        BusinessTravelList(),
                      ],
                    )),
    );
  }
}
