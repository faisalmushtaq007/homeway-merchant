part of 'business_document_bloc.dart';

@freezed
class BusinessDocumentEvent with _$BusinessDocumentEvent {
  const factory BusinessDocumentEvent() = _BusinessDocumentEvent;

  const factory BusinessDocumentEvent.assetsStartUploading({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsUploading;

  const factory BusinessDocumentEvent.tradeLicenseNumberOnChanged({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required TextEditingController textEditingController,
    @Default('') String currentUpdatedValue,
    @Default(0) int index,
  }) = TradeLicenseNumberOnChanged;

  const factory BusinessDocumentEvent.assetsRemove({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsRemove;

  const factory BusinessDocumentEvent.documentRemove({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = DocumentRemove;

  const factory BusinessDocumentEvent.saveAndNext({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = SaveAndNext;

  const factory BusinessDocumentEvent.back({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = Back;

  const factory BusinessDocumentEvent.askConfirmation({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = AskConfirmation;

  const factory BusinessDocumentEvent.confirmationYes({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationYes;

  const factory BusinessDocumentEvent.askConfirmationNo({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationNo;

  const factory BusinessDocumentEvent.uploadNewAssets({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = UploadNewAssets;

  const factory BusinessDocumentEvent.uploadButtonState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(-1) int index,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(true) bool hasVisible,
  }) = UploadButton;

  const factory BusinessDocumentEvent.addNewDocument({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(true) bool isTextFieldEnable,
  }) = AddNewDocument;

  const factory BusinessDocumentEvent.captureImageFromCamera({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCamera;
  const factory BusinessDocumentEvent.restoreCaptureImageFromCamera({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreCaptureImageFromCamera;
  const factory BusinessDocumentEvent.selectImageFromGallery({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGallery;
  const factory BusinessDocumentEvent.restoreSelectImageFromGallery({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreSelectImageFromGallery;

  const factory BusinessDocumentEvent.openMediaPicker({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = OpenMediaPicker;
  const factory BusinessDocumentEvent.selectDocumentSourceType({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(ImageSource.camera) ImageSource imageSource,
    @Default(DocumentPickerSource.camera)
    DocumentPickerSource documentPickerSource,
  }) = SelectDocumentSourceType;
  const factory BusinessDocumentEvent.closeMediaPicker({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CloseMediaPicker;
}
