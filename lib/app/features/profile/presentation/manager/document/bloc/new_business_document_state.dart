part of 'new_business_document_bloc.dart';

enum UploadBusinessDocumentStatus {
  initial,
  loading,
  loaded,
  error,
  get,
  getAll,
  delete,
  deleteAll,
  save,
  update,
}

abstract class NewBusinessDocumentState extends Equatable {
  const NewBusinessDocumentState();
}

class NewBusinessDocumentInitial extends NewBusinessDocumentState {
  @override
  List<Object> get props => [];
}

class UploadNewBusinessDocumentState extends NewBusinessDocumentState {
  const UploadNewBusinessDocumentState({
    this.businessDocumentUploadedEntity,
    this.status = UploadBusinessDocumentStatus.initial,
    this.hasNewUploadBusinessDocument = false,
    this.allBusinessDocuments=const [],
    this.hasEditBusinessDocument=false,
    this.currentIndex=-1,this.businessDocumentStatus=BusinessDocumentStatus.none,
  });

  final UploadBusinessDocumentStatus status;
  final bool hasNewUploadBusinessDocument;
  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;
  final List<NewBusinessDocumentEntity> allBusinessDocuments;
  final BusinessDocumentStatus businessDocumentStatus;
  final bool hasEditBusinessDocument;
  final int currentIndex;

  @override
  List<Object?> get props => [hasNewUploadBusinessDocument, status, businessDocumentUploadedEntity];
}

class DeleteNewBusinessDocumentState extends NewBusinessDocumentState {
  const DeleteNewBusinessDocumentState({
    this.status = UploadBusinessDocumentStatus.initial,
    this.hasDeleteUploadedDocument = false,
  });

  final UploadBusinessDocumentStatus status;
  final bool hasDeleteUploadedDocument;

  @override
  List<Object?> get props => [status, hasDeleteUploadedDocument];
}

class DeleteAllNewBusinessDocumentState extends NewBusinessDocumentState {
  const DeleteAllNewBusinessDocumentState({
    this.status = UploadBusinessDocumentStatus.initial,
    this.hasDeleteAllUploadedDocument = false,
  });

  final UploadBusinessDocumentStatus status;
  final bool hasDeleteAllUploadedDocument;

  @override
  List<Object?> get props => [status, hasDeleteAllUploadedDocument];
}

class GetNewBusinessDocumentState extends NewBusinessDocumentState {
  const GetNewBusinessDocumentState({
    this.status = UploadBusinessDocumentStatus.initial,
    this.businessDocumentUploadedEntity,
  });

  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;

  final UploadBusinessDocumentStatus status;

  @override
  List<Object?> get props => [];
}

class GetAllNewUploadBusinessDocumentState extends NewBusinessDocumentState {
  const GetAllNewUploadBusinessDocumentState({
    this.pageKey = 0,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.status = UploadBusinessDocumentStatus.initial,
    this.businessDocumentEntities = const [],
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;
  final UploadBusinessDocumentStatus status;
  final List<NewBusinessDocumentEntity> businessDocumentEntities;

  @override
  List<Object?> get props => [
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        status,
        businessDocumentEntities,
      ];
}

class NewBusinessDocumentLoadingState extends NewBusinessDocumentState {
  const NewBusinessDocumentLoadingState({
    this.isLoading = true,
    this.message = '',
  });

  final bool isLoading;
  final String message;

  @override
  List<Object?> get props => [
        isLoading,
        message,
      ];
}

class NewBusinessDocumentProcessingState extends NewBusinessDocumentState {
  const NewBusinessDocumentProcessingState({
    this.isProcessing = true,
    this.message = '',
  });

  final bool isProcessing;
  final String message;

  @override
  List<Object?> get props => [
        isProcessing,
        message,
      ];
}

class NewBusinessDocumentFailedState extends NewBusinessDocumentState {
  const NewBusinessDocumentFailedState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class NewBusinessDocumentExceptionState extends NewBusinessDocumentState {
  const NewBusinessDocumentExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.status = UploadBusinessDocumentStatus.initial,
  });

  final UploadBusinessDocumentStatus status;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get props => [
        message,
        stackTrace,
        exception,
        status,
      ];
}

class NewBusinessDocumentEmptyState extends NewBusinessDocumentState {
  const NewBusinessDocumentEmptyState({
    this.businessDocumentEntities = const [],
    this.message = '',
    this.status = UploadBusinessDocumentStatus.initial,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final List<NewBusinessDocumentEntity> businessDocumentEntities;
  final String message;
  final UploadBusinessDocumentStatus status;
  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get props => [
        businessDocumentEntities,
        message,
        status,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}

