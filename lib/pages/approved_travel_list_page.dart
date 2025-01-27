

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../controllers/leave_list_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import 'approval_details.dart';

class ApprovedTravelList extends StatefulWidget {
  @override
  _ApprovedTravelListState createState() => _ApprovedTravelListState();
}
class _ApprovedTravelListState extends State<ApprovedTravelList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getTravelApprovedList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }
  @override
  void initState() {
    super.initState();
    //if(controller.travelApprovedList.value.length==0)
    controller.offset.value = 0;
    controller.getTravelApprovedList();
  }
  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
      body:Obx(()=> NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            print("*****BottomOfLeaveApprovalList*****");
            // start loading data
            controller.offset.value +=limit;
            controller.isLoading.value = true;
            _loadData();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: controller.travelApprovedList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color:index%2==0 ? Colors.grey[100] : Colors.grey[300],
              child: Container(
                margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.APPROVED_TRAVEL_DETAILS, arguments: index);
                  },
                  child: ListTile(
                      leading: Text(controller.travelApprovedList[index].name),
                      title: Text(
                          controller
                              .travelApprovedList.value[index].employee_id!.name,style: TextStyle(color: backgroundIconColor),),
                      subtitle: Text(
                          controller.travelApprovedList.value[index].city_from +
                              " - " +
                              controller.travelApprovedList.value[index].city_to,style: TextStyle(color: backgroundIconColor),),
                      trailing: arrowforwardIcon),
                ),
              ),
            );
          },
        ),
      ),)
    );
  }
}
