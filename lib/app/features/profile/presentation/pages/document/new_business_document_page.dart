part of 'package:homemakers_merchant/app/features/profile/index.dart';

class NewBusinessDocumentPage extends StatefulWidget {
  const NewBusinessDocumentPage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessDocument = false,
    this.businessDocumentEntities = const [],
  });

  final int currentIndex;
  final List<NewBusinessDocumentEntity> businessDocumentEntities;
  final bool hasEditBusinessDocument;

  @override
  _NewBusinessDocumentPageController createState() => _NewBusinessDocumentPageController();
}

class _NewBusinessDocumentPageController extends State<NewBusinessDocumentPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  List<NewBusinessDocumentEntity> allBusinessDocuments = [];
  List<DocumentType> documentTypes = [
    DocumentType.tradeLicence,
    DocumentType.nationalID,
    DocumentType.selfie,
  ];
  late List<TextEditingController> textEditingControllers;
  late List<IdentityType> identityTypes = [];
  IdentityType? currentSelectedIdentityType;
  final GlobalKey<FormState> _newUploadDocumentFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    customScrollViewScrollController = ScrollController();
    allBusinessDocuments = [];
    allBusinessDocuments.clear();
    identityTypes = [];
    identityTypes.clear();
    identityTypes = const [
      IdentityType(
        identityTypeID: 0,
        title: 'National ID / Iqama',
        value: 'National ID / Iqama',
        documentType: DocumentType.nationalID,
      ),
      IdentityType(
        identityTypeID: 1,
        title: 'Passport',
        value: 'Passport',
        documentType: DocumentType.nationalID,
      ),
    ];
    currentSelectedIdentityType = identityTypes.first;
    textEditingControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    if (widget.hasEditBusinessDocument) {
      allBusinessDocuments = List<NewBusinessDocumentEntity>.from(widget.businessDocumentEntities.toList());
      if (allBusinessDocuments.length >= 2) {
        textEditingControllers[0].text = allBusinessDocuments[0].documentIdNumber;
        allBusinessDocuments.insert(0, widget.businessDocumentEntities[0]);
        allBusinessDocuments.insert(1, widget.businessDocumentEntities[1]);
      } else {
        allBusinessDocuments.insert(0, widget.businessDocumentEntities[0]);
      }
      setState(() {});
    } else {
      allBusinessDocuments.insert(0, NewBusinessDocumentEntity());
    }
  }

  @override
  void dispose() {
    identityTypes = [];
    identityTypes.clear();
    textEditingControllers[0].dispose();
    textEditingControllers[1].dispose();
    textEditingControllers[2].dispose();
    textEditingControllers = [];
    textEditingControllers.clear();
    allBusinessDocuments = [];
    allBusinessDocuments.clear();
    scrollController.dispose();
    customScrollViewScrollController.dispose();
    super.dispose();
  }

  Future<void> onUploadPressed() async {
    if (_newUploadDocumentFormKey.currentState!.validate()) {
      _newUploadDocumentFormKey.currentState!.save();
      if (allBusinessDocuments.first.documentType == DocumentType.nationalID &&
          !allBusinessDocuments.first.documentIdNumber.isEmptyOrNull) {
        context.read<BusinessDocumentBloc>().add(
              SaveBusinessDocument(
                currentIndex: widget.currentIndex,
                hasEditBusinessDocument: widget.hasEditBusinessDocument,
                businessDocumentUploadedEntity: allBusinessDocuments.first,
                allBusinessDocuments: allBusinessDocuments.toList(),
                businessDocumentStatus: BusinessDocumentStatus.saveBusinessDocument,
              ),
            );
        return;
      }
      return;
    }
    return;
  }

  void updateSelectedIdentityType(IdentityType selectedIdentityType) {
    currentSelectedIdentityType = selectedIdentityType;
    setState(() {});
  }

  void updateIdentityCard(Map<String, dynamic> mapData, CaptureImageEntity captureImageEntity) {
    allBusinessDocuments.insert(
      0,
      NewBusinessDocumentEntity(
        documentType: captureImageEntity.documentType,
        base64: captureImageEntity.base64Encode,
        captureDocumentID: captureImageEntity.captureDocumentID,
        mimeType: captureImageEntity.mimeType,
        networkAssetPath: captureImageEntity.networkUrl,
        documentIdNumber: textEditingControllers[0].value.text.trim(),
        localAssetPath: captureImageEntity.croppedFilePath.isEmptyOrNull
            ? captureImageEntity.originalFilePath
            : captureImageEntity.croppedFilePath,
        fileExtension: captureImageEntity.fileExtension,
        fileName: captureImageEntity.fileName,
        fileNameWithExtension: captureImageEntity.fileNameWithExtension,
        height: captureImageEntity.height,
        width: captureImageEntity.width,
      ),
    );
  }

  void updateTradeLicenseCard(Map<String, dynamic> mapData, CaptureImageEntity captureImageEntity) {
    allBusinessDocuments.insert(
      1,
      NewBusinessDocumentEntity(
        documentType: captureImageEntity.documentType,
        base64: captureImageEntity.base64Encode,
        captureDocumentID: captureImageEntity.captureDocumentID,
        mimeType: captureImageEntity.mimeType,
        networkAssetPath: captureImageEntity.networkUrl,
        documentIdNumber: '',
        localAssetPath: captureImageEntity.croppedFilePath.isEmptyOrNull
            ? captureImageEntity.originalFilePath
            : captureImageEntity.croppedFilePath,
        fileExtension: captureImageEntity.fileExtension,
        fileName: captureImageEntity.fileName,
        fileNameWithExtension: captureImageEntity.fileNameWithExtension,
        height: captureImageEntity.height,
        width: captureImageEntity.width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<NewBusinessDocumentBloc, NewBusinessDocumentState>(
        bloc: context.read<NewBusinessDocumentBloc>(),
        key: const Key('new-business-document-bloc-consumer-widget'),
        listenWhen: (previous, current) => previous != current,
        buildWhen: (previous, current) => previous != current,
        listener: (context, businessDocumentState) {
          if (businessDocumentState is UploadNewBusinessDocumentState) {
            return context.pushReplacement(Routes.WELCOME_PAGE);
          }
        },
        builder: (context, state) {
          return _NewBusinessDocumentPageView(this);
        },
      );
}

class _NewBusinessDocumentPageView extends WidgetView<NewBusinessDocumentPage, _NewBusinessDocumentPageController> {
  const _NewBusinessDocumentPageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: DoubleTapToExit(
          key: const Key('business-document-upload-doubleTap'),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Document'),
              centerTitle: false,
              actions: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            body: SlideInLeft(
              key: const Key('business_document-dashboard-slideinleft-widget'),
              from: context.width / 2 - 60,
              duration: const Duration(milliseconds: 500),
              child: Directionality(
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                child: PageBody(
                  controller: state.scrollController,
                  constraints: BoxConstraints(
                    minWidth: 1000,
                    minHeight: media.size.height - (media.padding.top + kToolbarHeight + media.padding.bottom),
                  ),
                  padding: EdgeInsetsDirectional.only(
                    top: topPadding,
                    //bottom: bottomPadding,
                    start: margins * 2.5,
                    end: margins * 2.5,
                  ),
                  child: Form(
                    key: state._newUploadDocumentFormKey,
                    child: CustomScrollView(
                      controller: state.customScrollViewScrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              const AnimatedGap(
                                6,
                                duration: Duration(milliseconds: 100),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Proof of Identity',
                                    style: context.headlineSmall!.copyWith(
                                      height: 0.9,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    maxLines: 2,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(
                                12,
                                duration: Duration(milliseconds: 100),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Please upload a original copy of your National ID and/or Commercial License for your business verification',
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.bodyMedium!.copyWith(fontSize: 13),
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    maxLines: 3,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(
                                16,
                                duration: Duration(milliseconds: 100),
                              ),
                              Wrap(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  Text(
                                    'Choose your identity type',
                                    style: context.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(
                                2,
                                duration: Duration(milliseconds: 100),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: context.width * 0.09,
                                width: context.width,
                                child: OverflowBar(
                                  alignment: MainAxisAlignment.start,
                                  overflowAlignment: OverflowBarAlignment.center,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    RadioGroup(
                                      items: state.identityTypes.toList(),
                                      scrollDirection: Axis.horizontal,
                                      onChanged: (value) {
                                        state.updateSelectedIdentityType(value);
                                      },
                                      selectedItem: state.currentSelectedIdentityType,
                                      shrinkWrap: true,
                                      labelBuilder: (ctx, index) {
                                        return Text(
                                          state.identityTypes[index].title,
                                          style: context.labelLarge,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const AnimatedGap(
                                6,
                                duration: Duration(milliseconds: 100),
                              ),
                              AppTextFieldWidget(
                                controller: state.textEditingControllers[0],
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: '${state.currentSelectedIdentityType?.title ?? 'ID Card'} number',
                                  hintText:
                                      'Enter your ${state.currentSelectedIdentityType?.title ?? 'ID Card'} number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your ${state.currentSelectedIdentityType?.title ?? 'identity'} number';
                                  }
                                  return null;
                                },
                              ),
                              const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                              NewBusinessDocumentComponentWidget(
                                key: const Key('upload-document-identity-card-widget'),
                                documentPlaceHolderImage: 'assets/svg/id_card.svg',
                                animate: false,
                                currentIndex: 0,
                                businessDocumentUploadedEntity: (widget.businessDocumentEntities.isNotNullOrEmpty)
                                    ? widget.businessDocumentEntities[0]
                                    : null,
                                selectedImageMetaData:
                                    (Map<String, dynamic> metaData, CaptureImageEntity captureImageEntity) {
                                  state.updateIdentityCard(metaData, captureImageEntity);
                                  return;
                                },
                                documentPlaceHolderWidget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Upload Photo Identity',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.labelLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      8,
                                      duration: Duration(milliseconds: 100),
                                    ),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'We accept only',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.labelMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      2,
                                      duration: Duration(milliseconds: 100),
                                    ),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'National ID/Iqama, Passport',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                documentType: DocumentType.nationalID,
                              ),
                              const AnimatedGap(
                                4,
                                duration: Duration(milliseconds: 100),
                              ),
                              const Divider(thickness: 0.8),
                              const AnimatedGap(
                                12,
                                duration: Duration(milliseconds: 100),
                              ),
                              Wrap(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  Text(
                                    'Trade License ',
                                    style: context.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(
                                1,
                                duration: Duration(milliseconds: 100),
                              ),
                              Wrap(
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  Text(
                                    'Please make sure that every details of the ID document is visible and name with you',
                                    style: context.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ],
                              ),
                              const AnimatedGap(
                                8,
                                duration: Duration(milliseconds: 100),
                              ),
                              NewBusinessDocumentComponentWidget(
                                key: const Key('upload-document-trade-license-widget'),
                                documentPlaceHolderImage: 'assets/svg/certificate_1.svg',
                                currentIndex: 1,
                                businessDocumentUploadedEntity: (widget.businessDocumentEntities.isNotNullOrEmpty &&
                                        widget.businessDocumentEntities.length >= 2)
                                    ? widget.businessDocumentEntities[1]
                                    : null,
                                animate: false,
                                selectedImageMetaData:
                                    (Map<String, dynamic> metaData, CaptureImageEntity captureImageEntity) {
                                  state.updateTradeLicenseCard(metaData, captureImageEntity);
                                  return;
                                },
                                documentPlaceHolderWidget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Upload Trade License',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.labelLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      8,
                                      duration: Duration(milliseconds: 100),
                                    ),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'We accept only',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.labelMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      2,
                                      duration: Duration(milliseconds: 100),
                                    ),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Trade or Commercial License',
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: context.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ).translate(),
                                      ],
                                    ),
                                  ],
                                ),
                                documentType: DocumentType.nationalID,
                              ),
                              const Divider(thickness: 0.8),
                            ],
                          ),
                        ),
                        SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            children: [
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (context.canPop()) {
                                          context.pop();
                                          return;
                                        }
                                        return;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        //minimumSize: Size(100, 40),
                                        side: const BorderSide(
                                          color: Color.fromRGBO(
                                            165,
                                            166,
                                            168,
                                            1.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Prev',
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(127, 129, 132, 1.0),
                                        ),
                                      ).translate(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      onPressed: (!state.textEditingControllers[0].value.text.trim().isEmptyOrNull &&
                                              (!state.allBusinessDocuments.first.localAssetPath.isEmptyOrNull ||
                                                  state.allBusinessDocuments.first.networkAssetPath.isEmptyOrNull))
                                          ? state.onUploadPressed
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        //minimumSize: Size(180, 40),
                                        disabledBackgroundColor: Color.fromRGBO(255, 219, 208, 1),
                                        disabledForegroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        'Upload',
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ).translate(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IdentityType {
  final int identityTypeID;
  final String title;
  final String value;
  final DocumentType documentType;
  final bool hasSelected;

  const IdentityType({
    required this.identityTypeID,
    required this.title,
    required this.value,
    required this.documentType,
    this.hasSelected = false,
  });
}
