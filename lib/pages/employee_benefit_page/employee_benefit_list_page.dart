

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/globals.dart';
import '../../controllers/employee_benefit_controller.dart';
import '../../localization.dart';
import '../../my_class/my_style.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeBenefitListPage extends StatefulWidget {
  @override
  _EmployeeBenefitListPageState createState() => _EmployeeBenefitListPageState();
}

class _EmployeeBenefitListPageState extends State<EmployeeBenefitListPage> {
  final EmployeeBenefitController controller = Get.put(EmployeeBenefitController());
  final box = GetStorage();
  String image = '';
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getEmployeeBenefitList();
  }

  Future _employeeBenefitData() async {
    controller.getEmployeeBenefitList();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    var limit = Globals.pag_limit;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.employee_benefit_list,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading.value &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.offset.value += limit;
            controller.isLoading.value = true;
            _employeeBenefitData();
          }
          return true;
        },
        child: Obx(
          () => ListView.builder(
            itemCount: controller.employeeBenefitList.value.length,
            itemBuilder: (BuildContext context, int dindex) {
              var status;
              if(controller.employeeBenefitList.value[dindex].state == 'pending'){
                status = 'Pending';
              }else if(controller.employeeBenefitList.value[dindex].state == 'on_hand'){
                status = 'On Hand';
              }else if(controller.employeeBenefitList.value[dindex].state == 'paid'){
                status = 'Paid';
              }else if(controller.employeeBenefitList.value[dindex].state == 'hand_over'){
                status = 'Hand Over';
              }
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.EMPLOYEE_BENEFIT_DETAILS, arguments: dindex);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
                                child: Text(
                                  labels.description,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  AppUtils.removeNullString(controller
                                      .employeeBenefitList[dindex].description
                                      .toString()),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
                                child: Text(
                                  labels.benefit,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  AppUtils.removeNullString(controller
                                      .employeeBenefitList[dindex].benefit_id.name
                                      .toString()),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
                                child: Text(
                                  labels.quantity,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  AppUtils.removeNullString(controller
                                      .employeeBenefitList[dindex].quantity
                                      .toString()),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
                                child: Text(
                                  labels.status,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  AppUtils.removeNullString(status
                                      .toString()),
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
