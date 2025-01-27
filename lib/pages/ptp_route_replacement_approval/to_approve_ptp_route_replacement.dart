import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/globals.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../routes/app_pages.dart';

class ToApprovePTPRouteReplacement extends StatefulWidget {
  const ToApprovePTPRouteReplacement({super.key});

  @override
  State<ToApprovePTPRouteReplacement> createState() => _ToApprovePTPRouteReplacementState();
}

class _ToApprovePTPRouteReplacementState extends State<ToApprovePTPRouteReplacement> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getPTPRouteReplacementApprovalList();
  }
  Future _loadData() async {
    controller.getPTPRouteReplacementApprovalList();
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
        child:  controller.ptpRouteReplacementApprovalList.value.length > 0 ? ListView.builder(
          itemCount: controller.ptpRouteReplacementApprovalList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PTP_ROUTE_REPLACEMENT_DETAIL,
                        arguments: index);
                  },
                  child: ListTile(
                    title: Text(
                        // "Approval 1",
                          controller.ptpRouteReplacementApprovalList
                              .value[index].name),
                    subtitle: controller.ptpRouteReplacementApprovalList
                              .value[index].planTripProductId!=null && controller.ptpRouteReplacementApprovalList
                              .value[index].planTripProductId!.code != "" ?  Text(
                        controller.ptpRouteReplacementApprovalList
                              .value[index].planTripProductId!.code.toString()): Text('-'),
                      trailing: arrowforwardIcon),
                ),
              ),
            );
          },
        ) : SizedBox(),
      ),
      ),
    );
  }
}