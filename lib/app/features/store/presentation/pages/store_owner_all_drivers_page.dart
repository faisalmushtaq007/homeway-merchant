part of 'package:homemakers_merchant/app/features/store/index.dart';

class StoreOwnerAllDrivers extends StatefulWidget {
  const StoreOwnerAllDrivers({super.key});
  @override
  _StoreOwnerAllDriversController createState() => _StoreOwnerAllDriversController();
}

class _StoreOwnerAllDriversController extends State<StoreOwnerAllDrivers> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  List<StoreOwnDeliveryPartnersInfo> listOfAllDrivers = [];
  List<StoreOwnDeliveryPartnersInfo> listOfAllSelectedDrivers = [];
  final TextEditingController searchTextEditingController = TextEditingController();
  WidgetState<StoreOwnDeliveryPartnersInfo> widgetState = const WidgetState<StoreOwnDeliveryPartnersInfo>.none();
  bool? haveSelectAllMenus = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    listOfAllDrivers = [];
    listOfAllDrivers.clear();
    listOfAllSelectedDrivers = [];
    listOfAllSelectedDrivers.clear();
    context.read<StoreBloc>().add(GetAllDriver());
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
    listOfAllDrivers = [];
    listOfAllDrivers.clear();
    listOfAllSelectedDrivers = [];
    listOfAllSelectedDrivers.clear();
    super.dispose();
  }

  void onSelectionChanged(List<StoreOwnDeliveryPartnersInfo> listOfMenuEntities) {
    setState(() {
      listOfAllSelectedDrivers = List<StoreOwnDeliveryPartnersInfo>.from(listOfMenuEntities.toList());
    });
  }

  void selectAllDrivers({bool? isSelectAllDrivers = false}) {
    haveSelectAllMenus = isSelectAllDrivers;
    if (isSelectAllDrivers != null && isSelectAllDrivers == true) {
      listOfAllSelectedDrivers = List.from(listOfAllDrivers.toList());
    } else {
      listOfAllSelectedDrivers = [];
      listOfAllSelectedDrivers.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<StoreBloc, StoreState>(
        key: const Key('all-driver-page-bloc-builder-widget'),
        bloc: context.watch<StoreBloc>(),
        builder: (context, state) {
          switch (state) {
            case GetAllDriverState():
              {
                listOfAllDrivers = List<StoreOwnDeliveryPartnersInfo>.from(state.storeOwnDeliveryPartnerEntities.toList());
                widgetState = WidgetState<StoreOwnDeliveryPartnersInfo>.allData(
                  context: context,
                );
              }
            case _:
              appLog.d('Default case: all driver page');
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
