import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:sembast/blob.dart';

class CaptureImageEntity {
  CaptureImageEntity({
    this.captureDocumentID = '',
    this.xOriginalFile,
    this.originalFile,
    this.xCroppedFile,
    this.croppedFile,
    this.originalFilePath = '',
    this.croppedFilePath = '',
    this.networkUrl = '',
    this.fileName = '',
    this.fileNameWithExtension = '',
    this.fileExtension = '',
    this.xFileReadAsBytes,
    this.fileReadAsBytes,
    this.fileReadAsString = '',
    this.xFileReadAsString = '',
    this.documentType = DocumentType.other,
    this.blob,
    this.base64Encode = '',
    this.mimeType = 'image/png',
    this.height = 0.0,
    this.width = 0.0,
  });

  factory CaptureImageEntity.fromMap(Map<String, dynamic> map) {
    return CaptureImageEntity(
      captureDocumentID: map['captureDocumentID'] as String,
      xOriginalFile: map['xOriginalFile'] as XFile?,
      originalFile: map['originalFile'] as File?,
      xCroppedFile: map['xCroppedFile'] as XFile?,
      croppedFile: map['croppedFile'] as File?,
      originalFilePath: map['originalFilePath'] ?? '',
      croppedFilePath: map['croppedFilePath'] ?? '',
      networkUrl: map['networkUrl'] ?? '',
      fileName: map['fileName'] ?? '',
      fileNameWithExtension: map['fileNameWithExtension'] ?? '',
      fileExtension: map['fileExtension'] ?? '',
      xFileReadAsBytes: map['xFileReadAsBytes'] ?? Uint8List(0),
      fileReadAsBytes: map['fileReadAsBytes'] ?? Uint8List(0),
      fileReadAsString: map['fileReadAsString'] ?? '',
      xFileReadAsString: map['xFileReadAsString'] ?? '',
      documentType: (map['documentType'] != null)
          ? DocumentType.values.byName(map['documentType'])
          : DocumentType.other,
      blob: map['blob'] ?? Blob(Uint8List(0)),
      base64Encode: map['base64'] ?? '',
      mimeType: map['mimeType'] ?? '',
      height: map['height'] ?? 0.0,
      width: map['width'] ?? 0.0,
    );
  }

  String captureDocumentID;
  XFile? xOriginalFile;
  File? originalFile;
  XFile? xCroppedFile;
  File? croppedFile;
  String originalFilePath;
  String croppedFilePath;
  String networkUrl;
  String fileName;
  String fileNameWithExtension;
  String fileExtension;
  Uint8List? xFileReadAsBytes;
  Uint8List? fileReadAsBytes;
  String fileReadAsString;
  String xFileReadAsString;
  DocumentType documentType;
  Blob? blob;
  String base64Encode;
  String mimeType;
  double height;
  double width;

  CaptureImageEntity copyWith({
    XFile? xOriginalFile,
    File? originalFile,
    XFile? xCroppedFile,
    File? croppedFile,
    String? originalFilePath,
    String? croppedFilePath,
    String? networkUrl,
    String? fileName,
    String? fileNameWithExtension,
    String? fileExtension,
    Uint8List? xFileReadAsBytes,
    Uint8List? fileReadAsBytes,
    String? fileReadAsString,
    String? xFileReadAsString,
    DocumentType? documentType,
    Blob? blob,
    String? base64Encode,
    String? mimeType,
    String? captureDocumentID,
    double? height,
    double? width,
  }) {
    return CaptureImageEntity(
      xOriginalFile: xOriginalFile ?? this.xOriginalFile,
      originalFile: originalFile ?? this.originalFile,
      xCroppedFile: xCroppedFile ?? this.xCroppedFile,
      croppedFile: croppedFile ?? this.croppedFile,
      originalFilePath: originalFilePath ?? this.originalFilePath,
      croppedFilePath: croppedFilePath ?? this.croppedFilePath,
      networkUrl: networkUrl ?? this.networkUrl,
      fileName: fileName ?? this.fileName,
      fileNameWithExtension:
          fileNameWithExtension ?? this.fileNameWithExtension,
      xFileReadAsBytes: xFileReadAsBytes ?? this.xFileReadAsBytes,
      fileReadAsBytes: fileReadAsBytes ?? this.fileReadAsBytes,
      fileReadAsString: fileReadAsString ?? this.fileReadAsString,
      xFileReadAsString: xFileReadAsString ?? this.xFileReadAsString,
      fileExtension: fileExtension ?? this.fileExtension,
      documentType: documentType ?? this.documentType,
      blob: blob ?? this.blob,
      base64Encode: base64Encode ?? this.base64Encode,
      mimeType: mimeType ?? this.mimeType,
      captureDocumentID: captureDocumentID ?? this.captureDocumentID,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'captureDocumentID': captureDocumentID,
      //'xOriginalFile': xOriginalFile,
      //'originalFile': originalFile,
      //'xCroppedFile': xCroppedFile,
      //'croppedFile': croppedFile,
      'originalFilePath': originalFilePath,
      'croppedFilePath': croppedFilePath,
      'networkUrl': networkUrl,
      'fileName': fileName,
      'fileNameWithExtension': fileNameWithExtension,
      //'xFileReadAsBytes': xFileReadAsBytes ?? Uint8List(0),
      //'fileReadAsBytes': fileReadAsBytes ?? Uint8List(0),
      'fileReadAsString': fileReadAsString,
      'xFileReadAsString': xFileReadAsString,
      'fileExtension': fileExtension,
      'documentType': documentType.name,
      'blob': blob ?? Blob(Uint8List(0)),
      'base64': base64Encode,
      'mimeType': mimeType,
      'width': width,
      'height': height,
    };
  }
}
