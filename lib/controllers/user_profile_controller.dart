
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import '../models/OrganizationChart.dart';
import '../models/employee.dart';
import '../pages/home_page.dart';
import '../services/employee_service.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../localization.dart';
import '../utils/app_utils.dart';
import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class UserProfileController extends GetxController {
  //static UserProfileController to = Get.find();
  EmployeeService? employeeService;
  TextEditingController phoneNoEditController = TextEditingController();
  TextEditingController emailEditController = TextEditingController();
  RxString orgList = "".obs;
  String image_base64 = '';
  final Rx<File?> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  var array = [];
  var empData = Employee().obs;
  String emp_name = '';
  final box = GetStorage();
  var emp_base64 = ''.obs;
  var profile_fetched  = false.obs;
  // UserProfileController({@required this.employeeService}) : assert(employeeService != null);

  @override
  void onInit() async{
    phoneNoEditController = TextEditingController();
    emailEditController = TextEditingController();
    this.employeeService = await EmployeeService().init();
    getUserInfo();
    super.onInit();
  }

  editPhoneNo() async {
    var phoneNo = phoneNoEditController.text;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await employeeService?.updateEmployeePhone(employee_id, phoneNo)
        .then((value) {
      Get.back();
      if (value == true) {
        getUserInfo();
        Get.back();
        AppUtils.showDialog(
            'Information!', 'Successfully Changed Your Phone No!');
      } else {
        AppUtils.showDialog('Information!', 'Not Success!');
      }
    });
  }

  editEmail() async {
    var email = emailEditController.text;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await employeeService?.updateEmployeeEmail(employee_id, email).then((value) {
      Get.back();
      if (value == true) {
        getUserInfo();
        Get.back();
        AppUtils.showDialog(
            'Information!', 'Successfully Changed Your Email address!');
      } else {
        AppUtils.showDialog('Information!', 'Not Success!');
      }
    });
  }

  editProfile() async {
    var image = image_base64;
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    var employee_id = box.read('emp_id');
    await employeeService?.updateEmployeeImage(employee_id, image).then((value) {
      // Get.back();
      if (value == true) {
        getUserInfo();
        Get.back();
        AppUtils.showDialog(
            'Information!', 'Successfully Changed Your Profile!');
      } else {
        AppUtils.showDialog('Information!', 'Not Success!');
      }
    });
  }

  getUserInfo() async {
    print('getUserInfo#');
    Future.delayed(
        Duration.zero,
        () => Get.dialog(
            Center(
                child: SpinKitWave(
              color: Color.fromRGBO(63, 51, 128, 1),
              size: 30.0,
            )),
            barrierDismissible: false));
    //fetch emp_id from GetX Storage
    var employeeId = box.read('emp_id');
    await employeeService?.getEmployeeProfile(employeeId).then((data) {
      Employee emp = data as Employee;
      if(emp != null) {
        if(emp.image_128!=null){
          emp_base64.value = emp.image_128;
        }else{
          emp_base64.value = '';
        }
        empData.value = emp;
        box.write('emp_name', emp.name);
        box.write('emp_image', emp.image_128);
        box.write('emp_dep', emp.department_id!.id.toString());
        box.write('emp_pos', emp.job_id!.id.toString());
        box.write('emp_company', emp.company_id!.id.toString());
        box.write('emp_company_name', emp.company_id!.name.toString());
        box.write("allow_leave_report", emp.allow_leave_report);
        box.write("allow_leave_request", data.allow_leave_request);
        box.write("allow_attendance_report", emp.allow_attendance_report);
        box.write("allow_organization_chart", emp.allow_organization_chart);
        box.write("allow_pms", emp.allow_pms);
        box.write("allow_payslip", emp.allow_payslip);
        box.write("allow_loan", emp.allow_loan);
        box.write("allow_calendar", emp.allow_calendar);
        box.write("allow_reward", emp.allow_reward);
        box.write("allow_warning", emp.allow_warning);
        box.write("allow_overtime", emp.allow_overtime);
        box.write("allow_approval", emp.allow_approval);
        box.write("mobile_app_attendance", emp.mobile_app_attendance);
        box.write("allow_travel_request", emp.allow_travel_request);
        box.write("allow_insurance", emp.allow_insurance);
        box.write("allow_employee_change", emp.allow_employee_change);
        box.write("allow_expense_report", emp.allow_expense_report);
        box.write("allow_document", emp.allow_document);
        box.write("allow_fleet_info", emp.allow_fleet_info);
        box.write("allow_maintenance_request", emp.allow_maintenance_request);
        box.write("allow_plan_trip", emp.allow_plan_trip);
        box.write("allow_plan_trip_waybill", emp.allow_plan_trip_waybill);
        box.write("allow_day_trip", emp.allow_day_trip);
        box.write("allow_out_of_pocket", emp.allow_out_of_pocket);
        box.write("allow_travel_expense", emp.allow_travel_expense);
        box.write("branch_id", emp.branch_id!.id);
        box.write("allow_purchase_order_approval", emp.allow_purchase_order_approval);
        box.write("allow_employee_benefit", emp.allow_employee_benefit);

        // fetchChildEmp(data);
        getFiscialYearData();
        Get.back();
      }
      else{
        Get.back();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchChildEmp(Employee data) {
    List<String> emp_name_list = <String>[];
    List<String> parent_name_list = <String>[];
    List<String> child_list = <String>[];
    var image = "";
    if (!data.image_128.isNull) {
      image = data.image_128.toString();
    }
    parent_name_list.add(data.name.toString() + "#image" );//+ image

    for (int i = 0; i < data.child_ids!.length; i++) {
      var image = "";
      if (!data.image_128.isNull) {
        image = data.image_128.toString();
      }
      emp_name_list.add(data.child_ids![i].name.toString() + "#image" );//+ image
    }
    var parent_data = OrganizationChart(
            id: data.parent_id!.name + "#image",
            email: '',
            next: parent_name_list)
        .toJson();
    box.write('emp', OrganizationChart(
        id: data.parent_id!.name + "#image",
        email: '',
        next: parent_name_list));
    var data_id = data.name.toString() + "#image" ;//+ image
    var child_data = OrganizationChart(
            id: data_id.toString(), email: data.work_email, next: emp_name_list)
        .toJson();
    array.add(parent_data);
    array.add(child_data);
    for (int k = 0; k < data.child_ids!.length; k++) {
      var data_id = data.child_ids![k].name.toString() +
          "#image";// +data.child_ids[k].image_128.toString()
      array.add(OrganizationChart(
              id: data_id.toString(),
              email: data.child_ids![k].work_email,
              next: child_list)
          .toJson());

      /*
       array.add(OrganizationChart(
              id: data_id.toString(),
              email: data.child_ids[k].work_email,
              next: child_list)
          .toJson());
       */

    }
    var str1 = array[0].toString();
    box.write('parent', data.parent_id.toString());
    box.write('child', data.child_ids);
    box.write('org_json', array.toString());
    //orgList.value = array.toString();
  }

  void setCameraImage(File image, String image64) {
    image_base64 = image64;
    isShowImage.value = true;
    selectedImage.value = image;
    editProfile();
  }

  void getFiscialYearData() async{
    var company_id = box.read('emp_company');
    await employeeService?.fetchFiscialYearData(int.parse(company_id)).then((value) {
      if(value!=null && value!=""){
      box.write('ficial_start_date',value.split(",")[0].toString());
      box.write('ficial_end_date',value.split(",")[1].toString());
      }

    });
  }
}
