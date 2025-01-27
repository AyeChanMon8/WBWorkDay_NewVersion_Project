

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/day_trip_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../pages/day_trip_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayTripTabBar extends StatefulWidget {
  @override
  _StateDayTripTabBar createState() => _StateDayTripTabBar();
}

class _StateDayTripTabBar extends State<DayTripTabBar> {
  final box = GetStorage();
  DayTripController dayTripController = Get.put(DayTripController());
  List expansionlistdata = [];
  List arrayList = [];
  List doneList = [];
  List data = [];
  int tabbar = 4;
  String role = '';
  @override
  void initState() {
    super.initState();
    role = box.read('role_category');
    //tabbar = role == 'manager'||role == 'dotted_line_manager' ? 2 : 1;
  }

  @override
  Widget build(BuildContext context) {
    final travel_request = box.read("allow_travel_request");
    final index = Get.arguments;

    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      initialIndex: 0,
      length: tabbar,
        child: Scaffold(
            appBar: AppBar(
                title: Text(labels!.dayTrip, style: appbarTextStyle()),
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
                actions: <Widget>[],
                automaticallyImplyLeading: true,
                bottom:TabBar(
                  isScrollable: true,
                  onTap: (index){
                    if(index==0){
                      dayTripController.offset.value = 0;
                      dayTripController.getDayTripList('open');
                    }else if(index==1){
                      dayTripController.offset.value = 0;
                      dayTripController.getDayTripList('running');
                    }else if(index==2){
                      dayTripController.offset.value = 0;
                      dayTripController.getDayTripList('expense_claim');
                    }
                    else{
                      dayTripController.offset.value = 0;
                      dayTripController.getDayTripList('close');
                    }
                  },
                  labelColor: Colors.white,
                  indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                  indicatorWeight: 5,
                  tabs: [
                    Tab(
                      text: labels.open,
                    ),
                    Tab(text: labels.running),
                    Tab(text: "Expense Claim"),
                    Tab(text: labels.close),
                  ],
                )
            ),
            body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
                children: [
                      DayTripListPage('open'),
                      DayTripListPage('running'),
                      DayTripListPage('expense_claim'),
                      DayTripListPage('close'),
                  ],
                )

      ),
    );
  }
}
