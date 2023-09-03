import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/services.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:sembast/blob.dart';

class CaptureImageEntity {
  CaptureImageEntity({
    required this.captureDocumentID,
    this.xOriginalFile,
    this.originalFile,
    this.xCroppedFile,
    this.croppedFile,
    required this.originalFilePath,
    required this.croppedFilePath,
    required this.networkUrl,
    required this.fileName,
    required this.fileNameWithExtension,
    required this.fileExtension,
    required this.xFileReadAsBytes,
    required this.fileReadAsBytes,
    required this.fileReadAsString,
    required this.xFileReadAsString,
    required this.documentType,
    required this.blob,
    required this.base64Encode,
    required this.mimeType,
  });

  factory CaptureImageEntity.fromMap(Map<String, dynamic> map) {
    return CaptureImageEntity(
      captureDocumentID: map['captureDocumentID'] as String,
      xOriginalFile: map['xOriginalFile'] as XFile?,
      originalFile: map['originalFile'] as File?,
      xCroppedFile: map['xCroppedFile'] as XFile?,
      croppedFile: map['croppedFile'] as File?,
      originalFilePath: map['originalFilePath'] as String,
      croppedFilePath: map['croppedFilePath'] as String,
      networkUrl: map['networkUrl'] ?? '',
      fileName: map['fileName'] as String,
      fileNameWithExtension: map['fileNameWithExtension'] as String,
      fileExtension: map['fileExtension'] as String,
      xFileReadAsBytes: map['xFileReadAsBytes'] as Uint8List,
      fileReadAsBytes: map['fileReadAsBytes'] as Uint8List,
      fileReadAsString: map['fileReadAsString'] as String,
      xFileReadAsString: map['xFileReadAsString'] as String,
      documentType: DocumentType.values.byName(map['documentType']),
      blob: map['blob'] as Blob,
      base64Encode: map['base64'] as String,
      mimeType: map['mimeType'] as String,
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
  Uint8List xFileReadAsBytes;
  Uint8List fileReadAsBytes;
  String fileReadAsString;
  String xFileReadAsString;
  DocumentType documentType;
  Blob blob;
  String base64Encode;
  String mimeType;

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
      fileNameWithExtension: fileNameWithExtension ?? this.fileNameWithExtension,
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
      'xFileReadAsBytes': xFileReadAsBytes,
      'fileReadAsBytes': fileReadAsBytes,
      'fileReadAsString': fileReadAsString,
      'xFileReadAsString': xFileReadAsString,
      'fileExtension': fileExtension,
      'documentType': documentType.name,
      'blob': blob,
      'base64': base64Encode,
      'mimeType': mimeType,
    };
  }
}
