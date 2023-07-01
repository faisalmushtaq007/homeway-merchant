import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:file_saver/file_saver.dart' as fileSaver;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_picker_source_enum.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/bank/confirm_bank_information_dialog.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/image_edit/common_widget.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/image_edit/crop_editor_helper.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/painters/text_detector_painter.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/uploaded_document_placeholder_widget.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/one_context.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_image_crop/data/data_editor_config.dart';
import 'package:new_image_crop/ui/dialog/image_editor_component/image_editor_plane.dart';
import 'package:new_image_crop/widget/size_builder.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:multi_image_crop/multi_image_crop.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage(
      {this.documentType = DocumentType.tradeLicence, super.key});

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
  final TextRecognizer _textRecognizer = GoogleMlKit.vision
      .textRecognizer(); //TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  late final ScrollController scrollController;

  DocumentPickerSource documentPickerSource = DocumentPickerSource.none;
  File? pickedSourceFile;
  ImageSource? type;
  XFile? pickedXSourceFile;
  DocumentPickerSourceStatus documentPickerSourceStatus =
      DocumentPickerSourceStatus.none;
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>> popupMenuKey =
      GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
  final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
    AspectRatioItem(text: 'original', value: CropAspectRatios.original),
    AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
    AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
    AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
    AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
    AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  ];
  AspectRatioItem? _aspectRatio;
  bool _cropping = false;
  Uint8List? selectedFileInBytes;
  EditorCropLayerPainter? _cropLayerPainter;
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
        return isTouching
            ? Colors.black.withOpacity(0.3)
            : Colors.black.withOpacity(0.7);
        // return Colors.black;
      });

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _aspectRatio = _aspectRatios[6];
    _cropLayerPainter = const EditorCropLayerPainter();
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
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
                return;
              },
              style: ElevatedButton.styleFrom(),
              icon: const Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                if (pickedXSourceFile != null || pickedSourceFile != null) {
                  controller.tailor();
                  BlocProvider.of<BusinessDocumentBloc>(context).add(
                    SaveAndNext(),
                  );
                }
                return;
              },
              style: ElevatedButton.styleFrom(),
              icon: const Icon(Icons.done,
                  color: Color.fromRGBO(69, 201, 125, 1)),
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
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
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
                return BlocListener<BusinessDocumentBloc,
                    BusinessDocumentState>(
                  listenWhen: (previous, current) => previous != current,
                  bloc: context.read<BusinessDocumentBloc>(),
                  listener: (context, state) {
                    state.maybeMap(
                      orElse: () {},
                    );
                  },
                  child:
                      BlocBuilder<BusinessDocumentBloc, BusinessDocumentState>(
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
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickingUp;
                        },
                        captureImageFromCameraSuccessState: (value) {
                          controller = ImageEditorController();
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickedUp;
                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                          selectedFileInBytes = value.uint8list;
                          fileMetaInfo = value.metaData;
                          //editorKey.currentState!.reset();
                        },
                        selectImageFromGalleryProcessingState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickingUp;
                        },
                        selectImageFromGallerySuccessState: (value) {
                          controller = ImageEditorController();
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickedUp;
                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                          selectedFileInBytes = value.uint8list;
                          fileMetaInfo = value.metaData;
                          //editorKey.currentState!.reset();
                        },
                        captureImageFromCameraFailedState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.notPickedUp;
                        },
                        selectImageFromGalleryFailedState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.notPickedUp;
                        },
                        cropState: (value) {},
                        flipState: (value) {
                          controller.upsideDown();
                          //editorKey.currentState!.flip();
                        },
                        resetAllState: (value) {},
                        resetAssetState: (value) {
                          controller.restore();
                          //editorKey.currentState!.reset();
                        },
                        leftRotateState: (value) {
                          controller.addRotateAngle90();
                          //editorKey.currentState!.rotate(right: value.hasRightTurn);
                        },
                        rightRotateState: (value) {
                          controller.reduceRotateAngle90();
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
                            _currentPickerStatus(
                                documentPickerSourceStatus, context),
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

  Widget _currentPickerStatus(
      DocumentPickerSourceStatus documentPickerSourceStatus,
      BuildContext context) {
    switch (documentPickerSourceStatus) {
      case DocumentPickerSourceStatus.none ||
            DocumentPickerSourceStatus.notPickedUp ||
            DocumentPickerSourceStatus.startPickup:
        {
          return const UploadedDocumentPlaceholderWidget();
        }
      case DocumentPickerSourceStatus.pickedUp:
        {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: context.height / 1.75, minWidth: context.width),
                child: ImageEditorPlane(
                  imageData: selectedFileInBytes!.buffer.asByteData(),
                  controller: controller,
                  editorConfig: editorConfig,
                  onTailorResult: (image, byteData, size) {
                    print('Result of clipping');
                    if (pickedXSourceFile != null || pickedSourceFile != null) {
                      _showScreenShotOfCropImageDialog(
                          context: context, byteData: byteData);
                      /*BlocProvider.of<BusinessDocumentBloc>(context)
                          .add(SaveCropDocument(
                        documentType: widget.documentType,
                        isCropping: _cropping,
                        bytes: selectedFileInBytes!,
                        extendedImageEditorState: editorKey.currentState!,
                        file: pickedSourceFile!,
                        xfile: pickedXSourceFile,
                        imageInfo: imageInfo!,
                      ));*/
                      return;
                    }
                  },
                ),
                /*child: ExtendedImage.memory(
                  selectedFileInBytes!,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  enableLoadState: true,
                  extendedImageEditorKey: editorKey,
                  constraints: BoxConstraints(
                      maxHeight: context.height / 2, maxWidth: context.width),
                  height: context.height / 2,
                  width: context.width,
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  matchTextDirection: true,
                  initEditorConfigHandler: (ExtendedImageState? state) {
                    return EditorConfig(
                      maxScale: 1,
                      cropRectPadding: const EdgeInsets.all(0.0),
                      hitTestSize: 20.0,
                      cropLayerPainter: _cropLayerPainter!,
                      initCropRectType: InitCropRectType.imageRect,
                      cropAspectRatio: _aspectRatio!.value,
                    );
                  },
                  cacheRawData: true,
                ),*/
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
                  border:
                      Border.all(color: const Color.fromRGBO(200, 201, 202, 1)),
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
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                      style:
                          TextButton.styleFrom(minimumSize: const Size(40, 36)),
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
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

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(recognizedText,
          inputImage.metadata!.size, inputImage.metadata!.rotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
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
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Select document source',
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
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
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        child: ListTile(
                          onTap: () async {
                            // Select source
                            context.read<BusinessDocumentBloc>().add(
                                  SelectDocumentSourceType(
                                    documentType: widget.documentType,
                                    documentPickerSource: GlobalApp
                                        .defaultDocumentPickerSource[index],
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
                          leading:
                              GlobalApp.defaultDocumentPickerSource[index].icon,
                          title: Text(
                            GlobalApp.defaultDocumentPickerSource[index]
                                .documentPickerName,
                            textDirection: serviceLocator<LanguageController>()
                                .targetTextDirection,
                            style: context.labelLarge,
                          ),
                          trailing: GlobalApp
                                      .defaultDocumentPickerSource[index] ==
                                  documentPickerSource
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: Theme.of(context).primaryColorLight,
                                )
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            side: GlobalApp
                                        .defaultDocumentPickerSource[index] ==
                                    documentPickerSource
                                ? BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 1.5,
                                  )
                                : BorderSide(color: Colors.grey[300]!),
                          ),
                          tileColor:
                              GlobalApp.defaultDocumentPickerSource[index] ==
                                      documentPickerSource
                                  ? Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(0.05)
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

  void _showScreenShotOfCropImageDialog(
      {required BuildContext context, required ByteData byteData}) {
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
            print('Dialog confirmed');
            await Future.delayed(const Duration(milliseconds: 300));
            Navigator.of(context).pop();
          },
          cancelPressed: () async {
            print('Dialog cancelled');
            await Future.delayed(const Duration(milliseconds: 300));
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
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
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
                textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
              ),
            ],
          ),
        );
      },
    );
  }
}
