

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
class ToApproveTripExpenseList extends StatefulWidget {
  @override
  _ToApproveTripExpenseListState createState() => _ToApproveTripExpenseListState();
}
class _ToApproveTripExpenseListState extends State<ToApproveTripExpenseList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getTripExpenseToApprove();
  }
  Future _loadData() async {
    controller.getTripExpenseToApprove();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }
  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
        body:Obx(()=>NotificationListener<ScrollNotification>(
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
            itemCount: controller.tripExpenseToApproveList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.TRIP_EXPENSE_APPROVAL,
                          arguments: index);
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
                        leading: Text(controller.tripExpenseToApproveList[index].number),
                        title: Text(
                          // "Approval 1",
                            controller.tripExpenseToApproveList
                                .value[index].company_id!.name),
                        subtitle: Text(
                            controller.tripExpenseToApproveList
                                .value[index].employee_id!.name),
                        trailing: arrowforwardIcon),
                  ),
                ),
              );
            },
          ),
        ),
        )
    );
  }
}