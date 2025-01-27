

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/warning_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/approval_list.dart';
import '../pages/leave_approved_list.dart';
import '../pages/warning_approval_page.dart';
import '../pages/warning_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WarningApprovalTabBar extends StatefulWidget {
  @override
  _StateWarningApprovalTabBar createState() => _StateWarningApprovalTabBar();
}

class _StateWarningApprovalTabBar extends State<WarningApprovalTabBar> {
  final WarningController controller = Get.put(WarningController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.warning, style: appbarTextStyle()),
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
                onTap: (index) {
                  if (index == 0) {
                    controller.flag = labels.approval;
                  } else {
                    controller.flag = labels.approve;
                  }
                },
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: labels.toApprove,
                  ),
                  Tab(text: labels?.approved),
                ],
              )),
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text(labels?.warning, style: appbarTextStyle()),
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              WarningApprovalPage(labels.approval),
              WarningApprovalPage(labels.approve),
            ],
          )),
    );
  }
}