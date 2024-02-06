part of 'package:homemakers_merchant/app/features/store/index.dart';

class BindStoreCardWidget extends StatefulWidget {
  const BindStoreCardWidget({
    super.key,
    required this.currentIndex,
    required this.onSelectionChanged,
    required this.storeEntity,
    required this.listOfAllSelectedStoreEntities,
    required this.listOfAllStoreEntities,
    required this.refreshStoreList,
  });

  final StoreEntity storeEntity;
  final int currentIndex;
  final List<StoreEntity> listOfAllStoreEntities;
  final List<StoreEntity> listOfAllSelectedStoreEntities;
  final Function(List<StoreEntity>) onSelectionChanged;
  final Function() refreshStoreList;

  @override
  _BindStoreCardWidgetState createState() => _BindStoreCardWidgetState();
}

class _BindStoreCardWidgetState extends State<BindStoreCardWidget> {
  Color carBackgroundColor = Colors.white;
  var _popupStoreItemIndex = 0;

  Widget _buildPopupMenuButton(int currentIndex, StoreEntity storeEntity) {
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
          MenuOptions.view.index,
          currentIndex,
          storeEntity,
        ),
        _buildPopupMenuItem(
          'Edit',
          Icons.edit,
          MenuOptions.edit.index,
          currentIndex,
          storeEntity,
        ),
        _buildPopupMenuItem(
          'Remove from store',
          Icons.store,
          MenuOptions.removeFromStore.index,
          currentIndex,
          storeEntity,
        ),
        _buildPopupMenuItem(
          'Delete',
          Icons.restore_from_trash,
          MenuOptions.delete.index,
          currentIndex,
          storeEntity,
        ),
      ],
    );
  }

//MenuOptions
  PopupMenuItem<int> _buildPopupMenuItem(
    String title,
    IconData iconData,
    int position,
    int currentIndex,
    StoreEntity storeEntity,
  ) {
    return PopupMenuItem(
      value: position,
      onTap: () async {
        switch (position) {
          case 0:
            {}
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
                      await Future.delayed(
                          const Duration(milliseconds: 300), () {});
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop(true);
                    },
                    cancelPressed: () async {
                      debugPrint('Dialog cancelled');
                      await Future.delayed(
                          const Duration(milliseconds: 300), () {});
                      if (!mounted) {
                        return;
                      }
                      Navigator.of(context).pop(false);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: serviceLocator<LanguageController>()
                          .targetTextDirection,
                      children: [
                        Text(
                          'Permanently delete this store. If there is an order for this store, then it will be deleted only after completing the orders, and if you still confirm for delete, then this store will remain pending and under review. Are you sure you want to delete this store?',
                          textDirection: serviceLocator<LanguageController>()
                              .targetTextDirection,
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
                serviceLocator<AppUserEntity>().stores.removeAt(currentIndex);
                await Future.delayed(const Duration(milliseconds: 500), () {});
                if (!mounted) {
                  return;
                }
                await Future.delayed(const Duration(milliseconds: 500), () {});
                widget.refreshStoreList();
                setState(() {});
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
              style: context.labelLarge!.copyWith(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
            ).translate(),
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
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: 8),
      child: ListTile(
        key: ObjectKey(widget.storeEntity),
        leading: ImageHelper(
          image: widget.storeEntity.storeImagePath,
          // image scale
          scale: 1.0,
          // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
          filterQuality: FilterQuality.high,
          // border radius only work with [ImageShape.rounded]
          borderRadius: BorderRadiusDirectional.circular(30),
          // alignment of image
          //alignment: Alignment.center,
          // indicates where image will be loaded from, types are [network, asset,file]
          imageType: findImageType(widget.storeEntity.storeImagePath),
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
          placeholderText: widget.storeEntity.storeName,
          placeholderTextStyle: context.labelLarge!.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
          placeholderBackgroundColor:
              context.colorScheme.primary.withOpacity(0.5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
          //side: BorderSide(color: Color.fromRGBO(127, 129, 132, 1)),
        ),
        title: Text(
          widget.storeEntity.storeName,
          style: context.titleMedium!.copyWith(fontWeight: FontWeight.w500),
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.storeEntity.storeAddress?.address?.area ?? '',
          style: context.labelMedium!.copyWith(fontWeight: FontWeight.w400),
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          maxLines: 3,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ).translate(),
        //dense: true,
        //minLeadingWidth: 20,
        onTap: () {
          setState(() {
            widget.listOfAllSelectedStoreEntities.contains(widget.storeEntity)
                ? widget.listOfAllSelectedStoreEntities
                    .remove(widget.storeEntity)
                : widget.listOfAllSelectedStoreEntities.add(widget.storeEntity);
            widget.onSelectionChanged
                ?.call(widget.listOfAllSelectedStoreEntities);
          });
        },
        selected:
            widget.listOfAllSelectedStoreEntities.contains(widget.storeEntity),
        trailing: (widget.listOfAllSelectedStoreEntities
                .contains(widget.storeEntity))
            ? const Icon(
                Icons.check,
                color: Color.fromRGBO(69, 201, 125, 1),
              )
            : /*_buildPopupMenuButton(
                widget.currentIndex,
                widget.storeEntity,
              ),*/
            null,
        selectedColor: const Color.fromRGBO(215, 243, 227, 1),
        selectedTileColor: const Color.fromRGBO(215, 243, 227, 1),
        tileColor: context.colorScheme.background,
      ),
    );
  }
}
