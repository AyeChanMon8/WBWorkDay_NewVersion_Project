

//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/leave_report_controller.dart';
// import '../localization.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LeaveTripReport extends StatelessWidget{
  final box = GetStorage();
  String image = '';
  final LeaveTripReportController controller = Get.put(
    LeaveTripReportController(),
  );
  Widget leaveTableTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: [
          Divider(
            thickness: 1,
          ),
          Container(
            child: Container(
              margin: EdgeInsets.only(left:10,right:10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(labels!.employeeName,style: labelPrimaryHightlightTextStyle()),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(labels!.leaveType,style: labelPrimaryHightlightTextStyle(),)),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.entitle,style: labelPrimaryHightlightTextStyle())),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.taken,style: labelPrimaryHightlightTextStyle())),
                  ),

                  Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(labels.balance,style: labelPrimaryHightlightTextStyle())),
                  ),
                ],
              ),
            ),
          ),

          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget leaveTableWidget(BuildContext context) {
    return Obx(()=>

        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.leave_report_list.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        child: Row(

                          children: [
                            Expanded(
                              child: Container(
                                child: Text(controller.leave_report_list.value[index].employee_name,style:labelPrimaryHightlightTextStyle() ,),
                              ),
                              flex: 1,
                            ),
                            Expanded(child: leavedWidget(context,index),flex: 3,),
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
                  ],
                ),
              );
            },
          ),
        ),
    );

  }


  Widget leavedWidget(BuildContext context,int index) {
    final labels = AppLocalizations.of(context);

    return Obx(()=>
        Container(

          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.leave_report_list.value[index].balance_list!.length,
            itemBuilder: (BuildContext context, int position) {
              return Container(
                padding: EdgeInsets.only(top:10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(controller.leave_report_list.value[index].balance_list![position].name.toString(),style: textfieldStyle(),),),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('${controller.leave_report_list.value[index].balance_list![position].entitle.toStringAsFixed(1)}')),),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(controller.leave_report_list.value[index].balance_list![position].taken.toString())),),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(controller.leave_report_list.value[index].balance_list![position].balance.toStringAsFixed(1)))),

                    ]),
              );
            },
          ),
        ),
    );

  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    return Scaffold(
      appBar: AppBar(
        title: Text(labels!.leaveReport,style: appbarTextStyle(),),
        backgroundColor: backgroundIconColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              hintText: (labels?.search),
                            ),
                            onChanged: (text) {
                             var leaveReport = controller.leaveReportList;
                             controller.leave_report_list.value = leaveReport.toList().where((element) => element.employee_name.contains(text)).toList();

                            },
                          ),
                        )),
                  ),
                  /*Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            labels?.sortBy,
                            style: maintitleStyle(),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Icon(Icons.sort)),
                      ],
                    ),
                  )*/
                ],
              ),
              SizedBox(
                height: 20,
              ),
              leaveTableTitleWidget(context),

              leaveTableWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
