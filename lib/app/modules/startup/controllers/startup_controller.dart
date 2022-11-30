import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hyperboliq/app/common/helpers.dart';
import 'package:hyperboliq/app/routes/app_pages.dart';
import 'package:image/image.dart' as imgLib;
import 'package:flutter/services.dart' show rootBundle;

class StartupController extends GetxController {
  List<Color> datasetAvgRgbs = [];
  List<String> dataset = [];

  @override
  void onInit() {
    getAvgValuesOfDataset();
    super.onInit();
  }

  getAvgValuesOfDataset() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final imagePaths = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/images/dataset/'));

    for (var path in imagePaths) {
      ByteData byteData = await rootBundle.load(path);

      Uint8List bytes = byteData.buffer.asUint8List();

      imgLib.Image? decodedImage = imgLib.decodeImage(bytes);
      Color avgRgb = getAverageRBG(decodedImage!);

      datasetAvgRgbs.add(avgRgb);
      dataset.add(path);
    }

    goToHome();
  }

  goToHome() {
    Get.toNamed(Routes.home);
  }
}
