import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../controllers/expense_travel_list/out_of_pocket_list.dart';
import '../controllers/out_of_pocket_controller.dart';
import '../controllers/travel_list_controller.dart';
// import '../localization.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'out_of_pocket_create.dart';

class OutOfPocketList extends StatefulWidget {
  @override
  _OutOfPocketListState createState() => _OutOfPocketListState();
}

class _OutOfPocketListState extends State<OutOfPocketList> {
  final OutofPocketList controller = Get.put(OutofPocketList());

  Future _loadData() async {
    print("****loadmore****");
    controller.getExpenseListForEmp();
  }

  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    final labels = AppLocalizations.of(context);
    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getExpenseListForEmp,
          child: NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                print("*****BottomOfTravelList*****");
                // start loading data
                controller.offset.value += limit;
                controller.isLoading.value = true;
                _loadData();
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.outofpocketExpenseList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.OUT_OF_POCKET_DETAILS,
                          arguments: index);
                    },
                    child: Card(
                      elevation: 5,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
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
                                  AppUtils.changeDateFormat(controller
                                      .outofpocketExpenseList
                                      .value[index]
                                      .date),
                                  style: maintitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 5),
                                child: Text(
                                  controller.outofpocketExpenseList.value[index]
                                      .employee_id.name,
                                  style: subtitleStyle(),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 20, top: 5),
                                  // child: controller.outofpocketExpenseList
                                  //             .value[index].state !=
                                  //         'draft'
                                  //     ? RichText(
                                  //         overflow: TextOverflow.ellipsis,
                                  //         strutStyle:
                                  //             StrutStyle(fontSize: 12.0),
                                  //         text: TextSpan(
                                  //           style: datalistStyle(),
                                  //           text: controller
                                  //               .outofpocketExpenseList
                                  //               .value[index]
                                  //               .number
                                  //               .toString(),
                                  //         ),
                                  //       )
                                  //     : SizedBox(),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(fontSize: 12.0),
                                    text: TextSpan(
                                      style: datalistStyle(),
                                      text: controller.outofpocketExpenseList
                                          .value[index].number
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, top: 5, right: 20),
                                child: controller.outofpocketExpenseList
                                            .value[index].state ==
                                        "finance_approve"
                                    ? Text(
                                        "Finance approve",
                                        style: subtitleStyle(),
                                      )
                                    : Text(
                                        controller.outofpocketExpenseList
                                            .value[index].state.capitalize!,
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
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
          elevation: 0.0,
          child:  Icon(
            FontAwesomeIcons.plus,
            color: barBackgroundColorStyle,
          ),
          backgroundColor: selectedItemBackgroundColorStyle,
          onPressed: () {
            List status = controller.outofpocketExpenseList
                .where((value) => value.state == 'draft')
                .toList();
            if (status.isNotEmpty) {
              AppUtils.showToast('Cannot Create!');
            } else {
              Get.toNamed(Routes.OUT_OF_POCKET_PAGE);
            }
          }),
    );
  }
}
