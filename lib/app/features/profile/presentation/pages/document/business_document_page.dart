part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BusinessDocumentPage extends StatefulWidget {
  const BusinessDocumentPage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessDocument = false,
    this.businessDocumentUploadedEntities = const [],
  });

  final int currentIndex;
  final List<BusinessDocumentUploadedEntity> businessDocumentUploadedEntities;
  final bool hasEditBusinessDocument;

  @override
  State<BusinessDocumentPage> createState() => _BusinessDocumentPageState();
}

class _BusinessDocumentPageState extends State<BusinessDocumentPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late final ScrollController innerListScrollController;
  List<BusinessDocumentUploadedEntity> allBusinessDocuments = [];

  List<TextEditingController> textEditingControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<DocumentType> documentTypes = [
    DocumentType.tradeLicence,
    DocumentType.nationalID,
    DocumentType.selfie,
  ];
  late AnimationController _animationController;
  late Animation<double> _animation;

  static final List<GlobalKey<FormState>> _uploadDocumentFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  static final GlobalKey<FormState> _uploadDocumentFormKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    allBusinessDocuments = [];
    allBusinessDocuments.clear();
    super.initState();
    scrollController = ScrollController();
    innerListScrollController = ScrollController();
    allBusinessDocuments.insert(
      0,
      BusinessDocumentUploadedEntity(
        documentType: DocumentType.tradeLicence,
        hasTextFieldEnable: true,
        businessDocumentAssetsEntity: [],
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
    context.read<PermissionBloc>().add(const RequestLocationPermissionEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    textEditingControllers[0].dispose();
    textEditingControllers[1].dispose();
    textEditingControllers[2].dispose();
    textEditingControllers.clear();
    textEditingControllers = [];
    innerListScrollController.dispose();
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
              padding: EdgeInsetsDirectional.only(end: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.translationValues(
                  _animation.value * width,
                  0.0,
                  0.0,
                ),
                child: PageBody(
                  controller: scrollController,
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: media.size.height,
                  ),
                  child: BlocBuilder<PermissionBloc, PermissionState>(
                    key: const Key(
                      'business-document-permission-bloc-builder-widget-key',
                    ),
                    bloc: context.read<PermissionBloc>(),
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return Stack(
                        children: [
                          PositionedDirectional(
                            top: 6,
                            start: margins * 2.5,
                            //end: margins * 2.5,
                            child: const AppLogo(
                              height: 80,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(top: 90),
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              controller: scrollController,
                              padding: EdgeInsetsDirectional.only(
                                start: margins * 2.5,
                                end: margins * 2.5,
                                //bottom: bottomPadding - margins,
                              ),
                              children: [
                                ScrollableRow(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    Text(
                                      'Upload Legal Documents',
                                      style: context.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ).translate()
                                  ],
                                ),
                                const AnimatedGap(
                                  8,
                                  duration: Duration(milliseconds: 300),
                                ),
                                Wrap(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    Text(
                                      'Share with us commercial license and government ID for your business verification',
                                      style: context.labelMedium!.copyWith(),
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ).translate()
                                  ],
                                ),
                                const AnimatedGap(
                                  8,
                                  duration: Duration(milliseconds: 300),
                                ),
                                BlocBuilder<BusinessDocumentBloc,
                                    BusinessDocumentState>(
                                  buildWhen: (previous, current) =>
                                      previous != current,
                                  bloc: context.watch<BusinessDocumentBloc>(),
                                  builder: (context, state) {
                                    state.maybeMap(
                                      orElse: () {},
                                      addNewAssetState: (value) {},
                                      addNewDocumentState: (value) {
                                        /*int index = value.currentIndex;
                                        final int nextIndex =
                                            value.newIndexPosition;
                                        var document =
                                            value.allBusinessDocuments[index];
                                        allBusinessDocuments[index] = document;

                                        allBusinessDocuments.insert(
                                          nextIndex,
                                          BusinessDocumentUploadedEntity(
                                            documentType: value.documentType,
                                            businessDocumentAssetsEntity: [],
                                          ),
                                        );*/
                                        final listOfUpdateDocuments =
                                            value.allBusinessDocuments.toList();
                                        allBusinessDocuments = List<
                                            BusinessDocumentUploadedEntity>.from(
                                          listOfUpdateDocuments.toList(),
                                        );
                                      },
                                    );
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: allBusinessDocuments.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          key: ObjectKey(
                                            allBusinessDocuments[index],
                                          ),
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Wrap(
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              children: [
                                                Text(
                                                  allBusinessDocuments[index]
                                                      .documentType
                                                      .documentTypeName,
                                                  textDirection: serviceLocator<
                                                          LanguageController>()
                                                      .targetTextDirection,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                )
                                              ],
                                            ),
                                            AnimatedCrossFade(
                                              crossFadeState:
                                                  (allBusinessDocuments[index]
                                                          .hasTextFieldEnable)
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState
                                                          .showSecond,
                                              duration: const Duration(
                                                milliseconds: 400,
                                              ),
                                              secondChild:
                                                  const SizedBox.shrink(),
                                              firstChild: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(
                                                  top: 12,
                                                  bottom: 4,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: DocumentTextField(
                                                        allBusinessDocuments:
                                                            allBusinessDocuments,
                                                        textEditingControllers:
                                                            textEditingControllers,
                                                        index: index,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            AnimatedCrossFade(
                                              crossFadeState: (allBusinessDocuments[
                                                                  index]
                                                              .documentFrontAssets !=
                                                          null &&
                                                      allBusinessDocuments[
                                                                  index]
                                                              .documentFrontAssets
                                                              ?.assetName !=
                                                          null)
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                              duration: const Duration(
                                                milliseconds: 400,
                                              ),
                                              secondChild:
                                                  const SizedBox.shrink(),
                                              firstChild: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(
                                                  top: 8,
                                                  bottom: 4,
                                                ),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(10),
                                                  ),
                                                  color: const Color.fromRGBO(
                                                    220,
                                                    242,
                                                    228,
                                                    1,
                                                  ),
                                                  child: ListTile(
                                                    key: ValueKey(
                                                      index.toString(),
                                                    ),
                                                    selected: (allBusinessDocuments[
                                                                    index]
                                                                .documentFrontAssets !=
                                                            null &&
                                                        allBusinessDocuments[
                                                                    index]
                                                                .documentFrontAssets
                                                                ?.assetName !=
                                                            null),
                                                    selectedTileColor:
                                                        const Color.fromRGBO(
                                                      220,
                                                      242,
                                                      228,
                                                      1,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(10),
                                                    ),
                                                    dense: true,
                                                    visualDensity:
                                                        const VisualDensity(
                                                      horizontal: 0,
                                                      vertical: 0,
                                                    ),
                                                    title: Text(
                                                      allBusinessDocuments[
                                                                  index]
                                                              .documentFrontAssets
                                                              ?.assetName ??
                                                          '',
                                                      style: context
                                                          .labelMedium!
                                                          .copyWith(
                                                        color: const Color
                                                            .fromRGBO(
                                                          42,
                                                          45,
                                                          50,
                                                          1.0,
                                                        ),
                                                      ),
                                                      textDirection: serviceLocator<
                                                              LanguageController>()
                                                          .targetTextDirection,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                    ).translate(),
                                                    trailing: SizedBox(
                                                      height: 26,
                                                      width: 26,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromRGBO(
                                                            234,
                                                            247,
                                                            238,
                                                            1,
                                                          ),
                                                          foregroundColor:
                                                              const Color
                                                                  .fromRGBO(
                                                            127,
                                                            129,
                                                            132,
                                                            1,
                                                          ),
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shape:
                                                              const CircleBorder(),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Icon(
                                                          Icons.close,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    tileColor:
                                                        const Color.fromRGBO(
                                                      220,
                                                      242,
                                                      228,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            AnimatedCrossFade(
                                              crossFadeState: (allBusinessDocuments[
                                                                  index]
                                                              .documentFrontAssets ==
                                                          null ||
                                                      allBusinessDocuments[
                                                                  index]
                                                              .documentFrontAssets
                                                              ?.assetsUploadStatus !=
                                                          DocumentUploadStatus
                                                              .uploaded)
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                              duration: const Duration(
                                                milliseconds: 400,
                                              ),
                                              firstChild: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(top: 12.0),
                                                child: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    // Navigate to document picker page
                                                    final List<dynamic>?
                                                        result =
                                                        await context.push<
                                                            List<dynamic>>(
                                                      Routes
                                                          .UPLOAD_DOCUMENT_PAGE,
                                                      extra: jsonEncode(
                                                        {
                                                          'documentType':
                                                              allBusinessDocuments[
                                                                      index]
                                                                  .documentType
                                                                  .name,
                                                        },
                                                      ),
                                                    );
                                                    // Check is Result exists or not
                                                    if (result != null &&
                                                        result.isNotEmpty) {
                                                      var currentIndex = index;
                                                      if ((index + 1) <
                                                          documentTypes
                                                              .length) {
                                                        await Future.delayed(
                                                          const Duration(
                                                            milliseconds: 500,
                                                          ),
                                                          () {},
                                                        );
                                                        if (!mounted) return;
                                                        context
                                                            .read<
                                                                BusinessDocumentBloc>()
                                                            .add(
                                                              AddNewDocument(
                                                                newIndexPosition:
                                                                    currentIndex +
                                                                        1,
                                                                documentType:
                                                                    documentTypes[
                                                                        currentIndex +
                                                                            1],
                                                                allBusinessDocuments:
                                                                    allBusinessDocuments
                                                                        .toList(),
                                                                businessDocumentUploadedEntity:
                                                                    allBusinessDocuments[
                                                                        currentIndex],
                                                                currentIndex:
                                                                    currentIndex,
                                                                uploadedData:
                                                                    result,
                                                              ),
                                                            );
                                                      } else {
                                                        await Future.delayed(
                                                          const Duration(
                                                            milliseconds: 500,
                                                          ),
                                                          () {},
                                                        );
                                                        if (!mounted) return;
                                                        serviceLocator<
                                                                    AppUserEntity>()
                                                                .currentProfileStatus =
                                                            CurrentProfileStatus
                                                                .businessDocumentUploaded;
                                                        context
                                                            .read<
                                                                BusinessDocumentBloc>()
                                                            .add(
                                                              AddNewDocument(
                                                                newIndexPosition:
                                                                    currentIndex,
                                                                documentType:
                                                                    documentTypes[
                                                                        currentIndex],
                                                                allBusinessDocuments:
                                                                    allBusinessDocuments
                                                                        .toList(),
                                                                businessDocumentUploadedEntity:
                                                                    allBusinessDocuments[
                                                                        currentIndex],
                                                                currentIndex:
                                                                    currentIndex,
                                                                uploadedData:
                                                                    result,
                                                              ),
                                                            );
                                                      }
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.upload_file,
                                                    color: Color.fromRGBO(
                                                      42,
                                                      45,
                                                      50,
                                                      1,
                                                    ),
                                                  ),
                                                  label: Text(
                                                    'Upload ${allBusinessDocuments[index].documentType.documentTypeName} Document',
                                                    textDirection: serviceLocator<
                                                            LanguageController>()
                                                        .targetTextDirection,
                                                    style: context.labelLarge!
                                                        .copyWith(
                                                      color:
                                                          const Color.fromRGBO(
                                                        42,
                                                        45,
                                                        50,
                                                        1,
                                                      ),
                                                    ),
                                                  ).translate(),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    minimumSize:
                                                        Size(context.width, 46),
                                                  ),
                                                ),
                                              ),
                                              secondChild:
                                                  const SizedBox.shrink(),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            start: margins * 2.5,
                            end: margins * 2.5,
                            child: Row(
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
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      style: const TextStyle(
                                        color:
                                            Color.fromRGBO(127, 129, 132, 1.0),
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
                                    onPressed: (allBusinessDocuments.any(
                                            (element) =>
                                                element.documentFrontAssets !=
                                                null))
                                        ? onUploadPressed
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: Size(180, 40),
                                      disabledBackgroundColor:
                                          Color.fromRGBO(255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Upload',
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                    ).translate(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onUploadPressed() {
    // todo:(Prasant) Call rest api
    context.go(Routes.WELCOME_PAGE);
    return;
  }
}

class DocumentTextField extends StatelessWidget {
  const DocumentTextField({
    super.key,
    required this.allBusinessDocuments,
    required this.textEditingControllers,
    required this.index,
  });

  final List<BusinessDocumentUploadedEntity> allBusinessDocuments;
  final List<TextEditingController> textEditingControllers;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(index),
      controller: allBusinessDocuments[index]
          .documentFrontAssets
          ?.textEditingController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      decoration: InputDecoration(
        labelText:
            'Enter ${allBusinessDocuments[index].documentType.documentTypeName}',
        alignLabelWithHint: true,
        isDense: true,
      ),
      onChanged: allBusinessDocuments[index].documentFrontAssets?.onChanged,
      onSubmitted: (value) {
        allBusinessDocuments[index].documentFrontAssets?.onSubmitted!(value);
        context.read<BusinessDocumentBloc>().add(
              TradeLicenseNumberOnChanged(
                textEditingController: textEditingControllers[index],
                currentUpdatedValue:
                    textEditingControllers[index].value.text.trim(),
                index: index,
              ),
            );
      },
    );
  }
}
