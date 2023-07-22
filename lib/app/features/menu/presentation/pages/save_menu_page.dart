part of 'package:homemakers_merchant/app/features/menu/index.dart';

class SaveMenuPage extends StatefulWidget {
  const SaveMenuPage({
    super.key,
    this.haveNewMenu = true,
    this.menuEntity,
  });

  final bool haveNewMenu;
  final MenuEntity? menuEntity;

  @override
  _SaveMenuPageController createState() => _SaveMenuPageController();
}

class _SaveMenuPageController extends State<SaveMenuPage> with AutomaticKeepAliveClientMixin<SaveMenuPage>, WidgetsBindingObserver {
  late final ScrollController scrollController;
  late final ScrollController _screenScrollController;
  int _currentPageIndex = 0;

  // StepProgressController
  final StepProgressController stepProgressController = StepProgressController(totalStep: 5, initialStep: 0);
  PageController controller = PageController(
    initialPage: 0,
  );
  FormPageStyle? formPageStyle = const FormPageStyle();

  // PageView
  PreloadPageController preloadPageController = PreloadPageController(initialPage: 0);

  // ProgressIndicatorType
  ProgressIndicatorType progress = ProgressIndicatorType.linear;

  // PageStorage
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  PageStorageBucket pageStorageBucketMenuForm1 = PageStorageBucket();
  PageStorageBucket pageStorageBucketMenuForm2 = PageStorageBucket();
  PageStorageBucket pageStorageBucketMenuForm3 = PageStorageBucket();
  PageStorageBucket pageStorageBucketMenuForm4 = PageStorageBucket();
  PageStorageBucket pageStorageBucketMenuForm5 = PageStorageBucket();

  List<GlobalKey<FormState>> formKeys = [];

  List<FocusNode> focusList = [];
  List<FormPageModel> pages = [];
  bool isKeyboardOpen = false;
  MenuStateStatus menuStateStatus = MenuStateStatus.none;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance?.addObserver(this);
    formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>(), GlobalKey<FormState>()];
    pages = [
      FormPageModel(
        body: Form(
          key: formKeys[0],
          child: PageStorage(
            bucket: pageStorageBucketMenuForm1,
            child: const MenuForm1Page(),
          ),
        ),
        formKey: formKeys[0],
      ),
      FormPageModel(
        body: Form(
          key: formKeys[1],
          child: PageStorage(
            bucket: pageStorageBucketMenuForm2,
            child: const MenuForm2Page(),
          ),
        ),
        formKey: formKeys[1],
      ),
      FormPageModel(
        body: Form(
          key: formKeys[2],
          child: PageStorage(
            bucket: pageStorageBucketMenuForm3,
            child: const MenuForm3Page(),
          ),
        ),
        formKey: formKeys[2],
      ),
      FormPageModel(
        body: Form(
          key: formKeys[3],
          child: PageStorage(
            bucket: pageStorageBucketMenuForm4,
            child: const MenuForm4Page(),
          ),
        ),
        formKey: formKeys[3],
      ),
      FormPageModel(
        body: Form(
          key: formKeys[4],
          child: PageStorage(
            bucket: pageStorageBucketMenuForm5,
            child: const MenuForm5Page(),
          ),
        ),
        formKey: formKeys[4],
      ),
    ];
    focusList = [FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode()];
    _screenScrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _screenScrollController?.removeListener(_scrollListener);
    WidgetsBinding.instance?.removeObserver(this);
    scrollController.dispose();
    controller.dispose();
    preloadPageController.dispose();
    focusList.asMap().forEach((key, value) => value.dispose());
    pages = [];
    pages.clear;
    focusList = [];
    focusList.clear();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    });
  }

  void _scrollListener() {
    if (_screenScrollController.offset >= _screenScrollController.position.maxScrollExtent && !_screenScrollController.position.outOfRange) {
      //reach the top
    }
    if (_screenScrollController.offset <= _screenScrollController.position.minScrollExtent && !_screenScrollController.position.outOfRange) {
      //reach the top
    }
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
    if (validateCurrentPage()) {
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
    }

    return;
  }

  void onFormSubmitted() {
    context.read<MenuBloc>().add(
          SaveMenu(
            menuEntity: serviceLocator<MenuEntity>().copyWith(
              id: (DateTime.now().millisecondsSinceEpoch - DateTime.now().millisecond) ~/ 1000,
            ),
            hasNewMenu: widget.haveNewMenu,
          ),
        );
  }

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
  Widget build(BuildContext context) {
    super.build(context);
    return PageStorage(
      bucket: pageStorageBucket,
      child: BlocListener<MenuBloc, MenuState>(
        key: const Key('save-menu-page-bloc-listener-widget'),
        bloc: context.watch<MenuBloc>(),
        listener: (context, state) {
          switch (state) {
            case SaveMenuState():
              {
                menuStateStatus = state.menuStateStatus;
                context.go(Routes.NEW_MENU_GREETING_PAGE, extra: state.menuEntity);
                return;
              }
            case _:
              appLog.d('Default case: all menu page');
          }
        },
        child: _SaveMenuPageView(this),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        appBar: AppBar(
          title: const Text('Menu').translate(),
          actions: const [
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
            padding: EdgeInsetsDirectional.fromSTEB(0, topPadding, 0, 0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                CustomScrollView(
                  controller: state._screenScrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const AnimatedGap(50, duration: Duration(milliseconds: 500)),
                          AnimatedContainer(
                            height: context.height * 0.64,
                            margin: EdgeInsetsDirectional.only(
                              start: margins * 1.5,
                              end: margins * 1.5,
                            ),
                            padding: EdgeInsetsDirectional.only(
                              start: margins * 2.25,
                              end: margins * 2.25,
                              top: margins * 2.25,
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
                                  offset: Offset(0, 3),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(
                                    0,
                                    0,
                                    0,
                                    0.16,
                                  ),
                                ),
                              ],
                            ),
                            child: PreloadPageView.builder(
                              controller: state.preloadPageController,
                              itemCount: state.pages.length,
                              preloadPagesCount: 0,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: state.onPageChanged,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      const AnimatedGap(18, duration: Duration(milliseconds: 500)),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 500,
                                            ),
                                            child: Text(
                                              '${(!widget.haveNewMenu && widget.menuEntity != null && widget.menuEntity?.menuName != null) ? widget.menuEntity?.menuName : 'Add new menu'}',
                                              style: context.titleLarge!.copyWith(
                                                color: context.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                              ),
                                            ).translate(),
                                          ),
                                        ],
                                      ),
                                      const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                      state.pages[index].body,
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Progress(
                            stepProgressController: state.stepProgressController,
                            strokeColor: context.colorScheme.surfaceTint.withOpacity(0.75),
                            valueColor: Colors.white,
                            //context.colorScheme.surface,
                            //backgroundColor: context.primaryColor,
                            tickColor: context.primaryColor,
                            onStepChanged: state.onStepChanged,
                            defaultColor: context.colorScheme.surface,
                            height: kToolbarHeight - margins,
                            margin: EdgeInsetsDirectional.symmetric(horizontal: context.width / margins),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: margins * 2,
                              end: margins * 2,
                            ),
                            child: Row(
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
                                    onPressed: state._nextButtonOnPressed,
                                    style: ElevatedButton.styleFrom(
                                      //minimumSize: Size(180, 40),
                                      backgroundColor: (state._currentPageIndex == state.pages.length - 1) ? const Color.fromRGBO(69, 201, 125, 1) : null,
                                      disabledBackgroundColor: (state._currentPageIndex == state.pages.length - 1)
                                          ? const Color.fromRGBO(215, 243, 227, 1)
                                          : const Color.fromRGBO(255, 219, 208, 1),
                                      disabledForegroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Next',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: TextStyle(color: (state._currentPageIndex == state.pages.length - 1) ? Colors.white : null),
                                    ).translate(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: (state.isKeyboardOpen) ? -(MediaQuery.of(context).viewInsets.bottom - margins * 1.5) : 8,
                  child: DisplayImage(
                    imagePath: '',
                    onPressed: () {},
                    hasIconImage: true,
                    hasEditButton: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
