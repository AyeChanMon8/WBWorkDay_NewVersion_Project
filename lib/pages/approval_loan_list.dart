

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ApprovalLoanList extends StatefulWidget {
  @override
  _ApprovalLoanListState createState() => _ApprovalLoanListState();
}

class _ApprovalLoanListState extends State<ApprovalLoanList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    controller.getLoanApprovalList();
    // perform fetching data delay
  }

  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getLoanApprovalList();
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
                  print("*****BottomOfLoanApprovalList*****");
                  // start loading data
                  controller.offset.value += limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: controller.loanApprovalList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.APPROVAL_LOAN_DETAILS,
                              arguments: index);
                        },
                        child: ListTile(
                            leading: Text(AppUtils.removeNullString(controller.loanApprovalList[index].name!
                                )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppUtils.removeNullString(controller.loanApprovalList.value[index].employee_id!.name),
                                    style: TextStyle(color: backgroundIconColor)

                                ),
                                SizedBox(height: 5),
                                Text(
                                  AppUtils.removeNullString(controller.loanApprovalList.value[index].type!),
                                    style: TextStyle(color: backgroundIconColor)

                                ),
                                SizedBox(height: 5),
                                Text(
                                  AppUtils.addThousnadSperator(controller.loanApprovalList.value[index].loan_amount!),
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
                                    Text(AppUtils.changeDateFormat(controller.loanApprovalList.value[index].payment_date!)),
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
