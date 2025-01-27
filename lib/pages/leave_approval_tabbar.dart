

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/approval_list.dart';
import '../pages/leave_approved_list.dart';
import '../pages/travel_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LeaveApprovalTabBar extends StatefulWidget {
  @override
  _StateLeaveApprovalTabBar createState() => _StateLeaveApprovalTabBar();
}

class _StateLeaveApprovalTabBar extends State<LeaveApprovalTabBar> {
  final box = GetStorage();

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
          shadowColor: Colors.white,
          title: Text(
              labels!.leaveRequest, style: appbarTextStyle()
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
                //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
              }),
          automaticallyImplyLeading: true,
          backgroundColor: backgroundIconColor,
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
          ),
        ),
        // appBar: GradientAppBar(
        //   gradient: LinearGradient(
        //     colors: [backgroundIconColor, backgroundIconColor],
        //   ),
        //   title: Text(labels?.leaveRequest, style: appbarTextStyle()),
        //   leading: IconButton(
        //       icon: Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Get.back();
        //         //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
        //       }),
        //   actions: <Widget>[],
        //   automaticallyImplyLeading: true,
        //   bottom:  TabBar(
        //     labelColor: Colors.white,
        //     indicatorColor: Color.fromRGBO(216, 181, 0, 1),
        //     indicatorWeight: 5,
        //     tabs: [
        //       Tab(
        //         text: "To Approve",
        //       ),
        //       Tab(text: labels?.approved),
        //     ],
        //   )
        //
        // ),
        body: TabBarView(
          children: [
            ApprovalList(),
            LeaveApprovedList(),
          ],
        )
      ),
    );
  }
}