import 'package:get/get.dart';

import '../controllers/overtime_list_controller.dart';
import '../controllers/overtime_response_list_controller.dart';

class OverTimeTabbarBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => OverTimeListController(),fenix : true);
   Get.lazyPut(() => OverTimeResponseListController(),fenix: true);

  }

}