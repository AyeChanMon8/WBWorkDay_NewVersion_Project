

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

class ApprovalList extends StatefulWidget {
  @override
  _ApprovalListState createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    controller.getLeaveApprovalList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getLeaveApprovalList();
  }

  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
      body: Obx(() => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              // start loading data
              controller.offset.value += limit;
              controller.isLoading.value = true;
              _loadData();
            }
            return true;
          },
          child: ListView.builder(
            itemCount: controller.leaveApprovalList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_REQUEST, arguments: index);
                    },
                    child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppUtils.changeDateFormat(controller
                                    .leaveApprovalList.value[index].start_date
                                    .toString()) +
                                " - " +
                                AppUtils.changeDateFormat(controller
                                    .leaveApprovalList.value[index].end_date
                                    .toString())),
                            SizedBox(
                              height: 5,
                            ),
                            Text(controller.leaveApprovalList.value[index]
                                .holiday_status_id!.name),
                          ],
                        ),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(controller
                              .leaveApprovalList.value[index].employee_id!.name),
                        ),
                        trailing: arrowforwardIcon),
                  ),
                ),
              );
            },
          ))),
    );
  }
}
