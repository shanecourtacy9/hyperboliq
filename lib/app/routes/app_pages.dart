import 'package:get/get.dart';
import 'package:hyperboliq/app/modules/startup/bindings/startup_binding.dart';
import 'package:hyperboliq/app/modules/startup/views/startup_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.startup;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.startup,
      page: () => const StartupView(),
      binding: StartupBinding(),
    ),
  ];
}
