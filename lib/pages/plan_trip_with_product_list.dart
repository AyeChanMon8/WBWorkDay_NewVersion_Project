

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/plan_trip_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PlantripWithProductListPage extends StatefulWidget {
  final String pageType;

  PlantripWithProductListPage(this.pageType);

  @override
  _PlantripWithProductListPage createState() => _PlantripWithProductListPage();
}

class _PlantripWithProductListPage extends State<PlantripWithProductListPage>{
  var emp_id = 0;
  final PlanTripController controller = Get.find();
  @override
  void initState() {
    super.initState();
    emp_id = int.tryParse(box.read('emp_id').toString())!;
    if(widget.pageType=='open') {
      controller.getPlantripList('open');
    }
  }
  var box = GetStorage();
  Future _loadData() async {
    print("****loadmore****");
    controller.getPlantripList(widget.pageType);
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    var role_category = box.read('role_category');
    return Scaffold(
      body: GetBuilder<PlanTripController>(
        init: PlanTripController(),
        builder:(controller) => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              print("*****BottomOfPlanTripList*****");
              if(controller.plantrip_with_product_list.length>=1){
                // start loading data
                controller.offset.value +=limit;
                controller.isLoading.value = true;
                _loadData();
              }

            }
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.plantrip_with_product_list.length,
            itemBuilder: (BuildContext context, int index) {
              var from_date = AppUtils.changeDefaultDateTimeFormat(DateTime.parse(controller.plantrip_with_product_list.value[index].fromDatetime)
                                                .add(Duration(hours: 6, minutes: 30))
                                                .toString()
                                                .replaceAll('.000', ''));
                // controller.plantrip_with_product_list.value[index].fromDatetime);
              // var to_date =  AppUtils.changeDefaultDateTimeFormat(controller.plantrip_with_product_list.value[index].toDatetime);
              var to_date = AppUtils.changeDefaultDateTimeFormat(DateTime.parse(controller.plantrip_with_product_list.value[index].toDatetime)
                                                .add(Duration(hours: 6, minutes: 30))
                                                .toString()
                                                .replaceAll('.000', ''));
              var routes = "";
              var route_names = [];
              if(controller.plantrip_with_product_list.value[index]
                  .routePlanIds!.length!=0){
                controller.plantrip_with_product_list.value[index]
                    .routePlanIds!.forEach((element) {
                  route_names.add(element.routeId!.name);
                });
              }

              routes = route_names.join(",");
              return Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    controller.current_page.value = widget.pageType;
                    // Get.toNamed(Routes.PLANTRIP_DETAILS,arguments: controller.plantrip_with_product_list.value[index]).then((value) {
                    //   if(value!=null){
                    //     controller.offset.value =0;
                    //     controller.getPlantripList(widget.pageType);
                    //   }
                    // });
                    Get.toNamed(Routes.PLANTRIP_DETAILS,arguments:index)?.then((value) {
                      if(value!=null){
                        controller.offset.value =0;
                        controller.getPlantripList(widget.pageType);
                      }
                    });

                  },
                  child: Card(
                    elevation: 5,
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                              EdgeInsets.only(left: 20,top: 20),
                              child: Text(
                                controller.plantrip_with_product_list.value[index].code??'',
                                style: maintitleStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 20, right: 20),
                              child: Text(
                                controller.plantrip_with_product_list.value[index].duration
                                    .toString() +
                                    " Days "+ controller.plantrip_with_product_list.value[index].duration_hours.toStringAsFixed(2)
                                    .toString()+" Hrs",
                                style: maintitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 20),
                          child: Text(
                            routes,
                            style: subtitleStyle(),
                          ),
                        ),
                        /*Container(
                          margin:EdgeInsets.only(left: 20),
                          child: Row(children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText('From Date :',style: datalistStyle(),),
                                AutoSizeText('${controller.plantrip_with_product_list[index].fromDatetime}',style: datalistStyle(),)
                              ],)),
                            SizedBox(width: 10,),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText('To Date :',style: datalistStyle(),),
                                AutoSizeText('${controller.plantrip_with_product_list[index].toDatetime}',style: datalistStyle(),)
                              ],)),
                          ],),
                        ),*/
                        Container(
                          margin:
                          EdgeInsets.only(left: 20, top: 10,right:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(labels!.fromDate+'   ',style: datalistStylenotBold(),),
                              AutoSizeText('${from_date}',style: datalistStyle(),)
                            ],),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 20, top: 10,right:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(labels.toDate+'   ',style: datalistStylenotBold(),),
                              AutoSizeText('${to_date}',style: datalistStyle(),)
                            ],),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 20, top: 10,right:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(labels.driver+'  ',style: datalistStylenotBold(),),
                              controller.plantrip_with_product_list[index].driverId!.name==null?Text("-"):
                              AutoSizeText('${controller.plantrip_with_product_list[index].driverId!.name}',style: datalistStyle(),)
                            ],),
                        ),
                        SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                              EdgeInsets.only(left: 20, bottom: 20, top: 10,right:20),
                              child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(labels.spare+' ',style: datalistStylenotBold(),),
                                  controller.plantrip_with_product_list[index].spare1Id!.name==null?Text("-"):
                                  AutoSizeText('(${controller.plantrip_with_product_list[index].spare1Id!.name})',style: datalistStyle(),)
                                ],),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 20, top: 5, right: 5),
                              child: controller.plantrip_with_product_list.value[index].state=='open'?
                              controller.plantrip_with_product_list.value[index].driverId!.id==emp_id?
                              Text(controller.plantrip_with_product_list.value[index].state.toUpperCase(),
                                style: subtitleStyle(),):Text(
                                'approved'.toUpperCase(),
                                style: subtitleStyle(),
                              ): 
                              controller.plantrip_with_product_list.value[index].state.toUpperCase()=="ADVANCE_WITHDRAW"?
                              Text("Advance Withdraw",style: subtitleStyle(),):
                              controller.plantrip_with_product_list.value[index].state.toUpperCase()=="ADVANCE_REQUEST"?
                              Text("Advance REQUEST",style: subtitleStyle(),):
                              Text(
                                controller.plantrip_with_product_list.value[index].state.toUpperCase(),
                                style: subtitleStyle(),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

        ),
      ),

    );
  }
}
