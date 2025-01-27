
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ApprovedEmployeeChangeList extends StatefulWidget {
  @override
  _ApprovedEmployeeChangeListState createState() => _ApprovedEmployeeChangeListState();
}

class _ApprovedEmployeeChangeListState extends State<ApprovedEmployeeChangeList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getEmployeeChangesApprovedList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    //if(controller.travelApprovedList.value.length==0)
    controller.offset.value = 0;
    controller.getEmployeeChangesApprovedList();
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
                print("*****BottomOfemployeeChangesApprovedList*****");
                // start loading data
                controller.offset.value += limit;
                controller.isLoading.value = true;
                _loadData();
              }
              return true;
            },
            child: ListView.builder(
              itemCount: controller.employeeChangesApprovedList.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.grey[100],
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.APPROVED_EMPLOYEE_CHANGES_DETAILS,
                            arguments: index);
                      },
                      child: ListTile(
                          leading: Text(AppUtils.removeNullString(controller.employeeChangesApprovedList[index].type
                          )),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                  AppUtils.removeNullString(controller.employeeChangesApprovedList.value[index].employeeId.name),
                                  style: TextStyle(color: backgroundIconColor)

                              ),
                              SizedBox(height: 10),
                              Text(
                                  AppUtils.removeNullString(controller.employeeChangesApprovedList.value[index].type),
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
                                  Text(AppUtils.changeDateFormat(controller.employeeChangesApprovedList.value[index].date)),
                                ],
                              ),
                            ),
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
