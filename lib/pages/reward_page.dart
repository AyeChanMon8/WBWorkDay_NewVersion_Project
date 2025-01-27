

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/reward_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/reward_details_page.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  RewardController controller = Get.put(RewardController());
 @override
  void initState() {
   controller.offset.value = 0;
    super.initState();
  }
  final box = GetStorage();
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: appbar(context, labels?.reward, user_image)),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //   child: Text(
                  //     labels?.rewards,
                  //     style: maintitleStyle(),
                  //   ),
                  // ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //       child: Text(
                  //         labels?.sortBy,
                  //         style: maintitleStyle(),
                  //       ),
                  //     ),
                  //     Container(
                  //         child: IconButton(
                  //       icon: Icon(Icons.sort),
                  //       onPressed: () {},
                  //     )),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
                      if(controller.rewards.length>=10){
                        controller.offset.value +=Globals.pag_limit;
                        controller.isLoading.value = true;
                        _loadData();
                      }
                      // start loading data
                    }
                    return true;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.rewards.length,
                    itemBuilder: (BuildContext context, int index) {
                      var date = AppUtils.changeDateFormat(controller.rewards[index].date);
                      return Card(
                        elevation: 2,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.REWARD_DETAILS_PAGE,
                                arguments: index);
                            //controller.downloadReward(controller.rewards[index]);
                          },
                          child: ListTile(
                              title: Text(
                                controller.rewards[index].description,
                                style: subtitleStyle(),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(date),
                                  Text(
                                    controller.rewards[index].employeeId![0].rewardTotal.toString(),
                                    style: subtitleStyle(),
                                  )
                                ],
                              ),
                              trailing: arrowforwardIcon),
                        ),
                      );
                    },
                  )),),
            ],
          ),
        ),
      ),
    );
  }

  void _loadData() {
    controller.getRewards();
  }
}
