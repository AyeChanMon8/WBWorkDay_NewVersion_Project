import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/globals.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../routes/app_pages.dart';

class ToApprovePTWRouteReplacement extends StatefulWidget {
  const ToApprovePTWRouteReplacement({super.key});

  @override
  State<ToApprovePTWRouteReplacement> createState() => _ToApprovePTPRouteReplacementState();
}

class _ToApprovePTPRouteReplacementState extends State<ToApprovePTWRouteReplacement> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getPTWRouteReplacementApprovalList();
  }
  Future _loadData() async {
    controller.getPTWRouteReplacementApprovalList();
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
        child: controller.ptwRouteReplacementApprovalList.value.length>0 ?ListView.builder(
          itemCount: controller.ptwRouteReplacementApprovalList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PTW_ROUTE_REPLACEMENT_DETAIL,
                        arguments: index);
                  },
                  child: ListTile(
                    title: Text(
                        // "Approval 1",
                          controller.ptwRouteReplacementApprovalList
                              .value[index].name),
                    subtitle: controller.ptwRouteReplacementApprovalList
                              .value[index].planTripWaybillId!=null && controller.ptwRouteReplacementApprovalList
                              .value[index].planTripWaybillId!.code != "" ?  Text(
                        controller.ptwRouteReplacementApprovalList
                              .value[index].planTripWaybillId!.code.toString()): Text('-'),
                      trailing: arrowforwardIcon),
                ),
              ),
            );
          },
        ): SizedBox(),
      ),
      ),
    );
  }
}