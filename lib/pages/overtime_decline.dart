

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/overtime_request_controller.dart';
import '../controllers/overtime_response_list_controller.dart';
// import '../localization.dart';
import '../models/employee_category.dart';
import '../models/employee_id.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OverTimeDeclinePage extends StatelessWidget {
  final OverTimeResponseListController controller = Get.find();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController remarkController = TextEditingController();
  late int index;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: appbar(context,labels!.decline, '')),
      // appBar: AppBar(
      //   backgroundColor: backgroundIconColor,
      //   title: Text(
      //     labels!.decline,
      //     // ("over_time"),
      //     style: TextStyle(),
      //   ),
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(8.0),
      //     child: Container(
      //       padding: const EdgeInsets.all(2.0),
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           begin: Alignment.topLeft,
      //           end: Alignment.topRight,
      //           colors: [
      //             const Color.fromRGBO(216, 181, 0, 1),
      //             const Color.fromRGBO(231, 235, 235, 1)
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              remarkWidget(context),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              declineButton(context, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget remarkWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
        child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Theme(
              data: new ThemeData(
                primaryColor: Color.fromRGBO(60, 47, 126, 1),
                primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
              ),
              child: TextField(
                maxLines: 5,
                controller: controller.remarkController,
                decoration: InputDecoration(
                  // suffix: Text("Reason"),
                  border: OutlineInputBorder(),
                  hintText: labels?.remark,
                ),
              ),
            )));
  }

  Widget declineButton(BuildContext context, int index) {
    final labels = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
              // width: double.infinity,
              height: 45,
              margin: EdgeInsets.only(left: 20, right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: textFieldTapColor,
                ),
                // color: textFieldTapColor,
                onPressed: () {
                  if(controller.remarkController.text.isNotEmpty)
                  controller.declineOvertime(controller.otDraftList[index].id);
                  else
                    AppUtils.showDialog('Warning!', 'Reason is require.');
                },
                child: Text(
                  labels!.decline,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
        Expanded(
          child: Container(
              // width: double.infinity,
              // decoration: BoxDecoration(
              //     border: Border.all(color: Color.fromRGBO(63, 51, 128, 1))),
              height: 45,
              margin: EdgeInsets.only(left: 10, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                // color: Colors.white,
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  labels.cancel,
                  style: TextStyle(color: Color.fromRGBO(63, 51, 128, 1)),
                ),
              )),
        ),
      ],
    );
  }
}
