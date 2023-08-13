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
              final navigateToStoreDetailsPage = await context.push(
                Routes.ADDRESS_FORM_PAGE,
                extra: {
                  'addressModel': widget.addressEntity,
                  'currentIndex': widget.currentIndex,
                  'hasNewAddress': false,
                  'hasViewAddress': true,
                  'latitude': addressEntity.address?.latitude ?? 0.0,
                  'locationData': addressEntity,
                  'longitude': addressEntity.address?.longitude ?? 0.0,
                  'allAddress': widget.listOfAllAddressEntities.toList(),
                },
              );
              if (!mounted) {
                return;
              }
              context.read<AddressBloc>().add(GetAllAddress());
            }
          case 1:
            {}
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
            color: const Color.fromRGBO(165, 166, 168, 1),
          ),
          const AnimatedGap(8, duration: Duration(milliseconds: 500)),
          Expanded(
            child: Text(
              title,
              style: context.labelLarge!.copyWith(
                color: Color.fromRGBO(42, 45, 50, 1),
                fontSize: 16,
              ),
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

  ImageType _findImageType(String? assetsPath) {
    if (assetsPath.isEmptyOrNull) {
      return ImageType.text;
    } else {
      switch (assetsPath) {
        case (final String path) when path.startsWith('http') || path.startsWith('https'):
          {
            return ImageType.network;
          }
        case (final String path) when path.startsWith('/') || path.startsWith('//'):
          {
            return ImageType.file;
          }
        case (final String path) when path.contains('.jpg') || path.contains('.png'):
          {
            return ImageType.file;
          }
        case (final String path) when path.contains('.svg'):
          {
            return ImageType.svg;
          }
        case _:
          {
            return ImageType.text;
          }
      }
    }
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
    return ListTile(
      leading: ImageHelper(
        image: widget.addressEntity.address?.area ?? 'assets/svg/home_address.svg',
        // image scale
        scale: 1.0,
        // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
        filterQuality: FilterQuality.high,
        // border radius only work with [ImageShape.rounded]
        borderRadius: BorderRadiusDirectional.circular(30),
        // alignment of image
        //alignment: Alignment.center,
        // indicates where image will be loaded from, types are [network, asset,file]
        imageType: state._findImageType(widget.addressEntity.address?.area),
        // indicates what shape you would like to be with image [rectangle, oval,circle or none]
        imageShape: ImageShape.rectangle,
        // image default box fit
        boxFit: BoxFit.fill,
        width: context.width / 8,
        height: context.width / 8,
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
        placeholderText: widget.addressEntity.address?.area,
        placeholderTextStyle: context.labelLarge!.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
        placeholderBackgroundColor: context.colorScheme.primary.withOpacity(0.5),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
        //side: BorderSide(color: Color.fromRGBO(127, 129, 132, 1)),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              Text(
                'Name: ${widget.addressEntity.fullName ?? 'N/A'}',
                style: context.titleMedium!.copyWith(color: const Color.fromRGBO(31, 31, 31, 1)),
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Wrap(
            children: [
              Text(
                'Phone: ${widget.addressEntity.phoneNumber ?? 'N?A'}',
                style: context.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
      subtitle: Wrap(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: sb.toString(),
                  style: context.displaySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
      dense: true,
      minLeadingWidth: 20,
      onTap: () async {
        //final navigateToStoreDetailPage=await context.push(Routes.ALL_STORES_PAGE);
      },
      trailing: state._buildPopupMenuButton(
        widget.currentIndex,
        widget.addressEntity,
      ),
      selectedColor: const Color.fromRGBO(215, 243, 227, 1),
      selectedTileColor: const Color.fromRGBO(215, 243, 227, 1),
      tileColor: Colors.white,
    );
  }
}
