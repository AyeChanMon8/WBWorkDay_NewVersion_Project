

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

class ApprovalTravelList extends StatefulWidget {
  @override
  _ApprovalTravelListState createState() => _ApprovalTravelListState();
}
class _ApprovalTravelListState extends State<ApprovalTravelList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getTravelApprovalList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));

  }
  @override
  void initState() {
    super.initState();
    controller.offset.value =0;
    controller.getTravelApprovalList();
  }
  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    image = box.read('emp_image');
    return Scaffold(
      body:Obx(() =>
        NotificationListener<ScrollNotification>(
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
              child:ListView.builder(
                    itemCount: controller.travelApprovalList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: index % 2 == 0 ? Colors.grey[100] : Colors.grey[300],
                        child: Container(
                          margin: EdgeInsets.only(top:0, left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.APPROVAL_TRAVEL_DETAILS, arguments: index);
                            },
                            child: ListTile(
                                // leading: CircleAvatar(
                                //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                                //   child: ClipRRect(
                                //     borderRadius: new BorderRadius.circular(50.0),
                                //     child: Image.network(
                                //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                // ),
                                // leading:
                                leading: Text(controller.travelApprovalList[index].name),
                                title: Text(
                                    // "Approval 1",
                                    controller
                                        .travelApprovalList.value[index].employee_id!.name,style: TextStyle(color: backgroundIconColor),),
                                subtitle: Text(
                                    controller.travelApprovalList.value[index].city_from +
                                        " - " +
                                        controller.travelApprovalList.value[index].city_to,style: TextStyle(color: backgroundIconColor),),
                                trailing: arrowforwardIcon),
                          ),
                        ),
                      );
                    },
      )),)
    );
  }
}
