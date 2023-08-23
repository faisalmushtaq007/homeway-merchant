part of 'package:homemakers_merchant/app/features/common/index.dart';

class AllStoreDialogWidget extends StatefulWidget {
  const AllStoreDialogWidget({
    required this.onChanged,
    this.initialSelectedAddonsList = const [],
    this.availableAddonsList = const [],
    super.key,
    this.errorWidget,
    this.waitingWidget,
    this.widgetTrailingIcon,
    this.widgetTextStyle,
    this.hasSeperateWidget = true,
  });

  final ValueChanged<List<StoreEntity>> onChanged;
  final List<StoreEntity> availableAddonsList;
  final List<StoreEntity> initialSelectedAddonsList;
  final Widget? waitingWidget;
  final Widget? errorWidget;
  final TextStyle? widgetTextStyle;
  final Icon? widgetTrailingIcon;
  final bool hasSeperateWidget;

  @override
  _AllStoreDialogWidgetController createState() => _AllStoreDialogWidgetController();
}

class _AllStoreDialogWidgetController extends State<AllStoreDialogWidget> {
  late final Future<DataSourceState<List<StoreEntity>>>? futureForAllStores;
  StoreEntity? storeEntity;
  String storeName = 'All Stores';
  @override
  void initState() {
    super.initState();
    initFutureAllStores();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCurrentStoreName(StoreEntity storeEntity) {
    this.storeEntity = storeEntity;
    storeName = storeEntity.storeName;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _AllStoreDialogWidgetView(this);

  Future<void> initFutureAllStores() async {
    futureForAllStores = serviceLocator<GetAllStoreUseCase>()();
  }
}

class _AllStoreDialogWidgetView extends WidgetView<AllStoreDialogWidget, _AllStoreDialogWidgetController> {
  const _AllStoreDialogWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<DataSourceState<List<StoreEntity>>>(
        future: state.futureForAllStores,
        waiting: (context) => widget.waitingWidget ?? defaultWidget(context),
        builder: (context, value) {
          if (value.isNull) {
            return defaultWidget(context);
          } else {
            List<StoreEntity> stores = [];
            value?.when(
              remote: (data, meta) {
                if (data.isNotNullOrEmpty) {
                  stores = data!.toList();
                } else {
                  stores = [];
                }
              },
              localDb: (data, meta) {
                if (data.isNotNullOrEmpty) {
                  stores = data!.toList();
                  stores.insert(
                    0,
                    StoreEntity(
                      storeName: 'All Stores',
                      storeID: -1,
                    ),
                  );
                } else {
                  stores = [];
                }
              },
              error: (dataSourceFailure, reason, error, networkException, stackTrace, exception, extra) {
                stores = [];
              },
            );
            return defaultWidget(context, stores);
          }
        },
        error: (context, error, stackTrace) => widget.errorWidget ?? defaultWidget(context));
  }

  Widget defaultWidget(
    BuildContext context, [
    List<StoreEntity>? stores = const [],
  ]) {
    return InkWell(
      child: Row(
        children: [
          Text(
            state.storeName,
            style: widget.widgetTextStyle ??
                context.labelMedium!.copyWith(
                  color: Color.fromRGBO(127, 129, 132, 1),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Icon(
            Icons.arrow_drop_up,
            color: Color.fromRGBO(127, 129, 132, 1),
          ),
        ],
      ),
      onTap: () async {
        if (stores.isNotNullOrEmpty) {
          final StoreEntity? storeEntity = await selectYourStore(context, stores!);
          if (storeEntity != null) {
            widget.onChanged([storeEntity]);
            state.updateCurrentStoreName(storeEntity);
            return;
          }
        } else {
          return;
        }
      },
    );
  }

  Future<StoreEntity?> selectYourStore(BuildContext context, List<StoreEntity> stores) async {
    final StoreEntity? storeEntity = await showConfirmationDialog<StoreEntity>(
      context: context,
      barrierDismissible: true,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 700),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ResponsiveDialog(
              context: context,
              hideButtons: true,
              maxLongSide: context.height / 2.25,
              maxShortSide: context.width,
              key: const Key('store-confirmation-dialog'),
              title: 'Select your store',
              confirmText: 'Confirm',
              cancelText: 'Cancel',
              okPressed: () async {
                debugPrint('Dialog confirmed');
                Navigator.of(context).pop();
              },
              cancelPressed: () {
                debugPrint('Dialog cancelled');
                Navigator.of(context).pop();
              },
              child: ListView.builder(
                padding: EdgeInsetsDirectional.zero,
                itemCount: stores.length,
                itemBuilder: (context, index) => _allFoodCategory(context, index, setState, stores[index]),
                shrinkWrap: true,
              ),
            );
          },
        );
      },
    );
    if (storeEntity != null) {
      return storeEntity;
    }
    return storeEntity;
  }

  Widget _allFoodCategory(BuildContext context, int index, StateSetter innerSetState, StoreEntity storeEntity) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
            top: (index == 0) ? BorderSide(color: Theme.of(context).dividerColor) : BorderSide.none, bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        horizontalTitleGap: 0,
        visualDensity: const VisualDensity(vertical: -1, horizontal: 0),
        title: Text(
          '${storeEntity.storeName}',
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
        ),
        onTap: () {
          innerSetState(() {});
          Navigator.of(context).pop(storeEntity);
          return;
        },
      ),
    );
  }
}
