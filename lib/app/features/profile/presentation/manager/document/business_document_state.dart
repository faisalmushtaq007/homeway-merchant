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

  const factory BusinessDocumentState.askConfirmationFailedState({
    @Default([]) List<BusinessDocumentUploadedEntity> allBusinessDocuments,
    @Default('') String message,
  }) = AskConfirmationFailedState;

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
    File? responseFile,
    XFile? pickedFile,
    Uint8List? uint8list,
    @Default({}) Map<String, dynamic> metaData,
  }) = CaptureImageFromCameraSuccessState;

  const factory BusinessDocumentState.captureImageFromCameraProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CaptureImageFromCameraFailedProcessingState;

  const factory BusinessDocumentState.captureImageFromCameraFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = CaptureImageFromCameraFailedState;

  const factory BusinessDocumentState.selectImageFromGalleryProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SelectImageFromGalleryProcessingState;

  const factory BusinessDocumentState.selectImageFromGallerySuccessState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    File? responseFile,
    XFile? pickedFile,
    Uint8List? uint8list,
    @Default({}) Map<String, dynamic> metaData,
  }) = SelectImageFromGallerySuccessState;

  const factory BusinessDocumentState.selectImageFromGalleryFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = SelectImageFromGalleryFailedState;

  const factory BusinessDocumentState.restoreCaptureImageFromCameraState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    Uint8List? uint8list,
  }) = RestoreCaptureImageFromCameraState;

  const factory BusinessDocumentState.restoreSelectImageFromGalleryState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    Uint8List? uint8list,
  }) = RestoreSelectImageFromGalleryState;

  const factory BusinessDocumentState.restoreCaptureImageFromCameraFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = RestoreCaptureImageFromCameraFailedState;

  const factory BusinessDocumentState.restoreSelectImageFromGalleryFailedState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default('') String message,
  }) = RestoreSelectImageFromGalleryFailedState;

  const factory BusinessDocumentState.openMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = OpenMediaPickerState;

  const factory BusinessDocumentState.selectDocumentSourceTypeState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(ImageSource.camera) ImageSource imageSource,
    @Default(DocumentPickerSource.camera)
    DocumentPickerSource documentPickerSource,
  }) = SelectDocumentSourceTypState;

  const factory BusinessDocumentState.closeMediaPickerState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = CloseMediaPickerState;

  const factory BusinessDocumentState.cropState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required AspectRatioItem aspectRatioItem,
    XFile? xfile,
    File? file,
    required ExtendedImageEditorState extendedImageEditorState,
    Uint8List? bytes,
    @Default(false) bool isCropping,
  }) = AssetCropState;

  const factory BusinessDocumentState.rightRotateState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetRightRotateState;

  const factory BusinessDocumentState.leftRotateState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    @Default(true) hasRightTurn,
  }) = AssetLeftRotateState;

  const factory BusinessDocumentState.flipState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = AssetFlipState;

  const factory BusinessDocumentState.resetAssetState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    AspectRatioItem? aspectRatioItem,
  }) = ResetAssetState;

  const factory BusinessDocumentState.resetAllState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = ResetAllAssetState;

  const factory BusinessDocumentState.saveCropDocumentSuccessState({
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
  }) = SaveCropDocumentSuccessState;

  const factory BusinessDocumentState.saveCropDocumentProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SaveCropDocumentProcessingState;

  const factory BusinessDocumentState.saveCropDocumentHideProcessingState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
  }) = SaveCropDocumentHideProcessingState;

  const factory BusinessDocumentState.saveCropDocumentFailedState({
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
  const factory BusinessDocumentState.saveCropDocumentErrorState({
    @Default(DocumentType.tradeLicence) DocumentType documentType,
    required String reason,
    StackTrace? stackTrace,
  }) = SaveCropDocumentErrorState;
}
