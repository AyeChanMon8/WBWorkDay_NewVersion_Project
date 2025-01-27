import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../localization.dart';
import '../pages/bottom_navigation.dart';
import '../pages/home_page.dart';
import '../routes/app_pages.dart';
import '../services/employee_service.dart';
import '../utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  EmployeeService? employeeService;
  String emp_id = '';
  final RxBool passwordToggle = true.obs;
  final box = GetStorage();
  var rememberme = true.obs;
  @override
  void onInit() async{
    super.onInit();
    print("onInit");
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    rememberme.value = box.read('rememberme')??false;

  }

  @override
  void onReady() async {
    print("onReady");
    super.onReady();
    this.employeeService = await EmployeeService().init();
    // Get.put(employeeService);
  }

  void apiLogin() async {
    if (emailTextController.text.isEmpty ||
        passwordTextController.text.isEmpty) {
      AppUtils.showToast('Please Fill Username and Password!');
    } else {
      Future.delayed(
          Duration.zero,
          () => Get.dialog(
              Center(
                  child: SpinKitWave(
                color: Color.fromRGBO(63, 51, 128, 1),
                size: 30.0,
              )),
              barrierDismissible: false));
      await employeeService?.checkLogin(emailTextController.text, passwordTextController.text)
          .then((data) async {
        print("dataReturn");
        print(data.toString());
        if (data.toString().isNotEmpty) {
          if(data.toString()=="0"){
            Get.back();
            AppUtils.showToast('Wrong EmployeeID or Password!');
          }else{
            emp_id = data.toString();
            //save to GetxStorage
            box.write('emp_id', emp_id);
            box.write('login_employee_id', emailTextController.text);
            if(box.read('rememberme')??false) {
              box.write('username', emailTextController.text);
              box.write('password', passwordTextController.text);
            }
            checkRole(emp_id);
          }
        }
        // else {

        //   Get.back();
        //   await employeeService
        //       .checkLogin(emailTextController.text, passwordTextController.text).then((value){
        //     if (data.toString().isNotEmpty) {
        //       if(data.toString()=="0"){
        //         AppUtils.showToast('Wrong EmployeeID or Password!');
        //       }else{
        //         emp_id = data.toString();
        //         //save to GetxStorage
        //         box.write('emp_id', emp_id);
        //         if(box.read('rememberme')??false) {
        //           box.write('username', emailTextController.text);
        //           box.write('password', passwordTextController.text);
        //         }
        //         checkRole(emp_id);
        //       }
        //     }else{
        //          Get.offAll(SplashPage());
        //     }
        //   });
        // }
      });
    }
  }
  

  @override
  void onClose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
    super.onClose();
  }

  void checkRole(String emp_id) async {
    await employeeService?.checkRole(int.tryParse(emp_id)!).then((data) async {
      final labels = AppLocalizations.of(Get.context!);
      var storage = LocalStorage('storefunction');
      bool value  = await storage.ready;
      if(value)
        //if(storage.getItem('home_function')==null){
          storage.setItem('home_function', [[
            FontAwesomeIcons.plus.codePoint,
            labels?.leaveTravelRequest,
            Routes.LEAVE_TRIP_TAB_BAR,
            true
          ],[FontAwesomeIcons.calendar.codePoint,
            labels?.leaveTravelReport,
            Routes.LEAVE_TRIP_REPORT,true],
            [
              FontAwesomeIcons.personBooth.codePoint,
              labels?.attendanceReport,
              Routes.ATTENDANCE_REPORT,
              true
            ],
            [
              FontAwesomeIcons.chartBar.codePoint,
              labels?.organizationChart,
              Routes.ORGANIZATION_CHART, true
            ]
          ].toList());
        //}

      if(data.contains("driver")){
        box.write('is_driver', true);
      }else{
        box.write('is_driver', false);
      }

      var roles = data.split(',');

      if(roles.length==2)
        {
          /*showDialog(context: Get.context,builder:(BuildContext context){
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Choose Your Role',style:  TextStyle(fontSize: 22, color: Color.fromARGB(255, 63, 51, 128),),textAlign: TextAlign.center,),
                    RaisedButton(onPressed: (){
                      box.write('role_category', roles[0]).then((value) =>
                          Get.offAll(BottomNavigationWidget()));
                    },child: Text("Manager",style: TextStyle(color: Colors.white),),color: Color.fromARGB(255, 63, 51, 128) ,),
                    RaisedButton(onPressed: (){
                      box.write('role_category', roles[1]).then((value) =>
                          Get.offAll(BottomNavigationWidget()));
                    },child: Text("Dotted Line Manager",style: TextStyle(color:Colors.white),),color:  Color.fromARGB(255, 63, 51, 128),),
                  ],
                ),
              ),
            );
          });*/

          box.write('real_role_category', data);
          print('realRole');
          print(box.read('real_role_category'));
          box.write('role_category', roles[0]).then((value) =>
              Get.offAll(BottomNavigationWidget()));
        }
        else {
        box.write('real_role_category', data);
        print('realRole');
          if(roles.length>0){
            box.write('role_category', roles[0]).then((value) =>

                Get.offAll(BottomNavigationWidget()));
          }

        }
      //  Get.offNamed('/bottomnavigation');

    });
  }
}
