part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage({this.documentType = DocumentType.tradeLicence, super.key});

  final DocumentType documentType;

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  List<File> _selectedImages = [];
  List<File> _editedImageFiles = [];
  int _currentImageIndex = 0;
  double _rotation = 0.0;
  double _zoom = 1.0;
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer(); //TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  late final ScrollController scrollController;

  DocumentPickerSource documentPickerSource = DocumentPickerSource.none;
  File? pickedSourceFile;
  ImageSource? type;
  XFile? pickedXSourceFile;
  DocumentPickerSourceStatus documentPickerSourceStatus = DocumentPickerSourceStatus.none;

  bool _cropping = false;
  Uint8List? selectedFileInBytes;

  Map<String, dynamic> fileMetaInfo = {};
  EditImageInfo? imageInfo;

  var controller = ImageEditorController();
  final editorConfig = DataEditorConfig(
      // Edit area background color
      // Configure the padding of the editing area
      cropRectPadding: const EdgeInsets.all(20.0),
      // Configure the length of the four corners of the viewfinder
      cornerLength: 30,
      // Configure the width of the four corners of the viewfinder
      cornerWidth: 4,
      // Configure the color of the four corners of the viewfinder
      cornerColor: Colors.blue,
      // Configure the click response area of the four corners of the viewfinder
      cornerHitTestSize: const Size(40, 40),
      // Configure the color of the four sides of the viewfinder
      lineColor: Colors.white,
      // Configure the color of the four sides of the viewfinder
      lineWidth: 2,
      // Configure the width of the four sides of the viewfinder frame
      lineHitTestWidth: 40,
      // Configure the length of each unit of the nine-square dotted line in the viewfinder
      dottedLength: 2,
      // Configure the color of the dotted line of the nine-square grid in the viewfinder
      dottedColor: Colors.white,
      // Configure the color of the outer portion of the viewfinder
      editorMaskColorHandler: (context, isTouching) {
        return isTouching ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.7);
        // return Colors.black;
      });

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
  }

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<BusinessDocumentBloc>(context).add(
                  Back(),
                );
                return;
              },
              style: ElevatedButton.styleFrom(),
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                if (pickedXSourceFile != null || pickedSourceFile != null) {
                  controller.tailor();
                }
                return;
              },
              style: ElevatedButton.styleFrom(),
              icon: const Icon(Icons.done, color: Color.fromRGBO(69, 201, 125, 1)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor,
          onPressed: _selectDocumentSource,
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: PageBody(
            controller: scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            child: BlocBuilder<PermissionBloc, PermissionState>(
              key: const Key('upload-document-address-bloc-builder-key'),
              bloc: context.read<PermissionBloc>(),
              //buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return BlocListener<BusinessDocumentBloc, BusinessDocumentState>(
                  listenWhen: (previous, current) => previous != current,
                  bloc: context.read<BusinessDocumentBloc>(),
                  listener: (context, state) {
                    state.maybeMap(
                      orElse: () {},
                      saveCropDocumentProcessingState: (value) {
                        showPlatformDialog<void>(
                          context: context,
                          material: MaterialDialogData(
                            barrierColor: Colors.transparent,
                            barrierDismissible: false,
                          ),
                          cupertino: CupertinoDialogData(
                            barrierDismissible: false,
                          ),
                          useRootNavigator: false,
                          barrierDismissible: false,
                          builder: (context) {
                            return SafeArea(
                              top: false,
                              child: Builder(builder: (BuildContext context) {
                                return Theme(
                                  data: theme,
                                  child: Dialog(
                                    // The background color
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),

                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // The loading indicator
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          // Some text
                                          Text(
                                            'Please wait while we are processing...',
                                            style: context.labelMedium!.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      },
                      saveCropDocumentHideProcessingState: (value) {
                        Navigator.of(context).pop();
                      },
                      saveCropDocumentSuccessState: (value) {
                        context.pop([
                          value.newFilePath,
                          value.newXFile,
                          value.newFile,
                          value.byteData,
                          value.bytes,
                          value.xfile,
                          value.file,
                          value.assetNetworkUrl,
                        ]);
                      },
                      backState: (value) {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    );
                  },
                  child: BlocBuilder<BusinessDocumentBloc, BusinessDocumentState>(
                    //buildWhen: (previous, current) => previous != current,
                    key: const Key('upload-business-document-bloc-builder-key'),
                    bloc: BlocProvider.of<BusinessDocumentBloc>(context),
                    builder: (context, state) {
                      state.maybeMap(
                        orElse: () {},
                        selectDocumentSourceTypeState: (value) {
                          documentPickerSource = value.documentPickerSource;
                        },
                        captureImageFromCameraProcessingState: (value) {
                          documentPickerSourceStatus = DocumentPickerSourceStatus.pickingUp;
                        },
                        captureImageFromCameraSuccessState: (value) {
                          controller = ImageEditorController();
                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                          selectedFileInBytes = value.uint8list;
                          fileMetaInfo = value.metaData;
                          if (selectedFileInBytes != null && (pickedSourceFile != null || pickedXSourceFile != null)) {
                            documentPickerSourceStatus = DocumentPickerSourceStatus.pickedUp;
                          } else {
                            documentPickerSourceStatus = DocumentPickerSourceStatus.notPickedUp;
                          }
                        },
                        selectImageFromGalleryProcessingState: (value) {
                          documentPickerSourceStatus = DocumentPickerSourceStatus.pickingUp;
                        },
                        selectImageFromGallerySuccessState: (value) {
                          controller = ImageEditorController();

                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                          selectedFileInBytes = value.uint8list;
                          fileMetaInfo = value.metaData;
                          if (selectedFileInBytes != null && (pickedSourceFile != null || pickedXSourceFile != null)) {
                            documentPickerSourceStatus = DocumentPickerSourceStatus.pickedUp;
                          } else {
                            documentPickerSourceStatus = DocumentPickerSourceStatus.notPickedUp;
                          }
                        },
                        captureImageFromCameraFailedState: (value) {
                          documentPickerSourceStatus = DocumentPickerSourceStatus.notPickedUp;
                        },
                        selectImageFromGalleryFailedState: (value) {
                          documentPickerSourceStatus = DocumentPickerSourceStatus.notPickedUp;
                        },
                        cropState: (value) {},
                        flipState: (value) {
                          controller.upsideDown();
                        },
                        resetAllState: (value) {},
                        resetAssetState: (value) {
                          controller.restore();
                        },
                        leftRotateState: (value) {
                          controller.addRotateAngle90();
                        },
                        rightRotateState: (value) {
                          controller.reduceRotateAngle90();
                        },
                        saveCropDocumentSuccessState: (value) {
                          controller = ImageEditorController();
                          documentPickerSourceStatus = DocumentPickerSourceStatus.notPickedUp;
                          pickedSourceFile = null;
                          pickedXSourceFile = null;
                        },
                      );
                      return Container(
                        padding: EdgeInsetsDirectional.only(
                          start: margins * 2.5,
                          end: margins * 2.5,
                          top: topPadding,
                          bottom: margins,
                        ),
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            _currentPickerStatus(documentPickerSourceStatus, context),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _currentPickerStatus(DocumentPickerSourceStatus documentPickerSourceStatus, BuildContext context) {
    switch (documentPickerSourceStatus) {
      case DocumentPickerSourceStatus.none || DocumentPickerSourceStatus.notPickedUp || DocumentPickerSourceStatus.startPickup:
        {
          return const UploadedDocumentPlaceholderWidget();
        }
      case DocumentPickerSourceStatus.pickedUp:
        {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: context.height / 1.75, minWidth: context.width),
                child: ImageEditorPlane(
                  imageData: selectedFileInBytes!.buffer.asByteData(),
                  controller: controller,
                  editorConfig: editorConfig,
                  onTailorResult: (image, byteData, size) {
                    if (pickedXSourceFile != null || pickedSourceFile != null) {
                      _showScreenShotOfCropImageDialog(
                        context: context,
                        byteData: byteData,
                      );

                      return;
                    }
                  },
                ),
              ),
              const AnimatedGap(10, duration: Duration(milliseconds: 500)),
              const Divider(
                height: 4,
                color: Color.fromRGBO(200, 201, 202, 1),
                thickness: 1,
              ),
              const AnimatedGap(10, duration: Duration(milliseconds: 500)),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(200, 201, 202, 1)),
                  borderRadius: BorderRadiusDirectional.circular(8),
                ),
                child: ScrollableRow(
                  padding: const EdgeInsets.all(1),
                  physics: const BouncingScrollPhysics(),
                  constraintsBuilder: (constraints) => BoxConstraints(
                    minWidth: constraints.maxWidth,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.addRotateAngle90();
                        /*BlocProvider.of<BusinessDocumentBloc>(context).add(
                            AssetLeftRotate(
                                hasRightTurn: false,
                                documentType: widget.documentType));*/
                        return;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.rotate_left),
                          Text(
                            'Left',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      key: Key('rotate-left-vertical-divider'),
                      height: 45,
                      child: VerticalDivider(
                        color: Color.fromRGBO(200, 201, 202, 1),
                        width: 2,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.reduceRotateAngle90();
                        /*BlocProvider.of<BusinessDocumentBloc>(context).add(
                            AssetRightRotate(
                                hasRightTurn: true,
                                documentType: widget.documentType));*/
                        return;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.rotate_right),
                          Text(
                            'Right',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      key: Key('rotate-right-vertical-divider'),
                      height: 45,
                      child: VerticalDivider(
                        color: Color.fromRGBO(200, 201, 202, 1),
                        width: 2,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.turnAround();
                        /*BlocProvider.of<BusinessDocumentBloc>(context)
                            .add(AssetFlip(documentType: widget.documentType));*/
                        return;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.flip),
                          ),
                          Text(
                            'Flip',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      key: Key('flip-vertical-divider'),
                      height: 45,
                      child: VerticalDivider(
                        color: Color.fromRGBO(200, 201, 202, 1),
                        width: 2,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(minimumSize: const Size(40, 36)),
                      onPressed: () {
                        controller.upsideDown();
                        return;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.flip),
                          Text(
                            'Flip',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      key: Key('flip-horizontal-divider'),
                      height: 45,
                      child: VerticalDivider(
                        color: Color.fromRGBO(200, 201, 202, 1),
                        width: 2,
                        thickness: 1,
                        indent: 4,
                        endIndent: 4,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.restore();
                        /*BlocProvider.of<BusinessDocumentBloc>(context).add(
                          ResetAsset(
                            documentType: widget.documentType,
                            aspectRatioItem: _aspectRatio,
                          ),
                        );*/
                        return;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.restore),
                          Text(
                            'Reset',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: kBottomNavigationBarHeight,
              ),
            ],
          );
        }
      case DocumentPickerSourceStatus.pickingUp:
        {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
      case DocumentPickerSourceStatus.error:
        {
          return const UploadedDocumentPlaceholderWidget();
        }
    }
  }

  void _selectDocumentSource([OpenMediaPickerState? value]) {
    OneContext().showBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return ListenableBuilder(
          listenable: serviceLocator<LanguageController>(),
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Select document source',
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        style: context.titleLarge,
                      ).translate(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //backgroundColor: Color.fromRGBO(234, 247, 238, 1),
                            //foregroundColor: Color.fromRGBO(127, 129, 132, 1),
                            padding: EdgeInsets.zero,
                            //shape: const CircleBorder(),
                          ),
                          onPressed: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 300),
                              () {},
                            ).then(
                              (value) => Navigator.of(context).pop(),
                            );
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: GlobalApp.defaultDocumentPickerSource.length - 2,
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        child: ListTile(
                          onTap: () async {
                            // Select source
                            context.read<BusinessDocumentBloc>().add(
                                  SelectDocumentSourceType(
                                    documentType: widget.documentType,
                                    documentPickerSource: GlobalApp.defaultDocumentPickerSource[index],
                                  ),
                                );
                            // Close the source confirmation
                            await Future.delayed(
                              const Duration(milliseconds: 300),
                              () {},
                            ).then(
                              (value) => Navigator.of(context).pop(),
                            );

                            // Close bottom sheet
                          },
                          leading: GlobalApp.defaultDocumentPickerSource[index].icon,
                          title: Text(
                            GlobalApp.defaultDocumentPickerSource[index].documentPickerName,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            style: context.labelLarge,
                          ),
                          trailing: GlobalApp.defaultDocumentPickerSource[index] == documentPickerSource
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).primaryColorLight,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            side: GlobalApp.defaultDocumentPickerSource[index] == documentPickerSource
                                ? BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 1.5,
                                  )
                                : BorderSide(color: Colors.grey[300]!),
                          ),
                          tileColor: GlobalApp.defaultDocumentPickerSource[index] == documentPickerSource
                              ? Theme.of(context).primaryColorLight.withOpacity(0.05)
                              : null,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showScreenShotOfCropImageDialog({required BuildContext context, required ByteData byteData, Image? image, Size? size}) {
    showConfirmationDialog(
      context: context,
      barrierDismissible: true,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
      builder: (BuildContext context) {
        return ResponsiveDialog(
          context: context,
          hideButtons: false,
          maxLongSide: context.height / 1.75,
          maxShortSide: context.width,
          title: 'Confirm Upload',
          confirmText: 'Confirm',
          cancelText: 'Cancel',
          okPressed: () async {
            await Future.delayed(
              const Duration(milliseconds: 300),
              () {},
            );
            if (!mounted) {
              return;
            }
            Navigator.of(context).pop();
            context.read<BusinessDocumentBloc>().add(
                  SaveCropDocument(
                    byteData: byteData,
                    xfile: pickedXSourceFile,
                    file: pickedSourceFile,
                    bytes: byteData.buffer.asUint8List(),
                    imageEditorController: controller,
                    documentType: widget.documentType,
                  ),
                );
          },
          cancelPressed: () async {
            await Future.delayed(
              const Duration(milliseconds: 300),
              () {},
            );
            if (!mounted) {
              return;
            }
            Navigator.of(context).pop();
          },
          child: ScrollableColumn(
            mainAxisSize: MainAxisSize.min,
            padding: const EdgeInsets.all(1),
            physics: const BouncingScrollPhysics(),
            constraintsBuilder: (constraints) => BoxConstraints(
              minWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  width: double.maxFinite,
                  //height: context.height,
                  //color: Colors.white,
                  //alignment: Alignment.center,
                  child: Image.memory(byteData.buffer.asUint8List()),
                ),
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 400)),
              Text.rich(
                TextSpan(
                  text:
                      'Please check the document, and its clarity and cropped size and confirm it. Once it will be uploaded, it will be verify by our verification team.\n\n',
                  children: [
                    TextSpan(
                      text: 'Will you confirm or cancel it?',
                      style: context.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                style: context.bodyMedium,
                softWrap: true,
                textAlign: TextAlign.center,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
            ],
          ),
        );
      },
    );
  }
}
