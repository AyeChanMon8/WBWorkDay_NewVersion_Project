
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';

class ApprovedRouteList extends StatefulWidget {
  @override
  _ApprovedRouteListState createState() => _ApprovedRouteListState();
}

class _ApprovedRouteListState extends State<ApprovedRouteList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  Future _loadData() async {
    print("****loadmore****");
    controller.getRouteApprovedList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    //if(controller.travelApprovedList.value.length==0)
    controller.offset.value = 0;
    controller.getRouteApprovedList();
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
            print("*****BottomOfLeaveApprovalList*****");
            // start loading data
            controller.offset.value += limit;
            controller.isLoading.value = true;
            _loadData();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: controller.routeApprovedList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.grey[100],
              child: Container(
                margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.APPROVED_ROUTE_DETAILS,
                        arguments: index);
                  },
                  child: ListTile(
                      leading: Text(
                          controller.routeApprovedList[index].code.toString() ==
                                  "null"
                              ? ""
                              : controller.routeApprovedList[index].code
                                  .toString()),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.routeApprovedList.value[index].name
                                        .toString() ==
                                    "null"
                                ? ""
                                : controller.routeApprovedList.value[index].name
                                    .toString(),
                            style: TextStyle(color: backgroundIconColor),
                          ),
                          SizedBox(height: 5),
                          Text(
                            controller.routeApprovedList.value[index].branch_id
                                        .toString() ==
                                    "null"
                                ? ""
                                : controller.routeApprovedList.value[index]
                                    .branch_id!.name
                                    .toString(),
                            style: TextStyle(color: backgroundIconColor),
                          ),
                        ],
                      ),
                      // subtitle: Text(
                      //   controller.routeApprovedList.value[index].from_street +
                      //       " - " +
                      //       controller.routeApprovedList.value[index].to_street,style: TextStyle(color: backgroundIconColor),),
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
