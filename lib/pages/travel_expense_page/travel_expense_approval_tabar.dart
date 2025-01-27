import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../localization.dart';
import '../../my_class/my_style.dart';
import '../../pages/out_of_pocket_page/toapprove_outofpocket_list.dart';
import '../../pages/travel_expense_page/approved_travel_expense_list.dart';
import '../../pages/travel_expense_page/toapprove_travelexpense_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravelExpenseApprovalTabar extends StatefulWidget {
  @override
  _TravelExpenseApprovalTabarState createState() =>
      _TravelExpenseApprovalTabarState();
}

class _TravelExpenseApprovalTabarState
    extends State<TravelExpenseApprovalTabar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.travelExpense, style: appbarTextStyle()),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                    //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                  }),
              actions: <Widget>[],
              automaticallyImplyLeading: true,
              bottom: TabBar(
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: labels.toApprove,
                  ),
                  Tab(text: labels?.approved),
                ],
              )
          ),
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text("Travel Expense", style: appbarTextStyle()),
          //     leading: IconButton(
          //         icon: Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Get.back();
          //           //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
          //         }),
          //     actions: <Widget>[],
          //     automaticallyImplyLeading: true,
          //     bottom: TabBar(
          //       labelColor: Colors.white,
          //       indicatorColor: Color.fromRGBO(216, 181, 0, 1),
          //       indicatorWeight: 5,
          //       tabs: [
          //         Tab(
          //           text: "To Approve",
          //         ),
          //         Tab(text: labels?.approved),
          //       ],
          //     )),
          body: TabBarView(
            children: [
              ToApproveTravelExpenseList(),
              ApprovedTravelExpenseList(),
            ],
          )),
    );
  }
}
