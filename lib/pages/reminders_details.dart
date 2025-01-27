

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/globals.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/reminder_noti_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'leave_detail.dart';

class RemindersDetails extends StatelessWidget {
  final ReindersNotiController controller = Get.put(ReindersNotiController());
  final box = GetStorage();
  late int index;
  late String image;
  late List<String> reminder;
  late String reminderText;
  Future<String> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
  }
  Widget pdfView(String pathPDF){
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
        body: SfPdfViewer.network(pathPDF.toString()),);
  }
  @override
  Widget build(BuildContext context) {
    index = Get.arguments;
    var showAttachment = false;
    var showDescription = false;
    final labels = AppLocalizations.of(context);
    final now = DateTime.now();
    image = box.read('emp_image');
    print(controller.reminderList.value[index].name);
    if((controller.reminderList.value[index].lastReminder!=null && controller.reminderList.value[index].lastReminder)){
      showAttachment = true;
      showDescription = true;
    }
    print("ShowAttachment >>"+showAttachment.toString());
    // if(controller.reminderList.value[index].description.contains("src=\"/web/image/")){
    //   reminder = controller.reminderList.value[index].description.split('src=\"/web/image/');
    //   reminderText = reminder[0]+'src=\"'+Globals.baseURL.split('/api')[0]+'/web/image/'+reminder[1];
    // }else{
    //   reminderText = controller.reminderList.value[index].description;
    // }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, "Reminders Details", image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.reminderList.value[index].contents,style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 15,),
              showDescription ?
              (controller.reminderList.value[index].description != null && controller.reminderList.value[index].description != false ? Text(controller.reminderList.value[index].description): SizedBox()):SizedBox(),
              showDescription ? SizedBox(height: 20): SizedBox(),
              
              showAttachment ? SizedBox(
                child: GridView.builder(
                    itemCount: controller.reminderList.value[index].attachment_ids!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context,fileIndex) {

                      return InkWell(
                        onTap: () async{
                          !controller.reminderList.value[index].attachment_ids![fileIndex].name.toString().contains('pdf')?
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return ImageDialog(
                                  bytes: base64Decode(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file),
                                );
                              }
                          ):
                          _createFileFromString(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file.toString()).then((path) async{
                            print("FilePath");
                            await requestManageExternalStoragePermission();
                            await OpenFile.open(path);
                             print(path.toString());
                          });
                        },child: Card(
                          elevation: 10,
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.all(10),
                            child: !controller.reminderList.value[index].attachment_ids![fileIndex].name.toString().contains('pdf')? 
                            
                            Image.memory(base64Decode(controller.reminderList.value[index].attachment_ids![fileIndex].attach_file)):AutoSizeText(
                              controller.reminderList.value[index].attachment_ids![fileIndex].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blueGrey,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }
                       ),
              ): SizedBox()
            ],
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

}
class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        body: SfPdfViewer.network(pdfPath));
  }
}