import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/globals.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../routes/app_pages.dart';

class ToApprovePTWRouteList extends StatefulWidget {
  const ToApprovePTWRouteList({super.key});

  @override
  State<ToApprovePTWRouteList> createState() => _ToApprovePTWRouteListState();
}

class _ToApprovePTWRouteListState extends State<ToApprovePTWRouteList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getPTWRouteApprovalList();
  }
  Future _loadData() async {
    controller.getPTWRouteApprovalList();
  }
  @override
  Widget build(BuildContext context) {
    image = box.read('emp_image');
    final labels = AppLocalizations.of(context);
    var limit = Globals.pag_limit;
    return Scaffold(
      body:Obx(()=> NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            // start loading data
            controller.offset.value +=limit;
            controller.isLoading.value = true;
            _loadData();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: controller.ptwRouteApprovalList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PlanTrip_WAYBILL_ROUTE_APPROVAL,
                        arguments: index);
                  },
                  child: ListTile(
                    title: Text(
                        // "Approval 1",
                          controller.ptwRouteApprovalList
                              .value[index].code),
                    subtitle: controller.ptwRouteApprovalList
                              .value[index].routePlanIds!=null && controller.ptwRouteApprovalList
                              .value[index].routePlanIds!.length>0 ?  Text(
                        controller.ptwRouteApprovalList
                              .value[index].routePlanIds![0].routeId.name.toString()): Text('-'),
                      trailing: arrowforwardIcon),
                ),
              ),
            );
          },
        ),
      ),
      ),
    );
  }
}