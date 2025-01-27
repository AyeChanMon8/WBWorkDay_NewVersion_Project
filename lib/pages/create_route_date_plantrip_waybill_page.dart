
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/plan_trip_controller.dart';
import '../models/plantrip_waybill.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CreateRouteDatePlanTripWaybill extends StatefulWidget {
  @override
  State<CreateRouteDatePlanTripWaybill> createState() => _CreateRouteDatePlanTripWaybillState();
}

class _CreateRouteDatePlanTripWaybillState extends State<CreateRouteDatePlanTripWaybill> {
  final PlanTripController controller = Get.find();
  late WayBill_Route_plan_ids arguments;
  var box = GetStorage();
  String image = '';
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  @override
  void initState() {
    arguments = Get.arguments;
    controller.routeName = arguments.routeId!.name.toString();
    if(arguments.startActualDate!=null && arguments.startActualDate!=""){
      controller.fromDateTextController.text = arguments.startActualDate;
    }else{
      controller.fromDateTextController = TextEditingController();
    }
    
     if(arguments.endActualDate!=null && arguments.endActualDate!=""){
      controller.toDateTextController.text = arguments.endActualDate;
    }else{
      controller.toDateTextController = TextEditingController();
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    image = box.read('emp_image');
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(8.0),
        child: appbar(context, "Plan Trip WayBill Route Form", image)),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(controller.routeName,style: TextStyle(fontSize : 15,fontWeight: FontWeight.w500))))
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Start Date')),
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: dateWidget(context, 'Start Date'),
                    )),)
                ]
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('End Date')),
              ),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: textFieldTapColor,
                      ),
                      child: dateWidget(context, 'End Date'),
                    )),)
                ]
              ),
              SizedBox(height: 30,),
              GFButton(
                color: textFieldTapColor,
                onPressed: () {
                  controller.saveRouteDate(arguments.id);
                },
                text: "Save",
                blockButton: true,
                size: GFSize.LARGE,
              )
            ]
          )
        )
      )
    );
  }

  Widget dateWidget(BuildContext context, String date) {
    var date_controller;
    var labels = AppLocalizations.of(context);
    var dateLbl = "";

    if (date == 'Start Date') {
      dateLbl = labels!.fromDate;
      date_controller = controller.fromDateTextController;
    } else if (date == 'End Date') {
      dateLbl = labels!.toDate;
      date_controller = controller.toDateTextController;

      // date_controller = controller.toDateTextController;
    }

    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  if (date == 'End Date') {
                    if (controller.fromDateTextController.text.isNotEmpty) {
                      _selectDate(context, date);
                    } else {
                      //showToast('Choose Start Date First!');
                      AppUtils.showToast('Choose Start Date First!');
                    }
                  } else if (date == 'Start Date') {
                    _selectDate(context, date);
                  }
                },
                child: TextField(
                  enabled: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.none,
                  controller: date_controller,
                  decoration: InputDecoration(
                    hintText: dateLbl,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future<Null> _selectDate(BuildContext context, String date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date == 'Start Date' ? (controller.fromDateTextController.text != null && controller.fromDateTextController.text != "" ? DateTime.parse(controller.fromDateTextController.text): DateTime.now()): (controller.toDateTextController.text!=null && controller.toDateTextController.text != ""? DateTime.parse(controller.toDateTextController.text): DateTime.now()),
      firstDate:date == 'Start Date' ? (controller.fromDateTextController.text != null && controller.fromDateTextController.text != "" ? DateTime.parse(controller.fromDateTextController.text): DateTime.now()): (controller.toDateTextController.text!=null && controller.toDateTextController.text != "" ? DateTime.parse(controller.toDateTextController.text): DateTime.now()),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: const Color.fromRGBO(60, 47, 126, 1),
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            highlightColor: Colors.grey[400],
            // textSelectionColor: Colors.grey,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (date == 'Start Date') {
        selectedFromDate = picked;
        controller.fromDateTextController.text =
            ("${selectedFromDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.fromDateTextController.text = formatter.format(picked);
        controller.toDateTextController.text = '';
        } else if (date == 'End Date') {
        selectedToDate = picked;
        controller.toDateTextController.text =
            ("${selectedToDate.toLocal()}".split(' ')[0]);
        var formatter = new DateFormat('yyyy-MM-dd');
        controller.toDateTextController.text = formatter.format(picked);
        controller.calculateinterval(selectedFromDate, selectedToDate);
      }
    }
  }
}