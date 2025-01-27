import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/overtime_list.dart';
import '../pages/overtime_response_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverTimeListTabBar extends StatefulWidget {
  @override
  _StateOverTimeListTabBar createState() => _StateOverTimeListTabBar();
}

class _StateOverTimeListTabBar extends State<OverTimeListTabBar> {
  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var role_category = box.read('role_category');
    return role_category == 'employee'
        ? employerTab(context)
        : managerTab(context);
  }

  Widget managerTab(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          title: Text(labels!.overTime, style: appbarTextStyle()),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context)),
          actions: <Widget>[],
          automaticallyImplyLeading: true,
          backgroundColor: backgroundIconColor,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorSize:TabBarIndicatorSize.tab,
            indicatorColor: Color.fromRGBO(216, 181, 0, 1),
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 5,
            tabs: [
              Tab(text: labels?.overtimeRequest),
              Tab(text: labels?.overtimeResponse),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OverTimeListPage(),
            OverTimeResponseListPage(),

            // LeaveListPage(),
            // TravelListPage(),
          ],
        ),
      ),
    );
  }

  Widget employerTab(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(labels!.overTime, style: appbarTextStyle()),
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
              Tab(text: labels?.overtimeResponse),
            ],
          ),
        ),
        // appBar: GradientAppBar(
        //   gradient: LinearGradient(
        //     colors: [backgroundIconColor, backgroundIconColor],
        //   ),
        //   title: Text(labels?.overTime, style: appbarTextStyle()),
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
        //       Tab(text: labels?.overtimeResponse),
        //     ],
        //   ),
        // ),
        body: TabBarView(
          children: [
            OverTimeResponseListPage(),
          ],
        ),
      ),
    );
  }
}
