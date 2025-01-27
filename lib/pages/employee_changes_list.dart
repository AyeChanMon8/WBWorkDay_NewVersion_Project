import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/employee_change_controller.dart';
import '../models/leave_list_response.dart';
import '../models/travel_expense/out_of_pocket_response.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../services/employee_service.dart';
import '../services/leave_service.dart';
import '../services/travel_request_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeChangeList extends StatefulWidget {
  @override
  _EmployeeChangeListState createState() => _EmployeeChangeListState();
}

class _EmployeeChangeListState extends State<EmployeeChangeList> {
  EmployeeChangeController controller =
  Get.put(EmployeeChangeController());

  Future _loadData() async {
    print("****load more****");
    controller.getEmployeeChangeList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;

    return Scaffold(
        appBar: AppBar(
          title: Text(labels!.employeeChanges),
        ),
        body: Obx(
              () => NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!controller.isLoading.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  print("*****BottomOfemployeeChangesApprovalList*****");
                  // start loading data
                  controller.offset.value += limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: controller.empChangeList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.grey[100],
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EMPLOYEE_CHANGES_DETAILS,
                              arguments: index);
                        },
                        child: ListTile(
                            leading: Container(
                              width: 90,
                              child: Text(AppUtils.removeNullString(controller.empChangeList[index].type.toUpperCase()
                              ),style: TextStyle(fontSize: 10),),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                    AppUtils.removeNullString(controller.empChangeList.value[index].employeeId.name),
                                    style: TextStyle(color: backgroundIconColor)

                                ),
                                SizedBox(height: 10),
                                Text(
                                    AppUtils.removeNullString(controller.empChangeList.value[index].state),
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
                                    Text(AppUtils.changeDateFormat(controller.empChangeList.value[index].date)),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.CREATE_EMPLOYEE_CHANGE);
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
