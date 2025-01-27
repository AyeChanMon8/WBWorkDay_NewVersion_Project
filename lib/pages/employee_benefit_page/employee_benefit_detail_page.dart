
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import '../../controllers/employee_benefit_controller.dart';
import '../../localization.dart';
import '../../my_class/my_app_bar.dart';
import '../../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmployeeBenefitDetailsPage extends StatelessWidget {
  int dindex = 0;
  final box = GetStorage();
  String image = '';
  final EmployeeBenefitController controller = Get.put(EmployeeBenefitController());
  ScrollController scrollController = ScrollController();
  Future<String> _createFileFromString(String encodedStr,String name) async {
    //final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;File file = File(
      "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path.toString();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    dindex = Get.arguments;
    image = box.read('emp_image');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: appbar(context, labels!.employee_benefit_details,image)),
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
                          'Paid Date',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].date!=null ?Text(
                            controller.employeeBenefitList.value[dindex].date,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Hand Over Date',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].hand_over_date!=null ?Text(
                            controller.employeeBenefitList.value[dindex].hand_over_date,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'On Hand Date',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].onhand_date!=null ?Text(
                            controller.employeeBenefitList.value[dindex].onhand_date,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Company',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].company_id!=null ?Text(
                            controller.employeeBenefitList.value[dindex].company_id.name,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Branch',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].branch_id!=null ?Text(
                            controller.employeeBenefitList.value[dindex].branch_id.name,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Job',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].job_id!=null ?Text(
                            controller.employeeBenefitList.value[dindex].job_id.name,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Benefit',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].benefit_id!=null ?Text(
                            controller.employeeBenefitList.value[dindex].benefit_id.name,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Description',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].description!=null ?Text(
                            controller.employeeBenefitList.value[dindex].description,
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Quantity',
                          // ("employee_name"),
                          style: datalistStyle(),
                        ),
                      ),
                      Obx(
                            () => Container(
                          child: controller.employeeBenefitList.value[dindex].quantity!=null ?Text(
                            controller.employeeBenefitList.value[dindex].quantity.toString(),
                            style: subtitleStyle(),
                          ):Text('-'),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.employeeBenefitList.value[dindex].attachment_ids.length > 0 ?SizedBox(
                child: GridView.builder(
                    itemCount: controller.employeeBenefitList.value[dindex].attachment_ids.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 1,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context,fileIndex) {

                      return InkWell(
                        onTap: () async{
                          !(controller.employeeBenefitList.value[dindex].attachment_ids[fileIndex].name.toString().contains('pdf'))?
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return ImageDialog(
                                  bytes: base64Decode(controller.employeeBenefitList.value[dindex].attachment_ids[fileIndex].datas),
                                );
                              }
                          ):
                          _createFileFromString(controller.employeeBenefitList.value[dindex].attachment_ids[fileIndex].datas.toString(),controller.employeeBenefitList.value[dindex].attachment_ids[fileIndex].name.toString()).then((path) async{
                            print("FilePath");
                            await requestManageExternalStoragePermission();
                            await OpenFile.open(path);
                             print(path.toString());
                          });
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.all(10),
                            child: AutoSizeText(
                              controller.employeeBenefitList.value[dindex].attachment_ids[fileIndex].name.toString(),
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
              ):SizedBox()
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
  }

  class ImageDialog extends StatelessWidget {
  Uint8List bytes;
  ImageDialog({required this.bytes});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PhotoView(
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        imageProvider: Image.memory(
          bytes,
        ).image,
        // decoration: BoxDecoration(
        //     image: DecorationImage(image: bytes, fit: BoxFit.cover)),
      ),
    );
  }
}
