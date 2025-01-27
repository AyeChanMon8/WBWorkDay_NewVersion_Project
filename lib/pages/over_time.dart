import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/overtime_request_controller.dart';
// import '../localization.dart';
import '../models/depart_empids.dart';
import '../models/department.dart';
import '../models/employee_category.dart';
import '../models/ot_department.dart';
import '../models/overtime_category.dart';
import '../my_class/my_app_bar.dart';
import '../my_class/my_style.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverTimePage extends StatefulWidget {
  @override
  _StateOverTimePage createState() => _StateOverTimePage();
}

class _StateOverTimePage extends State<OverTimePage> {
  // GlobalKey<ChipsInputState> _chipKey = GlobalKey();
  final OvertimeRequestController controller = Get.put(
    OvertimeRequestController(),
  );
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());
  TextEditingController dateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final formatTime = DateFormat("HH:mm:ss");
  final timeFormat = TimeOfDay.now();
  String dropdownValue = 'Employee Tags';
  final box = GetStorage();
  late String user_image;
  @override
  void initState() {
    print("initState");

    Future.delayed(Duration(seconds: 1), () => clearData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    user_image = box.read('emp_image');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.overtimeRequest,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reasonWidget(context),
              dateTimeDialog('from'),
              dateTimeDialog('to'),
              durationWidget(context),
              // SizedBox(
              //   height: 10,
              // ),
              //employeetags(context),
              // employeeTagDropDown(),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 50,
              //   child: Obx(()=>buildChips(controller.chipValues)),

              // ),
              SizedBox(
                height: 10,
              ),
              OvertimeDropDown(),
              SizedBox(
                height: 10,
              ),
              departmentDropDown(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: Obx(() => buildDeptChips(controller.deptChipValues)),
              ),
              // tagsWidget(context),
              // Container(
              //   margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              //   child: Wrap(
              //     children: [
              //       tagsWidget(context),
              //     ],
              //   ),
              // ),
              Obx(
                () => controller.is_add_request_line.value
                    ? otTitleWidget(context)
                    : new Container(),
              ),
              Divider(
                thickness: 1,
              ),
              Obx(
                () => controller.is_add_request_line.value
                    ? otWidget(context)
                    : new Container(),
              ),
              createButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildChips(RxList<EmployeeCategory> chipValues) {
  //   List<Widget> chips = new List();
  //   for (int i = 0; i < chipValues.length; i++) {
  //     InputChip actionChip = InputChip(

  //       label: Text(chipValues[i].name),
  //       elevation: 4,
  //       pressElevation: 4,
  //       shadowColor: Colors.grey,
  //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //       onPressed: () {

  //       },
  //       onDeleted: () {
  //         controller.removeChip(i);

  //       },

  //     );
  //     chips.add(actionChip);
  //   }
  //   return Container(

  //     margin: EdgeInsets.only(left: 10, right: 10, top: 10),
  //     child: ListView(
  //       // This next line does the trick.
  //       scrollDirection: Axis.horizontal,
  //       children: chips,
  //     ),
  //   );
  // }

  Widget buildDeptChips(RxList<OTDepartment> chipValues) {
    List<Widget> chips = [];
    for (int i = 0; i < chipValues.length; i++) {
      InputChip actionChip = InputChip(
        label: Text(chipValues[i].name),
        elevation: 4,
        pressElevation: 4,
        shadowColor: Colors.grey,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {},
        onDeleted: () {
          controller.removeDeptChip(i);
        },
      );
      chips.add(actionChip);
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: chips,
      ),
    );
  }

  Widget dateTimeDialog(String state) {
    final labels = AppLocalizations.of(context);
    final format = DateFormat("yyyy-MM-dd hh:mm aa");
    var date_controller;
    var hintText = "";
    if (state == 'from') {
      hintText = labels!.startdatetime;
      date_controller = controller.fromDateTimeTextController;
    } else {
      hintText = labels!.enddatetime;
      date_controller = controller.toDateTimeTextController;
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(children: <Widget>[
        // Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
          controller: date_controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2200));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );

              var date_time =
                  DateTimeField.combine(date, time).toString().split('.000')[0];

              if (state == 'from') {
                controller.fromDateTimeTextController.text =
                    date_time.toString();
                controller.selectedFromDate = DateTime.parse(date_time);
              } else {
                controller.toDateTimeTextController.text = date_time.toString();
                controller.selectedEndDate = DateTime.parse(date_time);
                controller.enableDropdown.value = true;
              }
              controller.calculateinterval(
                  controller.selectedFromDate, controller.selectedEndDate);

              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ]),
    );
  }

  Widget durationWidget(BuildContext context) {
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
                controller: controller.durationController,
                decoration: InputDecoration(
                  // suffix: Text("Duration"),
                  border: OutlineInputBorder(),
                  hintText: labels?.duration,
                ),
              ),
            )));
  }

  Widget reasonWidget(BuildContext context) {
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
                controller: controller.reasonTextController,
                decoration: InputDecoration(
                  // suffix: Text("Reason"),
                  border: OutlineInputBorder(),
                  hintText: labels?.overtimeReason,
                ),
              ),
            )));
  }

  // Widget tagsWidget(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20, bottom: 20),
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       physics: FixedExtentScrollPhysics(),
  //       shrinkWrap: true,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index) {
  //         return FilterChip(
  //           label: Text('Marketing'),
  //           // labelStyle: TextStyle(
  //           //     color: widget.isSelected ? Colors.black : Colors.white),
  //           // selected: widget.isSelected,
  //           onSelected: (bool selected) {
  //             // setState(() {
  //             //   widget.isSelected = !widget.isSelected;
  //             // });
  //           },
  //           selectedColor: Theme.of(context).accentColor,
  //           checkmarkColor: Colors.black,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget otTitleWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 15, right: 20, top: 50),
      child: Container(
        child: Text(
          (labels!.name),
          style: maintitleStyle(),
        ),
      ),
    );
  }

  Widget OvertimeDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<OvertimeCategory>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.category,
                              )),
                          value: controller.selectedOvertimeCategory,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: controller.enableDropdown.value
                              ? (OvertimeCategory? value) {
                                  controller.onChangeCategoryDropdown(value!);
                                }
                              : null,
                          // hint: Text('Department'),
                          items: controller.category_list
                              .map((OvertimeCategory overtime) {
                            return DropdownMenuItem<OvertimeCategory>(
                              value: overtime,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  overtime.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget departmentDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(1),
                  ),
                ),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(60, 47, 126, 1),
                    primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
                  ),
                  child: Obx(
                    () => DropdownButtonHideUnderline(
                      child: DropdownButton<OTDepartment>(
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.department,
                              )),
                          value: controller.selectedDepartment,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: controller.enableDropdown.value
                              ? (OTDepartment? value) {
                                  setState(() {
                                    controller
                                        .onChangeDepartmentDropdown(value!);
                                  });
                                }
                              : null,
                          // hint: Text('Department'),
                          items: controller.department_list
                              .map((OTDepartment department) {
                            return DropdownMenuItem<OTDepartment>(
                              value: department,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  department.name,
                                  style: TextStyle(),
                                ),
                              ),
                            );
                          }).toList()),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget employeeTagDropDown() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 10, right: 10),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.grey[350], width: 2),
  //                 borderRadius: const BorderRadius.all(
  //                   const Radius.circular(1),
  //                 ),
  //               ),
  //               child: Theme(
  //                 data: new ThemeData(
  //                   primaryColor: Color.fromRGBO(60, 47, 126, 1),
  //                   primaryColorDark: Color.fromRGBO(60, 47, 126, 1),
  //                 ),
  //                 child: Obx(
  //                   () => DropdownButtonHideUnderline(
  //                     child: DropdownButton<EmployeeCategory>(

  //                         value: controller.selectedEmployeeTag,
  //                         icon: Icon(Icons.keyboard_arrow_down),
  //                         iconSize: 30,
  //                         isExpanded: true,
  //                         onChanged: (EmployeeCategory value) {
  //                           controller.onChangeEmployeeTagDropdown(value);
  //                         },
  //                         hint: Text('Employee Tag'),
  //                         items: controller.employee_tag_list
  //                             .map((EmployeeCategory emptag) {
  //                           return DropdownMenuItem<EmployeeCategory>(
  //                             value: emptag,
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(left: 10),
  //                               child: Text(
  //                                 emptag.name,
  //                                 style: TextStyle(),
  //                               ),
  //                             ),
  //                           );
  //                         }).toList()),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget otWidget(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.requestLineList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              controller.requestLineList.value[index].emp_name,
                              style: maintitleStyle(),
                            ),
                            controller.requestLineList.value[index].email ==
                                    null
                                ? SizedBox()
                                : Text(controller
                                    .requestLineList.value[index].email),
                          ],
                        ),
                      ),
                      // GFCheckbox(
                      //   size: GFSize.SMALL,
                      //   onChanged: (value) {
                      //     // setState(() {
                      //     //   isChecked = value;
                      //     // });
                      //   },
                      //   value: true,
                      //   inactiveIcon: null,
                      // ),

                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 30.0,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.deleteEmpRow(index);
                        },
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
      ),
    );
  }

  Widget createButton(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.only(left: 40, right: 40, top: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)) ,
          backgroundColor: Color.fromRGBO(60, 47, 126, 1),
        ),
        // color: Color.fromRGBO(60, 47, 126, 1),
        onPressed: () {
          controller.createOverTime();
        },
        child: Text(
          (labels!.save),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  clearData() {
    controller.fromDateTimeTextController.text = "";
    controller.toDateTimeTextController.text = "";
    controller.durationController.text = "";
    controller.reasonTextController.text = "";
    controller.requestLineList.clear();
    controller.selectedDeptChip.clear();
    controller.deptChipValues.clear();
    controller.dept_ids.clear();
  }
}

class AppProfile {
  final String tags;

  const AppProfile(this.tags);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          tags == other.tags;

  @override
  int get hashCode => tags.hashCode;

  @override
  String toString() {
    return tags;
  }
}
