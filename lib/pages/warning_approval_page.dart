

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/warning_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WarningApprovalPage extends StatefulWidget {
  final String pageType;

  WarningApprovalPage(this.pageType);

  @override
  _WarningApprovalPageState createState() => _WarningApprovalPageState();
}

class _WarningApprovalPageState extends State<WarningApprovalPage> {
  final WarningController controller = Get.put(WarningController());

  final box = GetStorage();

  Future _loadData() async {
    widget.pageType == 'Approval'
        ? controller.getWarningApproval()
        : controller.getWarningApprove();
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    controller.offset.value = 0;
    if(widget.pageType == controller.flag){
      widget.pageType == 'Approval'
          ? controller.getWarningApproval()
          : controller.getWarningApprove();
    }else if(widget.pageType == 'Approval' && (controller.flag == null || controller.flag == "")){
      controller.getWarningApproval();
    }

  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
      body: Container(
        child: Obx(() => RefreshIndicator(
            child: NotificationListener<ScrollNotification>(
              // ignore: missing_return
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
                shrinkWrap: true,
                itemCount: controller.warnings.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          // widget.pageType == 'approval'
                          //     ?
                          Get.toNamed(Routes.WARNING_DETAILS_PAGE,
                              arguments: index);
                          // : controller.downloadWarning(
                          //     controller.warnings[index]);
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
                          leading: Text(controller.warnings[index].code),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (controller.warnings[index].employeeId
                                        .isNull)
                                    ? '-'
                                    : controller.warnings[index]
                                        .employeeId![0].name,
                                style: subtitleStyle(),
                              ),
                              Text(
                                (controller.warnings[index].description
                                        .isNull)
                                    ? '-'
                                    : controller
                                        .warnings[index].description,
                                style: subtitleStyle(),
                              ),
                            ],
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text((controller.warnings[index].date ==
                                        '')
                                    ? '-'
                                    : AppUtils.changeDateFormat(controller
                                        .warnings[index].date
                                        .toString())),
                                Text(
                                  (controller.warnings[index].mark
                                              .toString() ==
                                          '')
                                      ? '-'
                                      : controller.warnings[index].mark
                                          .toString(),
                                  // "Warning",
                                  style: subtitleStyle(),
                                )
                              ],
                            ),
                          ),
                          //trailing: arrowforwardIcon
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            onRefresh: widget.pageType == 'Approval'
                ? controller.getWarningApproval
                : controller.getWarningApprove
         )),
      ),
    );
  }
}
