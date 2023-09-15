import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/universal/banner_carousel/src/banner_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadImageUtils {
  Future<BannerModel> selectImagePicker(
    BuildContext context, {
    DocumentType documentType = DocumentType.other,
  }) async {
    final List<dynamic>? value = await context.push<List<dynamic>>(
      Routes.UPLOAD_DOCUMENT_PAGE,
      extra: jsonEncode(
        {
          'documentType': documentType.name,
        },
      ),
    );
    // Check is Result exists or not
    if (value != null && value.isNotEmpty) {
      var result = value;
      // Extarct and store the return value
      String filePath = result[0] as String;
      XFile? xCroppedDocumentFile = result[1] as XFile;
      File? croppedDocumentFile = result[2] as File;
      XFile? xFile = result[5] as XFile;
      File? file = result[6] as File;
      String? assetNetworkUrl = result[7] as String?;
      final int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var tempName = '${documentType.name}_$timeStamp';
      var fileNameWithExtension = path.basenameWithoutExtension(xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
      String fileExtension = path.extension(xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? '.png');
      String croppedFilePath = (xCroppedDocumentFile.path.isEmpty) ? xCroppedDocumentFile.path : croppedDocumentFile.path;
      final fileReadAsBytes = await file.readAsBytes();
      final xFileReadAsBytes = await xFile.readAsBytes();
      final fileReadAsString = base64Encode(fileReadAsBytes);
      final xFileReadAsString = base64Encode(xFileReadAsBytes);
      final documentID = const Uuid().v4();
      final double height=0.0;
      final double width=0.0;
      return BannerModel(
        imagePath: croppedFilePath,
        id: documentID,
        metaData: {
          'id': documentID,
          'filePath': filePath,
          'croppedFilePath': croppedFilePath,
          'fileExtension': fileExtension,
          'fileNameWithExtension': fileNameWithExtension,
          //'file': file,
          //'xFile': xFile,
          'assetNetworkUrl': assetNetworkUrl,
          'fileReadAsBytes': fileReadAsBytes,
          'xFileReadAsBytes': xFileReadAsBytes,
          'fileReadAsString': fileReadAsString,
          'xFileReadAsString': xFileReadAsString,
          'height':height,
          'width':width,
        },
      );
    } else {
      return BannerModel(
        imagePath: '',
        id: '-1',
        metaData: {},
      );
    }
  }
}
