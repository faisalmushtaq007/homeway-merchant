import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_picker_source_enum.dart';
import 'package:homemakers_merchant/app/features/profile/common/document_type_enum.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/manager/document/business_document_bloc.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/painters/text_detector_painter.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/document/uploaded_document_placeholder_widget.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/one_context/one_context.dart';
import 'package:image_picker/image_picker.dart';
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
          actions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
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
              buildWhen: (previous, current) => previous != current,
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
                    buildWhen: (previous, current) => previous != current,
                    bloc: context.read<BusinessDocumentBloc>(),
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
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickedUp;
                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                        },
                        selectImageFromGalleryProcessingState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickingUp;
                        },
                        selectImageFromGallerySuccessState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.pickedUp;
                          pickedSourceFile = value.responseFile;
                          pickedXSourceFile = value.pickedFile;
                        },
                        captureImageFromCameraFailedState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.notPickedUp;
                        },
                        selectImageFromGalleryFailedState: (value) {
                          documentPickerSourceStatus =
                              DocumentPickerSourceStatus.notPickedUp;
                        },
                      );
                      return Stack(
                        alignment: Alignment.topLeft,
                        clipBehavior: Clip.none,
                        textDirection: serviceLocator<LanguageController>()
                            .targetTextDirection,
                        children: [
                          ListView(
                            controller: scrollController,
                            shrinkWrap: true,
                            padding: EdgeInsetsDirectional.only(
                              start: margins * 2.5,
                              end: margins * 2.5,
                              top: topPadding,
                              bottom: bottomPadding,
                            ),
                            children: [
                              SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: _currentPickerStatus(
                                          documentPickerSourceStatus),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
      DocumentPickerSourceStatus documentPickerSourceStatus) {
    switch (documentPickerSourceStatus) {
      case DocumentPickerSourceStatus.none ||
            DocumentPickerSourceStatus.notPickedUp ||
            DocumentPickerSourceStatus.startPickup:
        {
          return const UploadedDocumentPlaceholderWidget();
        }
      case DocumentPickerSourceStatus.pickedUp:
        {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Image Picked up'),
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
}
