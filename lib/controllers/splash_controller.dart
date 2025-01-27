
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import '../models/home_function.dart';
import '../pages/bottom_navigation.dart';
import '../routes/app_pages.dart';
import '../services/employee_service.dart';
import '../utils/app_utils.dart';

// import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SplashController extends GetxController{
  EmployeeService? employeeService;
  String emp_id = '';
  final box = GetStorage();
  @override
  void onReady() async {
    super.onReady();
    //Get.put(employeeService);
    this.employeeService = await EmployeeService().init();
  }
  void apiForRememberLogin() async {
    this.employeeService = await EmployeeService().init();
    String username = box.read('username');
    String password = box.read('password');
    await employeeService?.checkLogin(username, password)
        .then((data) {
      if (!data.isNull) {
        emp_id = data.toString();
        box.write('emp_id', emp_id);
        //checking employee role
        checkRole(emp_id);
      } else {
        Get.back();
        AppUtils.showToast('Cannot Login!');
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
  void checkRole(String emp_id) async {
    this.employeeService = await EmployeeService().init();
    await employeeService?.checkRole(int.tryParse(emp_id)!).then((data) async {
      final labels = AppLocalizations.of(Get.context!);
      var storage = LocalStorage('storefunction');
      bool value  = await storage.ready;
      if(value)
        if(storage.getItem('home_function')==null){
         /* print(storage.getItem('home_function'));
          HomeFunctionList functionList = HomeFunctionList();
          functionList.items.add( HomeFunction(FontAwesomeIcons.plus,
              labels?.leaveTravelRequest,
              Routes.LEAVE_TRIP_TAB_BAR,
              true));
          functionList.items.add( HomeFunction(FontAwesomeIcons.calendar,
              labels?.leaveTravelReport,
              Routes.LEAVE_TRIP_REPORT,true));
          functionList.items.add( HomeFunction( FontAwesomeIcons.personBooth,
              labels?.attendanceReport,
              Routes.ATTENDANCE_REPORT,
              true));
          functionList.items.add( HomeFunction(FontAwesomeIcons.clock,
              labels?.overTime,
              Routes.OVER_TIME_LIST_PAGE, true));
          functionList.items.add( HomeFunction(FontAwesomeIcons.chartBar,
              labels?.organizationChart,
              Routes.ORGANIZATION_CHART, true));
          storage.setItem('home_function', functionList.toJSONEncodable());*/

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
        }
      box.write('role_category', data).then((value) =>  Get.offAll(BottomNavigationWidget()));
      //  Get.offNamed('/bottomnavigation');

    });
  }
}