import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hyperboliq/app/ui/app_colors.dart';
import 'package:hyperboliq/app/ui/text_styles.dart';
import 'package:hyperboliq/app/ui/ui_helpers.dart';

import '../controllers/startup_controller.dart';

class StartupView extends GetView<StartupController> {
  const StartupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          "Initialising Data...",
          style: title,
        ),
        Text(
          "Please wait while we initialise the dataset",
          style: subTitle,
        ),
        verticalSpaceSmall,
        LinearProgressIndicator(
          color: AppColors.primaryColour,
        )
      ],
    ));
  }
}
