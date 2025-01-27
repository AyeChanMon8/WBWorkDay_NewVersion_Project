
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/approval_employee_change_list.dart';
import '../pages/approval_loan_list.dart';
import '../pages/approval_route_list.dart';
import '../pages/approved_employee_change_list.dart';
import '../pages/approved_loan_list.dart';
import '../pages/approved_route_list.dart';
import '../pages/first_approval_employee_change_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeChangeApprovalTabBar extends StatefulWidget {
  @override
  _StateEmployeeChangeApprovalTabBar createState() => _StateEmployeeChangeApprovalTabBar();
}

class _StateEmployeeChangeApprovalTabBar extends State<EmployeeChangeApprovalTabBar> {

  int tabbar = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.employeeChanges, style: appbarTextStyle()),
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
                    text: labels.firstApprove,
                  ),
                  Tab(
                    text: labels.toApprove,
                  ),
                  Tab(text: labels?.approved),
                ],
              )
          ),
          body: TabBarView(
            children: [
              FirstApprovalEmployeeChangeList(),
              ApprovalEmployeeChangeList(),
              ApprovedEmployeeChangeList(),
            ],
          )
      ),
    );
  }
}