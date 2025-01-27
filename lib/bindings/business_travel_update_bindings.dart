import 'package:get/get.dart';

import '../controllers/business_travel_update_controller.dart';

class BusinessTravelUpdateBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => BusinessTravelUpdateController(),fenix: true);
  }

}