part of 'package:homemakers_merchant/app/features/order/index.dart';

class OrderTypeWidget extends StatefulWidget {
  const OrderTypeWidget({
    required this.onChanged,
    super.key,
  });
  final ValueChanged<int> onChanged;

  @override
  _OrderTypeWidgetController createState() => _OrderTypeWidgetController();
}

class _OrderTypeWidgetController extends State<OrderTypeWidget> {
  List<OrderTypeInfo> listOfOrderTypeInfo = [];
  OrderTypeInfo? selectedOrderTypeInfo;
  int selectedIndex = 0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    listOfOrderTypeInfo = [];
    listOfOrderTypeInfo.clear();
    scrollController = ScrollController();
    initListOfOrderTypeInfo();
    selectOrderTypeInfo(selectedIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void initListOfOrderTypeInfo() {
    listOfOrderTypeInfo = const [
      OrderTypeInfo(
        orderTypeInfoID: 0,
        title: 'All',
      ),
      OrderTypeInfo(
        orderTypeInfoID: 1,
        title: 'New',
      ),
      OrderTypeInfo(
        orderTypeInfoID: 2,
        title: 'Schedule',
      ),
      OrderTypeInfo(
        orderTypeInfoID: 3,
        title: 'Processing',
      ),
      OrderTypeInfo(
        orderTypeInfoID: 4,
        title: 'Deliver',
      ),
      OrderTypeInfo(
        orderTypeInfoID: 5,
        title: 'Cancel',
      ),
    ];
  }

  @override
  void dispose() {
    listOfOrderTypeInfo = [];
    listOfOrderTypeInfo.clear();
    super.dispose();
  }

  void selectOrderTypeInfo(
    int index,
  ) {
    selectedIndex = index;
    listOfOrderTypeInfo.asMap().forEach((key, value) {
      value.copyWith(hasSelected: false);
    });
    listOfOrderTypeInfo[index].copyWith(hasSelected: true);
    selectedOrderTypeInfo = listOfOrderTypeInfo[index];
    widget.onChanged(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _OrderTypeWidgetView(this);
}

class _OrderTypeWidgetView
    extends WidgetView<OrderTypeWidget, _OrderTypeWidgetController> {
  const _OrderTypeWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 65,
        width: context.width,
        color: Colors.grey.shade200,
        child: ScrollableRow(
          controller: state.scrollController,
          padding: EdgeInsetsDirectional.zero,
          mainAxisSize: MainAxisSize.min,
          textDirection:
          serviceLocator<LanguageController>()
              .targetTextDirection,
          physics: const BouncingScrollPhysics(),
          constraintsBuilder: (constraints) =>
              BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
          flexible: false,
          children: List.generate(
              state.listOfOrderTypeInfo.length,
                  (index) => Builder(
                builder: (context) {
                  return Padding(
                    padding:
                    const EdgeInsetsDirectional
                        .only(start: 8, end: 8.0),
                    child: ElevatedButton(
                      key: ValueKey(index),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadiusDirectional
                              .circular(10),
                        ),
                        minimumSize: Size(74, 42),
                        maximumSize: Size(104, 42),
                        //fixedSize: Size(104, 42),
                        backgroundColor:
                        (state.selectedIndex ==
                            index)
                            ? flexExt.FlexStringExtensions('#2C73D2').toColor
                            : flexExt.FlexStringExtensions('#D4E5ED').toColor,
                        //disabledBackgroundColor: '#B0A8B9'.toColor,
                      ),
                      onPressed: () {
                        state.selectOrderTypeInfo(index);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: '${state.listOfOrderTypeInfo[index].title} ',
                          children: const [
                            TextSpan(
                              text: '3',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: context.bodyMedium!
                            .copyWith(
                            color:
                            state.selectedIndex ==
                                index
                                ? Colors.white
                                : Colors
                                .black,),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8,
          children: choiceChips(context),
        ),
      ),
    );
  }

  List<Widget> choiceChips(BuildContext context) {
    List<Widget> chips = [];
    for (int index = 0; index < state.listOfOrderTypeInfo.length; index++) {
      Widget item = ChoiceChip(
        key: ValueKey(index),
        label: Text.rich(
          TextSpan(
            text: '${state.listOfOrderTypeInfo[index].title} ',
            children: const [
              TextSpan(
                text: '3',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
        ).translate(),
        labelStyle: TextStyle(
          color: (state.selectedIndex == index)
              ? context.colorScheme.primary
              : context.colorScheme.onSurface,
          fontWeight: (state.selectedIndex == index)
              ? FontWeight.w600
              : FontWeight.w500,
        ),
        selected: state.selectedIndex == index,
        side: BorderSide(
          color: (state.selectedIndex == index)
              ? context.colorScheme.primary
              : const Color.fromRGBO(165, 166, 168, 1),
        ),
        selectedColor: const Color.fromRGBO(238, 238, 238, 1),
        disabledColor: context.colorScheme.surface,
        backgroundColor: (state.selectedIndex == index)
            ? const Color.fromRGBO(238, 238, 238, 1)
            : Colors.white,
        onSelected: (bool value) {
          return state.selectOrderTypeInfo(index);
        },
      );
      chips.add(item);
    }
    return chips;
  }
}

class OrderTypeInfo {
  const OrderTypeInfo({
    required this.orderTypeInfoID,
    required this.title,
    this.icon,
    this.subTitle = '',
    this.onPressed,
    this.hasSelected = false,
    this.orderType = OrderType.none,
    this.value = 0,
  });

  final int orderTypeInfoID;
  final Icon? icon;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  final bool hasSelected;
  final OrderType orderType;
  final int value;

  OrderTypeInfo copyWith({
    int? orderTypeInfoID,
    Icon? icon,
    String? title,
    String? subTitle,
    VoidCallback? onPressed,
    bool? hasSelected,
    OrderType? orderType,
    int? value,
  }) {
    return OrderTypeInfo(
      orderTypeInfoID: orderTypeInfoID ?? this.orderTypeInfoID,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      onPressed: onPressed ?? this.onPressed,
      hasSelected: hasSelected ?? this.hasSelected,
      orderType: orderType ?? this.orderType,
      value: value ?? this.value,
    );
  }
}
