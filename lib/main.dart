import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native,
    ),
  );
}
