part of 'business_document_bloc.dart';

@freezed
class BusinessDocumentState with _$BusinessDocumentState {
  factory BusinessDocumentState.initial() = BusinessDocumentInitial;

  factory BusinessDocumentState.assetsUploadingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = AssetsUploadingState;

  factory BusinessDocumentState.assetsUploadSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = AssetsUploadSuccessState;

  factory BusinessDocumentState.assetsUploadFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
  }) = AssetsUploadFailedState;

  factory BusinessDocumentState.tradeLicenseNumberOnChangedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required TextEditingController textEditingController,
    @Default('') String currentUpdatedValue,
    @Default(0) int index,
  }) = TradeLicenseNumberOnChangedState;

  factory BusinessDocumentState.assetsRemoveFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = AssetsRemoveFailedState;
  factory BusinessDocumentState.assetsRemovingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = AssetsRemovingState;
  factory BusinessDocumentState.assetsRemoveSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    required int currentIndex,
    @Default([]) List<dynamic> uploadedData,
  }) = AssetsRemoveSuccessState;

  factory BusinessDocumentState.documentRemoveState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default(-1) int index,
    required int currentIndex,
    @Default([]) List<dynamic> uploadedData,
  }) = DocumentRemoveState;

  factory BusinessDocumentState.documentRemovingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = DocumentRemovingState;

  factory BusinessDocumentState.documentRemoveFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default(-1) int index,
  }) = DocumentRemoveFailedState;

  factory BusinessDocumentState.addNewDocumentState({
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
  }) = AddNewDocumentState;

  factory BusinessDocumentState.addNewAssetState({
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
  }) = AddNewAssetState;

  factory BusinessDocumentState.saveAndNextState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = SaveAndNextState;

  factory BusinessDocumentState.backState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = BackState;

  factory BusinessDocumentState.askConfirmationState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = AskConfirmationState;

  factory BusinessDocumentState.askConfirmationFailedState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default('') String message,
  }) = AskConfirmationFailedState;

  factory BusinessDocumentState.confirmationYesState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationYesState;

  factory BusinessDocumentState.askConfirmationNoState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
  }) = ConfirmationNoState;

  factory BusinessDocumentState.uploadNewAssetsState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) bool hasFrontSideAssets,
    BusinessDocumentAssetsEntity? businessDocumentAssetsEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentAssetsEntity> assetsEntries,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
  }) = UploadNewAssetsState;

  factory BusinessDocumentState.uploadButtonState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(-1) int index,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(true) bool hasVisible,
  }) = UploadButtonState;

  factory BusinessDocumentState.captureImageFromCameraSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    File? responseFile,
    XFile? pickedFile,
    Uint8List? uint8list,
    @Default({}) Map<String, dynamic> metaData,
  }) = CaptureImageFromCameraSuccessState;

  factory BusinessDocumentState.captureImageFromCameraProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCameraFailedProcessingState;

  factory BusinessDocumentState.captureImageFromCameraFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = CaptureImageFromCameraFailedState;

  factory BusinessDocumentState.selectImageFromGalleryProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGalleryProcessingState;

  factory BusinessDocumentState.selectImageFromGallerySuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    File? responseFile,
    XFile? pickedFile,
    Uint8List? uint8list,
    @Default({}) Map<String, dynamic> metaData,
  }) = SelectImageFromGallerySuccessState;

  factory BusinessDocumentState.selectImageFromGalleryFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = SelectImageFromGalleryFailedState;

  factory BusinessDocumentState.restoreCaptureImageFromCameraState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    Uint8List? uint8list,
  }) = RestoreCaptureImageFromCameraState;

  factory BusinessDocumentState.restoreSelectImageFromGalleryState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    Uint8List? uint8list,
  }) = RestoreSelectImageFromGalleryState;

  factory BusinessDocumentState.restoreCaptureImageFromCameraFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = RestoreCaptureImageFromCameraFailedState;

  factory BusinessDocumentState.restoreSelectImageFromGalleryFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = RestoreSelectImageFromGalleryFailedState;

  factory BusinessDocumentState.openMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = OpenMediaPickerState;

  factory BusinessDocumentState.selectDocumentSourceTypeState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(ImageSource.camera) ImageSource imageSource,
    @Default(DocumentPickerSource.camera) DocumentPickerSource documentPickerSource,
  }) = SelectDocumentSourceTypState;

  factory BusinessDocumentState.closeMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CloseMediaPickerState;

  factory BusinessDocumentState.cropState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    XFile? xfile,
    File? file,
    Uint8List? bytes,
    @Default(false) bool isCropping,
  }) = AssetCropState;

  factory BusinessDocumentState.rightRotateState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetRightRotateState;

  factory BusinessDocumentState.leftRotateState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetLeftRotateState;

  factory BusinessDocumentState.flipState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = AssetFlipState;

  factory BusinessDocumentState.resetAssetState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAssetState;

  factory BusinessDocumentState.resetAllState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAllAssetState;

  factory BusinessDocumentState.saveCropDocumentSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    XFile? xfile,
    File? file,
    Uint8List? bytes,
    ByteData? byteData,
    EditImageInfo? imageInfo,
    @Default(false) bool isCropping,
    @Default('') String message,
    XFile? newXFile,
    File? newFile,
    @Default('') String newFilePath,
    ImageEditorController? imageEditorController,
    Image? image,
    String? assetNetworkUrl,
  }) = SaveCropDocumentSuccessState;

  factory BusinessDocumentState.saveCropDocumentProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SaveCropDocumentProcessingState;

  factory BusinessDocumentState.saveCropDocumentHideProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SaveCropDocumentHideProcessingState;

  factory BusinessDocumentState.saveCropDocumentFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required String reason,
    StackTrace? stackTrace,
    XFile? xfile,
    File? file,
    Uint8List? bytes,
    ByteData? byteData,
    EditImageInfo? imageInfo,
    @Default(false) bool isCropping,
    ImageEditorController? imageEditorController,
    Image? image,
  }) = SaveCropDocumentFailedState;
  factory BusinessDocumentState.saveCropDocumentErrorState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required String reason,
    StackTrace? stackTrace,
  }) = SaveCropDocumentErrorState;

  factory BusinessDocumentState.saveBusinessDocumentState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.saveBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    @Default(false) bool hasEditBusinessDocument,
    @Default(-1) int currentIndex,
  }) = SaveBusinessDocumentState;

  factory BusinessDocumentState.getBusinessDocumentState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.getBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default(-1) int currentIndex,
  }) = GetBusinessDocumentState;

  factory BusinessDocumentState.getAllBusinessDocumentState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.getAllBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = GetAllBusinessDocumentState;

  factory BusinessDocumentState.deleteBusinessDocumentState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.deleteBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default(-1) int currentIndex,
    @Default(false) bool hasDelete,
  }) = DeleteBusinessDocumentState;

  factory BusinessDocumentState.deleteAllBusinessDocumentState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.deleteAllBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
    @Default(-1) int documentID,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default(false) bool hasDeleteAll,
  }) = DeleteAllBusinessDocumentState;

  factory BusinessDocumentState.failedBusinessDocumentState({
    @Default('') String message,
    @Default(BusinessDocumentStatus.failedForBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = BusinessDocumentFailedState;

  factory BusinessDocumentState.loadingBusinessDocumentState({
    @Default('') String message,
    @Default(true) bool isLoading,
    @Default(BusinessDocumentStatus.loadingForBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = BusinessDocumentLoadingState;

  factory BusinessDocumentState.processingBusinessDocumentState({
    @Default('') String message,
    @Default(true) bool isProcessing,
    @Default(BusinessDocumentStatus.processingForBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = BusinessDocumentProcessingState;

  factory BusinessDocumentState.emptyBusinessDocumentState({
    @Default('') String message,
    @Default(true) bool isEmpty,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(BusinessDocumentStatus.emptyForBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = BusinessDocumentEmptyState;

  factory BusinessDocumentState.exceptionBusinessDocumentState({
    @Default('') String message,
    StackTrace? stackTrace,
    Exception? exception,
    @Default(BusinessDocumentStatus.exceptionForBusinessDocument) BusinessDocumentStatus businessDocumentStatus,
  }) = BusinessDocumentExceptionState;
}
