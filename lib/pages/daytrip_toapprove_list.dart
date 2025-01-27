import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/globals.dart';
import '../controllers/day_trip_controller.dart';
import '../models/day_trip_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
class DayTripToApproveListPage extends StatelessWidget {
  DayTripController dayTripController = Get.put(DayTripController());
  Future _loadData() async {
    dayTripController.getDayTripToApproveList();
  }
  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Get.toNamed(Routes.CREATE_DAY_TRIP);
      //   },
      //   child: Icon(Icons.add),
      //   mini: true,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(()=>dayTripController.dayTripToApproveList.value==null?Container(): NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!dayTripController.isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              // start loading data
              dayTripController.offset.value +=limit;
              dayTripController.isLoading.value = true;
              _loadData();
            }
            return true;
          },
          child: ListView.builder(
              itemCount:dayTripController.dayTripToApproveList.length ,
              itemBuilder: (context,index){
                DayTripModel dayTripModel = dayTripController.dayTripToApproveList.value[index];
                return Card(
                    elevation: 5,
                    child:InkWell(
                      onTap:(){
                        Get.toNamed(Routes.CREATE_DAY_TRIP,arguments: dayTripModel)?.then((value) {
                          if(value!=null){
                            dayTripController.offset.value = 0;
                            dayTripController.getDayTripToApproveList();
                          }

                        });
                      },
                      child:  Container(
                        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dayTripModel.code!=null?
                                AutoSizeText(
                                  dayTripModel.code.toUpperCase(),
                                  style: maintitleStyle(),
                                ):AutoSizeText(''),
                                AutoSizeText(
                                  dayTripModel.fromDatetime,
                                  style: subtitleStyle(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  dayTripModel.vehicleId!.name,
                                  style: subtitleStyle(),
                                ),
                                AutoSizeText(
                                  dayTripModel.state.toUpperCase()+" >>",
                                  style: subtitleStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              })),),
    );
  }
}
