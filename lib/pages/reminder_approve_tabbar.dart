import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../my_class/my_style.dart';
import '../pages/reminder_approval_page.dart';
import '../pages/reward_approval_page.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderApproveTabbar extends StatefulWidget {
  @override
  _ReminderApproveTabbarState createState() => _ReminderApproveTabbarState();
}

class _ReminderApproveTabbarState extends State<ReminderApproveTabbar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
           shadowColor: Colors.white,
            title: Text(labels!.reminder, style: appbarTextStyle()),
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
          body: TabBarView(
            children: [
              ReminderApprovalPage(labels.approval),
              ReminderApprovalPage(labels.approve),
            ],
          )
      ),
    );
  }
}
