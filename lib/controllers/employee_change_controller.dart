import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/company.dart';
import '../models/department.dart';
import '../models/emp_job.dart';
import '../models/employee_change_create.dart';
import '../models/employee_jobinfo.dart';
import '../models/employee_promotion.dart';
import '../services/employee_service.dart';
import '../utils/app_utils.dart';

class EmployeeChangeController extends GetxController {

  TextEditingController wageTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  EmployeeService? employeeService;
  var empChangeList = <Employee_promotion>[].obs;
  final box = GetStorage();
  var offset = 0.obs;
  var isLoading = false.obs;
  var employee_list = <Emp_job>[].obs;
  var manager_employee_list = <Emp_job>[].obs;
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

  Rx<Emp_job> _selectedEmployee = Emp_job().obs;
  Emp_job get selectedEmployee => _selectedEmployee.value;
  set selectedEmployee(Emp_job type) => _selectedEmployee.value = type;

  Rx<Emp_job> _selectedManagerEmployee = Emp_job().obs;
  Emp_job get selectedManagerEmployee => _selectedManagerEmployee.value;
  set selectedManagerEmployee(Emp_job type) => _selectedManagerEmployee.value = type;

  Rx<Company_id> _selectedCompany = Company_id().obs;
  Company_id get selectedCompany => _selectedCompany.value;
  set selectedCompany(Company_id? type) => _selectedCompany.value = type!;

  Rx<Company_id> _selectedOldCompany = Company_id().obs;
  Company_id get selectedOldCompany => _selectedOldCompany.value;
  set selectedOldCompany(Company_id? type) => _selectedOldCompany.value = type!;

  Rx<Department> _selectedDepartment = Department().obs;
  Department get selectedDepartment => _selectedDepartment.value;
  set selectedDepartment(Department? type) => _selectedDepartment.value = type!;

  Rx<Department> _selectedOldDepartment = Department().obs;
  Department get selectedOldDepartment => _selectedOldDepartment.value;
  set selectedOldDepartment(Department? type) => _selectedOldDepartment.value = type!;

  Rx<Branch_id> _selectedBranch = Branch_id().obs;
  Branch_id get selectedBranch => _selectedBranch.value;
  set selectedBranch(Branch_id? type) => _selectedBranch.value = type!;

  Rx<Branch_id> _selectedOldBranch = Branch_id().obs;
  Branch_id get selectedOldBranch => _selectedOldBranch.value;
  set selectedOldBranch(Branch_id? type) => _selectedOldBranch.value = type!;

  Rx<Company> _selectedJobPosition = Company().obs;
  Company get selectedJobPosition => _selectedJobPosition.value;
  set selectedJobPosition(Company? type) => _selectedJobPosition.value = type!;

  Rx<Company> _selectedJobGrade = Company().obs;
  Company get selectedJobGrade => _selectedJobGrade.value;
  set selectedJobGrade(Company? type) => _selectedJobGrade.value = type!;

  Rx<Company> _selectedSalaryLevel = Company().obs;
  Company get selectedSalaryLevel => _selectedSalaryLevel.value;
  set selectedSalaryLevel(Company? type) => _selectedSalaryLevel.value = type!;

  @override
  void onReady() async {
    super.onReady();
     getEmployeeChangeList();
     getCompanyList("");
     getJobList();
     getJobGradeList();

  }

  @override
  void onInit() async{
    super.onInit();
    wageTextController = TextEditingController();
    effectiveDateTextController = TextEditingController();
    typeAheadController = TextEditingController();
    noteTextController = TextEditingController();
    // this.employeeService = await EmployeeService().init();
  }

  @override
  void onClose() {

    super.onClose();
  }

  getEmployeeChangeList() async {
    this.employeeService = await EmployeeService().init();
    print('getEmployeeChangeList');
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
    await employeeService?.getEmployeeChangeList(int.tryParse(employee_id)!,offset.toString()).then((data) {
      //empChangeList.value = data;
      if(offset!=0){
        isLoading.value = false;
        // data.forEach((element) {
        //   empChangeList.add(element);
        // });
        for(var i=0;i<data.length;i++){
          empChangeList.add(data[i]);
        }

      }else{
        empChangeList.value = data;
      }
      Get.back();
    });
  }


  getEmployeeList(int companyID,int branchId,int deptID) async {
    this.employeeService = await EmployeeService().init();
    print('getEmployeeList');
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
    await employeeService?.getAllEmployeeList(companyID,branchId,deptID).then((value) {
      if(value.length!=0){
          selectedEmployee = value[0];
          getEmployeeJobInfo();
      }
      employee_list.value = value;
      Get.back();
    });
  }
  getManagerEmployeeList(int companyID,int branchId,int deptId) async {
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
    await employeeService?.getManagerEmployeeList(companyID,branchId,deptId).then((data) {
      if(data.length!=0){
        this.selectedManagerEmployee = data[0];
      }
      manager_employee_list.value = data;
      Get.back();
    });
  }

  getEmployeeJobInfo() async {
    this.employeeService = await EmployeeService().init();
    print('getEmployeeList');
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
    await employeeService?.getEmployeeJobInfo(this.selectedEmployee.id).then((data) {
      this._selectedEmployeeJobInfo.value = data as Employee_jobinfo;
      this.old_salary_level.value = AppUtils.removeNullString(data.salary_level);
      this.old_jobgrade.value = AppUtils.removeNullString(data.job_grade);
      this.old_salary_level_name.value = AppUtils.removeNullString(data.salary_level_name);
      this.old_jobgrade_name.value = AppUtils.removeNullString(data.job_grade_name);
      this.old_wage.value = data.wage;
      Get.back();
    });
  }
  getDepartmentList(int id) async {
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
    await employeeService?.getDepartmentList(id,"").then((data) {
      // this.selectedDepartment = data[0];
      // this.selectedOldDepartment = data[0];
      this.selectedDepartment = null;
      this.selectedOldDepartment = null;
      department_list.value = data;
      old_department_list.value = data;
      //getEmployeeList(selectedOldCompany.id,selectedOldBranch.id,selectedOldDepartment.id);

      Get.back();
    });
  }
  getNewDepartmentList(int id) async {
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
    await employeeService?.getDepartmentList(id,"").then((data) {
      this.selectedDepartment = data[0];
      department_list.value = data;
      getManagerEmployeeList(this.selectedCompany.id, selectedBranch.id,selectedDepartment.id);
      Get.back();
    });
  }
  getOldDepartmentList(int id) async {
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
    await employeeService?.getAllDepartmentList(id).then((data) {
      if(data.length!=0){
        this.selectedOldDepartment = data[0];
      }
      old_department_list.value = data;
      getEmployeeList(selectedOldCompany.id,selectedOldBranch.id,selectedOldDepartment.id);
      Get.back();
    });
  }
  getJobList() async {
    this.employeeService = await EmployeeService().init();
    //print('getEmployeeChangeList');
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
    await employeeService?.getJobList(int.tryParse(employee_id)!).then((data) {
      if(data.length!=0){
        //this.selectedJobPosition = data[0];
        this.selectedJobPosition = null;
      }
      jobposition_list.value = data;

      Get.back();
    });
  }
  getJobGradeList() async {
    this.employeeService = await EmployeeService().init();
    //print('getEmployeeChangeList');
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

    await employeeService?.getJobGradeList().then((data) {
      if(data.length!=0){
        //this.selectedJobGrade = data[0];
        this.selectedJobGrade = null;
      }
      getSalaryLevelList();
      jobgrade_list.value = data;
      Get.back();
    });
  }
  getNewWage() async {
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

    await employeeService?.getEmployeeNewWage(int.tryParse(this.selectedJobGrade.id.toString())!,int.tryParse(this.selectedSalaryLevel.id.toString())!).then((data) {
      // print("newWage#");
      wageTextController.text = AppUtils.addThousnadSperator(data);
      print(data);
      Get.back();
    });
  }
  Future<List<Company_id>?> getCompanyList(String keyword) async{
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
    await employeeService?.getCompanyList(keyword).then((data) {
      if(data.length!=0){
        //data.insert(0,Company_id(id: 0,name: "Choose"));
        this.selectedCompany = null;
        this.selectedOldCompany = null;
        // this.selectedCompany = data[0];
        // this.selectedOldCompany = data[0];
      }
      company_list.value = data;
      old_company_list.value = data;
      //getBranchList(this.selectedCompany.id);
      Get.back();
    });
  }
  void getOldCompanyList() async{
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
    await employeeService?.getCompanyList("").then((data) {
      if(data.length!=0){
        this.selectedOldCompany = data[0];
      }
      old_company_list.value = data;
      getOldBranchList(this.selectedOldCompany.id);
      Get.back();
    });
  }
  void getOldBranchList(int id) async{
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
    await employeeService?.getBranchList(id,"").then((data) {
      if(data.length!=0){
        this.selectedOldBranch = data[0];
      }
      old_branch_list.value = data;
      getOldDepartmentList(this.selectedOldBranch.id);
      Get.back();
    });
  }

  void getBranchList(int id) async{
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
    await employeeService?.getBranchList(id,"").then((data) {
      if(data.length!=0){
        this.selectedBranch = null;
        this.selectedOldBranch = null;
        // this.selectedBranch = data[0];
        // this.selectedOldBranch = data[0];
        //getManagerEmployeeList(int.tryParse(this.selectedCompany.id.toString()),int.tryParse(this.selectedBranch.id.toString()));
      }
      branch_list.value = data;
      old_branch_list.value = data;
     // getDepartmentList(this.selectedBranch.id);
      Get.back();
    });
  }
  void getNewBranchList(int id) async{
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
    await employeeService?.getBranchList(id,"").then((data) {
      Get.back();
      if(data.length!=0){
        this.selectedBranch = data[0];

      }
      branch_list.value = data;
      // getManagerEmployeeList(this.selectedCompany.id, selectedBranch.id);
      getNewDepartmentList(this.selectedBranch.id);

    });
  }

  void onChangeCompanyDropdown(Company_id value,String status) {
    if(status=="old"){
      this.selectedOldCompany = value;
      update();
      getOldBranchList(this.selectedOldCompany.id);
    }else{
      this.selectedCompany = value;
      update();
      getNewBranchList(this.selectedCompany.id);
    }

  }
  void onChangeBranchDropdown(Branch_id value,String status) {
    if(status=="old"){
      this.selectedOldBranch = value;
      update();
      getOldDepartmentList(value.id);
    }else{
      this.selectedBranch = value;
      update();
      //getManagerEmployeeList(selectedCompany.id, selectedBranch.id);
      getNewDepartmentList(value.id);
    }

  }
  void onChangeDepartmentDropdown(Department value,String status) {
    if(status=="old"){
      this.selectedOldDepartment = value;
      update();
      getEmployeeList(this.selectedOldCompany.id,this.selectedOldBranch.id,this.selectedOldDepartment.id);
    }else{
      this.selectedDepartment = value;
      update();
      getManagerEmployeeList(this.selectedCompany.id,this.selectedBranch.id,this.selectedDepartment.id);
    }

  }
  void onChangeOldCompanyDropdown(Company_id value) {
    this.selectedOldCompany = value;
    update();
    getOldBranchList(this.selectedOldCompany.id);
  }
  void onChangeOldBranchDropdown(Branch_id value) {
    this.selectedOldBranch = value;
    update();
    getOldDepartmentList(this.selectedOldBranch.id);
  }
  void onChangeOldDepartmentDropdown(Department value) {
    this.selectedOldDepartment = value;
    update();
    getEmployeeList(this.selectedOldCompany.id,this.selectedOldBranch.id,this.selectedOldDepartment.id);
  }
  void onChangeSalaryDropdown(Company value) {
    this.selectedSalaryLevel = value;
    update();
    if(this.selectedJobGrade!=null&&this.selectedSalaryLevel!=null){
      getNewWage();
    }
  }
  void onChangeJobGradeDropdown(Company value) {
    this.selectedJobGrade = value;
    update();
    if(this.selectedJobGrade!=null&&this.selectedSalaryLevel!=null){
      getNewWage();
    }

  }
  void onChangeJobPositioneDropdown(Company value) {
    this.selectedJobPosition = value;
    update();
    //getNewWage();
  }
  void onChangeManagerDropdown(Emp_job value) {
    this.selectedManagerEmployee = value;
    update();
    //getNewWage();
  }


  void saveEmployeeChanges() async{
    print("wageTextController");
    print(wageTextController.text.toString());
    var new_wage = wageTextController.text.toString().replaceAll(",", "");
    var type = "promotion";
    if(val==1){
      type = "promotion";
    }
    else if(val==2){
      type = "demotion";
    }else if(val==3){
      type = "transfer";
    }else{
      type = "salary_change";
    }
    Employee_change_create employee_change_create = Employee_change_create(
        type: type,
        employeeId: selectedEmployee.id,
        companyId: selectedOldCompany.id,
        branchId: selectedOldBranch.id,
        departmentId: selectedOldDepartment.id,
        jobId: selectedEmployee.job_id,
        jobGradeId: int.tryParse(old_jobgrade.value)!,
        salaryLevelId: int.tryParse(old_salary_level.value)!,
        wage:_selectedEmployeeJobInfo.value.wage,
        date:effectiveDateTextController.text,
        newCompanyId:selectedCompany.id,
        newBranchId: selectedBranch.id,
        newDepartmentId:selectedDepartment.id,
        newJobId:selectedJobPosition.id ,
        newJobGradeId: selectedJobGrade.id,
        newSalaryLevelId: selectedSalaryLevel.id,
        newWage: double.tryParse(new_wage)!,
        note:noteTextController.text,
        newApprovedManagerId: selectedManagerEmployee.id);
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

        await employeeService?.createEmployeeChange(employee_change_create).then((data) {
         print("created");
          Get.back();
        //  AppUtils.showConfirmDialog('Information', 'Successfully Created!',(){
        //    Get.back();
        //    Get.back();
        //    getEmployeeChangeList();
        //  });

        Get.defaultDialog(title:'Information', content: Text("Successfully Created!"), confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          Get.back();
          getEmployeeChangeList();
        });
        });
  }
  getSalaryLevelList() async {
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

    await employeeService?.getSalaryLevelList().then((data) {
      if(data.length!=0){
        // this.selectedSalaryLevel = data[0];
        this.selectedSalaryLevel = null;
      }
     // getNewWage();
      salary_level_list.value = data;
      Get.back();
    });
  }

  void onChangeEmployeeDropdown(Emp_job value) {
    this.selectedEmployee = value;
    getEmployeeJobInfo();
    update();
  }

  void requestSend(int id, int requestID) async{
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
    await employeeService?.sendRequest(id,requestID).then((data) {
      Get.back();
      // AppUtils.showConfirmDialog('Information', 'Successful Requested!', (){
      //   offset.value = 0;
      //   getEmployeeChangeList();
      //   Get.back();
      //   Get.back(result: true);
      // });

      Get.defaultDialog(title:'Information', content: Text("Successfully Requested!"), confirmTextColor: Colors.white,onConfirm: () async{
        offset.value = 0;
        getEmployeeChangeList();
        Get.back();
        Get.back(result: true);
      });
      //Get.offNamed(Routes.LEAVE_TRIP_TAB_BAR);
    });
  }
}
