

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../controllers/loan_page_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../my_class/theme.dart';
import '../pages/pdf_view.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'leave_detail.dart';

class LoanDetailsPage extends StatelessWidget {
  late int dindex;
  final box = GetStorage();
  late String image;
  final LoanController controller = Get.put(LoanController());
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    dindex = Get.arguments;
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.loanDetails,image)),
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
                  child: Text(
                    controller.loanList[dindex].name!,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.status,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: Text(
                            controller.loanList[dindex].state!,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.employeeName,
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: Text(
                            controller.loanList[dindex].employee_id!.name,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.position,
                          // ("position"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                        () => Container(
                          child: controller.loanList[dindex].job_position!.name !=
                                  null
                              ? Text(
                                  controller.loanList[dindex].job_position!.name,
                                  style: subtitleStyle(),
                                )
                              : Text('-'),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.date,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("payment_start_date"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.loanList[dindex].date!),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller.loanList[dindex].payment_date!),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          labels.loanAmount,
                          // ("loan_amount"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          labels.noOfInstallments,
                          // ("no_of_installments"),
                          style: datalistStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            NumberFormat('#,###').format(double.tryParse(controller.loanList[dindex].loan_amount.toString())),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            controller.loanList[dindex].installment.toString(),
                            style: subtitleStyle(),
                          ),
                        ),
                      ],
                    ),
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
                Container(
                  child: Text(
                    'Attachments',
                    // ("loan_amount"),
                    style: datalistStyle(),
                  ),
                ),
                // Divider(
                //   thickness: 1,
                // ),
                SizedBox(
                  height: 10,
                ),
                controller.loanList.value[dindex].attachment!=null ?
                InkWell(
                  onTap: () async{
                    controller.loanList.value[dindex].attachment_filename!.contains('pdf')?
                    // _createFileFromString(controller.loanList.value[dindex].attachment.toString()).then((path) async{
                    //   await OpenFile.open(path);
                    // //  Get.to(PdfView(path,'Name.pdf'));
                    // }) :
                    _createFileFromString(controller.loanList.value[dindex].attachment.toString()) :
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return ImageDialog(
                            bytes: base64Decode(controller.loanList.value[dindex].attachment!),
                          );
                        }
                    );
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.attach_file),
                            Expanded(
                              child: AutoSizeText(
                                controller.loanList.value[dindex].attachment_filename!=null?controller.loanList.value[dindex].attachment_filename!:'',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blueAccent,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ):new Container(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Text(labels.installments, style: datalistStyle()),
                ),
                SizedBox(
                  height: 20,
                ),
                installmentTitleWidget(context),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                installmentWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget installmentTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              labels!.paymentDate,
              // ("payment_date"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              labels.status,
              // ("status"),
              style: subtitleStyle(),
            ),
          ),
          Container(
            child: Text(
              labels.amount,
              // ("amount"),
              style: subtitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  Widget installmentWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Obx(() => Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.loanList[dindex].loan_lines!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                              AppUtils.changeDateFormat(controller.loanList[dindex].loan_lines![index].date)
                            ),
                        ),
                        Container(
                          child: Text(controller
                              .loanList[dindex].loan_lines![index].state),
                        ),
                        Container(
                          child: Text(NumberFormat('#,###').format(double.tryParse(controller
                  .loanList[dindex].loan_lines![index].amount
                  .toString()))
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
        ));
  }
  Future<void> _createFileFromString(String encodedStr) async {
    //final encodedStr = "put base64 encoded string here";
    if (Platform.isAndroid) {
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   print("request");
      //   await Permission.storage.request();
      // }
      Uint8List bytes = base64.decode(encodedStr);
      final directory = await getExternalStorageDirectory();

        if (directory == null) {
          print('Could not get external storage directory');
          return;
        }

        final downloadFolder = Directory('${directory.path}/Download');
        if (!await downloadFolder.exists()) {
          await downloadFolder.create(recursive: true);
        }
      // String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "${downloadFolder.path}/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes);
      // await requestManageExternalStoragePermission();
      await OpenFile.open(file.path.toString());
    // return file.path.toString();
    } else {
      Uint8List bytes = base64.decode(encodedStr);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes);
      // await requestManageExternalStoragePermission();
      await OpenFile.open(file.path.toString());
    }
    
    // Uint8List bytes = base64.decode(encodedStr);
    // String dir = (await getApplicationDocumentsDirectory()).path;
    // File file = File(
    //     "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    // await file.writeAsBytes(bytes);
    // return file.path.toString();
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
