import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_hod_force_ranking_detail_model.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HODForceRankingPage extends StatefulWidget {
  const HODForceRankingPage({super.key});

  @override
  State<HODForceRankingPage> createState() =>
      _HODForceRankingPageState();
}

class _HODForceRankingPageState extends State<HODForceRankingPage> {
  final PmsListController controller = Get.put(PmsListController());
  PMSEmployeeDetailController detailController =
      Get.put(PMSEmployeeDetailController());
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    detailController.forceManagerRatingConfig_list();
    controller.offset.value = 0;
  }

  Future _loadData() async {
    print("****loadmore****");
    controller.getHODManagerPmsApprovalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: managerListViewWidget(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget managerListViewWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String role = box.read('role_category');
    controller.getHODManagerPmsApprovalList();
    return Container(
        child: Obx(
      () => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              print("*****BottomOfPmsList*****");
              if (controller.pmsHODForceRankingDetailModel.value.length >= 10) {
                // start loading data
                controller.offset.value += Globals.pag_limit;
                controller.isLoading.value = true;
                _loadData();
              }
            }
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.pmsHODForceRankingDetailModel.value.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.pmsHODForceRankingDetailModel.value[index]
                    .forceRankingGroupId!.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context1, int index1) {
                  HODForceRankingGroupId forceRankingValue = controller
                      .pmsHODForceRankingDetailModel
                      .value[index]
                      .forceRankingGroupId![index1];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PMS_HOD_Force_Manager_Detail_Page,
                          arguments: [
                            {
                              "first": controller.pmsHODForceRankingDetailModel
                                  .value[index].forceRankingGroupId![index1]
                            },
                            {"second": index1},
                            {"third": index},
                            {"fourth": controller.pmsHODForceRankingDetailModel
                                  .value[index].forceRankingGroupId![index1].alreadySentBack},
                            {"fifth": controller.pmsHODForceRankingDetailModel
                                  .value[index].forceRankingGroupId![index1].isRatingMatch}
                          ]);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 8,
                                child: Text("Force Ranking Group Position"),
                              ),
                              const Expanded(
                                flex: 2,
                                child: Text("-"),
                              ),
                              forceRankingValue.name!=null && forceRankingValue.name!=false ? Expanded(
                                flex: 2,
                                child: Text(forceRankingValue.name),
                              ): const Expanded(flex: 1,
                              child: Text('-'),),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )),
    ));
  }
}
