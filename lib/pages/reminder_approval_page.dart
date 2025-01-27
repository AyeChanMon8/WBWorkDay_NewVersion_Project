import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/globals.dart';
import '../controllers/reminder_controller.dart';
import '../controllers/reward_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
class ReminderApprovalPage extends StatefulWidget {
  final String pageType;

  ReminderApprovalPage(this.pageType);

  @override
  _ReminderApprovalPageState createState() => _ReminderApprovalPageState();
}

class _ReminderApprovalPageState extends State<ReminderApprovalPage> {
  final ReminderController controller = Get.put(ReminderController());
  Future _loadData() async {
    widget.pageType=='approval'?
    controller.getReminderApproval():
    controller.getReminderApprove();
  }
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    widget.pageType=='approval'?
    controller.getReminderApproval():
    controller.getReminderApprove();

  }
  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    return Container(
        child:  Obx(() => RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  // start loading data
                  controller.offset.value +=limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.reminders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        widget.pageType == 'approval' ?
                        Get.toNamed(Routes.REWARD_DETAILS_PAGE,
                            arguments: index):
                        controller.downloadReward(controller.reminders[index]);
                      },
                      child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.reminders[index].employeeId![0].name,
                                style: subtitleStyle(),
                              ),
                              Text(
                                controller.reminders[index].description,
                                style: subtitleStyle(),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.reminders[index].date),
                              Text(
                                controller.reminders[index].employeeId![0].rewardTotal.toString(),
                                style: subtitleStyle(),
                              )
                            ],
                          ),
                          trailing: arrowforwardIcon),
                    ),
                  );
                },
              ),
            ), onRefresh: widget.pageType=='approval'?
        controller.getReminderApproval:
        controller.getReminderApprove)
        ));
  }
}
