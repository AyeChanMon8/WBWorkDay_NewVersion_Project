

//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/payslip_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PayslipListPage extends StatefulWidget {
  @override
  _PayslipListPageState createState() => _PayslipListPageState();
}
class _PayslipListPageState extends State<PayslipListPage> {
  final PayslipController controller = Get.put(PayslipController());
  final box = GetStorage();
  late String net;
  late String image;
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
        appBar: AppBar(
          title: Text(labels!.paySlipsList,style: appbarTextStyle(),),
          backgroundColor: backgroundIconColor,
        ),
        body: Obx(()=>NotificationListener<ScrollNotification>(
          // onNotification: (ScrollNotification scrollInfo) {
          //   if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
          //       scrollInfo.metrics.maxScrollExtent) {
          //     print("*****BottomOfPmsList*****");
          //     if(controller.paySlips.length>=10){
          //       controller.offset.value +=Globals.pag_limit;
          //       controller.isLoading.value = true;
          //       _loadData();
          //     }
          //     // start loading data

          //   }
          //   return true;
          // },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.paySlips.length,
            // itemCount: 3,
            itemBuilder: (BuildContext context, int pindex) {
              // for (var i = 0;
              // i < controller.paySlips[pindex].line_ids.length;
              // i++) {
              //   print(controller.paySlips[pindex].line_ids[i]);
              //   if (controller.paySlips[pindex].line_ids[i].code == "NET") {
              //     net =
              //         NumberFormat('#,###.#').format(controller.paySlips[pindex].line_ids[i].total);
              //   }
              // }
              return Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => LeaveTripRequest()));

                    Get.toNamed(Routes.PAY_SLIP_DETAIL_PAGE, arguments: pindex);
                  },
                  child: Card(
                    elevation: 5,
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
                                'Payroll Period',
                                style: maintitleStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 20, right: 20),
                              child: Text(
                                AppUtils.removeNullString(controller.paySlips[pindex].month.toString())+"-"+AppUtils.removeNullString(controller.paySlips[pindex].year),
                                style: maintitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   margin:
                            //       EdgeInsets.only(left: 20, bottom: 10, top: 20),
                            //   child: Text(
                            //     // controller.leaveList.value[index]
                            //     //     .holiday_status_id.name,
                            //     "Employee Name",
                            //     style: datalistStyle(),
                            //   ),
                            // ),

                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, right: 20),
                              child: Text(
                                'Period',
                                style: maintitleStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 10, top: 20, right: 20),
                              child: Text(
                                controller.paySlips[pindex].dateFrom+"/"+controller.paySlips[pindex].dateTo,
                                style: maintitleStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                              EdgeInsets.only(left: 20, bottom: 10, top: 5),
                              child: Text(
                                // controller.leaveList.value[index].start_date +
                                //     "/" +
                                //     controller.leaveList.value[index].end_date,
                                "Total",
                                style: datalistStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, bottom: 20, top: 5, right: 20),
                              child: Text(
                                AppUtils.addThousnadSperator(controller.paySlips[pindex].total).toString(),
                                style: subtitleStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),)
        ));
  }

  void _loadData() {
    controller.getPaySlips();
  }
}