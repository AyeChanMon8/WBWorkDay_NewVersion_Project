import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/claiminsurancemodel.dart';
import '../models/emp_d.dart';
import '../models/employee.dart';
import '../models/employee_id.dart';
import '../models/insurance.dart';
import '../models/insurancemodel.dart';
import '../models/insurancetypemodel.dart';
import '../services/employee_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../routes/app_pages.dart';
import '../utils/app_utils.dart';

class InsuranceController extends GetxController {
  static InsuranceController to = Get.find();
  EmployeeService? employeeService;
  var insuranceList = <Insurancemodel>[].obs;
  var claimInsuranceList = <Claiminsurancemodel>[].obs;
  var insurancyTypeList = <Insurancetypemodel>[].obs;
  var insuranceData = Insurance().obs;
  var selectedPolicyType = Insurancetypemodel().obs;
  var selectedInsuranceType = Insurancemodel().obs;
  var balanceAmount = 0.0.obs;
  var image_base64 ='';
  final Rx<File?> selectedImage = File('').obs;
  final RxBool isShowImage = false.obs;
  final box = GetStorage();
  TextEditingController txtCalimAmont = TextEditingController();
  TextEditingController txtSelectedDate = TextEditingController();
  TextEditingController txtDescription =  TextEditingController();
  var selectedInsuranceRef = Insurancemodel().obs;
  var insurance_ref_show = false.obs;
  @override
  void onReady() async {
    super.onReady();
    this.employeeService = await EmployeeService().init();
    getInsurance();
  }

  @override
  void onInit() {
    super.onInit();
    txtCalimAmont = new TextEditingController();
    txtSelectedDate =new  TextEditingController();
    txtDescription =new TextEditingController();
  }

  getInsurance() async {
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
    var employee_id = box.read('emp_id');
    await employeeService?.insuranceList(employee_id).then((data) {
      insuranceList.value = data;
      if(data.length!=0){
        selectedInsuranceType.value = data[0];
        selectedInsuranceRef.value = data[0];
        //selectedInsuranceRef.value = Insurancemodel(insuranceTypeId: Insurance_type_id);
        balanceAmount.value = data[0].balanceAmount;
      }

      Get.back();
    });
  }

  getClaimInsurance() async {
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
    var employee_id = box.read('emp_id');
    await employeeService?.claimInsuranceList(employee_id).then((data) {
      claimInsuranceList.value = data;
      Get.back();
    });
  }

  getInsuranceType() async {
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
    var employee_id = box.read('emp_id');
    await employeeService?.insuranceTypeList().then((data) {
      insurancyTypeList.value = data;
      if(data.length!=0) selectedPolicyType.value = data[0];
      Get.back();
    });
  }

  void onChangePolicyDropdown(
      Insurancetypemodel insurancetypemodel) async {
    this.selectedPolicyType.value = insurancetypemodel;
    update();
  }

  void onChangeInsuranceDropdown(
      Insurancemodel insurancetypemodel) async {
    this.selectedInsuranceType.value = insurancetypemodel;
    update();
  }
  void onChangeInsuranceRefDropdown(
      Insurancemodel insurancetypemodel) async {
    this.selectedInsuranceRef.value = insurancetypemodel;
    update();
  }

  void calculateBalanceAmount(){

    Insurancemodel insurancemodel = selectedInsuranceType.value;
    if(insurancemodel.balanceAmount>0)
      balanceAmount.value = insurancemodel.balanceAmount-int.parse(txtCalimAmont.text);
    else
      balanceAmount.value = insurancemodel.coverageAmount - int.parse(txtCalimAmont.text);

  }

  void createClaimInsurance() async{
    if(balanceAmount==0||double.tryParse(txtCalimAmont.text.toString())!>double.tryParse(balanceAmount.value.toString())!){
      Get.snackbar('Warning', 'Can not Claim!', snackPosition: SnackPosition.TOP,backgroundColor: Colors.red);
    }else{

      var dateParse = DateTime.parse(txtSelectedDate.text.toString());
      var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";

      Future.delayed(
          Duration.zero,
              () => Get.dialog(
              Center(
                  child: SpinKitWave(
                    color: Color.fromRGBO(63, 51, 128, 1),
                    size: 30.0,
                  )),
              barrierDismissible: false));
      List<Emp_ID> refList = <Emp_ID>[];
      refList.add(Emp_ID(id: selectedInsuranceRef.value.id));
      //String json = jsonEncode(refList);
      await employeeService?.createClaimInsurance(selectedInsuranceType.value, int.parse(txtCalimAmont.text),txtDescription.text,image_base64,formattedDate,refList).then((data) {
        claimInsuranceList.value = data;
        Get.back();
        Get.back();
      });
    }

  }

  void createEmployeensurance() async{
    var employee_id = box.read('emp_id');
    var employee_name = box.read('emp_name');
    Future.delayed(
        Duration.zero,
            () => Get.dialog(
            Center(
                child: SpinKitWave(
                  color: Color.fromRGBO(63, 51, 128, 1),
                  size: 30.0,
                )),
            barrierDismissible: false));
await employeeService?.createEmployeeInsurance(selectedPolicyType.value, int.parse(employee_id),employee_name).then((data) {
      insuranceList.value = data;
      Get.back();
      Get.back();
    });
  }
  void setCameraImage(File image, String image64) {
    image_base64 = image64;
    isShowImage.value = true;
    selectedImage.value = image;
  }
  @override
  void onClose() {
    super.onClose();
  }
}
