part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreExpandedCardWidget<T, S> extends StatefulWidget {
  const StoreExpandedCardWidget({
    required this.expandableCardInfo,
    super.key,
  });

  final ExpandableCardInfo<T, S> expandableCardInfo;

  @override
  _StoreExpandedCardWidgetController<T, S> createState() => _StoreExpandedCardWidgetController<T, S>();
}

class _StoreExpandedCardWidgetController<T, S> extends State<StoreExpandedCardWidget<T, S>> {
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
          2: (BuildContext context) => const Text('The value is B!'),
          3: (BuildContext context) => const Text('The value is B!'),
          4: (BuildContext context) => const Text('The value is B!'),
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
            padding: EdgeInsetsDirectional.only(start: 8, end: 8, top: 8, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SUN',
                  style: context.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(69, 201, 125, 1),
                  ),
                ),
                AnimatedGap(4, duration: Duration(milliseconds: 200)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '9:00 AM',
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '-',
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '9:00 PM',
                      style: context.labelMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 7, //widget.expandableCardInfo.storeEntity.storeWorkingDays.length,
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
                  avatar: Icon(
                    Icons.check,
                    color: const Color.fromRGBO(69, 201, 125, 1),
                  ),
                  label: Text(
                    'Vegetration',
                    style: TextStyle(),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 6.0,
                  shadowColor: Colors.grey[60],
                  padding: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    side: BorderSide(
                      color: const Color.fromRGBO(69, 201, 125, 1),
                    ),
                  ),
                ),
              );
            },
            itemCount: 7, //widget.expandableCardInfo.storeEntity.storeWorkingDays.length,
          ),
        ),
        //const AnimatedGap(3, duration: Duration(milliseconds: 200)),
        Text(
          'Preparation Types',
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
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
                  avatar: Icon(
                    Icons.check,
                    color: const Color.fromRGBO(69, 201, 125, 1),
                  ),
                  label: Text(
                    'Cooking',
                    style: TextStyle(),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 6.0,
                  shadowColor: Colors.grey[60],
                  padding: const EdgeInsetsDirectional.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    side: BorderSide(
                      color: const Color.fromRGBO(69, 201, 125, 1),
                    ),
                  ),
                ),
              );
            },
            itemCount: 7, //widget.expandableCardInfo.storeEntity.storeWorkingDays.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => _StoreExpandedCardWidgetView<T, S>(this);
}

class _StoreExpandedCardWidgetView<T, S> extends WidgetView<StoreExpandedCardWidget<T, S>, _StoreExpandedCardWidgetController<T, S>> {
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
          childrenPadding: const EdgeInsetsDirectional.symmetric(vertical: 0, horizontal: 13),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          maintainState: true,
          title: Text(
            widget.expandableCardInfo.title,
            style: context.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.expandableCardInfo.subTitle,
          ),
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
