import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/pms_employee_detail_controller.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_force_ranking_detail_model.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManagerForceRankingPage extends StatefulWidget {
  const ManagerForceRankingPage({super.key});

  @override
  State<ManagerForceRankingPage> createState() =>
      _ManagerForceRankingPageState();
}

class _ManagerForceRankingPageState extends State<ManagerForceRankingPage> {
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
    controller.getManagerPmsApprovalList();
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
    controller.getManagerPmsApprovalList();
    return Container(
        child: Obx(
      () => NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              print("*****BottomOfPmsList*****");
              if (controller.pmsForceManagerDetailModels.value.length >= 10) {
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
            itemCount: controller.pmsForceManagerDetailModels.value.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.pmsForceManagerDetailModels.value[index]
                    .forceRankingGroupId!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context1, int index1) {
                  ForceRankingGroupId forceRankingValue = controller
                      .pmsForceManagerDetailModels
                      .value[index]
                      .forceRankingGroupId![index1];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PMS_Force_Manager_Detail_Page,
                          arguments: [
                            {
                              "first": controller.pmsForceManagerDetailModels
                                  .value[index].forceRankingGroupId![index1]
                            },
                            {"second": index1},
                            {"third": index}
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
                              Expanded(
                                flex: 2,
                                child: forceRankingValue.name!=null && forceRankingValue.name!=false ? Text(forceRankingValue.name): const Text('-'),
                              ),
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
