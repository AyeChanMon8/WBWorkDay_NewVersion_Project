

import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import '../controllers/documentation_controller.dart';
// import '../localization.dart';
import '../models/document.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

import 'pdf_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Documentation extends StatefulWidget {
  @override
  _DocumentationState createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation> {
  final DoucmentController controller = Get.put(DoucmentController());

  final box = GetStorage();

  String image = '';

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.documents, image)),
      body: Container(
        child: Obx(
              () => SizedBox(
            // paddingOnly(left: 30),
            child:ListView.builder(
                itemCount: controller.docList.length,
                itemBuilder: (context,index){
                  return  Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: Colors.grey,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.DOCUMENT_LIST,arguments: index);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        controller.docList[index].name,
                                        // "all_requests",
                                        style: listTileStyle(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Obx(
                                              () => Container(
                                            // padding: EdgeInsets.only(),
                                            child: Text(
                                              controller.docList[index].documentList.length.toString(),
                                              // "2",
                                              style: countLabelStyle(),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                )),
                                          ),
                                        ),
                                        arrowforwardIcon,
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )

                    ],
                  );
            }),
          ),

        ),

      )
    );
  }
  Widget documentListView(List<Documents> documentList){
    return ListView.builder(
      itemCount: documentList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Icon(
                  FontAwesomeIcons.file,
                  size: 50,
                ),
              ),
              // SizedBox(
              //   height: 30,
              // ),
              Text(
                documentList[index].documentName,
                style: datalistStyle(),
              )
            ],
          ),
        );
      },
    );
  }
}

