import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_picker_source_enum.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/document/business_document_uploaded_entity.dart';
import 'package:image_picker/image_picker.dart';

part 'business_document_event.dart';

part 'business_document_state.dart';

part 'business_document_bloc.freezed.dart';

class BusinessDocumentBloc
    extends Bloc<BusinessDocumentEvent, BusinessDocumentState> {
  BusinessDocumentBloc() : super(const BusinessDocumentInitial()) {
    on<OpenMediaPicker>(_openMediaPicker);
    on<CloseMediaPicker>(_closeMediaPicker);
    on<SelectDocumentSourceType>(_selectDocumentSourceType);
  }

  final ImagePicker _picker = ImagePicker();

  FutureOr<void> _openMediaPicker(
      OpenMediaPicker event, Emitter<BusinessDocumentState> emit) {
    emit(OpenMediaPickerState(documentType: event.documentType));
  }

  FutureOr<void> _closeMediaPicker(
      CloseMediaPicker event, Emitter<BusinessDocumentState> emit) {
    emit(CloseMediaPickerState(documentType: event.documentType));
  }

  FutureOr<void> _selectDocumentSourceType(SelectDocumentSourceType event,
      Emitter<BusinessDocumentState> emit) async {
    try {
      ImageSource source = ImageSource.camera;
      File? response;
      emit(SelectDocumentSourceTypState(
        documentType: event.documentType,
        documentPickerSource: event.documentPickerSource,
        imageSource: event.imageSource,
      ));
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        source = ImageSource.camera;
      } else {
        source = ImageSource.gallery;
      }
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        response = File(pickedFile.path);
      }
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        emit(
          CaptureImageFromCameraSuccessState(
            documentType: event.documentType,
            pickedFile: pickedFile,
            responseFile: response,
          ),
        );
      } else {
        emit(SelectImageFromGallerySuccessState(
          documentType: event.documentType,
          pickedFile: pickedFile,
          responseFile: response,
        ));
      }
    } catch (e) {
      if (event.documentPickerSource == DocumentPickerSource.camera) {
        emit(
          CaptureImageFromCameraFailedState(
            documentType: event.documentType,
          ),
        );
      } else {
        emit(
          SelectImageFromGalleryFailedState(
            documentType: event.documentType,
          ),
        );
      }
    }
  }
}
