

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../localization.dart';
import '../../my_class/my_style.dart';
import '../../pages/out_of_pocket_page/approved_outofpocket_list.dart';
import '../../pages/out_of_pocket_page/toapprove_outofpocket_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OutOfPocketApprovalTabar extends StatefulWidget {
  @override
  _OutOfPocketApprovalTabarState createState() => _OutOfPocketApprovalTabarState();
}

class _OutOfPocketApprovalTabarState extends State<OutOfPocketApprovalTabar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.white,
              title: Text(labels!.outOfPocket, style: appbarTextStyle()),
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
          // appBar: GradientAppBar(
          //     gradient: LinearGradient(
          //       colors: [backgroundIconColor, backgroundIconColor],
          //     ),
          //     title: Text(labels?.outOfPocket, style: appbarTextStyle()),
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
            children: [
              ToApproveOutOfPocketList(),
              ApprovedOutOfPocketList(),
            ],
          )
      ),
    );
  }
}
