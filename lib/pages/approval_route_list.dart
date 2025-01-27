
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class ApprovalRouteList extends StatefulWidget {
  @override
  _ApprovalRouteListState createState() => _ApprovalRouteListState();
}

class _ApprovalRouteListState extends State<ApprovalRouteList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getRouteApprovalList();
    // perform fetching data delay
  }

  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getRouteApprovalList();
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
              print("*****BottomOfLeaveApprovalList*****");
              // start loading data
              controller.offset.value += limit;
              controller.isLoading.value = true;
              _loadData();
            }
            return true;
          },
          child: ListView.builder(
            itemCount: controller.routeApprovalList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                // color: index % 2 == 0 ? Colors.grey[100] : Colors.grey[300],
                color: Colors.grey[100],
                child: Container(
                  margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.APPROVAL_ROUTE_DETAILS,
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
                        leading: Text(controller.routeApprovalList[index].code
                            .toString()),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppUtils.removeNullString(controller.routeApprovalList.value[index].name),
                              style: TextStyle(color: backgroundIconColor),
                            ),
                            SizedBox(height: 5),
                            Text(
                              controller.routeApprovalList.value[index]
                                          .branch_id
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : controller.routeApprovalList.value[index]
                                      .branch_id!.name
                                      .toString(),
                              style: TextStyle(color: backgroundIconColor),
                            ),
                          ],
                        ),
                        // subtitle: Text(
                        //    controller.routeApprovalList.value[index].from_street +
                        //       " - " +
                        //       controller.routeApprovalList.value[index].to_street,style: TextStyle(color: backgroundIconColor),),
                        trailing: arrowforwardIcon),
                  ),
                ),
              );
            },
          )),
    ));
  }
}
