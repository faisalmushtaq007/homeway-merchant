part of 'business_document_bloc.dart';

@freezed
class BusinessDocumentState with _$BusinessDocumentState {
  const factory BusinessDocumentState.initial() = BusinessDocumentInitial;

  const factory BusinessDocumentState.assetsUploadingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = AssetsUploadingState;

  const factory BusinessDocumentState.assetsUploadSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsUploadSuccessState;

  const factory BusinessDocumentState.assetsUploadFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
  }) = AssetsUploadFailedState;

  const factory BusinessDocumentState.tradeLicenseNumberOnChangedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required TextEditingController textEditingController,
    @Default('') String currentUpdatedValue,
    @Default(0) int index,
  }) = TradeLicenseNumberOnChangedState;

  const factory BusinessDocumentState.assetsRemoveFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
  }) = AssetsRemoveFailedState;

  const factory BusinessDocumentState.assetsRemoveSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
  }) = AssetsRemoveSuccessState;

  const factory BusinessDocumentState.documentRemoveState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = DocumentRemoveState;

  const factory BusinessDocumentState.documentRemovingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = DocumentRemovingState;

  const factory BusinessDocumentState.documentRemoveFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = DocumentRemoveFailedState;

  const factory BusinessDocumentState.saveAndNextState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = SaveAndNextState;

  const factory BusinessDocumentState.backState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = BackState;

  const factory BusinessDocumentState.askConfirmationState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = AskConfirmationState;

  const factory BusinessDocumentState.confirmationYesState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationYesState;

  const factory BusinessDocumentState.askConfirmationNoState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationNoState;

  const factory BusinessDocumentState.uploadNewAssetsState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = UploadNewAssetsState;

  const factory BusinessDocumentState.uploadButtonState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(-1) int index,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(true) bool hasVisible,
  }) = UploadButtonState;

  const factory BusinessDocumentState.addNewDocumentState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(true) bool isTextFieldEnable,
  }) = AddNewDocumentState;

  const factory BusinessDocumentState.captureImageFromCameraSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCameraSuccessState;
  const factory BusinessDocumentState.captureImageFromCameraProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCameraFailedProcessingState;
  const factory BusinessDocumentState.captureImageFromCameraFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCameraFailedState;
  const factory BusinessDocumentState.selectImageFromGalleryProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGalleryProcessingState;
  const factory BusinessDocumentState.selectImageFromGallerySuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGallerySuccessState;
  const factory BusinessDocumentState.selectImageFromGalleryFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGalleryFailedState;

  const factory BusinessDocumentState.restoreCaptureImageFromCameraState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreCaptureImageFromCameraState;

  const factory BusinessDocumentState.restoreSelectImageFromGalleryState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreSelectImageFromGalleryState;

  const factory BusinessDocumentState.openMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(ImageSource.gallery) ImageSource imageSource,
  }) = OpenMediaPickerState;
}
