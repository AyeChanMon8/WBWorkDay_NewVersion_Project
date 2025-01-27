import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/bottom_navigation.dart';
import '../pages/leave_list.dart';
import '../pages/pms_done_page.dart';
import '../pages/pms_manager_page.dart';
import '../pages/pms_page.dart';
import '../pages/travel_list.dart';
import '../routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'hod_force_ranking_page.dart';
import 'manager_force_ranking_page.dart';

class PmsTabBar extends StatefulWidget {
  @override
  _StatePmsTabBar createState() => _StatePmsTabBar();
}

class _StatePmsTabBar extends State<PmsTabBar> {
  final box = GetStorage();

  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  int tabbar = 1;
  String role = '';
  @override
  void initState() {
    super.initState();
    role = box.read('role_category');
    List<String> result = getRole(role);
    if (result.isNotEmpty) {
      if (findUserRole(result, 'manager') != -1) {
        role = 'manager';
      } else if (findUserRole(result, 'dotted_line_manager') != -1) {
        role = 'dotted_line_manager';
      }
    }
    tabbar = role == 'manager' || role == 'dotted_line_manager' ? 5 : 1;
  }

  int findUserRole(List<String> roleList, String data) {
    return roleList.indexOf('$data');
  }

  List<String> getRole(String data) {
    int index = data.indexOf(',');
    List<String> result = [];
    if (index != -1) {
      result = data.split(',');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      initialIndex: 0,
      length: tabbar,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.pms, style: appbarTextStyle()),
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  }),
              actions: <Widget>[],
              backgroundColor: backgroundIconColor,
              automaticallyImplyLeading: true,
              bottom: role == 'manager' || role == 'dotted_line_manager'
                  ? TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                      indicatorWeight: 5,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          text: labels!.self,
                        ),
                        Tab(text: labels.toApprove),
                        Tab(text: labels.approved),
                        Tab(text: labels.manager_force_ranking),
                        Tab(text: labels.hod_force_ranking),
                      ],
                    )
                  : TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                      indicatorWeight: 5,
                      tabs: [
                        Tab(
                          text: labels!.self,
                        ),
                      ],
                    )),
          body: role == 'manager' || role == 'dotted_line_manager'
              ? TabBarView(
                  children: [PmsPage(), PmsManagerPage(), PmsDonePage(),ManagerForceRankingPage(),HODForceRankingPage()],
                )
              : TabBarView(
                  children: [
                    PmsPage(),
                  ],
                )),
    );
  }
}
