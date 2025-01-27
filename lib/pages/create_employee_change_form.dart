

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '../controllers/employee_change_controller.dart';
import '../models/company.dart';
import '../models/department.dart';
import '../models/emp_job.dart';
import '../models/employee.dart';
import '../models/employee_promotion.dart';
import '../models/leave_type.dart';
import '../my_class/my_style.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_utils.dart';
import '../models/employee_promotion.dart';
// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class EmployeeChangeCreateForm extends StatefulWidget {
  @override
  _StateEmployeeChangeCreateForm createState() => _StateEmployeeChangeCreateForm();
}

class _StateEmployeeChangeCreateForm extends State<EmployeeChangeCreateForm> {
  final EmployeeChangeController controller = Get.put(EmployeeChangeController());

  int _value = 1;
  File? imageFile;
  bool keyboardOpen = false;
  String starttime = '';
  String endtime = '';
  late DateTime starttimeDate;
  late DateTime endtimeDate;
  String duration = '';
  final picker = ImagePicker();
  String img64 = '';
  late Uint8List bytes;
  late DateTime fromData;
  File? image;
  int index = 0;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKeyParent = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  var date = new DateFormat.yMd().add_jm().format(new DateTime.now());
  final box = GetStorage();
  String user_image = '';
  LeaveType leaves = LeaveType();
  bool checkLeave = false; //true
  String idData = '';
  // int val = 1;
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 1), () => clearData());
    super.initState();
  }
  Widget employeeDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
              child: DropdownButton<Emp_job>(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  hint: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        labels!.employeeName,
                      )),
                  value: controller.selectedEmployee,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30,
                  isExpanded: true,
                  onChanged: (Emp_job? value) {
                    controller.onChangeEmployeeDropdown(value!);
                  },
                  items:
                  controller.employee_list.map((Emp_job emp) {
                    return DropdownMenuItem<Emp_job>(
                      value: emp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          emp.name,
                          style: TextStyle(),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
  Widget employeeApprovedManagerDropDown() {
    final labels = AppLocalizations.of(context);
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
              child: DropdownButton<Emp_job>(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                  ),
                  hint: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        labels!.employeeName,
                      )),
                  value: controller.selectedManagerEmployee,
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 30,
                  isExpanded: true,
                  onChanged: (Emp_job? value) {
                    controller.selected_emp_type = labels.manager;
                    controller.onChangeManagerDropdown(value!);
                  },
                  items:
                  controller.manager_employee_list.map((Emp_job emp) {
                    return DropdownMenuItem<Emp_job>(
                      value: emp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          emp.name,
                          style: TextStyle(),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
  Widget companyDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Company_id>(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.company,
                              )),
                          value: controller.selectedCompany,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Company_id? value) {
                            controller.onChangeCompanyDropdown(value!,labels.new1);
                          },
                          items:
                          controller.company_list.map((Company_id company) {
                            return DropdownMenuItem<Company_id>(
                              value: company,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  company.name,
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
  Widget oldCompanyDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Company_id>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.company,
                              )),
                          value: controller.selectedOldCompany,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Company_id? value) {
                            controller.onChangeCompanyDropdown(value!,labels.old1);
                          },
                          items:
                          controller.old_company_list.map((Company_id company) {
                            return DropdownMenuItem<Company_id>(
                              value: company,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  company.name,
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Department>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                               labels!.department,
                              )),
                          value: controller.selectedDepartment,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Department? value) {
                            controller.onChangeDepartmentDropdown(value!,labels.new1);
                          },
                          items:
                          controller.department_list.map((Department dept) {
                            return DropdownMenuItem<Department>(
                              value: dept,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dept.complete_name!,
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
  Widget oldDepartmentDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Department>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.department,
                              )),
                          value: controller.selectedOldDepartment,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Department? value) {
                            controller.onChangeDepartmentDropdown(value!,labels.old1);
                          },
                          items:
                          controller.old_department_list.map((Department dept) {
                            return DropdownMenuItem<Department>(
                              value: dept,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  dept.name,
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
  Widget branchDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Branch_id>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.branch,
                              )),
                          value: controller.selectedBranch,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Branch_id? value) {
                            controller.onChangeBranchDropdown(value!,labels.new1);
                          },
                          items:
                          controller.branch_list.map((Branch_id branch) {
                            return DropdownMenuItem<Branch_id>(
                              value: branch,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  branch.name,
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
  Widget oldBranchDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Branch_id>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                               labels!.branch,
                              )),
                          value: controller.selectedOldBranch,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Branch_id? value) {
                            controller.onChangeBranchDropdown(value!,labels.old1);
                          },
                          items:
                          controller.old_branch_list.map((Branch_id branch) {
                            return DropdownMenuItem<Branch_id>(
                              value: branch,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  branch.name,
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
  Widget jobPostionDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Company>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.jobPosition,
                              )),
                          value: controller.selectedJobPosition,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Company? value) {
                            controller.onChangeJobPositioneDropdown(value!);
                          },
                          items:
                          controller.jobposition_list.map((Company branch) {
                            return DropdownMenuItem<Company>(
                              value: branch,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  branch.name,
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
  Widget jobGradeDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Company>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),

                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.jobGrade,
                              )),
                          value: controller.selectedJobGrade,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Company? value) {
                            controller.onChangeJobGradeDropdown(value!);
                          },
                          items:
                          controller.jobgrade_list.map((Company branch) {
                            return DropdownMenuItem<Company>(
                              value: branch,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  branch.name,
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
  Widget salaryLevelDropDown() {
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
                  border: Border.all(color: const Color.fromRGBO(214, 214, 214, 1), width: 2),
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
                      child: DropdownButton<Company>(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),
                          hint: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                labels!.salaryLevel,
                              )),
                          value: controller.selectedSalaryLevel,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                          isExpanded: true,
                          onChanged: (Company? value) {
                            controller.onChangeSalaryDropdown(value!);
                          },
                          items:
                          controller.salary_level_list.map((Company branch) {
                            return DropdownMenuItem<Company>(
                              value: branch,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  branch.name,
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
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    index = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          labels!.employeeChangeRequest,
          style: appbarTextStyle(),
        ),
        backgroundColor: backgroundIconColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text("Company",style:datalistStyle()),
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text("New Company",style:datalistStyle()),
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                children: [
              Obx(()=>Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Radio(
                        value: 1,
                        groupValue: controller.val.value,
                        onChanged: (value) {
                          //setState(() {
                          controller.val.value = value!;
                          print("value#");
                          print(value);
                          //});
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  ),),

                  Expanded(
                    flex:2,
                    child: Text(labels.promotion,style: TextStyle(fontSize: 11),),
                  ),
                  Obx(()=>   Expanded(
                    flex:1,
                    child:  Radio(
                      value: 2,
                      groupValue: controller.val.value,
                      onChanged: (value) {
                        //setState(() {
                        controller.val.value = value!;
                        //});
                      },
                      activeColor: Colors.green,
                    ),
                  ),),

                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(labels.demotion,style: TextStyle(fontSize: 11),),
                    ),
                  ),
                  Obx(()=>  Expanded(
                    flex:1,
                    child:  Radio(
                      value: 3,
                      groupValue: controller.val.value,
                      onChanged: (value) {
                        controller.val.value = value!;
                        print("value#");
                        print(value);
                      },
                      activeColor: Colors.green,
                    ),
                  ),),

                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(labels.transfer,style: TextStyle(fontSize: 11),),
                    ),
                  ),
                  Obx(()=> Expanded(
                    flex:1,
                    child:  Radio(
                      value: 4,
                      groupValue: controller.val.value,
                      onChanged: (value) {
                        //setState(() {
                        controller.val.value = value!;
                        print("value#");
                        print(value);
                        //});
                      },
                      activeColor: Colors.green,
                    ),
                  ),),

                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text(labels.salaryChange,style: TextStyle(fontSize: 11),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TypeAheadField(
              //     textFieldConfiguration: TextFieldConfiguration(
              //         controller: controller.typeAheadController,
              //         autofocus: true,
              //         // style: DefaultTextStyle.of(context).style.copyWith(
              //         //     fontStyle: FontStyle.italic
              //         // ),
              //         decoration: InputDecoration(
              //             border: OutlineInputBorder()
              //         )
              //     ),
              //     suggestionsCallback: (pattern) async {
              //       print("suggestionsCallback#");
              //       print(pattern.toString());
              //       var new_pattern = "";
              //       if(pattern.toString().isEmpty){
              //         new_pattern = "";
              //       }else{
              //         print("getCompanyList#");
              //         new_pattern = pattern;
              //         await controller.getCompanyList(new_pattern);
              //       }
              //        return await controller.getCompanyList(new_pattern);
              //     },
              //     itemBuilder: (context, suggestion) {
              //       print("suggestion#");
              //       print(suggestion);
              //       return ListTile(
              //         // leading: Icon(Icons.shopping_cart),
              //         title: Text(suggestion.toString()),
              //         // subtitle: Text('\$${suggestion['price']}'),
              //       );
              //     },
              //     onSuggestionSelected: (suggestion) {
              //       // Navigator.of(context).push(MaterialPageRoute(
              //       //     builder: (context) => ProductPage(product: suggestion)
              //       // ));
              //     },
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.company,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: oldCompanyDropDown(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.branch,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: oldBranchDropDown(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.department,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: oldDepartmentDropDown(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.employeeName,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: employeeDropDown(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.jobPosition,style:datalistStyle()),
                    ),
                  ),
                  Obx(()=> Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppUtils.removeNullString(controller.selectedEmployee.job_name)),
                    ),
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.jobGrade,style:datalistStyle()),
                    ),
                  ),
                  Obx(()=> Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppUtils.removeNullString(controller.old_jobgrade_name.value)),
                    ),
                  ),),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.salaryLevel,style:datalistStyle()),
                    ),
                  ),
                  Obx(()=>  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppUtils.removeNullString(controller.old_salary_level_name.value)),
                    ),
                  ),),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.wage,style:datalistStyle()),
                    ),
                  ),
                  Obx(()=>
                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppUtils.addThousnadSperator(controller.old_wage.value)),
                    ),
                  ),)

                ],
              ),
              SizedBox(height: 10,),

              Divider(
                thickness: 1,
              ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newCompany,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: companyDropDown(),
                  ),
                ],
              ),

               SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newBranch,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: branchDropDown(),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newDepartment,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: departmentDropDown(),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newJobPosition,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: jobPostionDropDown(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newJobGrade,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: jobGradeDropDown(),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newSalaryLevel,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: salaryLevelDropDown(),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              // Divider(
              //   thickness: 1,
              // ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.newWage,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(height: 0.5,fontSize: 14),
                        enabled: false,
                        controller: controller.wageTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ((labels.wage)),
                        ),
                        onChanged: (text) {

                        },
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.effectiveDate,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: textFieldTapColor,
                          ),
                          child: dateWidget(context, labels.effectiveDate),
                        )),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.approvedManager,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: employeeApprovedManagerDropDown(),
                  ),
                ],
              ),
              Row(
                children: [

                  Expanded(
                    flex:1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(labels.note,style:datalistStyle()),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(height: 3,fontSize: 14),
                        controller: controller.noteTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ((labels.typeNote)),
                        ),
                        onChanged: (text) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GFButton(
                  color: textFieldTapColor,
                  onPressed: () {
                      controller.saveEmployeeChanges();
                  },
                  text: labels.save,
                  blockButton: true,
                  size: GFSize.LARGE,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget dateWidget(BuildContext context, String date) {
    var date_controller;
    return Container(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                    _selectDate(context, date);

                },
                child: TextField(
                  textAlign: TextAlign.start,
                  style: TextStyle( height: 0.5,fontSize: 14),
                  enabled: false,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.none,
                  controller: controller.effectiveDateTextController,
                  decoration: InputDecoration(
                    hintText: date,
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
      initialDate:  DateTime.now(),
      firstDate: DateTime(1950),
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
      selectedFromDate = picked;
      controller.effectiveDateTextController.text =
      ("${selectedFromDate.toLocal()}".split(' ')[0]);
      var formatter = new DateFormat('yyyy-MM-dd');
      controller.effectiveDateTextController.text = formatter.format(picked);

    }
  }
}
