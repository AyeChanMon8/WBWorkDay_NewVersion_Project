

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/approval_travel_list_page.dart';
import '../pages/approved_travel_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TravelApprovalTabBar extends StatefulWidget {
  @override
  _StateTravelApprovalTabBar createState() => _StateTravelApprovalTabBar();
}

class _StateTravelApprovalTabBar extends State<TravelApprovalTabBar> {

  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  int tabbar = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.travelRequest, style: appbarTextStyle()),
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
          //     title: Text(labels?.travelRequest, style: appbarTextStyle()),
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
              ApprovalTravelList(),
              ApprovedTravelList(),
            ],
          )
      ),
    );
  }
}