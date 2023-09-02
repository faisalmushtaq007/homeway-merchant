part of 'package:homemakers_merchant/app/features/profile/index.dart';

class NewBusinessDocumentPage extends StatefulWidget {
  const NewBusinessDocumentPage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessDocument = false,
    this.businessDocumentUploadedEntities = const [],
  });

  final int currentIndex;
  final List<BusinessDocumentUploadedEntity> businessDocumentUploadedEntities;
  final bool hasEditBusinessDocument;

  @override
  _NewBusinessDocumentPageController createState() => _NewBusinessDocumentPageController();
}

class _NewBusinessDocumentPageController extends State<NewBusinessDocumentPage> {
  late final ScrollController scrollController;
  late final ScrollController customScrollViewScrollController;
  List<BusinessDocumentUploadedEntity> allBusinessDocuments = [];
  List<DocumentType> documentTypes = [
    DocumentType.tradeLicence,
    DocumentType.nationalID,
    DocumentType.selfie,
  ];
  late List<TextEditingController> textEditingControllers;
  late List<IdentityType> identityTypes = [];
  IdentityType? currentSelectedIdentityType;

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
        title: 'ID Card',
        value: 'ID Card',
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

  void onUploadPressed() {
    // todo:(Prasant) Call rest api
    context.go(Routes.WELCOME_PAGE);
    return;
  }

  void updateSelectedIdentityType(IdentityType selectedIdentityType) {
    currentSelectedIdentityType = selectedIdentityType;
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) => _NewBusinessDocumentPageView(this);
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
                                'In order to completed your registration. Please upload a copy of your identity with A clear selfie photo to proof the document holder.',
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
                            child: RadioGroup(
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
                                );
                              },
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
                              labelText: 'Enter ${state.currentSelectedIdentityType?.title ?? 'identity'}',
                              hintText: 'Enter your ${state.currentSelectedIdentityType?.title ?? 'identity'} number',
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
                                      'ID Card, Passport',
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
                            animate: false,
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
                                  onPressed: (state.allBusinessDocuments.any((element) => element.documentFrontAssets != null)) ? state.onUploadPressed : null,
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
