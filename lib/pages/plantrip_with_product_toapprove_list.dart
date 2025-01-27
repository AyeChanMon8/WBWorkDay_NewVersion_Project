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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlantripWithProductToApproveListPage extends StatefulWidget {

  @override
  _PlantripWithProductToApproveListPage createState() => _PlantripWithProductToApproveListPage();
}

class _PlantripWithProductToApproveListPage extends State<PlantripWithProductToApproveListPage>{
  final PlanTripController controller = Get.put(PlanTripController());
  var box = GetStorage();
  Future _loadData() async {

  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    var role_category = box.read('role_category');
    return Scaffold(
      body: GetBuilder<PlanTripController>(
        init: PlanTripController(),
        builder:(controller) => RefreshIndicator(
          onRefresh: controller.getPlantripToApproveList,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.plantrip_with_product_toapprove_list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PLANTRIP_DETAILS,arguments: controller.plantrip_with_product_toapprove_list.value[index])?.then((value) {
                        if(value!=null){
                          controller.getPlantripToApproveList();
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
                                EdgeInsets.only(left: 20, bottom: 10, top: 20),
                                child: Text(
                                  controller.plantrip_with_product_toapprove_list.value[index]
                                      .routePlanIds!.length==0?"":controller.plantrip_with_product_toapprove_list.value[index]
                                      .routePlanIds!.first.routeId!.name,
                                  style: subtitleStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 20, right: 20),
                                child: Text(
                                  controller.plantrip_with_product_toapprove_list.value[index].duration
                                      .toString() +
                                      " Days",
                                  style: maintitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 5),
                                child: Text(
                                  DateFormat("dd/MM/yyyy HH:mm:ss").format(
                                          DateTime.parse( 
                                  controller.plantrip_with_product_toapprove_list.value[index].fromDatetime)),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin:
                                  EdgeInsets.only(left: 20, bottom: 20, top: 5),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                      style: datalistStyle(),
                                      text: controller
                                          .plantrip_with_product_toapprove_list.value[index].spare1Id!.name,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  controller.plantrip_with_product_toapprove_list.value[index].state.toUpperCase(),
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
      ),

    );
  }
}
