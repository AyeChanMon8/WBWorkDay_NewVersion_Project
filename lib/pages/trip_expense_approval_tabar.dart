import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/appproved_tripexpense_list.dart';
import '../pages/toapprove_tripexpense_list.dart';
import '../pages/travel_expense_page/toapprove_travelexpense_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripExpenseApprovalTabar extends StatefulWidget {
  @override
  _TripExpenseApprovalTabarState createState() => _TripExpenseApprovalTabarState();
}
class _TripExpenseApprovalTabarState extends State<TripExpenseApprovalTabar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.tripExpense, style: appbarTextStyle()),
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
              bottom:  TabBar(
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: labels.tripExpense,
                  ),
                  Tab(text: labels?.approved),
                ],
              )
          ),
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text('Trip Expense', style: appbarTextStyle()),
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
          //     bottom:  TabBar(
          //       labelColor: Colors.white,
          //       indicatorColor: Color.fromRGBO(216, 181, 0, 1),
          //       indicatorWeight: 5,
          //       tabs: [
          //         Tab(
          //           text: "To Approve",
          //         ),
          //         Tab(text: labels?.approved),
          //       ],
          //     )
          //
          // ),
          body: TabBarView(
            children: [
              ToApproveTripExpenseList(),
              ApprovedTripExpenseList(),
            ],
          )
      ),
    );
  }
}
