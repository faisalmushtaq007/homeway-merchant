part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreExpandedCardWidget<T, S> extends StatefulWidget {
  const StoreExpandedCardWidget({
    required this.expandableCardInfo,
    super.key,
  });

  final ExpandableCardInfo<T, S> expandableCardInfo;

  @override
  _StoreExpandedCardWidgetController<T, S> createState() =>
      _StoreExpandedCardWidgetController<T, S>();
}

class _StoreExpandedCardWidgetController<T, S>
    extends State<StoreExpandedCardWidget<T, S>> {
  late ExpansionTileController? controller;
  WidgetState<Widget> widgetState = const WidgetState<Widget>.none();

  @override
  void initState() {
    super.initState();
    controller = ExpansionTileController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      init(context);
    }
    super.didChangeDependencies();
  }

  void init(BuildContext context) {
    widgetState = WidgetState<Widget>.allData(
      context: context,
      child: ConditionalSwitch.single<int>(
        context: context,
        valueBuilder: (BuildContext context) => widget.expandableCardInfo.id,
        caseBuilders: {
          0: (BuildContext context) => SizedBox(
                height: 65,
                width: double.infinity,
                child: _storeAvailability(context),
              ),
          1: (BuildContext context) => SizedBox(
                height: 160,
                width: double.infinity,
                child: _storeMenuAndPreparationType(context),
              ),
          2: (BuildContext context) =>
              (widget.expandableCardInfo.storeEntity.menuEntities.isEmptyOrNull)
                  ? const Offstage()
                  : SizedBox(
                      height: context.width / 2.25,
                      width: double.infinity,
                      child: _storeAvailableMenus(context),
                    ),
          3: (BuildContext context) => (widget.expandableCardInfo.storeEntity
                  .storeOwnDeliveryPartnersInfo.isEmptyOrNull)
              ? const Offstage()
              : SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: _storeAvailableDrivers(context),
                ),
          4: (BuildContext context) => SizedBox(
                height: 65,
                width: double.infinity,
                child: _storeAvailablePaymentMethods(context),
              ),
        },
        fallbackBuilder: (BuildContext context) => const Offstage(),
      ),
    );
  }

  Widget _storeAvailability(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      //padding: EdgeInsetsDirectional.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsetsDirectional.only(bottom: 16, end: 8, top: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(6),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 8, end: 8, top: 8, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              children: [
                Text(
                  widget.expandableCardInfo.storeEntity.storeWorkingDays[index]
                      .shortName,
                  style: context.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(69, 201, 125, 1),
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                Row(
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.expandableCardInfo.storeEntity.storeOpeningTime,
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ).translate(),
                    Text(
                      '-',
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ).translate(),
                    Text(
                      widget.expandableCardInfo.storeEntity.storeClosingTime,
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                    ).translate(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.expandableCardInfo.storeEntity.storeWorkingDays.length,
    );
  }

  Widget _storeMenuAndPreparationType(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          key: const Key('expandable-card-food-type'),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 8,
                ),
                child: Chip(
                  labelPadding: const EdgeInsetsDirectional.all(2),
                  avatar: const Icon(
                    Icons.check,
                    color: Color.fromRGBO(69, 201, 125, 1),
                  ),
                  label: Text(
                    widget.expandableCardInfo.storeEntity
                        .storeAvailableFoodTypes[index].title,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ).translate(),
                  backgroundColor: Colors.white,
                  elevation: 6.0,
                  shadowColor: Colors.grey[60],
                  padding: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    side: const BorderSide(
                      color: Color.fromRGBO(69, 201, 125, 1),
                    ),
                  ),
                ),
              );
            },
            itemCount: widget
                .expandableCardInfo.storeEntity.storeAvailableFoodTypes.length,
          ),
        ),
        //const AnimatedGap(3, duration: Duration(milliseconds: 200)),
        Text(
          'Preparation Types',
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
        Flexible(
          key: const Key('expandable-card-preparation-type'),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 8,
                ),
                child: Chip(
                  labelPadding: const EdgeInsetsDirectional.all(2),
                  avatar: const Icon(
                    Icons.check,
                    color: Color.fromRGBO(69, 201, 125, 1),
                  ),
                  label: Text(
                    widget.expandableCardInfo.storeEntity
                        .storeAvailableFoodPreparationType[index].title,
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ).translate(),
                  backgroundColor: Colors.white,
                  elevation: 6.0,
                  shadowColor: Colors.grey[60],
                  padding: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    side: const BorderSide(
                      color: Color.fromRGBO(69, 201, 125, 1),
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.expandableCardInfo.storeEntity
                .storeAvailableFoodPreparationType.length,
          ),
        ),
      ],
    );
  }

  Widget _storeAvailableDrivers(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      //padding: EdgeInsetsDirectional.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(index),
          margin: const EdgeInsetsDirectional.only(bottom: 16, end: 8, top: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(6),
          ),
          color: const Color.fromRGBO(242, 242, 242, 1),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16, end: 16, top: 12, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageHelper(
                  image: 'assets/svg/online_driver.svg',
                  /*image: (widget.storeOwnDeliveryPartnerEntity.imageEntity != null && widget.storeOwnDeliveryPartnerEntity.imageEntity!.imagePath.isNotEmpty)
                      ? widget.storeOwnDeliveryPartnerEntity.imageEntity?.imagePath ?? ''
                      : (widget.storeOwnDeliveryPartnerEntity.hasOnline)
                      ? 'assets/svg/online_driver.svg'
                      : 'assets/svg/offline_driver.svg',*/
                  // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
                  filterQuality: FilterQuality.high,
                  // border radius only work with [ImageShape.rounded]
                  borderRadius: BorderRadiusDirectional.circular(30),
                  // alignment of image
                  //alignment: Alignment.center,
                  // indicates where image will be loaded from, types are [network, asset,file]
                  imageType: ImageType.svg,
                  // indicates what shape you would like to be with image [rectangle, oval,circle or none]
                  imageShape: ImageShape.rectangle,
                  // image default box fit
                  boxFit: BoxFit.fill,
                  width: context.width / 10,
                  height: context.width / 10,
                  defaultErrorBuilderColor: Colors.blueGrey,
                  errorBuilder: const Icon(
                    Icons.image_not_supported,
                    size: 10000,
                  ),
                  // loader builder widget, default as icon if null
                  loaderBuilder: const CircularProgressIndicator(),
                  matchTextDirection: true,
                ),
                Text(
                  widget.expandableCardInfo.storeEntity
                      .storeOwnDeliveryPartnersInfo[index].driverName,
                  style: context.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                Text(
                  widget.expandableCardInfo.storeEntity
                      .storeOwnDeliveryPartnersInfo[index].driverMobileNumber,
                  style: context.labelMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                const AnimatedGap(4, duration: Duration(milliseconds: 200)),
                Chip(
                  //labelPadding: const EdgeInsetsDirectional.all(2),
                  avatar: const SingleStarRating(
                    rating: 4.2,
                    starColor: Color.fromRGBO(42, 45, 50, 1),
                    starSize: 16,
                  ),
                  label: Text(
                    '4.2',
                    style: context.labelMedium!.copyWith(
                      color: const Color.fromRGBO(42, 45, 50, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    textDirection: serviceLocator<LanguageController>()
                        .targetTextDirection,
                  ).translate(),
                  backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                  elevation: 0.0,
                  padding: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                ),
                const AnimatedGap(4, duration: Duration(milliseconds: 200)),
              ],
            ),
          ),
        );
      },
      itemCount: widget
          .expandableCardInfo.storeEntity.storeOwnDeliveryPartnersInfo.length,
    );
  }

  Widget _storeAvailableMenus(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      //padding: EdgeInsetsDirectional.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(index),
          margin: const EdgeInsetsDirectional.only(bottom: 16, end: 8, top: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(6),
          ),
          color: const Color.fromRGBO(242, 242, 242, 1),
          child: Padding(
            padding: EdgeInsetsDirectional.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  child: ImageHelper(
                    image: widget.expandableCardInfo.storeEntity
                        .menuEntities[index].menuImages[0].assetPath,
                    //'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg',
                    // image scale
                    scale: 1.0,
                    // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
                    filterQuality: FilterQuality.high,
                    // border radius only work with [ImageShape.rounded]
                    borderRadius: BorderRadiusDirectional.circular(0),
                    // alignment of image
                    //alignment: Alignment.center,
                    // indicates where image will be loaded from, types are [network, asset,file]
                    //imageType: ImageType.network,
                    // indicates what shape you would like to be with image [rectangle, oval,circle or none]
                    imageShape: ImageShape.rectangle,
                    // image default box fit
                    boxFit: BoxFit.fill,
                    width: context.width / 2.15,
                    height: context.width / 2.15,
                    // imagePath: 'assets/images/image.png',
                    // default loader color, default value is null
                    //defaultLoaderColor: Colors.red,
                    // default error builder color, default value is null
                    defaultErrorBuilderColor: Colors.blueGrey,
                    // the color you want to change image with
                    //color: Colors.blue,
                    // blend mode with image only
                    //blendMode: BlendMode.srcIn,
                    // error builder widget, default as icon if null
                    errorBuilder: const Icon(
                      Icons.image_not_supported,
                      size: 10000,
                    ),
                    // loader builder widget, default as icon if null
                    loaderBuilder: const CircularProgressIndicator(),
                    matchTextDirection: true,
                    placeholderText: 'Dum Handi',
                    placeholderTextStyle: context.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    placeholderBackgroundColor:
                        context.colorScheme.primary.withOpacity(0.5),
                    imageType: findImageType(
                        'https://img.freepik.com/premium-photo/dum-handi-chicken-biryani-is-prepared-earthen-clay-pot-called-haandi-popular-indian-non-vegetarian-food_466689-52225.jpg'),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: const Color.fromRGBO(242, 242, 242, 1),
                    )),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Center(
                            child: Container(
                              width: context.width / 2.15,
                              padding: const EdgeInsetsDirectional.only(
                                start: 12,
                                end: 12,
                                top: 12,
                                bottom: 4,
                              ),
                              child: Text(
                                widget.expandableCardInfo.storeEntity
                                    .menuEntities[index].menuName,
                                style: context.labelMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ).translate(),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          top: -20,
                          child: Center(
                            child: Chip(
                              labelPadding: const EdgeInsetsDirectional.all(1),
                              avatar: const SingleStarRating(
                                rating: 4.2,
                                starColor: Color.fromRGBO(42, 45, 50, 1),
                                starSize: 16,
                              ),
                              label: Text(
                                '4.2',
                                style: context.labelSmall!.copyWith(
                                  color: const Color.fromRGBO(42, 45, 50, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                textDirection:
                                    serviceLocator<LanguageController>()
                                        .targetTextDirection,
                              ).translate(),
                              backgroundColor:
                                  const Color.fromRGBO(69, 201, 125, 1),
                              elevation: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: -4, vertical: -4),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsetsDirectional.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                side: const BorderSide(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const AnimatedGap(4, duration: Duration(milliseconds: 200)),
              ],
            ),
          ),
        );
      },
      itemCount: widget.expandableCardInfo.storeEntity.menuEntities.length,
    );
  }

  Widget _storeAvailablePaymentMethods(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      //padding: EdgeInsetsDirectional.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            end: 8,
          ),
          child: Chip(
            //labelPadding: const EdgeInsetsDirectional.all(2),
            /*avatar: widget.expandableCardInfo.storeEntity.storeAcceptedPaymentModes[index].icon?.copyWith(
              color: const Color.fromRGBO(69, 201, 125, 1),
            ),*/
            avatar: const Icon(
              Icons.check,
              color: Color.fromRGBO(69, 201, 125, 1),
            ),
            label: Text(
              widget.expandableCardInfo.storeEntity
                  .storeAcceptedPaymentModes[index].title,
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ).translate(),
            //shadowColor: Colors.grey[60],
            backgroundColor: Colors.white,
            elevation: 6.0,
            shadowColor: Colors.grey[60],
            padding: const EdgeInsetsDirectional.all(8),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20),
              side: const BorderSide(
                color: Color.fromRGBO(69, 201, 125, 1),
              ),
            ),
          ),
        );
      },
      itemCount: widget
          .expandableCardInfo.storeEntity.storeAcceptedPaymentModes.length,
    );
  }

  @override
  Widget build(BuildContext context) =>
      _StoreExpandedCardWidgetView<T, S>(this);
}

class _StoreExpandedCardWidgetView<T, S> extends WidgetView<
    StoreExpandedCardWidget<T, S>, _StoreExpandedCardWidgetController<T, S>> {
  const _StoreExpandedCardWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: PageStorageKey('${widget.expandableCardInfo.id}'),
      elevation: 2,
      child: ListTileTheme(
        //contentPadding: EdgeInsets.all(0),
        //dense: true,
        //horizontalTitleGap: 0.0,
        //minLeadingWidth: 0,
        child: ExpansionTile(
          childrenPadding: const EdgeInsetsDirectional.symmetric(
              vertical: 0, horizontal: 13),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          maintainState: true,
          title: Text(
            widget.expandableCardInfo.title,
            style: context.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
          ).translate(),
          subtitle: Text(
            widget.expandableCardInfo.subTitle,
            textDirection:
                serviceLocator<LanguageController>().targetTextDirection,
          ).translate(),
          controller: state.controller,
          children: [
            state.widgetState.maybeWhen(
              orElse: () {
                return const Offstage();
              },
              allData: (context, child, message, data) {
                return child ?? const Offstage();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableCardInfo<T, S> {
  ExpandableCardInfo({
    this.isExpanded = false,
    this.isEmpty = false,
    required this.id,
    this.data = const [],
    required this.title,
    required this.subTitle,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.height = 100.0,
    required this.storeEntity,
    this.secondaryData = const [],
  });

  int id;
  bool isExpanded;
  bool isEmpty;
  List<T> data;
  List<S> secondaryData;
  String title;
  String subTitle;
  TextStyle? titleTextStyle;
  TextStyle? subTitleTextStyle;
  double height;
  StoreEntity storeEntity;

  ExpandableCardInfo<T, S> copyWith({
    bool? isExpanded,
    bool? isEmpty,
    List<T>? data,
    String? title,
    String? subTitle,
    TextStyle? titleTextStyle,
    TextStyle? subTitleTextStyle,
    double? height,
    int? id,
    StoreEntity? storeEntity,
    List<S>? secondaryData,
  }) {
    return ExpandableCardInfo(
      isExpanded: isExpanded ?? this.isExpanded,
      isEmpty: isEmpty ?? this.isEmpty,
      data: data ?? this.data,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subTitleTextStyle: subTitleTextStyle ?? this.subTitleTextStyle,
      height: height ?? this.height,
      id: id ?? this.id,
      storeEntity: storeEntity ?? this.storeEntity,
      secondaryData: secondaryData ?? this.secondaryData,
    );
  }
}

typedef RatingTapCallback = void Function(double rating);

class SingleStarRating extends StatefulWidget {
  const SingleStarRating({
    super.key,
    this.length = 1,
    this.rating = 0,
    this.between = 0.0,
    this.starSize = 20.0,
    this.color,
    this.onRaitingTap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.starColor = const Color.fromRGBO(69, 201, 125, 1),
  });

  final int length;
  final double rating;
  final double between;
  final double starSize;
  final RatingTapCallback? onRaitingTap;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? starColor;

  @override
  State<SingleStarRating> createState() => _SingleStarRatingState();
}

class _SingleStarRatingState extends State<SingleStarRating> {
  late Widget startRateIcon;

  @override
  void initState() {
    super.initState();
    calculateRate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void calculateRate() {
    if (widget.rating == 0) {
      startRateIcon = Icon(Icons.star_border,
          color: widget.starColor, size: widget.starSize);
    } else {
      final double value = widget.rating - widget.rating.truncate();
      if (value == 0) {
        startRateIcon =
            Icon(Icons.star, color: widget.starColor, size: widget.starSize);
      } else if (value > 0 && value < 1) {
        startRateIcon = Icon(Icons.star_half,
            color: widget.starColor, size: widget.starSize);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return startRateIcon;
  }
}
