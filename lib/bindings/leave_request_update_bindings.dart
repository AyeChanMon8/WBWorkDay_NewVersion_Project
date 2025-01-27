import 'package:get/get.dart';

import '../controllers/leave_request_update_controller.dart';

class LeaveRequestUpdateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveRequestUpdateController(),fenix: true);
  }

}