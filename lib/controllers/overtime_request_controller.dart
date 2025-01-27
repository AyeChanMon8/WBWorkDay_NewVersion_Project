
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:intl/intl.dart';
import '../controllers/overtime_list_controller.dart';
import '../models/category_id.dart';
import '../models/depart_empids.dart';
import '../models/department.dart';
import '../models/emp_dept_tag.dart';
import '../models/employee.dart';
import '../models/employee_category.dart';
import '../models/employee_id.dart';
import '../models/ot_department.dart';
import '../models/overtime_category.dart';
import '../models/overtime_request.dart';
import '../models/overtime_request_line.dart';
import '../models/request_line.dart';
import '../routes/app_pages.dart';
import '../services/employee_service.dart';
import '../services/master_service.dart';
import '../services/overtime_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OvertimeRequestController extends GetxController {
  OvertimeService? overtimeService;
  MasterService? masterService;
  TextEditingController fromDateTimeTextController = TextEditingController();
  TextEditingController toDateTimeTextController = TextEditingController();
  TextEditingController reasonTextController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  var requestLineList = <OvertimeRequestLine>[].obs;
  var requestLineTempList = <OvertimeRequestLine>[].obs;
  var employeeDeptTagRequestLineList = <EmployeeDeptTag>[].obs;
  var empIdsByDept = <int>[];
  var empIdsByTag = <int>[];
  var empListByDept = <EmployeeID>[];
  var empListByTag = <EmployeeID>[];
  final RxString duration = "".obs;
  final RxBool is_add_request_line = false.obs;
  final box = GetStorage();
  var from_date_time = "";
  var to_date_time = "";
  var category_ids = <CategoryID>[];
  var dept_ids = <OTDepartment>[];
  var otcategory_ids = <OvertimeCategory>[];
  var employee_tag_list = <EmployeeCategory>[].obs;
  var enableDropdown = false.obs;
  int categ_id = 0;
  Rx<EmployeeCategory> _selectedEmployeeTag = EmployeeCategory().obs;
  EmployeeCategory get selectedEmployeeTag => _selectedEmployeeTag.value;
  set selectedEmployeeTag(EmployeeCategory state) =>
      _selectedEmployeeTag.value = state;
  var department_list = <OTDepartment>[].obs;
  var category_list = <OvertimeCategory>[].obs;
  Rx<OTDepartment> _selectedDepartment = OTDepartment().obs;
  OTDepartment get selectedDepartment => _selectedDepartment.value;
  set selectedDepartment(OTDepartment department) =>
      _selectedDepartment.value = department;

  Rx<OvertimeCategory> _selectedOvertimeCategory = OvertimeCategory().obs;
  OvertimeCategory get selectedOvertimeCategory => _selectedOvertimeCategory.value;
  set selectedOvertimeCategory(OvertimeCategory department) =>
      _selectedOvertimeCategory.value = department;
  
  final OverTimeListController _overTimeListController = Get.find();
  // var chipValues = List<EmployeeCategory>().obs;
  // var selectedChip = List<bool>().obs;

  var deptChipValues = <OTDepartment>[].obs;
  var selectedDeptChip = <bool>[].obs;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  @override
  void onInit() {
    fromDateTimeTextController = TextEditingController();
    toDateTimeTextController = TextEditingController();
    reasonTextController = TextEditingController();
    durationController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    this.overtimeService = await OvertimeService().init();
    this.masterService = await MasterService().init();
    // getEmployeeTag();
    getDepartments();
    getOvertimeCategories();
    super.onReady();
  }


  void onChangeDepartmentDropdown(OTDepartment department) async {
    var employee_id = int.tryParse(box.read('emp_id'));
    if (department.name != 'Department') {
      bool dept_found = false;
      var dept = OTDepartment(id: department.id, name: department.name, branch_id: department.branch_id);
      if (dept_ids.length > 0) {
        for (int i = 0; i < dept_ids.length; i++) {
          if (dept_ids[i].id == department.id) {
            dept_found = true;
            break;
          }
        }
        if (!dept_found) {
          dept_ids.add(dept);
        }
      } else {
        dept_ids.add(dept);
      }
      if (!dept_found) {
        Future.delayed(
            Duration.zero,
            () => Get.dialog(
                Center(
                    child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
                barrierDismissible: false));
        await overtimeService?.getEmployeeByDept(department.id, employee_id!)
            .then((data) {
          Get.back();
          for (int i = 0; i < data.length; i++) {
            print(data[i].department_id!.id);
            var from_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedFromDate.toString().split('.')[0]).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
            var to_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedEndDate.toString().split('.')[0]).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];

            requestLineList.add(
              OvertimeRequestLine(
                employee_id: data[i].id,
                duration: double.tryParse(durationController.text)!,
                start_date: from_date,
                end_date: to_date,
                email: data[i].work_email,
                state: 'draft',
                emp_name: data[i].name,
                dept_id: data[i].department_id!.id,
                branch_id: data[i].branch_id!.id
              ),
            );
          }
        });
        is_add_request_line.value = true;
        deptChipValues.add(department);
        selectedDeptChip.add(true);
      }
    }
  }

  void onChangeCategoryDropdown(OvertimeCategory OTCategory) async {
    if(OTCategory.name != 'Overtime Category'){
    this.selectedOvertimeCategory= OTCategory;
    this.categ_id = OTCategory.id;
    update();
    }
    
  }

  clearOtRequestLine() {
    requestLineList.clear();
  }

  // getEmployeeTag() async {
  //   await masterService.getEmployeeCategoryList().then((data) {
  //     data.insert(0, EmployeeCategory(id: 0, name: 'Employee Tag'));

  //     this.selectedEmployeeTag = data[0];
  //     employee_tag_list.value = data;
  //   });
  // }

  getDepartments() async {
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService?.getDepartmentList(employee_id!).then((data) {
      print("deptSize");
      print(data.length);
      data.insert(0, OTDepartment(id: 0, name: 'Department', branch_id: Branch_id(id: 0, name: 'Branch')));
      this.selectedDepartment = data[0];
      department_list.value = data;
    });
  }

  getOvertimeCategories() async{
    var employee_id = int.tryParse(box.read('emp_id'));
    await masterService?.getOvertimeCategoryList(employee_id!).then((data) {
      print("deptSize");
      print(data.length);
      data.insert(0, OvertimeCategory(id: 0, name: 'Overtime Category'));
      this.selectedOvertimeCategory = data[0];
      category_list.value = data;
    });
    
  }

  createOverTime() async {
    var employee_id = int.tryParse(box.read('emp_id'));

    var purpose = reasonTextController.text;
    var duration = double.tryParse(durationController.text);
    var from_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedFromDate.toString().split('.')[0]).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];

    var to_date = DateFormat('yyyy-MM-dd HH:mm').parse(selectedEndDate.toString().split('.')[0]).subtract(Duration(hours: 6,minutes: 30)).toString().split('.')[0];
    if(categ_id == 0){
      categ_id = 0;
    }
    if (from_date.isNotEmpty &&
        to_date.isNotEmpty &&
        durationController.text.isNotEmpty &&
        purpose.isNotEmpty &&
        requestLineList.length != 0 && 
        categ_id != 0 && categ_id!= null) {
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      List<Branch_id> branch_ids = [];
      for(var i=0;i<dept_ids.length;i++){
        Branch_id branch = new Branch_id();
        branch.id = dept_ids[i].branch_id!.id;
        branch.name = dept_ids[i].branch_id!.name;
        branch_ids.add(branch);
      }
      var overtime_request = OvertimeRequest(
        name: reasonTextController.text,
        department_ids: dept_ids,
        branch_ids: branch_ids,
        start_date: from_date,
        end_date: to_date,
        duration: double.parse(durationController.text),
        reason: reasonTextController.text,
        request_line: requestLineList,
        requested_employee_id: employee_id!,
        categ_id: categ_id,
      );
      print(overtime_request.toJson());

      await overtimeService?.overtimeRequest(employee_id!, overtime_request)
          .then((data) {
        Get.back();
        if (data.contains("ERROR")) {
          AppUtils.showErrorDialog(data, '409');
        } else {
          _overTimeListController.getOtList();
          // AppUtils.showConfirmDialog('Information', 'Successfully Saved!',(){
          //   Get.back();
          //   Get.back();
          // });
          Get.defaultDialog(title:'Information',content: Text('Successfully Saved!'),confirmTextColor: Colors.white,onConfirm: (){
              Get.back();
              Get.back();
            });
        }
      });
    } else {
      AppUtils.showDialog('Warning!',"Fill Required Data!");
    }
  }

  @override
  void onClose() {
    // fromDateTimeTextController?.dispose();
    // toDateTimeTextController?.dispose();
    // reasonTextController?.dispose();
    // durationController?.dispose();
    duration.value = "";
    clearOtRequestLine();

    super.onClose();
  }

  void calculateinterval(DateTime selectedFromDate, DateTime selectedToDate) {
    if (fromDateTimeTextController.text.isNotEmpty &&
        toDateTimeTextController.text.isNotEmpty) {
      if (selectedToDate.isAfter(selectedFromDate)) {
        final differenceHr = selectedToDate
            .difference(selectedFromDate)
            .inHours;
        final differenceHalf = differenceHr + 0.5;
        final difference = selectedToDate
            .difference(selectedFromDate)
            .inMinutes;
        final differentValue = (double.parse(difference.toString()) / 60);
        if (differenceHalf <= differentValue)
          durationController.value =
              TextEditingValue(
                  text: differenceHalf.toStringAsFixed(1).toString());
        else {
          durationController.value =
              TextEditingValue(
                  text: differenceHr.toStringAsFixed(1).toString());
        }
        if (requestLineList.length > 0) {
          requestLineList.clear();
          dept_ids.clear();
          selectedDeptChip.clear();
          deptChipValues.clear();
        }
      }
      else{
        Get.defaultDialog(title:'Warning',content: Text('End date must be greater than start date.'),confirmTextColor: Colors.white,onConfirm: () async{
          Get.back();
          toDateTimeTextController.text = '';
        });

        // AppUtils.showConfirmDialog('Warning', 'End date must be greater than start date.',(){
        //   Get.back();
        //   toDateTimeTextController.text = '';
        // });
      }
    }
  }

  // void createRequestLine(List<EmployeeDeptTag> empList) {
  //   // requestLineList.clear();
  //   // category_ids.clear();
  //   var employee_ids = empList;
  //
  //   if(requestLineList.length>0){
  //     for(int i=0;i<employee_ids.length;i++){
  //       for(int j=0;j<requestLineList.length;j++){
  //         if(employee_ids[i].id == requestLineList[j].employee_id){
  //           requestLineList.removeAt(j);
  //           break;
  //         }
  //       }
  //       requestLineList.add(OvertimeRequestLine(employee_id: employee_ids[i].id,email: employee_ids[i].work_email,status:'waiting',employee_name: employee_ids[i].name));
  //       //requestLineToShowList.add(OvertimeRequestLine(employee_id: 0,email: employee_ids[i].work_email,status:'',employee_name: employee_ids[i].name));
  //     }
  //   }else{
  //     for(int i=0;i<employee_ids.length;i++){
  //
  //       requestLineList.add(OvertimeRequestLine(employee_id: employee_ids[i].id,email: employee_ids[i].work_email,status:'waiting',employee_name: employee_ids[i].name));
  //       //requestLineToShowList.add(OvertimeRequestLine(employee_id: 0,email: employee_ids[i].work_email,status:'',employee_name: employee_ids[i].name));
  //     }
  //   }
  //     is_add_request_line.value = true;
  //   }

  void deleteEmpRow(int index) {
    requestLineList.removeAt(index);
  }

  void removeDeptChip(int index) {
    if (requestLineList.length > 0) {
      requestLineList.removeWhere(
          (value) => deptChipValues.elementAt(index).id == value.dept_id);
    }
    //remove dept tag chip
    selectedDeptChip.removeAt(index);
    deptChipValues.removeAt(index);
    //remove department ids
    dept_ids.removeAt(index);
  }
}
