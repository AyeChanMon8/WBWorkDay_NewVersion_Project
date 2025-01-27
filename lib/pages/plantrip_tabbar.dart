

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/plan_trip_controller.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_class/my_style.dart';
import '../pages/plan_trip_with_product_list.dart';

class PlanTripTabBar extends StatefulWidget {
  @override
  _StatePlanTripTabBar createState() => _StatePlanTripTabBar();
}

class _StatePlanTripTabBar extends State<PlanTripTabBar> {
  final box = GetStorage();
  final PlanTripController controller = Get.put(PlanTripController());
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
        // appBar: GradientAppBar(
        //   gradient: LinearGradient(
        //     colors: [backgroundIconColor, backgroundIconColor],
        //   ),
        //   title: Text(labels?.planTrip, style: appbarTextStyle()),
        //   leading: IconButton(
        //       icon: Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Get.back();
        //       }),
        //   actions: <Widget>[],
        //   automaticallyImplyLeading: true,
        // bottom: TabBar(
        //   onTap: (index){
        //     if(index==0){
        //       controller.offset.value = 0;
        //       controller.getPlantripList('open');
        //     }else if(index==1){
        //       controller.offset.value = 0;
        //       controller.getPlantripList('running');
        //     }else{
        //       controller.offset.value = 0;
        //       controller.getPlantripList('close');
        //     }
        //   },
        //   labelColor: Colors.white,
        //   indicatorColor: Color.fromRGBO(216, 181, 0, 1),
        //   indicatorWeight: 5,
        //   tabs: [
        //     Tab(
        //       text: 'OPEN',
        //     ),
        //     Tab(text: 'RUNNING'),
        //     Tab(text: 'CLOSED'),
        //   ],
        // )
        //
        // ),
        appBar: AppBar(
          title: Text(labels!.planTrip, style: appbarTextStyle()),
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
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            onTap: (index) {
              if (index == 0) {
                controller.offset.value = 0;
                controller.getPlantripList('open');
              } else if (index == 1) {
                controller.offset.value = 0;
                controller.getPlantripList('running');
              }else if (index == 2){
                controller.offset.value = 0;
                controller.getPlantripList('expense_claim');
              }
              else {
                controller.offset.value = 0;
                controller.getPlantripList('close');
              }
            }

            ,
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
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PlantripWithProductListPage('open'),
            PlantripWithProductListPage('running'),
            PlantripWithProductListPage('expense_claim'),
            PlantripWithProductListPage('close')
          ],
        ),
      ),
    );
  }
}
