import 'package:get/get.dart';

import '../controllers/startup_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StartupController());
  }
}
