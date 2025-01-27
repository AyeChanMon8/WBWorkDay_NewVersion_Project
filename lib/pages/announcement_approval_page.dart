import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class AnnouncementApprovalPage extends StatefulWidget {
  String pageType;

  AnnouncementApprovalPage(this.pageType);

  @override
  _AnnouncementApprovalPageState createState() =>
      _AnnouncementApprovalPageState();
}

class _AnnouncementApprovalPageState extends State<AnnouncementApprovalPage> {
  final ApprovalController controller = Get.put(ApprovalController());
  Future _loadData() async {
    widget.pageType == 'approval'
        ? controller.getAnnouncementsList()
        : controller.getApprovedAnnouncementsList();
  }

  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    widget.pageType == 'approval'
        ? controller.getAnnouncementsList()
        : controller.getApprovedAnnouncementsList();
  }

  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    return Scaffold(
      body: Obx(() => RefreshIndicator(
          child: NotificationListener<ScrollNotification>(
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
              itemCount: controller.announcementList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.APPROVAL_ANNOUNCEMENTS_DETAILS,
                            arguments:
                                controller.announcementList.value[index]);
                      },
                      child: ListTile(
                          leading:
                              Text(controller.announcementList[index].name),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppUtils.changeDateFormat(controller
                                        .announcementList
                                        .value[index]
                                        .date_start
                                        .toString()) +
                                    " - " +
                                    controller
                                        .announcementList.value[index].date_end
                                        .toString(),
                                // "Announcements 1",
                              ),
                              SizedBox(height: 5),
                              Text(
                                controller.announcementList.value[index]
                                    .announcement_reason,
                                // "Announcements 1",
                              ),
                            ],
                          ),
                          subtitle: Text(controller
                              .announcementList.value[index].company_id!.name
                              .toString()),
                          trailing: arrowforwardIcon),
                    ),
                  ),
                );
              },
            ),
          ),
          onRefresh: widget.pageType == 'approval'
              ? controller.getAnnouncementsList
              : controller.getApprovedAnnouncementsList)),
    );
  }
}
