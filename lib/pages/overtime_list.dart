

import 'package:flutter/material.dart';
// import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/globals.dart';
import '../localization.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../controllers/overtime_list_controller.dart';
// import '../localization.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OverTimeListPage extends StatelessWidget {
  final OverTimeListController controller =Get.find();

  bool declined = true;
  bool accept = true;
  bool click = true;
  toggle(String text) {
    // setState(() {
    //   if (text == "declined") {
    //     declined = false;
    //     accept = true;
    //   } else if (text == "accept") {
    //     accept = false;
    //     declined = true;
    //   }
    // });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final formatTime = DateFormat("HH:mm:ss");
  final timeFormat = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return  Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Obx(
              () => RefreshIndicator(
                onRefresh: controller.getOtList,
                child: NotificationListener<ScrollNotification>(
                  // ignore: missing_return
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!controller.isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        print("***bottomReach***");
                        if(controller.otList.value.length>=10){
                          controller.offset.value +=Globals.pag_limit;
                          controller.isLoading.value = true;
                          _loadData();
                        }
                       
                      }
                      return true;
                    },
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.otList.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    var data = index.toString() + ",open";
                    return Container(
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.OVERTIME_DETAILS,
                                arguments: data,
                              );
                            },
                            child: Card(
                              semanticContainer: true,
                              elevation: 5,
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                    right: 10.0),
                                // leading: CircleAvatar(
                                //   backgroundColor:
                                //       Color.fromRGBO(216, 181, 0, 1),
                                //   child: ClipRRect(
                                //     borderRadius:
                                //         new BorderRadius.circular(50.0),
                                //     child: Image.network(
                                //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                // ),
                               
                                title: Text(
                                  controller.otList.value[index].name
                                      .toString(),
                                  // "Attendance Regualarization",
                                  style: maintitleStyle(),
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top:5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                       
                                        Text(
                                          DateFormat("dd/MM/yyyy HH:mm:ss").format(
                                          DateTime.parse(controller
                                              .otList.value[index].start_date
                                              .toString())),
                                          style: subtitleStyle(),
                                        ),
                                        
                                        Text(
                                          controller
                                              .otList[index].state
                                              .toString().capitalize!,
                                          style: subtitleStyle(),
                                        ),
                                      ]),
                                ),
                              ),
                            )));
                  },
                )),
              ),
            )),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(
              FontAwesomeIcons.plus,
              color: barBackgroundColorStyle,
            ),
            backgroundColor: selectedItemBackgroundColorStyle,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LeaveTripRequest()));
              Get.toNamed(Routes.OVER_TIME_PAGE);
            }),
      );

  }

  void _loadData() {
     controller.getOtList();
  }
}
