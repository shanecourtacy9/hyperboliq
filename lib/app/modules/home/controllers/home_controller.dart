import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:delta_e/delta_e.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyperboliq/app/common/helpers.dart';
import 'package:hyperboliq/app/modules/startup/controllers/startup_controller.dart';
import 'package:image/image.dart' as imgLib;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  Rx<XFile?>? image;
  RxBool showLoader = false.obs;
  Rx<imgLib.Image?>? newImage;
  final StartupController _startupController = Get.find();

  Future<void> uploadImage() async {
    showLoader(true);

    ImagePicker picker = ImagePicker();
    XFile? pickedImaged = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImaged != null) {
      image = Rx<XFile>(pickedImaged);
    }
    showLoader(false);
  }

  Future<void> processImage() async {
    showLoader(true);

    imgLib.Image newSplitImage = await getNewImage(20, 20);
    newImage = Rx<imgLib.Image?>(newSplitImage);
    showLoader(false);
  }

  Future<imgLib.Image> getNewImage(int widthCount, int heightCount) async {
    Uint8List imageList = await image!.value!.readAsBytes();

    imgLib.Image? decodedImage = imgLib.decodeImage(imageList);
    imgLib.Image? newCreatedImage = decodedImage;
    int x = 0, y = 0;

    int width = (decodedImage!.width / widthCount).round();
    int height = (decodedImage.height / heightCount).round();

    List<imgLib.Image> parts = [];
    List<imgLib.Image> newImages = [];
    List<Color> avgColours = [];
    for (int i = 0; i < heightCount; i++) {
      for (int j = 0; j < widthCount; j++) {
        imgLib.Image imageToAdd =
            imgLib.copyCrop(decodedImage, x, y, width, height);
        parts.add(imageToAdd);
        Color avgPartRgb = getAverageRBG(imageToAdd);
        int shortestValueIndex = 0;
        double shortestValue = double.maxFinite;
        for (int k = 0; k < _startupController.datasetAvgRgbs.length; k++) {
          double distance =
              getDeltaE(_startupController.datasetAvgRgbs[k], avgPartRgb);

          if (distance < shortestValue) {
            shortestValue = distance;
            shortestValueIndex = k;
          }
        }

        ByteData byteData = await rootBundle
            .load(_startupController.dataset[shortestValueIndex]);

        Uint8List bytes = byteData.buffer.asUint8List();

        imgLib.Image? imageToReplace = imgLib.decodeImage(bytes);

        imgLib.Image resizedImage = imgLib.copyResize(imageToReplace!,
            width: imageToAdd.width, height: imageToAdd.height);
        newImages.add(resizedImage);
        avgColours.add(avgPartRgb);
        newCreatedImage = imgLib.copyInto(newCreatedImage!, resizedImage,
            dstX: x, dstY: y, srcH: imageToAdd.height, srcW: imageToAdd.width);

        x += width;
      }
      x = 0;
      y += height;
    }
    return newCreatedImage!;
  }
}
