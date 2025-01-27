

import 'package:flutter/material.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/expense_report_complete.dart';
import '../pages/expense_report_open.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ExpenseReportTabBar extends StatefulWidget {
  @override
  _ExpenseReportTabBarState createState() => _ExpenseReportTabBarState();
}
class _ExpenseReportTabBarState extends State<ExpenseReportTabBar> {
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(labels!.expenseReports, style: appbarTextStyle()),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: <Widget>[],
          automaticallyImplyLeading: true,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Color.fromRGBO(216, 181, 0, 1),
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: labels?.open,
              ),
              Tab(text: labels?.complete),
            ],
          ),
        ),
        // appBar: GradientAppBar(
        //   gradient: LinearGradient(
        //     colors: [backgroundIconColor, backgroundIconColor],
        //   ),
        //   title: Text(labels?.expenseReports, style: appbarTextStyle()),
        //   leading: IconButton(
        //       icon: Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //       ),
        //       onPressed: () => Navigator.pop(context)),
        //   actions: <Widget>[],
        //   automaticallyImplyLeading: true,
        //   bottom: TabBar(
        //     labelColor: Colors.white,
        //     indicatorColor: Color.fromRGBO(216, 181, 0, 1),
        //     indicatorWeight: 5,
        //     tabs: [
        //       Tab(
        //         text: labels?.open,
        //       ),
        //       Tab(text: labels?.complete),
        //     ],
        //   ),
        // ),
        body: TabBarView(
          children: [
            ExpenseOpenReport(),
            ExpenseCompleteReport(),
          ],
        ),
      ),
    );
  }
}
