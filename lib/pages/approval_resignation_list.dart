
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ApprovalResignationList extends StatefulWidget {
  @override
  _ApprovalResignationListState createState() => _ApprovalResignationListState();
}

class _ApprovalResignationListState extends State<ApprovalResignationList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getResignationApprovalList();
    // perform fetching data delay
  }
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getResignationApprovalList();
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
                  print("*****BottomOfresignationApprovalList*****");
                  // start loading data
                  controller.offset.value += limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: controller.resignationApprovalList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.APPROVAL_RESIGNATION_DETAILS,
                              arguments: index);
                        },
                        child: ListTile(
                            leading: Text(AppUtils.removeNullString(controller.resignationApprovalList[index].name
                            )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    AppUtils.removeNullString(controller.resignationApprovalList.value[index].employeeId!.name),
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
                                    Text(AppUtils.changeDateFormat(controller.resignationApprovalList.value[index].approvedRevealingDate),style: TextStyle(color: backgroundIconColor)),
                                  ],
                                ),
                              ),
                            ),
                            trailing: arrowforwardIcon),
                      ),
                    ),
                  );
                },
              )),
        ));
  }
}
