part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressCardWidget extends StatefulWidget {
  const AddressCardWidget({
    required this.addressEntity,
    required this.currentIndex,
    required this.listOfAllAddressEntities,
    super.key,
  });

  final AddressModel addressEntity;
  final int currentIndex;
  final List<AddressModel> listOfAllAddressEntities;

  @override
  _AddressCardWidgetController createState() => _AddressCardWidgetController();
}

class _AddressCardWidgetController extends State<AddressCardWidget> {
  Color carBackgroundColor = Colors.white;
  var _popupStoreItemIndex = 0;
  AddressModel addressEntity = AddressModel();
  int currentIndex = -1;
  List<AddressModel> listOfAllAddressEntities = [];

  Widget _buildPopupMenuButton(int currentIndex, AddressModel addressEntity) {
    return PopupMenuButton(
      child: Container(
        height: 36,
        width: 48,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.more_vert,
        ),
      ),
      onSelected: (value) {
        _onStoreSelected(value as int);
      },
      offset: Offset(0.0, AppBar().preferredSize.height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(8),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
          'View',
          Icons.remove_red_eye,
          AppOptions.view.index,
          currentIndex,
          addressEntity,
        ),
        _buildPopupMenuItem(
          'Edit',
          Icons.edit,
          AppOptions.edit.index,
          currentIndex,
          addressEntity,
        ),
        _buildPopupMenuItem(
          'Set as Default',
          Icons.check,
          AppOptions.setAsDefault.index,
          currentIndex,
          addressEntity,
        ),
        _buildPopupMenuItem(
          'Delete',
          Icons.restore_from_trash,
          AppOptions.delete.index,
          currentIndex,
          addressEntity,
        ),
      ],
    );
  }

//Options
  PopupMenuItem<int> _buildPopupMenuItem(
    String title,
    IconData iconData,
    int position,
    int currentIndex,
    AddressModel addressEntity,
  ) {
    return PopupMenuItem(
      value: position,
      onTap: () async {
        switch (_popupStoreItemIndex) {
          case 0:
            {
              final mapAddressDetails = await context.push(
                Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
                extra: {
                  'addressModel': widget.addressEntity,
                  'currentIndex': widget.currentIndex,
                  'hasNewAddress': false,
                  'allAddress': widget.listOfAllAddressEntities.toList(),
                },
              );
              if (!mounted) {
                return;
              }
              context.read<AddressBloc>().add(GetAllAddress());
            }
          case 1:
            {
              final mapAddressDetails = await context.push(
                Routes.PICKUP_LOCATION_FROM_MAP_PAGE,
                extra: {
                  'addressModel': widget.addressEntity,
                  'currentIndex': widget.currentIndex,
                  'hasNewAddress': false,
                  'allAddress': widget.listOfAllAddressEntities.toList(),
                },
              );
              if (!mounted) {
                return;
              }
              context.read<AddressBloc>().add(GetAllAddress());
            }
          case 2:
            {}
          case 3:
            {
              final result = await showConfirmationDialog<bool>(
                context: context,
                barrierDismissible: true,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 700),
                builder: (BuildContext context) {
                  return ResponsiveDialog(
                    context: context,
                    hideButtons: false,
                    maxLongSide: context.height / 3,
                    maxShortSide: context.width,
                    title: 'Confirm Delete',
                    confirmText: 'Confirm',
                    cancelText: 'Cancel',
                    okPressed: () async {
                      debugPrint('Dialog confirmed');
                      await Future.delayed(const Duration(milliseconds: 300), () {});
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop(true);
                    },
                    cancelPressed: () async {
                      debugPrint('Dialog cancelled');
                      await Future.delayed(const Duration(milliseconds: 300), () {});
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop(false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      children: [
                        Text(
                          'Permanently delete this address. If there is an order for this address, then it will be deleted only after completing the orders, and if you still confirm for delete, then this address will remain pending and under review. Are you sure you want to delete this address?',
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        ),
                      ],
                    ),
                  );
                },
              );
              if (result != null && result) {
                await Future.delayed(const Duration(milliseconds: 500), () {});
                if (!mounted) {
                  return;
                }
                // Delete functionality
              }
              return;
            }
        }
      },
      child: Row(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            iconData,
          ),
          const AnimatedGap(8, duration: Duration(milliseconds: 500)),
          Expanded(
            child: Text(
              title,
              style: context.labelLarge!.copyWith(),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
          ),
        ],
      ),
    );
  }

  void _onStoreSelected(int value) {
    setState(() {
      _popupStoreItemIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    addressEntity = widget.addressEntity;
    currentIndex = widget.currentIndex;
    listOfAllAddressEntities = widget.listOfAllAddressEntities.toList();
  }

  @override
  Widget build(BuildContext context) => _AddressCardWidgetView(this);
}

class _AddressCardWidgetView extends WidgetView<AddressCardWidget, _AddressCardWidgetController> {
  const _AddressCardWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    final String building = state.addressEntity.address?.apartment ?? '';
    final String area = state.addressEntity.address?.area ?? '';
    final String landmark = state.addressEntity.address?.landmark ?? '';
    final String city = state.addressEntity.address?.city ?? '';
    final String district = state.addressEntity.address?.district ?? '';
    final String postalcode = state.addressEntity.address?.postalCode?.toString() ?? '';
    final String currentState = state.addressEntity.address?.state ?? '';
    final String country = state.addressEntity.address?.country ?? '';
    final bool isDefaultAddress = state.addressEntity?.isDefault ?? false;
    final String saveAddressAs = state.addressEntity.address?.savedAddressAs ?? '';
    final String selectedMapAddress = state.addressEntity.address?.displayAddressName ?? '';
    final listOfAddressElements = <String>[building, landmark, area, city, district, postalcode, currentState, country];
    listOfAddressElements.removeWhere((element) => element.isEmpty);
    final sb = StringBuffer();
    sb.writeAll(listOfAddressElements, ', ');
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Card(
        margin: EdgeInsetsDirectional.only(
          bottom: 8,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          saveAddressAs,
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleMedium!.copyWith(),
                        ),
                      ],
                    ),
                    const AnimatedGap(6, duration: Duration(milliseconds: 100)),
                    Wrap(
                      children: [
                        Text(
                          sb.toString(),
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                          maxLines: 6,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: context.labelMedium!.copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state._buildPopupMenuButton(
                  widget.currentIndex,
                  widget.addressEntity,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
