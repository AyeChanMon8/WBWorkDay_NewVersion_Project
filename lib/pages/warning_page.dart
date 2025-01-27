

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/warning_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WarningPage extends StatefulWidget {
  @override
  _WarningPageState createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  final WarningController controller = Get.put(WarningController());

  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
    controller.getWarning();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels!.warning, user_image)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
          Obx(()=>NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                print("*****BottomOfPmsList*****");
                if(controller.warnings.length>=10){
                  controller.offset.value +=Globals.pag_limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
                // start loading data
              }
              return true;
            },
            child:  ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.warnings.length,
                  itemBuilder: (BuildContext context, int index) {
                    var date = AppUtils.changeDateFormat(controller.warnings[index].date);
                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.WARNING_DETAILS_PAGE,
                              arguments: index);
                          //controller.downloadWarning(controller.warnings[index]);
                        },
                        child: ListTile(
                            // leading: CircleAvatar(
                            //   backgroundColor: Color.fromRGBO(216, 181, 0, 1),
                            //   child: ClipRRect(
                            //     borderRadius: new BorderRadius.circular(50.0),
                            //     child: Image.network(
                            //       "https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg",
                            //       fit: BoxFit.contain,
                            //     ),
                            //   ),
                            // ),
                            // leading:
                            title: Text(
                              (controller.warnings[index].description.isNull)
                                  ? '-'
                                  : controller.warnings[index].description,
                              style: subtitleStyle(),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((date == '')
                                    ? '-'
                                    : date),
                                Text(
                                  (controller.warnings[index].mark.toString() ==
                                          '')
                                      ? '-'
                                      : controller.warnings[index].mark
                                          .toString(),
                                  // "Warning",
                                  style: subtitleStyle(),
                                ),

                              ],
                            ),
                            trailing: arrowforwardIcon),
                      ),
                    );
                  },
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadData() {
    controller.getWarning();
  }
}
