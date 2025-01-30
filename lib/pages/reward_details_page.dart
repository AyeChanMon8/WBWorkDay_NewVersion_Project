

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/reward_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'leave_detail.dart';

class RewardsDetailsPage extends StatelessWidget {
  int index = 0;
  final RewardController controller = Get.put(RewardController());
  final box = GetStorage();
  Future<String> _createFileFromString(String encodedStr) async {
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

  @override
  Widget build(BuildContext context) {
    index = Get.arguments;
    final labels = AppLocalizations.of(context);
    String user_image = box.read('emp_image');
    print("state#");
    print(controller.rewards[index].state);
    var date = AppUtils.changeDateFormat(controller.rewards[index].date);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels?.rewards, user_image)),
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 5, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                child: Text(
                  controller.rewards[index].code,
                  style: maintitleStyle(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels!.employeeName,
                      // (("employee_name")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.rewards[index].employeeId![0].name,
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.date,
                      // (("date")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      date,
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.description,
                      // (("reward_type")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.rewards[index].description,
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.rewardsDescription,
                      // (("reward_type")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      AppUtils.removeNullString(
                          controller.rewards[index].rewardTypeId!.isEmpty
                              ? ""
                              : controller.rewards[index].rewardTypeId![0].name
                                  .toString()),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.rewardTitle,
                      // (("reward_type")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      AppUtils.removeNullString(controller
                              .rewards[index].rewardTitleId!.isEmpty
                          ? ''
                          : controller.rewards[index].rewardTitleId![0].name),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.carriedForward,
                      // (("carrier_forward")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller
                          .rewards[index].employeeId![0].rewardCarriedForward
                          .toString(),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.thisYear,
                      // (("this_year")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.rewards[index].employeeId![0].rewardThisYear
                          .toString(),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.total,
                      // (("total")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.rewards[index].employeeId![0].rewardTotal
                          .toString(),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.marks,
                      // (("marks")),
                      style: datalistStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.rewards[index].mark.toString(),
                      style: subtitleStyle(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      labels.viewPDF,
                      // (("marks")),
                      style: datalistStyle(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.downloadReward(controller.rewards[index]);
                    },
                    child: Container(
                      child: Icon(
                        Icons.note_rounded,
                        size: 25,
                        color: Color.fromRGBO(60, 47, 126, 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            controller.rewards[index].warningAttachId!.length > 0
                ? Column(
                    children: [
                      for (var data
                          in controller.rewards[index].warningAttachId!)
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  '${data.attached_filename}',
                                  style: datalistStyle(),
                                ),
                              ),
                              data.attached_filename.contains('pdf')
                                  ? InkWell(
                                      onTap: () async {
                                        _createFileFromString(data.attachment)
                                            .then((path) async {
                                          // await requestManageExternalStoragePermission();
                                          await OpenFile.open(path);
                                        });
                                        log('attachment => ${data.attachment}');
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.note_rounded,
                                          size: 25,
                                          color:
                                              Color.fromRGBO(60, 47, 126, 0.5),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (_) {
                                              return ImageDialog(
                                                bytes: base64Decode(
                                                    data.attachment),
                                              );
                                            });
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 25,
                                          color:
                                              Color.fromRGBO(60, 47, 126, 0.5),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                    ],
                  )
                : SizedBox(),
            rewardActionTitleWidget(context),
            SizedBox(
              height: 10,
            ),
            rewardActionWidget(context),
            SizedBox(
              height: 20,
            ),
            controller.rewards[index].state == 'approve'
                ? SizedBox()
                : approveButton(context),
          ],
        ),
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

  Widget approveButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.approveReward(controller.rewards[index].id);
              },
              text: labels?.approve,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: GFButton(
              onPressed: () {
                controller.declinedReward(controller.rewards[index].id);
              },
              type: GFButtonType.outline,
              text: labels?.decline,
              textColor: textFieldTapColor,
              blockButton: true,
              size: GFSize.LARGE,
              color: textFieldTapColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget rewardActionTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              // width: 80,
              child: Text(
                (labels!.employeeName),
                style: subtitleStyle(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              // width: 70,
              child: Text(
                (labels.marks),
                style: subtitleStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rewardActionWidget(BuildContext context) {
    //List<TextEditingController> _controllers = new List();
    int fields;
    List<TextEditingController> remark_controllers;
    List<TextEditingController> total_amount_controllers;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.rewards[index].rewardActionId!.length,
        itemBuilder: (BuildContext context, int pos) {
          var name = AppUtils.removeNullString(controller
              .rewards[index].rewardActionId![pos].employee!.name
              .toString());
          var mark = AppUtils.removeNullString(
              controller.rewards[index].rewardActionId![pos].mark.toString());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: 80,
                        child: Text(name),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 80,
                        child: Text(mark),
                      ),
                    ),
                  ],
                ),
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
            ],
          );
        },
      ),
    );
  }
}
