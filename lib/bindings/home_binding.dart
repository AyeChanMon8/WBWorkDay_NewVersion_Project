import 'package:get/get.dart';

import '../controllers/attendance_report_controller.dart';
import '../controllers/organization_chart_controller.dart';
import '../controllers/pms_list_controller.dart';
import '../controllers/user_profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<PmsListController>(() => PmsListController());
    Get.lazyPut<OrganizationalChartController>(
        () => OrganizationalChartController());
    Get.lazyPut<AttendanceReportController>(() => AttendanceReportController());
  }
}
