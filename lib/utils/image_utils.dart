library image_utils_class;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as ImageProcess;

class ImageUtils {
  static MemoryImage base64ToImage(String base64String) {
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  static Uint8List base64ToUnit8list(String base64String) {
    return base64Decode(base64String);
  }

  static String fileToBase64(File imgFile) {
    return base64Encode(imgFile.readAsBytesSync());
  }

  static Future<String> networkImageToBase64(String url) async {
    final http.Response response = await http.get(url);
    return base64.encode(response.bodyBytes);
  }

  Future<String> assetImageToBase64(String path) async {
    final ByteData bytes = await rootBundle.load(path);
    return base64.encode(Uint8List.view(bytes.buffer));
  }

  Widget imageFromBase64String(String base64String) {
    try {
      return Image.memory(base64Decode(base64String));
    } on Exception catch (e) {
      return const SizedBox.shrink();
    }
  }

  Uint8List dataFromBase64String(String base64String) {
    try {
      return base64Decode(base64String);
    } on Exception catch (e) {
      return Uint8List(0);
    }
  }

  String base64String(Uint8List data) {
    try {
      return base64Encode(data);
    } on Exception catch (e) {
      return '';
    }
  }

  String fileImageToBase64(String imagePath) {
    try {
      final File file = File(imagePath);
      final imageFile = ImageProcess.decodeImage(
        file.readAsBytesSync(),
      );
      return base64Encode(ImageProcess.encodePng(imageFile));
    } on Exception catch (e) {
      return '';
    }
  }

  Widget decodeBase64ToImageMemoryWidget(String base64Image) {
    try {
      final byteImage = const Base64Decoder().convert(base64Image);
      return Image.memory(byteImage);
    } on Exception catch (e) {
      return const SizedBox.shrink();
    }
  }
}
