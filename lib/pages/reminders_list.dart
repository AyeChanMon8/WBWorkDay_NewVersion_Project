import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/announcements_controller.dart';
import 'package:winbrother_hr_app/controllers/reminder_noti_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/pages/announcements_details.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
//  import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'leave_detail.dart';

class RemindersList extends StatefulWidget {
  @override
  _RemindersListState createState() => _RemindersListState();
}

class _RemindersListState extends State<RemindersList> {
  final ReindersNotiController controller = Get.put(ReindersNotiController());

  final box = GetStorage();

  int? index;

  String? image;
  String selectall = "Select All";

  void initData() {
    controller.getRemindersList();
  }

  @override
  void initState() {
    super.initState();
    initData();
    controller.offset.value = 0;
    handleNotification();
  }

  void handleNotification() async {
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

          String message_type = "";
          Map<String, dynamic> dataMap = event.notification.additionalData!;
          if (dataMap != null && dataMap.length > 0) {
            message_type = dataMap["type"];
          }

          if (message_type != null && message_type == "noti") {
            controller.getRemindersList();
            String title = event.notification.title!;
            String body = event.notification.body!;
            Get.snackbar("Notification $title", body);
          }
        } catch (error) {}
      });
      event.complete(event.notification);
    });
  }

  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    if (Platform.isAndroid) {
    final directory = await getExternalStorageDirectory();

        if (directory == null) {
          print('Could not get external storage directory');
          return "";
        }

        final downloadFolder = Directory('${directory.path}/Download');
        if (!await downloadFolder.exists()) {
          await downloadFolder.create(recursive: true);
        }
    // String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "${downloadFolder.path}/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
    }else{
        var path = await getApplicationDocumentsDirectory();
      final file = new File('${path.path}/' + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes, flush: true);
      return file.path.toString();
    }
  }

  Widget pdfView(String pathPDF) {
    print("pdfView");
    return Scaffold(
        appBar: AppBar(
          title: Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        body: SfPdfViewer.network(pathPDF.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, labels?.reminders, image!)),
      body: Stack(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GFButton(
                  onPressed: () {
                    controller.reminderList.forEach((element) {
                      element.selected = true;
                    });
                    setState(() {
                      if (selectall == 'Select All') {
                        selectall = 'Unselect All';
                      } else {
                        selectall = 'Select All';
                        controller.reminderList.forEach((element) {
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
                        index < controller.reminderList.length;
                        index++) {
                      if (controller.reminderList[index].selected)
                        controller.readMsg(
                            controller.reminderList[index], index);
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
                      print(controller.reminderList.length);
                      controller.reminderList.forEach((element) {
                        element.selected = true;
                      });
                      controller.deleteConfirm();
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
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!controller.isLoading.value &&
                                    scrollInfo.metrics.pixels ==
                                        scrollInfo.metrics.maxScrollExtent) {
                                  controller.offset.value += Globals.pag_limit;
                                  controller.isLoading.value = true;
                                  //_loadData();
                                }
                                return false;
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
                                          controller
                                              .reminderList[index].create_date,
                                          true);
                                  dateValue = date.toLocal().toString();

                                  return Dismissible(
                                    key: Key(controller
                                        .reminderList[index].noti_id
                                        .toString()),
                                    child: InkWell(
                                      onLongPress: () {
                                        controller.readMsg(
                                            controller.reminderList[index],
                                            index);
                                      },
                                      onDoubleTap: () {
                                        controller.readMsg(
                                            controller.reminderList[index],
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
                                                                .reminderList[
                                                                    index]
                                                                .selected,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                controller
                                                                        .reminderList[
                                                                            index]
                                                                        .selected =
                                                                    value ??
                                                                        false;
                                                              });
                                                            })),
                                                    controller
                                                            .reminderList[index]
                                                            .has_read
                                                        ? Icon(
                                                            Icons.circle,
                                                            color: Colors
                                                                .transparent,
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Icons.circle,
                                                            color: Color(
                                                                0xff1D84F9),
                                                            size: 30,
                                                          ),
                                                  ],
                                                )),
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
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  (controller
                                                              .reminderList[
                                                                  index]
                                                              .lastReminder &&
                                                          controller
                                                              .reminderList[
                                                                  index]
                                                              .name
                                                              .toLowerCase()
                                                              .contains(
                                                                  'birthday'))
                                                      ? SizedBox()
                                                      : AutoSizeText(
                                                          controller
                                                              .reminderList[
                                                                  index]
                                                              .contents,
                                                          style: controller
                                                                  .reminderList[
                                                                      index]
                                                                  .has_read
                                                              ? TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      900])
                                                              : TextStyle(
                                                                  // fontWeight:
                                                                  // FontWeight.bold,
                                                                  color: Colors
                                                                      .black)),
                                                  (controller
                                                              .reminderList[
                                                                  index]
                                                              .lastReminder &&
                                                          controller
                                                              .reminderList[
                                                                  index]
                                                              .name
                                                              .toLowerCase()
                                                              .contains(
                                                                  'birthday'))
                                                      ? (controller
                                                                      .reminderList
                                                                      .value[
                                                                          index]
                                                                      .description !=
                                                                  null &&
                                                              controller
                                                                      .reminderList
                                                                      .value[
                                                                          index]
                                                                      .description !=
                                                                  false
                                                          ? AutoSizeText(
                                                              controller
                                                                  .reminderList
                                                                  .value[index]
                                                                  .description,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis,
                                                              style: controller
                                                                      .reminderList[
                                                                          index]
                                                                      .has_read
                                                                  ? TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          900])
                                                                  : TextStyle(
                                                                      // fontWeight:
                                                                      // FontWeight.bold,
                                                                      color: Colors
                                                                          .black))
                                                          : SizedBox())
                                                      : SizedBox(),
                                                  (controller
                                                              .reminderList[
                                                                  index]
                                                              .lastReminder &&
                                                          controller
                                                              .reminderList[
                                                                  index]
                                                              .name
                                                              .toLowerCase()
                                                              .contains(
                                                                  'birthday'))
                                                      ? SizedBox(
                                                          child:
                                                              GridView.builder(
                                                                  itemCount: controller
                                                                      .reminderList
                                                                      .value[
                                                                          index]
                                                                      .attachment_ids!
                                                                      .length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  gridDelegate:
                                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                                    childAspectRatio:
                                                                        1,
                                                                    crossAxisSpacing:
                                                                        0.8,
                                                                    mainAxisSpacing:
                                                                        1,
                                                                    crossAxisCount:
                                                                        2,
                                                                  ),
                                                                  itemBuilder:
                                                                      (context,
                                                                          fileIndex) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        !controller.reminderList.value[index].attachment_ids![fileIndex].name.toString().contains('pdf')
                                                                            ? await showDialog(
                                                                                context: context,
                                                                                builder: (_) {
                                                                                  return ImageDialog(
                                                                                    bytes: base64Decode(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file),
                                                                                  );
                                                                                })
                                                                            : _createFileFromString(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file.toString()).then((path) async {
                                                                                print("FilePath");
                                                                                // await requestManageExternalStoragePermission();
                                                                                await OpenFile.open(path);
                                                                                print(path.toString());
                                                                              });
                                                                      },
                                                                      child: !controller
                                                                              .reminderList
                                                                              .value[index]
                                                                              .attachment_ids![fileIndex]
                                                                              .name
                                                                              .toString()
                                                                              .contains('pdf')
                                                                          ? Container(
                                                                              height: 30,
                                                                              width: 30,
                                                                              padding: EdgeInsets.all(10),
                                                                              child: Image.memory(
                                                                                base64Decode(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            )
                                                                          : AutoSizeText(
                                                                              controller.reminderList.value[index].attachment_ids![fileIndex].name.toString(),
                                                                              style: TextStyle(fontWeight: FontWeight.normal, color: Colors.blueGrey, fontSize: 16),
                                                                            ),
                                                                    );
                                                                  }),
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
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
                                                          .reminderList[index],
                                                      index);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                            // SizedBox(width: 3,),
                                            // GestureDetector(
                                            //     onTap: () {
                                            //       Get.toNamed(
                                            //           Routes.REMINDERS_DETAILS,
                                            //           arguments: index);
                                            //     },
                                            //     child: Icon(
                                            //       MaterialCommunityIcons
                                            //           .information,
                                            //       color: Color.fromRGBO(60, 47, 126, 1),
                                            //     )),
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
                                                      controller.reminderList
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
                                            controller.reminderList[index],
                                            index);
                                        //setState(() {
                                        controller.reminderList.removeAt(index);
                                        // });
                                      }
                                      return null;
                                    },
                                  );
                                },
                                itemCount: controller.reminderList.length,
                              )),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> requestManageExternalStoragePermission() async {
    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      var status = await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        print("Permission granted.");
      } else {
        print("Permission denied.");
        // Redirect the user to app settings to enable the permission
        await openAppSettings();
      }
    }
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
                controller.deleteMsg(controller.reminderList[index], index);
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
              width: 10,
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
                controller.readMsg(controller.reminderList[index], index);
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

  void _loadData() {
    controller.getRemindersList();
  }
}
