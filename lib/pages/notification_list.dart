import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../constants/globals.dart';
import '../controllers/notification_controller.dart';
import '../my_class/my_app_bar.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationMessageList extends StatefulWidget {
  NotificationMessageList({Key? key}) : super(key: key);

  @override
  _NotificationMessageListState createState() =>
      _NotificationMessageListState();
}

class _NotificationMessageListState extends State<NotificationMessageList> {
  final NotificationController controller = Get.put(
    NotificationController(),
  );
  final box = GetStorage();
  late String image;
  String selectall = "Select All";
  void initData() async {
    controller.retrieveMsgs();
  }

  @override
  void initState() {
    initData();
    super.initState();
    controller.offset.value = 0;
    handleNotification();
  }

  void handleNotification() async {
    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   this.setState(() {
    //     //TODO put data to one of controller for notification messages.
    //     try {
    //       var data = notification.payload.additionalData;
    //       String message =
    //       notification.jsonRepresentation().replaceAll("\\n", "\n");

    //       String message_type = null;
    //       Map<String, dynamic> dataMap = notification.payload.additionalData;
    //       if (dataMap != null && dataMap.length > 0) {
    //         message_type = dataMap["type"];
    //       }

    //       if (message_type != null && message_type == "noti") {
    //         controller.retrieveMsgs();
    //         String title = notification.payload.title;
    //         String body = notification.payload.body;
    //         Get.snackbar("Notification $title", body);
    //       }
    //     } catch (error) {

    //     }
    //   });
    // });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification

      this.setState(() {
        //TODO put data to one of controller for notification messages.
        try {
          // var data = event.notification.additionalData;
          // String message =
          // event.notification.jsonRepresentation().replaceAll("\\n", "\n");

          String message_type = '';
          Map<String, dynamic> dataMap = event.notification.additionalData!;
          if (dataMap != null && dataMap.length > 0) {
            message_type = dataMap["type"];
          }

          if (message_type != null && message_type == "noti") {
            controller.retrieveMsgs();
            String title = event.notification.title!;
            String body = event.notification.body!;
            Get.snackbar("Notification $title", body);
          }
        } catch (error) {}
      });
      event.complete(event.notification);
    });
  }

  Widget slideLeftBackground(int index) {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                controller.deleteMsg(controller.notificationList[index], index);
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground(int index) {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                controller.readMsg(controller.notificationList[index], index);
              },
              child: Icon(
                FontAwesomeIcons.inbox,
                color: Colors.white,
              ),
            ),
            Text(
              " Read",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Material(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, "Notifications", image)),
      body: Stack(
        children: <Widget>[
          // new Container(
          //   decoration: new BoxDecoration(
          //       image: new DecorationImage(
          //           image: AssetImage('assets/images/background.png'),
          //           fit: BoxFit.fill)),
          // ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GFButton(
                  onPressed: () {
                    controller.notificationList.forEach((element) {
                      element.selected = true;
                    });
                    setState(() {
                      if (selectall == 'Select All') {
                        selectall = 'Unselect All';
                        // controller.notificationList.forEach((element) {
                        //       element.selected = !element.has_read;
                        //
                        //  });
                      } else {
                        selectall = 'Select All';
                        controller.notificationList.forEach((element) {
                          element.selected = false;
                        });
                      }
                    });
                  },
                  child: Text(selectall),
                ),
                SizedBox(
                  width: 10,
                ),
                GFButton(
                  onPressed: () {
                    setState(() {
                      selectall = 'Select All';
                    });
                    for (int index = 0;
                        index < controller.notificationList.length;
                        index++) {
                      if (controller.notificationList[index].selected)
                        controller.readMsg(
                            controller.notificationList[index], index);
                    }
                  },
                  child: Text('Read All'),
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                GFButton(
                    onPressed: () {
                      print("deleteAll#");
                      print(controller.notificationList.length);
                      controller.notificationList.forEach((element) {
                        element.selected = true;
                      });
                      controller.deleteConfirm();
                      // for(int index = 0 ; index< controller.notificationList.length;index++){
                      //   print(controller.notificationList[index].selected);
                      //   if(controller.notificationList[index].selected)
                      //     controller.deleteMsg(
                      //         controller.notificationList[index],
                      //         index);
                      // }
                    },
                    child: Text('Delete All'),
                    color: Colors.red),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 2, right: 2, bottom: 2, top: 50),
                        child: Obx(
                          () => NotificationListener<ScrollNotification>(
                              // ignore: missing_return
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!controller.isLoading.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  controller.offset.value += Globals.pag_limit;
                                  controller.isLoading.value = true;
                                  //_loadData();
                                }
                                return true;
                              },
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: Color(0xffCCCCCC),
                                  height: 1,
                                ),
                                controller: controller.scrollController,
                                itemBuilder: (context, index) {
                                  var dateValue = '';

                                  var date = DateFormat("yyyy-MM-dd HH:mm:ss")
                                      .parse(
                                          controller.notificationList[index]
                                              .create_date,
                                          true);
                                  dateValue = date.toLocal().toString();

                                  return Dismissible(
                                    key: Key(controller
                                        .notificationList[index].id
                                        .toString()),
                                    child: InkWell(
                                      onLongPress: () {
                                        controller.readMsg(
                                            controller.notificationList[index],
                                            index);
                                      },
                                      onDoubleTap: () {
                                        controller.readMsg(
                                            controller.notificationList[index],
                                            index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                            value: controller
                                                                .notificationList[
                                                                    index]
                                                                .selected,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                controller
                                                                    .notificationList[
                                                                        index]
                                                                    .selected = value!;
                                                              });
                                                            })),
                                                    controller
                                                            .notificationList[
                                                                index]
                                                            .has_read
                                                        ? Icon(
                                                            Icons.circle,
                                                            color: Colors
                                                                .transparent,
                                                            size: 10,
                                                          )
                                                        : Icon(
                                                            Icons.circle,
                                                            color: Color(
                                                                0xff1D84F9),
                                                            size: 8,
                                                          ),
                                                  ],
                                                )),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /* Expanded(
                                                  flex:1,
                                                  child: Visibility(
                                                      visible: controller
                                                          .notificationList[index]
                                                          .subTitle !=
                                                          null,
                                                      child: Text(controller
                                                          .notificationList[index]
                                                          .subTitle)),
                                                ),*/
                                            Expanded(
                                              flex: 7,
                                              child: AutoSizeText(
                                                  controller
                                                      .notificationList[index]
                                                      .contents,
                                                  style: controller
                                                          .notificationList[
                                                              index]
                                                          .has_read
                                                      ? TextStyle(
                                                          color:
                                                              Colors.grey[900])
                                                      : TextStyle(
                                                          // fontWeight:
                                                          // FontWeight.bold,
                                                          color: Colors.black)),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: AutoSizeText(
                                                  AppUtils.timeInfo(dateValue)),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  controller.deleteMsg(
                                                      controller
                                                              .notificationList[
                                                          index],
                                                      index);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    background: slideRightBackground(index),
                                    secondaryBackground:
                                        slideLeftBackground(index),
                                    confirmDismiss: (direction) async {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        final bool res = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Text(
                                                    "Are you sure you want to delete?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      //setState(() {
                                                      controller
                                                          .notificationList
                                                          .removeAt(index);
                                                      //});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                        return res;
                                      } else {
                                        controller.readMsg(
                                            controller.notificationList[index],
                                            index);
                                        //setState(() {
                                        controller.notificationList
                                            .removeAt(index);
                                        // });
                                      }
                                      return null;
                                    },
                                  );
                                },
                                itemCount: controller.notificationList.length,
                              )),
                        ))),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _loadData() {
    controller.retrieveMsgs();
  }
}
