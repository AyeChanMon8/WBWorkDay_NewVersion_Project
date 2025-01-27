
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/approval_loan_list.dart';
import '../pages/approval_route_list.dart';
import '../pages/approved_loan_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/approved_route_list.dart';

class LoanApprovalTabBar extends StatefulWidget {
  @override
  _StateLoanApprovalTabBar createState() => _StateLoanApprovalTabBar();
}

class _StateLoanApprovalTabBar extends State<LoanApprovalTabBar> {

  late int tabbar;
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
              title: Text(labels!.loan, style: appbarTextStyle()),
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
              ApprovalLoanList(),
              ApprovedLoanList(),
            ],
          )
      ),
    );
  }
}