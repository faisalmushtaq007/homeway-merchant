part of 'package:homemakers_merchant/app/features/profile/index.dart';

class NewBusinessDocumentComponentWidget extends StatefulWidget {
  const NewBusinessDocumentComponentWidget({
    required super.key,
    required this.documentPlaceHolderWidget,
    required this.documentPlaceHolderImage,
    required this.animate,
    required this.currentIndex,
    this.hasEditBusinessDocument = false,
    this.businessDocumentUploadedEntities = const [],
    this.businessDocumentUploadedEntity,
    this.enableTextField = false,
    this.documentType = DocumentType.other,
    this.customCloseButton,
    required this.selectedImageMetaData,
  });

  final int currentIndex;
  final List<NewBusinessDocumentEntity> businessDocumentUploadedEntities;
  final bool hasEditBusinessDocument;
  final NewBusinessDocumentEntity? businessDocumentUploadedEntity;
  final bool enableTextField;
  final DocumentType documentType;
  final Widget documentPlaceHolderWidget;
  final String documentPlaceHolderImage;
  final bool animate;
  final Widget? customCloseButton;
  final void Function(
          Map<String, dynamic> metaData, CaptureImageEntity captureImageEntity)
      selectedImageMetaData;

  @override
  _NewBusinessDocumentComponentWidgetController createState() =>
      _NewBusinessDocumentComponentWidgetController();
}

class _NewBusinessDocumentComponentWidgetController
    extends State<NewBusinessDocumentComponentWidget>
    with SingleTickerProviderStateMixin {
  bool enableTextField = false;
  bool hasAssetsPath = false;
  List<BannerModel> listBanners = [];
  DocumentType documentType = DocumentType.other;
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  NewBusinessDocumentEntity? businessDocumentUploadedEntity;

  @override
  void initState() {
    super.initState();
    enableTextField = widget.enableTextField;
    documentType = widget.documentType;
    listBanners = [];
    listBanners.clear();
    if (widget.animate) controller.repeat();
    if (widget.businessDocumentUploadedEntity.isNotNull) {
      businessDocumentUploadedEntity = widget.businessDocumentUploadedEntity;
      /*listBanners.insert(
        0,
        BannerModel(
          imagePath: croppedFilePath,
          id: businessDocumentUploadedEntity?.captureDocumentID,
          metaData: metaData,
        ),
      );*/
    }
  }

  @override
  void didUpdateWidget(covariant NewBusinessDocumentComponentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animate && !widget.animate) controller.stop();
    if (!oldWidget.animate && widget.animate) controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    listBanners = [];
    listBanners.clear();
    super.dispose();
  }

  Future<void> selectDocumentPicker(
      {DocumentType documentType = DocumentType.other}) async {
    // Navigate to document picker page
    final List<dynamic>? result = await context.push<List<dynamic>>(
      Routes.UPLOAD_DOCUMENT_PAGE,
      extra: jsonEncode(
        {
          'documentType': documentType.name,
        },
      ),
    );
    // Check is Result exists or not
    if (result != null && result.isNotEmpty) {
      // Extarct and store the value
      String filePath = result[0] as String;
      XFile? xCroppedDocumentFile = result[1] as XFile;
      File? croppedDocumentFile = result[2] as File;
      XFile? xFile = result[5] as XFile;
      File? file = result[6] as File;
      String? assetNetworkUrl = result[7] as String?;
      final int timeStamp = DateTime.now().millisecondsSinceEpoch;
      var tempName = 'homeway_document_image_$timeStamp';
      var fileNameWithExtension = path.basename(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
      var fileNameWithoutExtension = path.basenameWithoutExtension(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
      String fileExtension = path.extension(
          xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? '.png');
      String croppedFilePath = (xCroppedDocumentFile.path.isEmpty)
          ? xCroppedDocumentFile.path
          : croppedDocumentFile.path;
      final fileReadAsBytes = await file.readAsBytes();
      final xFileReadAsBytes = await xFile.readAsBytes();
      final fileReadAsString = base64Encode(fileReadAsBytes);
      final xFileReadAsString = base64Encode(xFileReadAsBytes);
      final uuid = const Uuid().v4();
      final String mimeType =
          xCroppedDocumentFile.mimeType ?? xFile.mimeType ?? 'image/png';
      var decodedImage =
          await decodeImageFromList(xFileReadAsBytes ?? fileReadAsBytes);
      double height = decodedImage.height.toDouble();
      double width = decodedImage.width.toDouble();

      final Map<String, dynamic> metaData = {
        'captureDocumentID': uuid,
        'originalFilePath': filePath,
        'croppedFilePath': croppedFilePath,
        'fileExtension': fileExtension,
        'fileNameWithExtension': fileNameWithExtension,
        'fileName': fileNameWithoutExtension,
        'originalFile': file,
        'xOriginalFile': xFile,
        'xCroppedFile': xCroppedDocumentFile,
        'croppedFile': croppedDocumentFile,
        'networkUrl': assetNetworkUrl,
        'fileReadAsBytes': fileReadAsBytes,
        'xFileReadAsBytes': xFileReadAsBytes,
        'fileReadAsString': fileReadAsString,
        'xFileReadAsString': xFileReadAsString,
        'documentType': widget.documentType.name,
        'blob': (xFileReadAsBytes.isNotNullOrEmpty)
            ? Blob(xFileReadAsBytes)
            : Blob(fileReadAsBytes),
        'base64': (xFileReadAsString.isNotEmpty)
            ? xFileReadAsString
            : fileReadAsString,
        'mimeType': mimeType,
        'height': height,
        'width': width,
      };
      final CaptureImageEntity captureImageEntity =
          CaptureImageEntity.fromMap(metaData);
      // Set Only single image, not list of images
      // when select new image, it will replace the old selected image
      listBanners = [];
      listBanners.clear();
      //
      listBanners.insert(
        0,
        BannerModel(
          imagePath: croppedFilePath,
          id: uuid,
          metaData: metaData,
        ),
      );
      widget.selectedImageMetaData(metaData, captureImageEntity);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) =>
      _NewBusinessDocumentComponentWidgetView(this);
}

class _NewBusinessDocumentComponentWidgetView extends WidgetView<
    NewBusinessDocumentComponentWidget,
    _NewBusinessDocumentComponentWidgetController> {
  const _NewBusinessDocumentComponentWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Stack(
        children: [
          BannerCarousel(
            banners: state.listBanners.toList(),
            customizedIndicators: const IndicatorModel.animation(
                width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
            height: context.width / 2.75,
            activeColor: Colors.amberAccent,
            disableColor: Colors.white,
            animation: true,
            margin: EdgeInsetsDirectional.zero,
            borderRadius: 10,
            onTap: (id) => print(id),
            //width: 250,
            indicatorBottom: false,
            showIndicator: false,
          ),
          GestureDetector(
            onTap: () {
              state.selectDocumentPicker(documentType: widget.documentType);
            },
            child: Align(
              alignment: Alignment.topRight,
              child: widget.customCloseButton ??
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(6),
                      child: Icon(
                        Icons.edit,
                        color: context.colorScheme.primary,
                        size: 18,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
      secondChild: InkWell(
        onTap: () {
          state.selectDocumentPicker(documentType: widget.documentType);
        },
        child: DottedBorder(
          animation: state.controller,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          // padding: EdgeInsets.all(6),
          borderPadding: const EdgeInsets.all(3),
          dashPattern: const [20, 4],
          strokeWidth: 1.5,
          childOnTop: true,
          color: context.colorScheme.onPrimaryContainer.withOpacity(0.5),
          child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: context.width / 3.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          Expanded(
                            flex: 3,
                            child: widget.documentPlaceHolderWidget,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: context.width / 6,
                              width: context.width / 6,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                child: ImageHelper(
                                  image: widget.documentPlaceHolderImage,
                                  filterQuality: FilterQuality.high,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                  imageType: findImageType(
                                      widget.documentPlaceHolderImage),
                                  imageShape: ImageShape.rectangle,
                                  boxFit: BoxFit.cover,
                                  defaultErrorBuilderColor: Colors.blueGrey,
                                  errorBuilder: const Icon(
                                    Icons.image_not_supported,
                                    size: 10000,
                                  ),
                                  loaderBuilder:
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      crossFadeState: (state.listBanners.isNotNullOrEmpty)
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
    );
  }
}
