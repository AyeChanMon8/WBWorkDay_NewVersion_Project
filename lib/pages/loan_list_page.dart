

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/loan_page_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../localization.dart';

class LoanListPage extends StatefulWidget {
  @override
  _LoanListPageState createState() => _LoanListPageState();
}

class _LoanListPageState extends State<LoanListPage> {
  final LoanController controller = Get.put(LoanController());
  final box = GetStorage();
  late String image;
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getloanList();
  }

  Future _loadData() async {
    controller.getloanList();
    // perform fetching data delay
    //await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    var limit = Globals.pag_limit;
  
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.loanList,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: NotificationListener<ScrollNotification>(
        // onNotification: (ScrollNotification scrollInfo) {
        //   if (!controller.isLoading.value &&
        //       scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
        //     controller.offset.value += limit;
        //     controller.isLoading.value = true;
        //     _loadData();
        //   }
        //   return true;
        // },
        child: Obx(
          () => ListView.builder(
            itemCount: controller.loanList.value.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int dindex) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.LOAN_DETAILS, arguments: dindex);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 20, right: 20),
                                child: Text(
                                  controller.loanList[dindex].name!,
                                  style: maintitleStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 20, right: 20),
                                child: Text(
                                  controller.loanList[dindex].employee_id!.name,
                                  style: maintitleStyle(),
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
                                  // controller.leaveList.value[index].start_date +
                                  //     "/" +
                                  //     controller.leaveList.value[index].end_date,
                                  labels.status,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: controller
                                      .loanList[dindex].state!=null ? Text(
                                  AppUtils.removeNullString(controller
                                      .loanList[dindex].state
                                      .toString()),
                                  style: subtitleStyle(),
                                ):Text('-',
                                style: subtitleStyle()),
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
                                  // controller.leaveList.value[index].start_date +
                                  //     "/" +
                                  //     controller.leaveList.value[index].end_date,
                                  labels.loanAmount,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  NumberFormat('#,###').format(double.tryParse(
                                      controller.loanList[dindex].loan_amount
                                          .toString())),
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
                                    left: 20, bottom: 20, top: 5),
                                child: Text(
                                  // controller.leaveList.value[index].description,
                                  labels.numberOfInstallments,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  controller.loanList[dindex].installment
                                      .toString(),
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
                                    left: 20, bottom: 20, top: 5),
                                child: Text(
                                  // controller.leaveList.value[index].description,
                                  labels.paymentStartDate,
                                  style: datalistStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: Text(
                                  AppUtils.changeDateFormat(
                                      controller.loanList[dindex].date!),
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
