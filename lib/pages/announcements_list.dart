
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/globals.dart';
import '../controllers/announcements_controller.dart';
import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/announcements_details.dart';
import '../routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnnouncementsList extends StatelessWidget {
  final AnnouncementsController controller = Get.put(AnnouncementsController());
  final box = GetStorage();
  int index = 0;

  String image = '';
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.announcements, image)),
      body: Obx(
        () => NotificationListener<ScrollNotification>(
                // ignore: missing_return
                onNotification: (ScrollNotification scrollInfo) {
                    if (!controller.isLoading.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        print("***bottomReach***");
                        if(controller.announcementList.value.length>=10){
                          controller.offset.value +=Globals.pag_limit;
                          controller.isLoading.value = true;
                          _loadData();
                        }

                    }
                    return true;
                },
                child: ListView.builder(
                                      itemCount: controller.announcementList.value.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Card(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) => AnnouncementsDetails()));
                                                Get.toNamed(Routes.ANNOUNCEMENTS_DETAILS, arguments: index);
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
                                                   leading:Text(
                                                     controller
                                                         .announcementList.value[index].name,
                                                     // "Announcements 1",
                                                   ),
                                                  title: Text(
                                                    controller
                                                        .announcementList.value[index].announcement_reason,
                                                    // "Announcements 1",
                                                  ),
                                                  subtitle: Text(controller
                                                      .announcementList.value[index].company_id!.name),
                                                  trailing: arrowforwardIcon),
                                            ),
                                          ),
                                        );
                        },
        )),
      ),
    );
  }

  void _loadData() {
      controller.getAnnouncementsList();
  }
}
