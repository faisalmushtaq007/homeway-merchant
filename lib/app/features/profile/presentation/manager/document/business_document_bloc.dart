import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/painters/text_detector_painter.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_picker_source_enum.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/document/business_document_uploaded_entity.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/image_edit/common_widget.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/image_edit/crop_editor_helper.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homemakers_merchant/utils/universal_platform/universal_platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_image_crop/ui/dialog/image_editor_component/image_editor_plane.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_saver/file_saver.dart' as fileSaver;
import 'package:path/path.dart' as path;

part 'business_document_event.dart';

part 'business_document_state.dart';

part 'business_document_bloc.freezed.dart';

class BusinessDocumentBloc
    extends Bloc<BusinessDocumentEvent, BusinessDocumentState> {
  BusinessDocumentBloc() : super(BusinessDocumentInitial()) {
    on<BusinessDocumentEvent>(
      (events, emit) async {
        await events.map(
          (value) {},
          assetsStartUploading: (value) {},
          tradeLicenseNumberOnChanged: (value) {},
          assetsRemove: (value) {},
          documentRemove: (value) {},
          saveAndNext: (value) {},
          back: (value) {
            emit(
              BackState(
                allBusinessDocuments: value.allBusinessDocuments.toList(),
              ),
            );
          },
          askConfirmation: (value) {},
          confirmationYes: (value) {},
          askConfirmationNo: (value) {},
          uploadNewAssets: (value) {},
          uploadButtonState: (value) {},
          addNewDocument: (value) {
            // Add a document object into list of documents
            var allDocumentItems = <BusinessDocumentUploadedEntity>[];
            allDocumentItems.addAll(value.allBusinessDocuments.toList());
            allDocumentItems.asMap().forEach((key, item) async {
              if (item == value.businessDocumentUploadedEntity) {
                var result = value.uploadedData;
                // Extarct and store the return value
                String filePath = result[0] as String;
                XFile? xCroppedDocumentFile = result[1] as XFile;
                File? croppedDocumentFile = result[2] as File;
                XFile? xFile = result[5] as XFile;
                File? file = result[6] as File;
                String? assetNetworkUrl = result[7] as String?;
                final int timeStamp = DateTime.now().millisecondsSinceEpoch;
                var tempName =
                    '${item.documentType.documentTypeName}_$timeStamp';
                var fileNameWithExtension = path.basenameWithoutExtension(
                    xCroppedDocumentFile?.path ??
                        croppedDocumentFile?.path ??
                        tempName);
                String fileExtension = path.extension(
                    xCroppedDocumentFile?.path ??
                        croppedDocumentFile?.path ??
                        '.png');

                if (item.documentFrontAssets == null) {
                  item.documentFrontAssets = BusinessDocumentAssetsEntity(
                    assetName: fileNameWithExtension,
                    assetPath: filePath,
                    assetOriginalName:
                        path.basenameWithoutExtension(xFile.path ?? file.path),
                    assetExtension: fileExtension,
                    assetsUploadStatus: DocumentUploadStatus.uploaded,
                    hasAssetsFrontSide: true,
                    assetIdNumber: '',
                  );
                  return emit(AddNewDocumentState(
                    newIndexPosition: value.newIndexPosition,
                    isTextFieldEnable: value.isTextFieldEnable,
                    indexOfTextField: value.indexOfTextField,
                    documentType: value.documentType,
                    allBusinessDocuments: allDocumentItems.toList(),
                    assetsEntries: value.assetsEntries.toList(),
                    businessDocumentAssetsEntity:
                    allDocumentItems[value.currentIndex]
                        .documentFrontAssets,
                    businessDocumentUploadedEntity:
                    allDocumentItems[value.currentIndex],
                    currentIndex: value.currentIndex,
                    uploadedData: value.uploadedData,
                  ));
                }

                /// Copywith
                else {
                  BusinessDocumentAssetsEntity businessDocumentAssetsEntity =
                      item.documentFrontAssets!.copyWith(
                    assetName: fileNameWithExtension,
                    assetOriginalName:
                        path.basenameWithoutExtension(xFile.path ?? file.path),
                    assetPath: filePath,
                    assetExtension: fileExtension,
                    //assetIdNumber: value.textEditingControllers[value.currentIndex].value.text.trim(),
                    assetsUploadStatus: DocumentUploadStatus.uploaded,
                    hasAssetsFrontSide: true,
                  );
                  allDocumentItems[value.currentIndex].documentFrontAssets =
                      businessDocumentAssetsEntity;
                  return emit(AddNewDocumentState(
                    newIndexPosition: value.newIndexPosition,
                    isTextFieldEnable: value.isTextFieldEnable,
                    indexOfTextField: value.indexOfTextField,
                    documentType: value.documentType,
                    allBusinessDocuments: allDocumentItems.toList(),
                    assetsEntries: value.assetsEntries.toList(),
                    businessDocumentAssetsEntity:
                    allDocumentItems[value.currentIndex]
                        .documentFrontAssets ??
                        businessDocumentAssetsEntity,
                    businessDocumentUploadedEntity:
                    allDocumentItems[value.currentIndex],
                    currentIndex: value.currentIndex,
                    uploadedData: value.uploadedData,
                  ));
                }
              }
            });
            //return;
          },
          captureImageFromCamera: (value) {},
          restoreCaptureImageFromCamera: (value) {},
          selectImageFromGallery: (value) {},
          restoreSelectImageFromGallery: (value) {},
          openMediaPicker: (value) async => await _openMediaPicker(value, emit),
          selectDocumentSourceType: (value) async =>
              await _selectDocumentSourceType(value, emit),
          closeMediaPicker: (value) async =>
              await _closeMediaPicker(value, emit),
          crop: (value) async => await _assetCrop(value, emit),
          rightRotate: (value) async => await _assetRightRotate(value, emit),
          leftRotate: (value) async => await _assetLeftRotate(value, emit),
          flip: (value) async => await _assetFlip(value, emit),
          resetAsset: (value) async => await _resetAsset(value, emit),
          resetAll: (value) async => await _resetAllAsset(value, emit),
          saveCropDocument: (value) async =>
              await _saveCropDocument(value, emit),
          addNewAsset: (value) {
            emit(AddNewAssetState(
              newIndexPosition: value.newIndexPosition,
              isTextFieldEnable: value.isTextFieldEnable,
              indexOfTextField: value.indexOfTextField,
              documentType: value.documentType,
              onChanged: value.onChanged,
              textEditingController: value.textEditingController,
              allBusinessDocuments: value.allBusinessDocuments.toList(),
              assetsEntries: value.assetsEntries.toList(),
              businessDocumentAssetsEntity: value.businessDocumentAssetsEntity,
              businessDocumentUploadedEntity:
                  value.businessDocumentUploadedEntity,
              currentIndex: value.currentIndex,
              uploadedData: value.uploadedData,
            ));
          },
        );
      },
      transformer: sequential(),
    );
/*    on<OpenMediaPicker>(
      _openMediaPicker,
      transformer: sequential(),
    );
    on<CloseMediaPicker>(
      _closeMediaPicker,
      transformer: sequential(),
    );
    on<SelectDocumentSourceType>(
      _selectDocumentSourceType,
      transformer: sequential(),
    );
    on<AssetCrop>(
      _assetCrop,
      transformer: sequential(),
    );
    on<AssetLeftRotate>(
      _assetLeftRotate,
      transformer: sequential(),
    );
    on<AssetRightRotate>(
      _assetRightRotate,
      transformer: sequential(),
    );
    on<AssetFlip>(
      _assetFlip,
      transformer: sequential(),
    );
    on<ResetAsset>(
      _resetAsset,
      transformer: sequential(),
    );
    on<ResetAllAsset>(
      _resetAllAsset,
      transformer: sequential(),
    );
    on<SaveCropDocument>(
      _saveCropDocument,
      transformer: sequential(),
    );*/
    final TextRecognizer textRecognizer = GoogleMlKit.vision
        .textRecognizer(); //TextRecognizer(script: TextRecognitionScript.latin);
    bool canProcess = true;
    bool isBusy = false;
    CustomPaint? _customPaint;
  }

  final ImagePicker _picker = ImagePicker();

  FutureOr<void> _openMediaPicker(
    OpenMediaPicker event,
    Emitter<BusinessDocumentState> emit,
  ) {
    emit(OpenMediaPickerState(documentType: event.documentType));
  }

  FutureOr<void> _closeMediaPicker(
    CloseMediaPicker event,
    Emitter<BusinessDocumentState> emit,
  ) {
    emit(CloseMediaPickerState(documentType: event.documentType));
  }

  FutureOr<void> _selectDocumentSourceType(
    SelectDocumentSourceType event,
    Emitter<BusinessDocumentState> emit,
  ) async {
    try {
      ImageSource source = ImageSource.camera;
      File? response;
      Uint8List? originalBytes;
      var metaData = <String, dynamic>{};
      emit(
        SelectDocumentSourceTypState(
          documentType: event.documentType,
          documentPickerSource: event.documentPickerSource,
          imageSource: event.imageSource,
        ),
      );
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        source = ImageSource.camera;
        emit(CaptureImageFromCameraFailedProcessingState());
      } else {
        source = ImageSource.gallery;
        emit(SelectImageFromGalleryProcessingState());
      }
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        response = File(pickedFile.path);
        originalBytes = await pickedFile.readAsBytes();
        final mimeType = pickedFile.mimeType ?? '';
        final length = await pickedFile.length();
        final name = pickedFile.name;
        final path = pickedFile.path;
        //var encryptedBase64EncodedString = await File(path).readAsString(encoding:utf8);
        //var decoded = base64Decode(encryptedBase64EncodedString);
        metaData['mimeType'] = mimeType;
        metaData['length'] = length;
        metaData['name'] = name;
        metaData['path'] = path;
        metaData['bytes'] = originalBytes;
      }
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        emit(
          CaptureImageFromCameraSuccessState(
            documentType: event.documentType,
            pickedFile: pickedFile,
            responseFile: response,
            uint8list: originalBytes,
            metaData: metaData,
          ),
        );
      } else {
        emit(
          SelectImageFromGallerySuccessState(
            documentType: event.documentType,
            pickedFile: pickedFile,
            responseFile: response,
            uint8list: originalBytes,
            metaData: metaData,
          ),
        );
      }
    } catch (e) {
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        emit(
          CaptureImageFromCameraFailedState(
            documentType: event.documentType,
          ),
        );
      } else {
        appLog.d('State SelectImageFromGalleryFailedState');
        emit(
          SelectImageFromGalleryFailedState(
            documentType: event.documentType,
          ),
        );
      }
    }
  }

  FutureOr<void> _assetCrop(
      AssetCrop event, Emitter<BusinessDocumentState> emit) async {
    emit(
      AssetCropState(
        aspectRatioItem: event.aspectRatioItem,
        documentType: event.documentType,
        extendedImageEditorState: event.extendedImageEditorState,
        bytes: event.bytes,
        file: event.file,
        isCropping: event.isCropping,
        xfile: event.xfile,
      ),
    );
  }

  FutureOr<void> _assetLeftRotate(
      AssetLeftRotate event, Emitter<BusinessDocumentState> emit) async {
    emit(
      AssetLeftRotateState(
        hasRightTurn: event.hasRightTurn,
        documentType: event.documentType,
      ),
    );
    return;
  }

  FutureOr<void> _assetRightRotate(
      AssetRightRotate event, Emitter<BusinessDocumentState> emit) async {
    emit(
      AssetRightRotateState(
        hasRightTurn: event.hasRightTurn,
        documentType: event.documentType,
      ),
    );
    return;
  }

  FutureOr<void> _assetFlip(
      AssetFlip event, Emitter<BusinessDocumentState> emit) async {
    emit(
      AssetFlipState(
        documentType: event.documentType,
      ),
    );
    return;
  }

  FutureOr<void> _resetAsset(
      ResetAsset event, Emitter<BusinessDocumentState> emit) async {
    emit(
      ResetAssetState(
        aspectRatioItem: event.aspectRatioItem,
        documentType: event.documentType,
      ),
    );
    return;
  }

  FutureOr<void> _resetAllAsset(
      ResetAllAsset event, Emitter<BusinessDocumentState> emit) async {
    emit(
      ResetAllAssetState(
        documentType: event.documentType,
      ),
    );
    return;
  }

  FutureOr<void> _saveCropDocument(
      SaveCropDocument event, Emitter<BusinessDocumentState> emit) async {
    try {
      if (event.xfile != null || event.file != null) {
        if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.mediaLibrary,
            Permission.storage,
            //Permission.manageExternalStorage,
            Permission.accessMediaLocation,
          ].request();
          bool status =
              statuses.entries.any((element) => element.value.isGranted);
          //bool status = await Permission.storage.isGranted;
          if (!status) {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.mediaLibrary,
              Permission.storage,
              //Permission.manageExternalStorage,
              Permission.accessMediaLocation,
            ].request();
          }
          emit(SaveCropDocumentFailedState(
            documentType: event.documentType,
            reason: 'Storage permission is not granted',
            imageEditorController: event.imageEditorController,
            xfile: event.xfile,
            file: event.file,
            bytes: event.bytes,
            byteData: event.byteData,
          ));
        }
        emit(SaveCropDocumentProcessingState(
          documentType: event.documentType,
        ));
        //final EditImageInfo imageInfo = await cropImageDataWithDartLibrary(state: event.extendedImageEditorState);
        final int timeStamp = DateTime.now().millisecondsSinceEpoch;
        String nameOfExtension = path
            .extension(event.xfile!.path ?? event.file!.path)
            .replaceAll('.', '');
        final String filePath = await fileSaver.FileSaver.instance.saveFile(
          name:
              '${path.basenameWithoutExtension(event.xfile!.path ?? event.file!.path)}_$timeStamp',
          bytes: event.bytes!,
          filePath: event.xfile?.path,
          file: event.file!,
          ext: path
              .extension(event.xfile!.path ?? event.file!.path)
              .replaceAll('.', ''),
          mimeType: fileSaver.MimeType.values.byName(nameOfExtension),
        );
        if (filePath == null || filePath.isEmpty) {
          await Future.delayed(
            const Duration(seconds: 1),
            () {},
          );
          emit(SaveCropDocumentHideProcessingState(
            documentType: event.documentType,
          ));
          await Future.delayed(
            const Duration(milliseconds: 500),
            () {},
          );
          emit(SaveCropDocumentFailedState(
            documentType: event.documentType,
            reason:
                'Your selected document is not saved in your device, but uploaded into our server',
            imageEditorController: event.imageEditorController,
            xfile: event.xfile,
            file: event.file,
            bytes: event.bytes,
            byteData: event.byteData,
          ));
          return;
        }
        await Future.delayed(
          const Duration(seconds: 1),
          () {},
        );
        emit(SaveCropDocumentHideProcessingState(
          documentType: event.documentType,
        ));
        await Future.delayed(
          const Duration(milliseconds: 500),
          () {},
        );
        //await processImage(InputImage.fromFile(File(filePath)));
        //await Future.delayed(const Duration(milliseconds: 500));
        emit(
          SaveCropDocumentSuccessState(
            documentType: event.documentType,
            extendedImageEditorState: event.extendedImageEditorState,
            bytes: event.bytes,
            file: event.file,
            isCropping: event.isCropping,
            xfile: event.xfile,
            //imageInfo: imageInfo,
            message:
                'Your selected document is saved in this path: $filePath and successfully uploaded into our server',
            newFilePath: filePath,
            image: event.image,
            byteData: event.byteData,
            newFile: File(filePath),
            newXFile: XFile(filePath),
          ),
        );
        return;
      }
    } catch (e, s) {
      emit(SaveCropDocumentErrorState(
        documentType: event.documentType,
        reason: '$e',
        stackTrace: s,
      ));
    }
  }

  Future<void> processImage(InputImage inputImage) async {
    final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();
    String _text = '';
    CustomPaint? _customPaint;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(recognizedText,
          inputImage.metadata!.size, inputImage.metadata!.rotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
      appLog.d(_text);
    }
  }
}
