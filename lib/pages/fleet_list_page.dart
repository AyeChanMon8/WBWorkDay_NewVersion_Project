

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/FleetController.dart';
// import '../localization.dart';
import '../models/fleet_model.dart';
import '../my_class/my_app_bar.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FleetListPage extends StatelessWidget {
 final FleetController controller = Get.put(FleetController());
  @override
  Widget build(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context,labels!.fleet, '')),
      body: Container(
        child: Obx(()=> ListView.separated(
            itemCount: controller.fleetList.length ,
            separatorBuilder: (context,index)=>Divider(height: 1,),
            itemBuilder: (context,index){
              Fleet_model value = controller.fleetList[index];
              return LimitedBox(
                maxHeight: 100,
                child: InkWell(
                  onTap: (){
                    controller.getOneFleet(index);
                    Get.toNamed(Routes.FLEET_PAGE,arguments: value);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10,left:10,),
                    child: Row(children: [
                      value.image128 != null && value.image128 != "" ? Image.memory(
                        base64Decode(value.image128??""),
                        fit: BoxFit.cover,
                        scale: 0.1,
                        height: 100,
                        width: 100,
                      ) : Container(width: 100,height: 100,),
                      Container(
                        margin: EdgeInsets.only(top: 0,left:10,),
                        child: Text(value.name))
                    ],),
                  ),
                ),
              );
            }),
      )),
    );
  }
}
