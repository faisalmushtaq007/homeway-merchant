import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/document/business_document_uploaded_entity.dart';
import 'package:image_picker/image_picker.dart';

part 'business_document_event.dart';
part 'business_document_state.dart';
part 'business_document_bloc.freezed.dart';

class BusinessDocumentBloc
    extends Bloc<BusinessDocumentEvent, BusinessDocumentState> {
  BusinessDocumentBloc() : super(const BusinessDocumentInitial()) {
    on<BusinessDocumentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  final ImagePicker imagePicker = ImagePicker();
}
