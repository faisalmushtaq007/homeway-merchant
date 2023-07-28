part of 'package:homemakers_merchant/app/features/store/index.dart';

class DriverCard extends StatefulWidget {
  const DriverCard(
      {required this.storeOwnDeliveryPartnerEntity, super.key, required this.currentIndex, required this.listOfAllStoreOwnDeliveryPartnerEntities});

  final StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
  final int currentIndex;
  final List<StoreOwnDeliveryPartnersInfo> listOfAllStoreOwnDeliveryPartnerEntities;

  @override
  State<DriverCard> createState() => _DriverCardState();
}

class _DriverCardState extends State<DriverCard> {
  Color carBackgroundColor = Colors.white;
  var _popupStoreItemIndex = 0;

  Widget _buildPopupMenuButton(int currentIndex, StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity) {
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
          storeEnum.Options.view.index,
          currentIndex,
          storeOwnDeliveryPartnerEntity,
        ),
        _buildPopupMenuItem(
          'Edit',
          Icons.edit,
          storeEnum.Options.edit.index,
          currentIndex,
          storeOwnDeliveryPartnerEntity,
        ),
        _buildPopupMenuItem(
          'Remove from store',
          Icons.store,
          storeEnum.Options.removeFromStore.index,
          currentIndex,
          storeOwnDeliveryPartnerEntity,
        ),
        _buildPopupMenuItem(
          'Delete',
          Icons.restore_from_trash,
          storeEnum.Options.delete.index,
          currentIndex,
          storeOwnDeliveryPartnerEntity,
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
    StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity,
  ) {
    return PopupMenuItem(
      value: position,
      onTap: () async {
        switch (_popupStoreItemIndex) {
          case 0:
            {
              final navigateToStoreDetailsPage = await context.push(Routes.STORE_DETAILS_PAGE);
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
                          'Permanently delete this driver. If there is an order for this driver, then it will be deleted only after completing the orders, and if you still confirm for delete, then this driver will remain pending and under review. Are you sure you want to delete this driver?',
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
                serviceLocator<AppUserEntity>().drivers.removeAt(currentIndex);
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageHelper(
        image: ((widget.storeOwnDeliveryPartnerEntity.imageEntity != null && widget.storeOwnDeliveryPartnerEntity.imageEntity!.imagePath.isNotEmpty))
            ? widget.storeOwnDeliveryPartnerEntity.imageEntity?.imagePath ?? ''
            : (widget.storeOwnDeliveryPartnerEntity.hasOnline)
                ? 'assets/svg/online_driver.svg'
                : 'assets/svg/offline_driver.svg',
        // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
        filterQuality: FilterQuality.high,
        // border radius only work with [ImageShape.rounded]
        borderRadius: BorderRadiusDirectional.circular(30),
        // alignment of image
        //alignment: Alignment.center,
        // indicates where image will be loaded from, types are [network, asset,file]
        imageType: (widget.storeOwnDeliveryPartnerEntity.imageEntity != null && widget.storeOwnDeliveryPartnerEntity.imageEntity!.imagePath.isNotEmpty)
            ? ImageType.network
            : ImageType.svg,
        // indicates what shape you would like to be with image [rectangle, oval,circle or none]
        imageShape: ImageShape.rectangle,
        // image default box fit
        boxFit: BoxFit.fill,
        width: context.width / 8,
        height: context.width / 8,
        defaultErrorBuilderColor: Colors.blueGrey,
        errorBuilder: const Icon(
          Icons.image_not_supported,
          size: 10000,
        ),
        // loader builder widget, default as icon if null
        loaderBuilder: const CircularProgressIndicator(),
        matchTextDirection: true,
        placeholderText: widget.storeOwnDeliveryPartnerEntity.driverName,
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
      title: Text(
        widget.storeOwnDeliveryPartnerEntity.driverName,
        style: context.titleMedium!.copyWith(color: const Color.fromRGBO(31, 31, 31, 1)),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.storeOwnDeliveryPartnerEntity.vehicleInfo?.vehicleType ?? '',
        style: const TextStyle(color: Color.fromRGBO(127, 129, 132, 1)),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      dense: true,
      minLeadingWidth: 20,
      onTap: () async {},
      trailing: _buildPopupMenuButton(
        widget.currentIndex,
        widget.storeOwnDeliveryPartnerEntity,
      ),
      selectedColor: const Color.fromRGBO(215, 243, 227, 1),
      selectedTileColor: const Color.fromRGBO(215, 243, 227, 1),
      tileColor: Colors.white,
    );
  }
}
