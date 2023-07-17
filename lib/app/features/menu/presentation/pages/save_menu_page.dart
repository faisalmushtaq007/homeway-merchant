part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveMenuPage extends StatefulWidget {
  const SaveMenuPage({super.key});

  @override
  _SaveMenuPageController createState() => _SaveMenuPageController();
}

class _SaveMenuPageController extends State<SaveMenuPage> {
  late final ScrollController scrollController;
  int _currentPageIndex = 0;
  final StepProgressController stepProgressController = StepProgressController(initialStep: 0, totalStep: 5);
  PageController controller = PageController(initialPage: 0);
  FormPageStyle? formPageStyle = FormPageStyle();
  PreloadPageController preloadPageController = PreloadPageController(initialPage: 0);
  ProgressIndicatorType progress = ProgressIndicatorType.linear;

  static final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(debugLabel: 'fomr1'),
    GlobalKey<FormState>(debugLabel: 'fomr2'),
    GlobalKey<FormState>(debugLabel: 'fomr3'),
    GlobalKey<FormState>(debugLabel: 'fomr4'),
    GlobalKey<FormState>(debugLabel: 'fomr5')
  ];
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  List<FormPageModel> pages = [
    FormPageModel(
      body: MenuForm1Page(),
      formKey: formKeys[0],
    ),
    FormPageModel(
      body: MenuForm2Page(),
      formKey: formKeys[1],
    ),
    FormPageModel(
      body: MenuForm3Page(),
      formKey: formKeys[2],
    ),
    FormPageModel(
      body: MenuForm4Page(),
      formKey: formKeys[3],
    ),
    FormPageModel(
      body: MenuForm5Page(),
      formKey: formKeys[4],
    ),
  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    preloadPageController.dispose();
    super.dispose();
  }

  bool validateCurrentPage() {
    final page = pages[_currentPageIndex];
    if (page.formKey != null) {
      final form = page.formKey!.currentState!;
      if (form.validate()) {
        form.save();
      } else {
        return false;
      }
    }
    return true;
  }

  void _nextButtonOnPressed() {
    /*if (validateCurrentPage()) {
      setState(() {
        if (_currentPageIndex < pages.length - 1) {
          _currentPageIndex++;
          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
          preloadPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        } else {
          onFormSubmitted();
        }
      });
    }*/
    debugPrint('_nextButtonOnPressed Pages length: ${pages.length}, _currentPageIndex: ${_currentPageIndex}');
    setState(() {
      if (_currentPageIndex < pages.length - 1) {
        _currentPageIndex++;
        //controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        preloadPageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        stepProgressController.nextStep();
      } else {
        onFormSubmitted();
      }
    });
    return;
  }

  void onFormSubmitted() {}

  void onPageChanged(int currentIndex) {}

  void onStepChanged(int currentIndex) {}

  void _prevButtonOnPressed() {
    if (_currentPageIndex > 0) {
      setState(() {
        _currentPageIndex--;
        /*controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );*/
        preloadPageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        stepProgressController.prevStep();
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) => _SaveMenuPageView(this);
}

class _SaveMenuPageView extends WidgetView<SaveMenuPage, _SaveMenuPageController> {
  const _SaveMenuPageView(super.state);

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
      child: PlatformScaffold(
      
        material: (context, platform) {
          return MaterialScaffoldData(
            resizeToAvoidBottomInset: true,
          );
        },
        cupertino: (context, platform) {
          return CupertinoPageScaffoldData(
            resizeToAvoidBottomInset: true,
          );
        },
        appBar: PlatformAppBar(
          automaticallyImplyLeading: true,
          trailingActions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: PageBody(
            controller: state.scrollController,
            constraints: BoxConstraints(
              minHeight: context.height,
              minWidth: 1000,
            ),
            padding: EdgeInsetsDirectional.fromSTEB(margins * 2.5, topPadding, margins * 2.5, bottomPadding),
            child: Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.antiAlias,
              children: [
             
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AnimatedGap(50, duration: Duration(milliseconds: 500)),
                    Flexible(
                      child: AnimatedContainer(
                        margin: EdgeInsetsDirectional.only(start:margins,end:margins,),
                        padding: EdgeInsetsDirectional.only(
                          start: margins*2.5,
                          end: margins*2.5,
                          top: margins*2.5,
                          bottom: margins,
                        ),
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0,3),
                              blurRadius: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.16)
                            ),
                          ]
                        ),
                        child: PreloadPageView.builder(
                          controller: state.preloadPageController,
                          itemCount: state.pages.length,
                          preloadPagesCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: state.onPageChanged,
                          itemBuilder: (context, index) {
                            return CustomScrollView(
                              controller: state.scrollController,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              slivers: [
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                    [
                                      const AnimatedGap(18,
                                          duration: Duration(milliseconds: 500)),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          Text('Add new Food',style:context.titleLarge!.copyWith(color: context.primaryColor,fontWeight: FontWeight.bold,fontSize: 24,),).translate(),
                                        ],
                                      ),
                                      const AnimatedGap(12,
                                          duration: Duration(milliseconds: 500)),
                                      state.pages[index].body,
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Progress(
                      stepProgressController: state.stepProgressController,
                      strokeColor:
                          context.colorScheme.surfaceTint.withOpacity(0.75),
                      valueColor: Colors.white, //context.colorScheme.surface,
                      //backgroundColor: context.primaryColor,
                      tickColor: context.primaryColor,
                      onStepChanged: state.onStepChanged,
                      defaultColor: context.colorScheme.surface,
                      height: kToolbarHeight - margins,
                      margin: EdgeInsetsDirectional.symmetric(
                          horizontal: context.width / 8),
                    ),
Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: state._prevButtonOnPressed,
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
                            onPressed: state._nextButtonOnPressed,
                            style: ElevatedButton.styleFrom(
                              //minimumSize: Size(180, 40),
                              disabledBackgroundColor:
                                  Color.fromRGBO(255, 219, 208, 1),
                              disabledForegroundColor: Colors.white,
                            ),
                            child: Text(
                              'Next',
                              textDirection:
                                  serviceLocator<LanguageController>()
                                      .targetTextDirection,
                            ).translate(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                   PositionedDirectional(
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      DisplayImage(
                        imagePath: '',
                        onPressed: () {},
                        hasIconImage: true,
                        hasEditButton: false,
                      ),
                    ],
                  ),
                  top: margins * 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
