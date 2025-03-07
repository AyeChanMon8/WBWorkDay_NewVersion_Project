import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:url_launcher/url_launcher.dart';
import '../constants/globals.dart';
import '../controllers/announcements_controller.dart';
import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/pdf_view.dart';

import 'leave_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnnouncementsDetails extends StatelessWidget {
  final AnnouncementsController controller = Get.put(AnnouncementsController());
  final box = GetStorage();
  late int index;
  late String image;
  late List<String> announcement;
  late String announcementText;
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
      final file = new File('${path.path}/'+ DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes, flush: true);
      return file.path;
    }
  }

  // Widget pdfView(String pathPDF) {
  //   print("pdfView");
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Document"),
  //       actions: <Widget>[
  //         IconButton(
  //           icon: Icon(Icons.share),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //     body: SfPdfViewer.network(pathPDF.toString()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    index = Get.arguments;
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    if (controller.announcementList.value[index].announcement
        .contains("src=\"/web/image/")) {
      announcement = controller.announcementList.value[index].announcement
          .split('src=\"/web/image/');
      announcementText = announcement[0] +
          'src=\"' +
          Globals.baseURL.split('/api')[0] +
          '/web/image/' +
          announcement[1];
    } else {
      announcementText = controller.announcementList.value[index].announcement;
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, "Announcements Details", image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  controller.announcementList.value[index].company_id!.name,
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
                  controller.announcementList.value[index].announcement_reason,
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
                child: HtmlWidget(
                  announcementText,

                  // this callback will be triggered when user taps a link
                  onTapUrl: (url) => launchUrl(Uri.parse(url)),
                ),
                // Html(
                //     onLinkTap: (link){
                //       launch(link);
                //     },
                //     data:
                //         announcementText),
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

              SizedBox(
                child: GridView.builder(
                    itemCount: controller
                        .announcementList.value[index].attachment_id!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, fileIndex) {
                      return InkWell(
                        onTap: () async {
                          !controller.announcementList.value[index]
                                  .attachment_id![fileIndex].name
                                  .toString()
                                  .contains('pdf')
                              ? await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ImageDialog(
                                      bytes: base64Decode(controller
                                          .announcementList
                                          .value[index]
                                          .attachment_id![fileIndex]
                                          .datas),
                                    );
                                  })
                              : _createFileFromString(controller
                                      .announcementList
                                      .value[index]
                                      .attachment_id![fileIndex]
                                      .datas
                                      .toString())
                                  .then((path) async {
                                  print("FilePath");
                                  // await requestManageExternalStoragePermission();
                                  await OpenFile.open(path);
                                  print(path.toString());
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => FullPdfViewerScreen(path)),
                                  // );
                                  // Get.to(PdfView(path,controller.announcementList.value[index].attachment_id[fileIndex].name));
                                });
                        },
                        // child: controller.announcementList.value[index].attachment_id[fileIndex].name.contains('pdf')?
                        // FlatButton(
                        //   child:  Text(controller.announcementList.value[index].attachment_id[fileIndex].name.toString()),
                        //   onPressed: () {/* ... */},
                        // ): Image.memory(base64Decode(controller.announcementList.value[index].attachment_id[fileIndex].datas), width: 50, height: 50),
                        // child:  new Card(
                        //     child:Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Text(controller.announcementList.value[index].attachment_id[fileIndex].name.toString()),
                        // )),
                        // child:new Card(
                        //   child: Container(
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       children: [
                        //         Expanded(child: AutoSizeText(controller.announcementList.value[index].attachment_id[fileIndex].name.toString())),
                        //         SizedBox(height: 10,),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.all(10),
                            child: AutoSizeText(
                              controller.announcementList.value[index]
                                  .attachment_id![fileIndex].name
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blueGrey,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
              )
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

// class FullPdfViewerScreen extends StatelessWidget {
//   final String pdfPath;

//   FullPdfViewerScreen(this.pdfPath);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Document"),
//         ),
//         body: SfPdfViewer.network(pdfPath));
//   }
// }
