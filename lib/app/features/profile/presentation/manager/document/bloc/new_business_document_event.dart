part of 'new_business_document_bloc.dart';

abstract class NewBusinessDocumentEvent extends Equatable {
  const NewBusinessDocumentEvent();
}

class UploadNewBusinessDocument extends NewBusinessDocumentEvent {
  const UploadNewBusinessDocument({
    this.businessDocumentUploadedEntity,
    this.hasNewUploadBusinessDocument = false,
    this.allBusinessDocuments=const [],
    this.hasEditBusinessDocument=false,
    this.currentIndex=-1,this.businessDocumentStatus=BusinessDocumentStatus.none,
  });
  final bool hasNewUploadBusinessDocument;
  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;
  final List<NewBusinessDocumentEntity> allBusinessDocuments;
  final BusinessDocumentStatus businessDocumentStatus;
  final bool hasEditBusinessDocument;
  final int currentIndex;

  @override
  List<Object?> get props => [businessDocumentUploadedEntity, hasNewUploadBusinessDocument];
}

class DeleteNewUploadBusinessDocument extends NewBusinessDocumentEvent {
  const DeleteNewUploadBusinessDocument({this.businessDocumentUploadedEntity, this.documentID = -1});
  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;
  final int documentID;

  @override
  List<Object?> get props => [businessDocumentUploadedEntity, documentID];
}

class DeleteAllNewUploadBusinessDocument extends NewBusinessDocumentEvent {
  const DeleteAllNewUploadBusinessDocument();

  @override
  List<Object?> get props => [];
}

class GetNewUploadBusinessDocument extends NewBusinessDocumentEvent {
  const GetNewUploadBusinessDocument({this.businessDocumentUploadedEntity, this.documentID = -1});
  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;
  final int documentID;

  @override
  List<Object?> get props => [businessDocumentUploadedEntity, documentID];
}

class GetAllNewUploadBusinessDocument extends NewBusinessDocumentEvent {
  const GetAllNewUploadBusinessDocument({
    this.pageKey = 0,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get props => [
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}
