

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../controllers/leave_list_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'approval_details.dart';

class LeaveApprovedList extends StatefulWidget {
  @override
  _LeaveApprovedListState createState() => _LeaveApprovedListState();
}

class _LeaveApprovedListState extends State<LeaveApprovedList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    if (controller.leaveApprovedList.value.length == 0)
      controller.getLeaveApprovedList();
  }

  Future _loadData() async {
    controller.getLeaveApprovedList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
        body: Obx(
      () => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // start loading data
            controller.offset.value += limit;
            controller.isLoading.value = true;
            _loadData();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: controller.leaveApprovedList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ApprovalDetails()));

                    Get.toNamed(Routes.APPROVED_LEAVE_DETAIL, arguments: index);
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
                      //leading: Text(controller.leaveApprovedList[index].name),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppUtils.changeDateFormat(controller
                                  .leaveApprovedList.value[index].start_date
                                  .toString()) +
                              " - " +
                              AppUtils.changeDateFormat(controller
                                  .leaveApprovedList.value[index].end_date
                                  .toString())),
                          SizedBox(height: 5),
                          Text(controller.leaveApprovedList.value[index]
                              .holiday_status_id!.name),
                        ],
                      ),
                      subtitle: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(controller
                            .leaveApprovedList.value[index].employee_id!.name),
                      ),
                      trailing: arrowforwardIcon),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
