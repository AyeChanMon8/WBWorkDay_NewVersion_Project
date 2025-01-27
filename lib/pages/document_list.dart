

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/globals.dart';
import '../controllers/approval_controller.dart';
import '../controllers/documentation_controller.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class DocumentList extends StatefulWidget {
  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  final DoucmentController controller = Get.find();
  final box = GetStorage();
  String image = '';
  var arguments_index = 0;
  Future _loadData() async {
    print("****loadmore****");

    // perform fetching data delay
  }

  @override
  void initState() {
    super.initState();
    arguments_index = Get.arguments;

  }

  @override
  Widget build(BuildContext context) {
    var limit = Globals.pag_limit;
    image = box.read('emp_image');
    return Scaffold(
        appBar: AppBar(
            title: Text('Document List', style: appbarTextStyle()),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.back();
                  //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                }),
            actions: <Widget>[],
            automaticallyImplyLeading: true,

        ),
        body: Obx(
              () => NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {

                return true;
              },
              child: GridView.builder(
                 padding: EdgeInsets.only(top:5,right:10),
                  itemCount: controller
                      .docList[arguments_index].documentList.length,
                  shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisSpacing: 0.9,
                    mainAxisSpacing: 0.5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int fileIndex) {
                    return InkWell(
                      onTap: () async {
                        File? file = await controller.getDoc(
                            controller
                                .docList[arguments_index].documentList[fileIndex].documentId,controller
                            .docList[arguments_index].documentList[fileIndex].file_type);
                        if (AppUtils.isImage(file!.path)) {
                          Get.dialog(Stack(
                            children: [
                              Center(child: Image.file(file)),
                              Positioned(right : 0,child: TextButton(onPressed: (){Get.back();}, child: Text('Close',style:TextStyle(color: Colors.white,fontSize: 20) ,)))
                            ],
                          ));
                        } else {
                          await requestManageExternalStoragePermission();
                          await OpenFile.open(file.path);
                          /* Get.to(PdfView(file.path,controller
                      .docList[index].documentList[fileIndex].documentName));*/
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.only(top:10,left:10),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Icon(
                                FontAwesomeIcons.file,
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0,right:8),
                              child: Text(
                                controller
                                    .docList[arguments_index].documentList[fileIndex].documentName,
                                style: subtitleStyle(),
                              ),
                            ),
                            Row(
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(left:10.0),
                                //   child: Text(
                                //     'Type : ',
                                //   ),
                                // ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:10.0),
                                    child: Text("Type - "+AppUtils.removeNullString(controller
                                        .docList[arguments_index].documentList[fileIndex].file_type),
                                      style: datalistStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ),
        ));
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
