

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/day_trip_controller.dart';
import '../models/day_trip_model.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
class DayTripListPage extends StatefulWidget {
  final String pageType;
  DayTripListPage(this.pageType);

  @override
  _DayTripListPageState createState() => _DayTripListPageState();
}
class _DayTripListPageState extends State<DayTripListPage> {
  var box = GetStorage();
  var isDriver = false;
  var role_category = "";
  var emp_id = 0;
   DayTripController dayTripController = Get.find();
  @override
  void initState() {
    super.initState();

    if(widget.pageType=='open'){
      dayTripController.getDayTripList('open');
    }
    print("real_role_category");
    print(box.read("real_role_category"));
    print("role_category");
    print(box.read("role_category"));
    isDriver = box.read("is_driver");
    role_category = box.read("role_category");
    emp_id = int.tryParse(box.read('emp_id').toString())!;
    print("is_driver");
    print(box.read("is_driver"));
  }
  @override
  Widget build(BuildContext context) {
    Future _loadData() async {
      dayTripController.getDayTripList(widget.pageType);
    }
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
      body: Obx(()=>dayTripController.dayTripList.value==null?Container(): NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!dayTripController.isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              // start loading data
              if(dayTripController.dayTripList.value.length>=10){
                dayTripController.offset.value +=limit;
                dayTripController.isLoading.value = true;
                _loadData();
              }

            }
            return true;
          },
          child: ListView.builder(
              itemCount:dayTripController.dayTripList.length ,
              itemBuilder: (context,index){
                DayTripModel dayTripModel = dayTripController.dayTripList.value[index];
                var from_date = AppUtils.changeDefaultDateTimeFormat(dayTripModel.fromDatetime);
                var to_date =  AppUtils.changeDefaultDateTimeFormat(dayTripModel.toDatetime);
                return Card(
                    elevation: 5,
                    child:InkWell(
                      onTap:(){
                        dayTripController.current_page.value = widget.pageType;
                        Get.toNamed(Routes.CREATE_DAY_TRIP,arguments: index)?.then((value) {
                          if(value!=null){
                            dayTripController.offset.value = 0;
                            dayTripController.getDayTripList(widget.pageType);
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
                                AutoSizeText(from_date,
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
                                Expanded(
                                  child: AutoSizeText(
                                    dayTripModel.vehicleId!.name,
                                    style: subtitleStyle(),
                                  ),
                                ),
                                dayTripModel.state=='open'?
                                dayTripModel.driverId!.id==emp_id?AutoSizeText(
                                  dayTripModel.state.toUpperCase()+" >>",
                                  style: subtitleStyle(),
                                ):AutoSizeText(
                                  "approved".toUpperCase()+" >>",
                                  style: subtitleStyle(),
                                ): AutoSizeText(
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


