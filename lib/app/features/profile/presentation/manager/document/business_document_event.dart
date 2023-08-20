part of 'business_document_bloc.dart';

@freezed
class BusinessDocumentEvent with _$BusinessDocumentEvent {
  factory BusinessDocumentEvent() = _BusinessDocumentEvent;

  factory BusinessDocumentEvent.assetsStartUploading({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsUploading;

  factory BusinessDocumentEvent.tradeLicenseNumberOnChanged({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required TextEditingController textEditingController,
    @Default('') String currentUpdatedValue,
    @Default(0) int index,
  }) = TradeLicenseNumberOnChanged;

  factory BusinessDocumentEvent.assetsRemove({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsRemove;

  factory BusinessDocumentEvent.documentRemove({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
  }) = DocumentRemove;

  factory BusinessDocumentEvent.saveAndNext({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = SaveAndNext;

  factory BusinessDocumentEvent.back({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = Back;

  factory BusinessDocumentEvent.askConfirmation({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = AskConfirmation;

  factory BusinessDocumentEvent.confirmationYes({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationYes;

  factory BusinessDocumentEvent.askConfirmationNo({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationNo;

  factory BusinessDocumentEvent.uploadNewAssets({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = UploadNewAssets;

  factory BusinessDocumentEvent.uploadButtonState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(-1) int index,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(true) bool hasVisible,
  }) = UploadButton;

  factory BusinessDocumentEvent.addNewDocument({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(false) bool isTextFieldEnable,
    required int newIndexPosition,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    required int currentIndex,
    @Default([]) List<dynamic> uploadedData,
  }) = AddNewDocument;

  factory BusinessDocumentEvent.addNewAsset({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(false) bool isTextFieldEnable,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    required int newIndexPosition,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    required int currentIndex,
    @Default([]) List<dynamic> uploadedData,
  }) = AddNewAsset;

  factory BusinessDocumentEvent.captureImageFromCamera({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCamera;

  factory BusinessDocumentEvent.restoreCaptureImageFromCamera({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreCaptureImageFromCamera;

  factory BusinessDocumentEvent.selectImageFromGallery({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGallery;

  factory BusinessDocumentEvent.restoreSelectImageFromGallery({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = RestoreSelectImageFromGallery;

  factory BusinessDocumentEvent.openMediaPicker({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = OpenMediaPicker;

  factory BusinessDocumentEvent.selectDocumentSourceType({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(ImageSource.camera) ImageSource imageSource,
    @Default(DocumentPickerSource.camera) DocumentPickerSource documentPickerSource,
  }) = SelectDocumentSourceType;

  factory BusinessDocumentEvent.closeMediaPicker({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CloseMediaPicker;

  factory BusinessDocumentEvent.crop({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    XFile? xfile,
    File? file,
    Uint8List? bytes,
    @Default(false) bool isCropping,
  }) = AssetCrop;

  factory BusinessDocumentEvent.rightRotate({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetRightRotate;

  factory BusinessDocumentEvent.leftRotate({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetLeftRotate;

  factory BusinessDocumentEvent.flip({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = AssetFlip;

  factory BusinessDocumentEvent.resetAsset({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAsset;

  factory BusinessDocumentEvent.resetAll({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAllAsset;

  factory BusinessDocumentEvent.saveCropDocument({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    XFile? xfile,
    File? file,
    Uint8List? bytes,
    ByteData? byteData,
    EditImageInfo? imageInfo,
    @Default(false) bool isCropping,
    ImageEditorController? imageEditorController,
    Image? image,
  }) = SaveCropDocument;

  factory BusinessDocumentEvent.saveBusinessDocument({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.none) BusinessDocumentStatus businessDocumentStatus,
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    @Default(false) bool hasEditBusinessDocument,
    @Default(-1) int currentIndex,
  }) = SaveBusinessDocument;

  factory BusinessDocumentEvent.getBusinessDocument({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.none) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default(-1) int currentIndex,
  }) = GetBusinessDocument;

  factory BusinessDocumentEvent.getAllBusinessDocument({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.none) BusinessDocumentStatus businessDocumentStatus,
    @Default(1) int pageKey,
    @Default(10) int pageSize,
    @Default('') String searchItem,
  }) = GetAllBusinessDocument;

  factory BusinessDocumentEvent.deleteBusinessDocument({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.none) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default(-1) int currentIndex,
  }) = DeleteBusinessDocument;

  factory BusinessDocumentEvent.deleteAllBusinessDocument({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.none) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  }) = DeleteAllBusinessDocument;
}
