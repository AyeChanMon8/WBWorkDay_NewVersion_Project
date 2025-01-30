

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/approval_controller.dart';
import '../controllers/employee_change_controller.dart';
import '../controllers/employee_document_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
// import '../localization.dart';
import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EmployeeDocumentDetails extends StatefulWidget {
  @override
  _EmployeeDocumentDetailsState createState() => _EmployeeDocumentDetailsState();
}

class _EmployeeDocumentDetailsState extends State<EmployeeDocumentDetails> {
  final EmployeeDocumentController controller = Get.put(EmployeeDocumentController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    controller.getAttachementByDocID(controller.docList[index].id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, "Employee Document Details",image)),
      body: Scrollbar(
        // isAlwaysShown: true,
        controller: scrollController,
        thickness: 5,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Document Number',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: Text(
                            AppUtils.removeNullString(controller.docList.value[index].name),
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Document Type',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: Text(AppUtils.removeNullString(controller.docList.value[index].documentType.name)
                           ,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Issue Date',
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child:  Text(AppUtils.removeNullString(controller.docList.value[index].issueDate)
                           ,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Attachments',
                    // ("employee_name"),
                    style: datalistStyle(),
                  ),
                ),
                Obx(()=> GridView.builder(
                    itemCount: controller.attachment_list.length,
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
                              bytes: base64Decode(controller
                                  .attachment_list[fileIndex].data
                              ),
                            ));
                      },
                      child: controller.attachment_list[fileIndex].type.contains("pdf")?

                      InkWell(onTap:(){
                        _createFileFromString(controller.attachment_list[fileIndex].data.toString()).then((path) async{
                          // await OpenFile.open(path);
                          // await requestManageExternalStoragePermission();
  final result = await OpenFile.open(path);
                          print(path.toString());

                        });
                      },child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(controller.attachment_list[fileIndex].type),
                          )))
                          : Card(
                        child: Image.memory(
                            base64Decode(controller.attachment_list[fileIndex].data),
                            width: 50,
                            height: 50),
                      ),
                    ))),


              ],
            ),
          ),
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
  @override
  void initState() {

    super.initState();
  }
  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    if (Platform.isAndroid) {
    Uint8List bytes = base64.decode(encodedStr);
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
    Uint8List bytes = base64.decode(encodedStr);
    var path = await getApplicationDocumentsDirectory();
      final file = new File('${path?.path}/'+ DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes, flush: true);
      return file.path.toString();
  }
  }
}