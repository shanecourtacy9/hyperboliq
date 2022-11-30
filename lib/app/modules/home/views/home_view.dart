import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hyperboliq/app/modules/home/views/widgets/empty_content.dart';
import 'package:hyperboliq/app/modules/home/views/widgets/loading.dart';
import 'package:hyperboliq/app/ui/text_styles.dart';
import 'package:hyperboliq/app/ui/ui_helpers.dart';
import 'package:image/image.dart' as imgLib;

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Upload Image"),
          onPressed: () {
            controller.uploadImage();
          },
          tooltip: 'Pick Image from gallery',
          icon: const Icon(Icons.photo_library),
        ),
        body: Obx(() => Stack(
              children: [
                controller.image?.value == null
                    ? const EmptyContent()
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          ExpansionTile(
                            initiallyExpanded: true,
                            expandedAlignment: Alignment.centerLeft,
                            title: const Text(
                              "Selected Image",
                              style: subTitle,
                            ),
                            children: [
                              Image.file(
                                File(controller.image!.value!.path),
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                              verticalSpaceSmall
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () => controller.processImage(),
                              child: const Text("Process Image")),
                          verticalSpaceSmall,
                          controller.newImage?.value != null
                              ? Image.memory(Uint8List.fromList(imgLib
                                  .encodeJpg(controller.newImage!.value!)))
                              : Container()
                        ],
                      ),
                Visibility(
                    visible: controller.showLoader.value,
                    child: const Loading())
              ],
            )));
  }
}
