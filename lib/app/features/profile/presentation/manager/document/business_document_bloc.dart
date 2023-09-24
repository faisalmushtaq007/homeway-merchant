import 'dart:async';

import 'dart:io';
import 'package:collection/collection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/authentication/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/image_edit/crop_editor_helper.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
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
          assetsRemove: (value) {
            _assetsRemove(value, emit);
          },
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
            final int currentIndex = value.currentIndex;
            final int nextIndex = value.newIndexPosition;
            allDocumentItems = List<BusinessDocumentUploadedEntity>.from(
                value.allBusinessDocuments.toList());
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
                final double height = 0.0;
                final double width = 0.0;

                if (item.documentFrontAssets == null) {
                  item.documentFrontAssets = BusinessDocumentAssetsEntity(
                    assetName: fileNameWithExtension,
                    assetPath: filePath,
                    assetOriginalName:
                        path.basenameWithoutExtension(xFile.path ?? file.path),
                    assetExtension: fileExtension,
                    assetsUploadStatus: DocumentUploadStatus.uploaded,
                  );
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
                  allDocumentItems[value.currentIndex].hasButtonEnable = false;
                  allDocumentItems[value.currentIndex].documentFrontAssets =
                      businessDocumentAssetsEntity;
                }
              }
            });
            //return;
            if (currentIndex != nextIndex) {
              allDocumentItems.insert(
                nextIndex,
                BusinessDocumentUploadedEntity(
                    documentType: documentTypes[nextIndex]),
              );
            }
            emit(AddNewDocumentState(
              newIndexPosition: value.newIndexPosition,
              isTextFieldEnable: value.isTextFieldEnable,
              indexOfTextField: value.indexOfTextField,
              documentType: value.documentType,
              allBusinessDocuments: allDocumentItems.toList(),
              assetsEntries: value.assetsEntries.toList(),
              businessDocumentAssetsEntity:
                  allDocumentItems[value.currentIndex].documentFrontAssets,
              businessDocumentUploadedEntity:
                  allDocumentItems[value.currentIndex],
              currentIndex: value.currentIndex,
              uploadedData: value.uploadedData,
            ));
            return;
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
          saveBusinessDocument: (SaveBusinessDocument value) =>
              _saveBusinessDocument(value, emit),
          deleteAllBusinessDocument: (DeleteAllBusinessDocument value) =>
              _deleteAllBusinessDocument(value, emit),
          deleteBusinessDocument: (DeleteBusinessDocument value) =>
              _deleteBusinessDocument(value, emit),
          getAllBusinessDocument: (GetAllBusinessDocument value) =>
              _getAllBusinessDocument(value, emit),
          getBusinessDocument: (GetBusinessDocument value) =>
              _getBusinessDocument(value, emit),
        );
      },
      //transformer: sequential(),
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
      double height = 0.0;
      double width = 0.0;
      if (pickedFile != null) {
        response = File(pickedFile.path);
        originalBytes = await pickedFile.readAsBytes();
        final mimeType = pickedFile.mimeType ?? '';
        final length = await pickedFile.length();
        final name = pickedFile.name;
        final path = pickedFile.path;
        var decodedImage = await decodeImageFromList(originalBytes);
        //var encryptedBase64EncodedString = await File(path).readAsString(encoding:utf8);
        //var decoded = base64Decode(encryptedBase64EncodedString);
        height = decodedImage.height.toDouble();
        width = decodedImage.width.toDouble();
        metaData['mimeType'] = mimeType;
        metaData['length'] = length;
        metaData['name'] = name;
        metaData['path'] = path;
        metaData['bytes'] = originalBytes;
        metaData['height'] = height;
        metaData['width'] = width;
      }
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        emit(
          CaptureImageFromCameraSuccessState(
            documentType: event.documentType,
            pickedFile: pickedFile,
            responseFile: response,
            uint8list: originalBytes,
            metaData: metaData,
            width: width,
            height: height,
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
            width: width,
            height: height,
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
        documentType: event.documentType,
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
          double height = 0.0;
          double width = 0.0;
          final Uint8List originalBytes = await event.xfile?.readAsBytes() ??
              event.file?.readAsBytesSync() ??
              event.bytes as Uint8List? ??
              Uint8List.fromList([0]);
          var decodedImage = await decodeImageFromList(originalBytes);
          height = decodedImage.height.toDouble();
          width = decodedImage.width.toDouble();

          emit(SaveCropDocumentFailedState(
            documentType: event.documentType,
            reason: 'Storage permission is not granted',
            imageEditorController: event.imageEditorController,
            xfile: event.xfile,
            file: event.file,
            bytes: event.bytes,
            byteData: event.byteData,
            height: height,
            width: width,
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
          customMimeType: 'image/jpg',
          mimeType: nameOfExtension.contains('jpg')
              ? fileSaver.MimeType.custom
              : fileSaver.MimeType.values.byName(nameOfExtension),
        );
        if (filePath.isEmptyOrNull) {
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
          double height = 0.0;
          double width = 0.0;
          final Uint8List originalBytes = await event.xfile?.readAsBytes() ??
              event.file?.readAsBytesSync() ??
              event.bytes as Uint8List? ??
              Uint8List.fromList([0]);
          var decodedImage = await decodeImageFromList(originalBytes);
          height = decodedImage.height.toDouble();
          width = decodedImage.width.toDouble();
          emit(SaveCropDocumentFailedState(
            documentType: event.documentType,
            reason:
                'Your selected document is not saved in your device, but uploaded into our server',
            imageEditorController: event.imageEditorController,
            xfile: event.xfile,
            file: event.file,
            bytes: event.bytes,
            byteData: event.byteData,
            height: height,
            width: width,
          ));
          return;
        } else {
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
          double height = 0.0;
          double width = 0.0;
          final Uint8List originalBytes = await event.xfile?.readAsBytes() ??
              event.file?.readAsBytesSync() ??
              event.bytes as Uint8List? ??
              Uint8List.fromList([0]);
          var decodedImage = await decodeImageFromList(originalBytes);
          height = decodedImage.height.toDouble();
          width = decodedImage.width.toDouble();
          emit(
            SaveCropDocumentSuccessState(
              documentType: event.documentType,

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
              height: height,
              width: width,
            ),
          );
          return;
        }
      }
    } catch (e, s) {
      emit(SaveCropDocumentErrorState(
        documentType: event.documentType,
        reason: '$e',
        stackTrace: s,
      ));
    }
  }

  Future<void> _assetsRemove(
      AssetsRemove value, Emitter<BusinessDocumentState> emit) async {}

  Future<void> _saveBusinessDocument(
      SaveBusinessDocument event, Emitter<BusinessDocumentState> emit) async {
    try {
      final DataSourceState<List<NewBusinessDocumentEntity>> results =
          await serviceLocator<SaveAllDocumentUseCase>()(
              event.allBusinessDocuments.toList());
      await results.when(
        remote: (data, meta) async {
          appLog.d('Business Document bloc save remote ${data?.length}');
          if (data.isNotNullOrEmpty) {
            await updateUserProfile(data!.toList());
          }
          emit(
            SaveBusinessDocumentState(
              allBusinessDocuments: data ?? event.allBusinessDocuments.toList(),
              hasEditBusinessDocument: event.hasEditBusinessDocument,
            ),
          );
        },
        localDb: (data, meta) async {
          appLog.d('Business Document bloc save local ${data?.length}');
          if (data.isNotNullOrEmpty) {
            await updateUserProfile(data!.toList());
          }
          emit(
            SaveBusinessDocumentState(
              allBusinessDocuments: data ?? event.allBusinessDocuments.toList(),
              hasEditBusinessDocument: event.hasEditBusinessDocument,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Business Document bloc save error $reason');
          emit(
            BusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessDocumentStatus:
                  BusinessDocumentStatus.saveBusinessDocument,
            ),
          );
        },
      );

      return;
    } catch (e, s) {
      appLog.e('Business Document bloc save exception $e');
      emit(
        BusinessDocumentExceptionState(
          message:
              'Something went wrong during saving your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessDocumentStatus: BusinessDocumentStatus.saveBusinessDocument,
        ),
      );
    }
  }

  Future<void> updateUserProfile(
      List<NewBusinessDocumentEntity> allBusinessDocuments) async {
    final getCurrentUserResult =
        await serviceLocator<GetAllAppUserPaginationUseCase>()();
    await getCurrentUserResult.when(
      remote: (data, meta) {},
      localDb: (data, meta) async {
        if (data.isNotNullOrEmpty) {
          appLog.d('Document GetAllAppUserPaginationUseCase is not null');
          data!.forEach((element) {
            appLog.d('${element.toMap()}');
          });
          final AppUserEntity cacheAppUserEntity = data.last.copyWith(
            userID: data.last.userID,
            businessProfile: data.last.businessProfile
                ?.copyWith(allBusinessDocuments: allBusinessDocuments),
            currentUserStage: 4,
          );
          final editUserResult = await serviceLocator<SaveAllAppUserUseCase>()(
            [cacheAppUserEntity],
          );
          editUserResult.when(
            remote: (data, meta) {
              appLog.d(
                  'Update current user with business profile save remote ${data?.last.toMap()}');
            },
            localDb: (data, meta) {
              appLog.d(
                  'Update current user with business profile save local ${data?.last.toMap()}');
              if (data != null) {
                var cachedAppUserEntity = serviceLocator<AppUserEntity>()
                  ..currentUserStage = 4
                  ..businessProfile = data.last.businessProfile
                      ?.copyWith(allBusinessDocuments: allBusinessDocuments);
                serviceLocator<UserModelStorageController>()
                    .setUserModel(cachedAppUserEntity);
              }
            },
            error: (dataSourceFailure, reason, error, networkException,
                stackTrace, exception, extra) {
              appLog.d(
                  'Update current user with business profile exception $error');
            },
          );
        } else {
          appLog.d('Document GetAllAppUserPaginationUseCase is null');
        }
      },
      error: (dataSourceFailure, reason, error, networkException, stackTrace,
          exception, extra) {
        appLog.d('Document updateUserProfile $reason ');
      },
    );
    return;
  }

  Future<void> _deleteAllBusinessDocument(DeleteAllBusinessDocument event,
      Emitter<BusinessDocumentState> emit) async {
    try {
      final DataSourceState<bool> result =
          await serviceLocator<DeleteAllDocumentUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Business Document bloc delete all remote $data');
          emit(
            DeleteAllBusinessDocumentState(
              allBusinessDocuments: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Business Document bloc delete all local $data');
          emit(
            DeleteAllBusinessDocumentState(
              allBusinessDocuments: [],
              hasDeleteAll: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace,
            exception, extra) {
          appLog.d('Business Document bloc delete all error $reason');
          emit(
            BusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessDocumentStatus:
                  BusinessDocumentStatus.deleteAllBusinessDocument,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Business Document bloc delete all exception $e');
      emit(
        BusinessDocumentExceptionState(
          message:
              'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessDocumentStatus:
              BusinessDocumentStatus.deleteAllBusinessDocument,
        ),
      );
    }
  }

  Future<void> _deleteBusinessDocument(
      DeleteBusinessDocument event, Emitter<BusinessDocumentState> emit) async {
    /*try {
      final DataSourceState<bool> result = await serviceLocator<DeleteDocumentUseCase>()(
        input: event.businessDocumentUploadedEntity,
        id: event.documentID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Business Document bloc delete remote $data');
          emit(
            DeleteBusinessDocumentState(
              businessDocumentUploadedEntity: event.businessDocumentUploadedEntity,
              currentIndex: event.currentIndex,
              allBusinessDocuments: event.allBusinessDocuments.toList(),
              documentID: event.documentID,
              hasDelete: data ?? false,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Business Document bloc delete local $data');
          emit(
            DeleteBusinessDocumentState(
              businessDocumentUploadedEntity: event.businessDocumentUploadedEntity,
              currentIndex: event.currentIndex,
              allBusinessDocuments: event.allBusinessDocuments.toList(),
              documentID: event.documentID,
              hasDelete: data ?? false,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Business Document bloc delete error $reason');
          emit(
            BusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessDocumentStatus: BusinessDocumentStatus.deleteBusinessDocument,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Business Document bloc delete exception $e');
      emit(
        BusinessDocumentExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessDocumentStatus: BusinessDocumentStatus.deleteBusinessDocument,
        ),
      );
    }*/
  }

  Future<void> _getAllBusinessDocument(
      GetAllBusinessDocument event, Emitter<BusinessDocumentState> emit) async {
    /*try {
      emit(BusinessDocumentLoadingState(message: 'Please wait while we are fetching your profile...'));
      final DataSourceState<List<BusinessDocumentUploadedEntity>> result = await serviceLocator<GetAllDocumentUseCase>()();
      result.when(
        remote: (data, meta) {
          appLog.d('Business Document bloc get all remote');
          if (data == null || data.isEmpty) {
            emit(
              BusinessDocumentEmptyState(
                message: 'Business Document is empty',
                allBusinessDocuments: [],
                businessDocumentStatus: BusinessDocumentStatus.getAllBusinessDocument,
              ),
            );
          } else {
            emit(
              GetAllBusinessDocumentState(
                allBusinessDocuments: data.toList(),
              ),
            );
          }
        },
        localDb: (data, meta) {
          appLog.d('Business Document bloc get all local');
          if (data == null || data.isEmpty) {
            emit(
              BusinessDocumentEmptyState(
                message: 'Business Document is empty',
                allBusinessDocuments: [],
                businessDocumentStatus: BusinessDocumentStatus.getAllBusinessDocument,
              ),
            );
          } else {
            emit(
              GetAllBusinessDocumentState(
                allBusinessDocuments: data.toList(),
              ),
            );
          }
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Business Document bloc get all error $reason');
          emit(
            BusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessDocumentStatus: BusinessDocumentStatus.getAllBusinessDocument,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Business Document bloc get all $e');
      emit(
        BusinessDocumentExceptionState(
          message: 'Something went wrong during getting your all stores, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessDocumentStatus: BusinessDocumentStatus.getAllBusinessDocument,
        ),
      );
    }*/
  }

  Future<void> _getBusinessDocument(
      GetBusinessDocument event, Emitter<BusinessDocumentState> emit) async {
    /*try {
      final DataSourceState<BusinessDocumentUploadedEntity> result = await serviceLocator<GetDocumentUseCase>()(
        input: event.businessDocumentUploadedEntity,
        id: event.documentID,
      );
      result.when(
        remote: (data, meta) {
          appLog.d('Business Document bloc edit remote ${data?.toMap()}');
          emit(
            GetBusinessDocumentState(
              businessDocumentUploadedEntity: data ?? event.businessDocumentUploadedEntity,
              currentIndex: event.currentIndex,
              documentID: event.documentID,
            ),
          );
        },
        localDb: (data, meta) {
          appLog.d('Business Document bloc edit local ${data?.toMap()}');
          emit(
            GetBusinessDocumentState(
              businessDocumentUploadedEntity: data ?? event.businessDocumentUploadedEntity,
              currentIndex: event.currentIndex,
              documentID: event.documentID,
            ),
          );
        },
        error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
          appLog.d('Business Document bloc edit error $reason');
          emit(
            BusinessDocumentExceptionState(
              message: reason,
              //exception: e as Exception,
              stackTrace: stackTrace,
              businessDocumentStatus: BusinessDocumentStatus.getBusinessDocument,
            ),
          );
        },
      );
    } catch (e, s) {
      appLog.e('Business Document bloc get exception $e');
      emit(
        BusinessDocumentExceptionState(
          message: 'Something went wrong during getting your store details, please try again',
          //exception: e as Exception,
          stackTrace: s,
          businessDocumentStatus: BusinessDocumentStatus.getBusinessDocument,
        ),
      );
    }*/
  }
}
