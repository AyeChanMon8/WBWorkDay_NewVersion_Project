import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../my_class/my_style.dart';
import 'toapprove_ptw_route_list.dart';

class PTWRouteApprovalTabar extends StatefulWidget {
  const PTWRouteApprovalTabar({super.key});

  @override
  State<PTWRouteApprovalTabar> createState() => _PTWRouteApprovalTabarState();
}

class _PTWRouteApprovalTabarState extends State<PTWRouteApprovalTabar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.ptwRouteApproval, style: appbarTextStyle()),
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
                labelColor: Colors.white,
                indicatorColor: Color.fromRGBO(216, 181, 0, 1),
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: labels.toApprove,
                  )
                ],
              )
          ),
          body: TabBarView(
            children: [
              ToApprovePTWRouteList()
            ],
          )),
    );
  }
}