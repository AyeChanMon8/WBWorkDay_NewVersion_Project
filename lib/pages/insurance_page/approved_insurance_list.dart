

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/globals.dart';
import '../../controllers/approval_controller.dart';
import '../../my_class/my_style.dart';
import '../../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../localization.dart';
class ApprovedInsuranceList extends StatefulWidget {

  @override
  State<ApprovedInsuranceList> createState() => _ApprovedInsuranceListState();
}

class _ApprovedInsuranceListState extends State<ApprovedInsuranceList> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getInsuranceApproved();
  }
  Future _loadData() async {
    controller.getInsuranceApproved();
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
          itemCount: controller.insuranceApprovedList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.APPROVED_INSURANCE_DETAILS,
                        arguments: index);
                  },
                  child: ListTile(
                    leading: Text(controller.insuranceApprovedList[index].name),
                    title: Text(
                        // "Approval 1",
                          controller.insuranceApprovedList
                              .value[index].employeeId!.name),
                    subtitle: Text(
                        controller.insuranceApprovedList
                              .value[index].coverageAmount.toString()),
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