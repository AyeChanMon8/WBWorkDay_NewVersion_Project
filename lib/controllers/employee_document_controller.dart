import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/company.dart';
import '../models/department.dart';
import '../models/employee.dart';
import '../models/employee_change_create.dart';
import '../models/employee_document.dart';
import '../models/employee_document_attachment.dart';
import '../models/employee_jobinfo.dart';
import '../models/employee_promotion.dart';
import '../models/leave_balance.dart';
import '../models/leave_report.dart';
import '../models/leave_report_list.dart';
import '../services/employee_service.dart';
import '../services/leave_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/app_utils.dart';

import '../models/employee_document.dart';
import '../services/employee_service.dart';

class EmployeeDocumentController extends GetxController {

  TextEditingController wageTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  EmployeeService? employeeService;
  var docList = <Employee_document>[].obs;
  var attachment_list = <Attachment>[].obs;
  final box = GetStorage();
  var offset = 0.obs;
  var isLoading = false.obs;
  var employee_list = <Employee>[].obs;
  var manager_employee_list = <Employee>[].obs;
  var company_list = <Company_id>[].obs;
  var old_company_list = <Company_id>[].obs;
  var department_list = <Department>[].obs;
  var old_department_list = <Department>[].obs;
  var branch_list = <Branch_id>[].obs;
  var old_branch_list = <Branch_id>[].obs;
  var salary_level_list = <Company>[].obs;
  var jobposition_list = <Company>[].obs;
  var jobgrade_list = <Company>[].obs;
  TextEditingController effectiveDateTextController = TextEditingController();
  TextEditingController typeAheadController = TextEditingController();
  var old_jobgrade = "".obs;
  var old_salary_level = "".obs;
  var old_jobgrade_name = "".obs;
  var old_salary_level_name = "".obs;
  var old_wage = 0.0.obs;
  var selected_emp_type = 'employee';
  var val = 1.obs;
  Rx<Employee_jobinfo> _selectedEmployeeJobInfo = Employee_jobinfo().obs;

  Rx<Employee> _selectedEmployee = Employee().obs;
  Employee get selectedEmployee => _selectedEmployee.value;
  set selectedEmployee(Employee type) => _selectedEmployee.value = type;

  Rx<Employee> _selectedManagerEmployee = Employee().obs;
  Employee get selectedManagerEmployee => _selectedManagerEmployee.value;
  set selectedManagerEmployee(Employee type) => _selectedManagerEmployee.value = type;

  Rx<Company_id> _selectedCompany = Company_id().obs;
  Company_id get selectedCompany => _selectedCompany.value;
  set selectedCompany(Company_id type) => _selectedCompany.value = type;

  Rx<Company_id> _selectedOldCompany = Company_id().obs;
  Company_id get selectedOldCompany => _selectedOldCompany.value;
  set selectedOldCompany(Company_id type) => _selectedOldCompany.value = type;

  Rx<Department> _selectedDepartment = Department().obs;
  Department get selectedDepartment => _selectedDepartment.value;
  set selectedDepartment(Department type) => _selectedDepartment.value = type;

  Rx<Department> _selectedOldDepartment = Department().obs;
  Department get selectedOldDepartment => _selectedOldDepartment.value;
  set selectedOldDepartment(Department type) => _selectedOldDepartment.value = type;

  Rx<Branch_id> _selectedBranch = Branch_id().obs;
  Branch_id get selectedBranch => _selectedBranch.value;
  set selectedBranch(Branch_id type) => _selectedBranch.value = type;

  Rx<Branch_id> _selectedOldBranch = Branch_id().obs;
  Branch_id get selectedOldBranch => _selectedOldBranch.value;
  set selectedOldBranch(Branch_id type) => _selectedOldBranch.value = type;

  Rx<Company> _selectedJobPosition = Company().obs;
  Company get selectedJobPosition => _selectedJobPosition.value;
  set selectedJobPosition(Company type) => _selectedJobPosition.value = type;

  Rx<Company> _selectedJobGrade = Company().obs;
  Company get selectedJobGrade => _selectedJobGrade.value;
  set selectedJobGrade(Company type) => _selectedJobGrade.value = type;

  Rx<Company> _selectedSalaryLevel = Company().obs;
  Company get selectedSalaryLevel => _selectedSalaryLevel.value;
  set selectedSalaryLevel(Company type) => _selectedSalaryLevel.value = type;

  @override
  void onReady() async {
    super.onReady();
    getDocumentList();
  }

  @override
  void onInit() async{
    super.onInit();
    wageTextController = TextEditingController();
    effectiveDateTextController = TextEditingController();
    typeAheadController = TextEditingController();
    noteTextController = TextEditingController();

  }

  @override
  void onClose() {
    super.onClose();
  }
  getDocumentList() async {
    this.employeeService = await EmployeeService().init();
    print('getDocumentList');
    var employee_id = box.read('emp_id');
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService?.getEmployeeDocList(int.tryParse(employee_id)!,offset.toString()).then((data) {
      //docList.value = data;
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   docList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          docList.add(data[i]);
        }
      }else{
        docList.value = data;
      }
      Get.back();
    });
  }
  getAttachementByDocID(int docID) async {
    this.employeeService = await EmployeeService().init();

    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
    await employeeService?.getAttachementByDocID(docID).then((data) {

      attachment_list.value = data;
      print("att#");
      print(attachment_list[0].type);
      Get.back();
    });
  }
}
