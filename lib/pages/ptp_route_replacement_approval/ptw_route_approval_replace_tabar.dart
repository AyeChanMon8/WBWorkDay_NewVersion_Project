import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../my_class/my_style.dart';
import 'to_approve_ptw_route_replacement.dart';

class PTWRouteApprovalReplaceTabar extends StatefulWidget {
  const PTWRouteApprovalReplaceTabar({super.key});

  @override
  State<PTWRouteApprovalReplaceTabar> createState() => _PTWRouteApprovalReplaceTabarState();
}

class _PTWRouteApprovalReplaceTabarState extends State<PTWRouteApprovalReplaceTabar> {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(
              title: Text(labels!.ptwRouteReplacementApproval, style: appbarTextStyle()),
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
              ToApprovePTWRouteReplacement()
            ],
          )),
    );
  }
}