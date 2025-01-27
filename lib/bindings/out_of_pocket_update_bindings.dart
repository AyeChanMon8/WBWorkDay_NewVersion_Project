import 'package:get/get.dart';

import '../controllers/out_of_pocket_update_controller.dart';
class OutOfPocketUpdateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => OutOfPocketUpdateController(),fenix: true);
  }

}