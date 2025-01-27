

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/approval_controller.dart';
import '../localization.dart';
import '../models/announcement.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';

import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnnouncementApprovalDetails extends StatelessWidget {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  Announcement announcement = Announcement();
  String image = '';
  @override
  Widget build(BuildContext context) {
    announcement = Get.arguments;
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    print("announcement.attachment_id ${announcement!.attachment_id!.length}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.announcements, image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  announcement.name,
                  style: maintitleStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  announcement.company_id!.name,
                  style: maintitleStyle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  announcement.announcement_reason,
                  // "Announcments",
                  style: maintitleStyle(),
                ),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Dear " +
                          controller
                              .announcementList.value[index].announcement_type
                              .toString(),
                      style: subtitleStyle(),
                    ),
                  ),
                  Container(
                    child: Text(
                      controller.announcementList.value[index].date_start +
                          " - " +
                          controller.announcementList.value[index].date_end,
                      style: subtitleStyle(),
                    ),
                  ),
                ],
              ),*/
              SizedBox(
                height: 20,
              ),
              Container(
                child: Html(data: announcement.announcement),
              ),
              /*SizedBox(
                        // paddingOnly(left: 30),
                        height: 60,
                        child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: controller.announcementList.value[index].attachment_id.length,
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int fileIndex) {
                              return GFButton(
                                  onPressed: () {
                                    controller.getFile(index, fileIndex);
                                  },
                                  shape: GFButtonShape.pills,
                                  icon: Icon(
                                    Icons.download_sharp,
                                    color: Colors.white,
                                  ),
                                  text: controller.announcementList.value[index].attachment_id[fileIndex].name);
                            }),
                      ),*/

              announcement.attachment_id == null
                  ? Container()
                  : SizedBox(
                      child: GridView.builder(
                          itemCount: announcement.attachment_id!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 1,
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, fileIndex) => InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                            bytes: base64Decode(announcement
                                                .attachment_id![fileIndex]
                                                .datas),
                                          ));
                                },
                                child: announcement.attachment_id![fileIndex]
                                                .datas ==
                                            null ||
                                        announcement.attachment_id![fileIndex]
                                                .datas ==
                                            "null"
                                    ? SizedBox()
                                    : announcement.attachment_id![fileIndex].name.contains("pdf")?

                                      InkWell(onTap:(){
                                        _createFileFromString(announcement.attachment_id![fileIndex].datas.toString()).then((path) async{
                                          await requestManageExternalStoragePermission();
                                          await OpenFile.open(path);
                                          print(path.toString());
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => FullPdfViewerScreen(path)),
                                          // );
                                          // Get.to(PdfView(path,controller.announcementList.value[index].attachment_id[fileIndex].name));
                                        });
                                      },child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(announcement.attachment_id![fileIndex].name),
                                      )))
                                    : Card(
                                      child: Image.memory(
                                          base64Decode(announcement
                                              .attachment_id![fileIndex].datas),
                                          width: 50,
                                          height: 50),
                                    ),
                              )),
                    ),
              announcement.state == 'to_approve'
                  ? Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                              onPressed: () {
                                controller.approveAnnouncement(announcement.id);
                              },
                              text: labels?.approve,
                              blockButton: true,
                              size: GFSize.LARGE,
                              color: textFieldTapColor,
                            ),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFButton(
                            onPressed: () {
                              controller.rejectAnnouncement(
                                  announcement.id);
                            },
                            type: GFButtonType.outline,
                            text: 'Reject',
                            textColor: textFieldTapColor,
                            blockButton: true,
                            size: GFSize.LARGE,
                            color: textFieldTapColor,
                          ),
                        ),
                      )
                    ],
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
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
}
