
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ApprovedSuspensionList extends StatefulWidget {
  @override
  _ApprovedSuspensionListState createState() => _ApprovedSuspensionListState();
}

class _ApprovedSuspensionListState extends State<ApprovedSuspensionList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getSuspensionApprovedList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    //controller.offset.value = 0;
    controller.getSuspensionApprovedList();
  }

  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    image = box.read('emp_image');
    return Scaffold(
        body: Obx(
              () => NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoading.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  print("*****BottomOfresignationApprovedList*****");
                  // start loading data
                  controller.offset.value += limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                return true;
              },
              child: controller.suspensionApprovedList.value.length > 0 ?ListView.builder(
                itemCount: controller.suspensionApprovedList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.APPROVED_SUSPENSION_DETAILS,
                              arguments: index);
                        },
                        child: ListTile(
                            leading: Text(AppUtils.removeNullString(controller.suspensionApprovedList[index].name
                            )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppUtils.removeNullString(controller.suspensionApprovedList.value[index].employeeId!.name),
                                    style: TextStyle(color: backgroundIconColor)

                                ),
                              ],
                            ),

                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Text(AppUtils.changeDateFormat(controller.suspensionApprovedList.value[index].approvedRevealingDate),style: TextStyle(color: backgroundIconColor)),
                                  ],
                                ),
                              ),
                            ),
                            trailing: arrowforwardIcon),
                      ),
                    ),
                  );
                },
              ): SizedBox()),
        ));
  }
}
