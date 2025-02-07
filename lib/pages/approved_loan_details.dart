import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/approval_controller.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../pages/travel_expense_page/travel_expense_detail.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'leave_detail.dart';

class ApprovedLoanDetails extends StatefulWidget {
  @override
  _ApprovedLoanDetailsState createState() => _ApprovedLoanDetailsState();
}

class _ApprovedLoanDetailsState extends State<ApprovedLoanDetails> {
  final ApprovalController controller = Get.put(ApprovalController());
  final box = GetStorage();
  String image = '';
  int index = 0;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    index = Get.arguments;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: appbar(context, labels!.loanDetails, image)),
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
                    controller.loanApprovedList.value[index].name!,
                    style: subtitleStyle(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
                            controller.loanApprovedList[index].state!,
                            style: subtitleStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
                            controller.loanApprovedList.value[index]
                                .employee_id!.name,
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
                          child: controller.loanApprovedList.value[index]
                                      .job_position!.name !=
                                  null
                              ? Text(
                                  controller.loanApprovedList.value[index]
                                      .job_position!.name,
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
                            AppUtils.changeDateFormat(
                                controller.loanApprovedList.value[index].date!),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            AppUtils.changeDateFormat(controller
                                .loanApprovedList.value[index].payment_date!),
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
                          labels.company,
                          // ("date"),
                          style: datalistStyle(),
                        ),
                      ),
                      Container(
                        child: Text(
                          ("Branch"),
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: controller
                                  .loanApprovedList
                                  .value[index]
                                  .company_id!
                                  .name!=null ? Text(
                              AppUtils.removeNullString(controller
                                  .loanApprovedList
                                  .value[index]
                                  .company_id!
                                  .name),
                              style: subtitleStyle(),
                            ):Text('-',
                            style: subtitleStyle(),),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: controller
                                    .loanApprovedList
                                    .value[index]
                                    .branch_id!
                                    .name!=null ? Text(
                                AppUtils.removeNullString(controller
                                    .loanApprovedList
                                    .value[index]
                                    .branch_id!
                                    .name),
                                style: subtitleStyle(),
                              ):Text('-',
                              style: subtitleStyle(),),
                            ),
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
                            NumberFormat('#,###').format(double.tryParse(
                                controller
                                    .loanApprovedList.value[index].loan_amount
                                    .toString())),
                            style: subtitleStyle(),
                          ),
                        ),
                        Container(
                          child: Text(
                            controller.loanApprovedList.value[index].installment
                                .toString(),
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
                    labels.attachment,
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
                controller.loanApprovedList.value[index].attachment != null
                    ? InkWell(
                        onTap: () async {
                          controller.loanApprovedList.value[index]
                                  .attachment_filename!
                                  .contains('pdf')
                              ? 
                              // _createFileFromString(controller
                              //         .loanApprovedList.value[index].attachment
                              //         .toString())
                              //     .then((path) async {
                              //     await OpenFile.open(path);
                              //     //  Get.to(PdfView(path,'Name.pdf'));
                              //   })
                              _createFileFromString(controller
                                      .loanApprovedList.value[index].attachment
                                      .toString())
                              : await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ImageDialog(
                                      bytes: base64Decode(controller
                                          .loanApprovedList
                                          .value[index]
                                          .attachment!),
                                    );
                                  });
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 50,
                            // width: 120,
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.attach_file),
                                  Expanded(
                                    child: AutoSizeText(
                                      controller.loanApprovedList.value[index]
                                                  .attachment_filename !=
                                              null
                                          ? controller.loanApprovedList
                                              .value[index].attachment_filename!
                                          : '',
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
                      )
                    : new Container(),
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
            itemCount:
                controller.loanApprovedList.value[index].loan_lines!.length,
            itemBuilder: (BuildContext context, int pos) {
              return Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(AppUtils.changeDateFormat(controller
                              .loanApprovedList
                              .value[index]
                              .loan_lines![pos]
                              .date)),
                        ),
                        Container(
                          child: Text(controller.loanApprovedList.value[index]
                              .loan_lines![pos].state),
                        ),
                        Container(
                          child: Text(NumberFormat('#,###').format(
                              double.tryParse(controller.loanApprovedList
                                  .value[index].loan_lines![pos].amount
                                  .toString()))),
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

  // Future<String> _createFileFromString(String encodedStr) async {
  //   //final encodedStr = "put base64 encoded string here";
  //   Uint8List bytes = base64.decode(encodedStr);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = File(
  //       "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
  //   await file.writeAsBytes(bytes);
  //   return file.path.toString();
  // }

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
