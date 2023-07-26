part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnerAllDrivers extends StatefulWidget {
  const StoreOwnerAllDrivers({super.key});
  @override
  _StoreOwnerAllDriversController createState() => _StoreOwnerAllDriversController();
}

class _StoreOwnerAllDriversController extends State<StoreOwnerAllDrivers> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<MenuEntity> listOfAllMenus = [];
  List<MenuEntity> listOfAllSelectedMenus = [];
  final TextEditingController searchTextEditingController = TextEditingController();
  WidgetState<MenuEntity> widgetState = const WidgetState<MenuEntity>.none();
  bool? haveSelectAllMenus = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    context.read<MenuBloc>().add(GetAllMenu());
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    searchTextEditingController.dispose();
    listOfAllMenus = [];
    listOfAllMenus.clear();
    listOfAllSelectedMenus = [];
    listOfAllSelectedMenus.clear();
    super.dispose();
  }

  void onSelectionChanged(List<MenuEntity> listOfMenuEntities) {
    setState(() {
      listOfAllSelectedMenus = List<MenuEntity>.from(listOfMenuEntities.toList());
    });
  }

  void selectAllMenus({bool? isSelectAllMenus = false}) {
    haveSelectAllMenus = isSelectAllMenus;
    if (isSelectAllMenus != null && isSelectAllMenus == true) {
      listOfAllSelectedMenus = List.from(listOfAllMenus.toList());
    } else {
      listOfAllSelectedMenus = [];
      listOfAllSelectedMenus.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MenuBloc, MenuState>(
        key: const Key('all-menus-page-bloc-builder-widget'),
        bloc: context.watch<MenuBloc>(),
        builder: (context, state) {
          switch (state) {
            case GetAllMenuState():
              {
                listOfAllMenus = List<MenuEntity>.from(state.menuEntities.toList());
                widgetState = WidgetState<MenuEntity>.allData(
                  context: context,
                );
              }
            case _:
              appLog.d('Default case: all menu page');
          }
          return _StoreOwnerAllDriversView(this);
        },
      );
}

class _StoreOwnerAllDriversView extends WidgetView<StoreOwnerAllDrivers, _StoreOwnerAllDriversController> {
  const _StoreOwnerAllDriversView(super.state);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
