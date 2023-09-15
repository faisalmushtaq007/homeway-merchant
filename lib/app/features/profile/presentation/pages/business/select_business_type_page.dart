part of 'package:homemakers_merchant/app/features/profile/index.dart';

class ConfirmBusinessTypePage extends StatefulWidget {
  const ConfirmBusinessTypePage({
    super.key,
    this.currentIndex = -1,
    this.hasEditBusinessProfile = false,
    this.businessProfileEntity,
    this.businessTypeEntity,
  });

  final BusinessProfileEntity? businessProfileEntity;
  final bool hasEditBusinessProfile;
  final int currentIndex;
  final BusinessTypeEntity? businessTypeEntity;

  @override
  _ConfirmBusinessTypePageController createState() => _ConfirmBusinessTypePageController();
}

class _ConfirmBusinessTypePageController extends State<ConfirmBusinessTypePage> {
  List<BusinessTypeEntity> _businessTypesList = [];
  late SwiperController swiperController;

  // Wheater to loop through elements
  bool _loop = false;

  // Scroll controller for carousel
  late InfiniteScrollController _controller;

  // Maintain current index of carousel
  int _selectedIndex = 0;

  // Width of each item
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => context.width;
  bool _center = true;
  double _anchor = 0.0;
  double _velocityFactor = 0.5;
  bool selected = false;
  double selectedWidthActive = 0;
  double selectedHeightActive = 0;
  String pickupBusinessTypeName = '';
  BusinessTypeEntity selectedBusinessTypeEntity = BusinessTypeEntity();

  @override
  void initState() {
    super.initState();
    _businessTypesList = [];
    _businessTypesList = List<BusinessTypeEntity>.from(businessTypeList.toList());
    swiperController = SwiperController();
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 200;
  }

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
    _controller.dispose();
  }

  void onIndexChanged(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _selectBusinessTypeCard(int selectedIndex) {
    //_businessTypesList[key].hasSelected == _businessTypesList[index].hasSelected &&
    for (int index = 0; index < _businessTypesList.length; index++) {
      _businessTypesList[index].hasSelected = false;
    }
    _businessTypesList[selectedIndex].hasSelected = true;
    selectedBusinessTypeEntity = _businessTypesList[selectedIndex];
    pickupBusinessTypeName = _businessTypesList[selectedIndex].businessTypeName ?? '';
    setState(() {});
  }

  void _nextButtonOnPressed() {
    serviceLocator<AppUserEntity>().currentProfileStatus = CurrentProfileStatus.businessTypeSaved;
    if (!mounted) {
      return;
    }
    if (widget.businessProfileEntity != null) {
      final businessProfileEntity = widget.businessProfileEntity!.copyWith(
        businessTypeEntity: selectedBusinessTypeEntity,
      );
      context.read<BusinessProfileBloc>().add(
            SaveBusinessProfile(
              businessProfileEntity: businessProfileEntity,
              hasEditBusinessProfile: widget.hasEditBusinessProfile,
              currentIndex: widget.currentIndex,
              hasSaveBusinessType: true,
            ),
          );

      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) => _ConfirmBusinessTypePageView(this);
}

class _ConfirmBusinessTypePageView extends WidgetView<ConfirmBusinessTypePage, _ConfirmBusinessTypePageController> {
  const _ConfirmBusinessTypePageView(super.state);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    final ScrollController scrollController = ScrollController();
    double selectedWidthInActive = context.width * 0.45;
    double selectedHeightInActive = context.width * 0.45;
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
            title: const Text('Business Type'),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: SlideInLeft(
            key: const Key('select-business-type-page-slideleft-widget'),
            delay: const Duration(milliseconds: 500),
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: 1000,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                top: topPadding,
                //bottom: bottomPadding,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocListener<BusinessProfileBloc, BusinessProfileState>(
                key: const Key('business-type--page-bloc-listener'),
                bloc: context.read<BusinessProfileBloc>(),
                listener: (context, businessState) {
                  if (businessState is SaveBusinessProfileState && businessState.hasSaveBusinessType) {
                    context.push(
                      Routes.BANK_INFORMATION_PAGE,
                    );
                    return;
                  }
                },
                child: BlocBuilder<PermissionBloc, PermissionState>(
                  bloc: context.read<PermissionBloc>(),
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, permissionState) {
                    return Stack(
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.topStart,
                          child: AppLogo(),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            minWidth: double.infinity,
                            minHeight: media.size.height,
                          ),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(top: media.padding.top + kToolbarHeight + margins),
                                height: context.width / 1.25,
                                width: context.width,
                                child: Swiper(
                                  itemCount: state._businessTypesList.length,
                                  controller: state.swiperController,
                                  //pagination: const SwiperPagination(),
                                  onIndexChanged: (index) {
                                    state._selectBusinessTypeCard(index);
                                    return;
                                  },
                                  onTap: (index) {
                                    state._selectBusinessTypeCard(index);
                                    return;
                                  },
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: AnimateWidget(
                                        duration: const Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn,
                                        builder: (BuildContext context, Animate animate) {
                                          return ScaleTransition(
                                            scale: animate.curvedAnimation,
                                            alignment: FractionalOffset.center,
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 500),
                                              height: selectedHeightInActive,
                                              width: selectedWidthInActive,
                                              decoration: BoxDecoration(
                                                boxShadow: state._businessTypesList[index].hasSelected
                                                    ? [
                                                        BoxShadow(
                                                          blurRadius: 36,
                                                          spreadRadius: 17,
                                                          blurStyle: BlurStyle.normal,
                                                          offset: Offset.fromDirection(0.0, 0.0),
                                                          color: const Color.fromRGBO(69, 201, 125, 1),
                                                        ),
                                                      ]
                                                    : null,
                                                borderRadius: BorderRadiusDirectional.circular(15),
                                              ),
                                              child: Card(
                                                key: ValueKey(index),
                                                color: const Color.fromRGBO(240, 237, 237, 1.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadiusDirectional.circular(15),
                                                  /*side: BorderSide(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),*/
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    state._businessTypesList[index].localAssetWidget ??
                                                        SvgPicture.asset(state._businessTypesList[index].localAssetPath),
                                                    const AnimatedGap(16, duration: Duration(milliseconds: 500)),
                                                    Wrap(
                                                      children: [
                                                        Text(
                                                          '${state._businessTypesList[index].businessTypeName}',
                                                          style: context.titleMedium!.copyWith(color: '#090909'.toColor),
                                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                        ).translate(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  autoplay: false,
                                  viewportFraction: 0.6,
                                  scale: 0.8,
                                  loop: false,
                                  fade: 0.5,
                                  curve: Curves.fastOutSlowIn,
                                ),
                              ),
                              const AnimatedGap(24, duration: Duration(milliseconds: 500)),
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      (state.pickupBusinessTypeName.isEmpty)
                                          ? 'Pickup your business type'
                                          : 'Your business type is ${state.pickupBusinessTypeName}',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: context.titleMedium,
                                    ).translate(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          bottom: kBottomNavigationBarHeight - bottomPadding,
                          start: 0,
                          end: 0,
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
                                  onPressed: state.pickupBusinessTypeName.isNotEmpty ? state._nextButtonOnPressed : null,
                                  style: ElevatedButton.styleFrom(
                                    //minimumSize: Size(180, 40),
                                    disabledBackgroundColor: const Color.fromRGBO(255, 219, 208, 1),
                                    disabledForegroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'Next',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
            ),
          ),
        ),
      ),
    );
  }
}
