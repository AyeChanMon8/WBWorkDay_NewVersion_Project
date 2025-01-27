import 'package:get/get.dart';

import '../controllers/travel_request_update_controller.dart';

class TravelRequestUpdateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TravelRequestUpdateController(),fenix: true);
  }

}