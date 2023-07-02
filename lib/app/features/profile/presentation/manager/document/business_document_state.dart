part of 'business_document_bloc.dart';

@unfreezed
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
  }) = AssetsRemoveFailedState;

  factory BusinessDocumentState.assetsRemoveSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
    @Default(-1) int index,
  }) = AssetsRemoveSuccessState;

  factory BusinessDocumentState.documentRemoveState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String reason,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default(-1) int index,
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
    @Default(-1) int index,
  }) = DocumentRemoveFailedState;

  factory BusinessDocumentState.addNewDocumentState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(false) bool isTextFieldEnable,
    required int newIndexPosition,
  }) = AddNewDocumentState;

  factory BusinessDocumentState.addNewAssetState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(0) int indexOfTextField,
    @Default(false) bool isTextFieldEnable,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    required int newIndexPosition,
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
    @Default(DocumentPickerSource.camera)
    DocumentPickerSource documentPickerSource,
  }) = SelectDocumentSourceTypState;

  factory BusinessDocumentState.closeMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CloseMediaPickerState;

  factory BusinessDocumentState.cropState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required AspectRatioItem aspectRatioItem,
    XFile? xfile,
    File? file,
    required ExtendedImageEditorState extendedImageEditorState,
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
    AspectRatioItem? aspectRatioItem,
  }) = ResetAssetState;

  factory BusinessDocumentState.resetAllState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAllAssetState;

  factory BusinessDocumentState.saveCropDocumentSuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    XFile? xfile,
    File? file,
    ExtendedImageEditorState? extendedImageEditorState,
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
    ExtendedImageEditorState? extendedImageEditorState,
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
}
