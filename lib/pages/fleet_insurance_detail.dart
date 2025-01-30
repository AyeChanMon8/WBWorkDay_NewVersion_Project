

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/fleet_insurance.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/pdf_view.dart';
import '../utils/app_utils.dart';
class FleetInsuranceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Fleet_insurance fleet_insurance = Get.arguments;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, 'Insurance Detail', '')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText('Valid Date : ${AppUtils.formatter.format(DateTime.parse(fleet_insurance.startDate))} - ${AppUtils.formatter.format(DateTime.parse(fleet_insurance.endDate))}',style: TextStyle(fontSize: 20,color: Color.fromRGBO(88, 98, 134, 1)),),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Name : ${fleet_insurance.vehicleId.name}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Type : ${fleet_insurance.insuranceTypeId.name}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Insurance Company : ${fleet_insurance.insuranceCompany}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Contact Person : ${fleet_insurance.contactPerson}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('Contact Phone : ${fleet_insurance.contactPhone}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),
              AutoSizeText('By : ${fleet_insurance.by}',style: TextStyle(fontSize: 18,color: Color.fromRGBO(88, 98, 134, 1))),
              SizedBox(height: 10,),

              GridView.builder(
                // padding: EdgeInsets.all(10),
                  itemCount: fleet_insurance.attachmentId.length,
                  shrinkWrap: true,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisSpacing: 0.9,
                    mainAxisSpacing: 0.5,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int fileIndex) {
                    return InkWell(
                      onTap: () async {
                        File? file = await _createFileFromString(fleet_insurance.attachmentId[fileIndex].datas,fleet_insurance.attachmentId[fileIndex].name,fleet_insurance.attachmentId[fileIndex].mimetype);
                        if (AppUtils.isImage(file!.path)) {
                          Get.dialog(Stack(
                            children: [
                              Center(child: Image.file(file)),
                              Positioned(right : 0,child: TextButton(onPressed: (){Get.back();}, child: Text('Close',style:TextStyle(color: Colors.white,fontSize: 20) ,)))
                            ],
                          ));
                        } else {
                          // await requestManageExternalStoragePermission();
                          await OpenFile.open(file.path);
                          //Get.to(PdfView(file.path,fleet_insurance.attachmentId[fileIndex].name));
                        }
                      },
                      child: Card(
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
                              fleet_insurance.attachmentId[fileIndex].name,
                              style: datalistStyle(),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
  Future<File?> _createFileFromString(String data,String name,String type) async {
    return AppUtils.createPDF(data, name,type);
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
