part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuCardWidget extends StatefulWidget {
  const MenuCardWidget({
    super.key,
    required this.menuEntity,
    required this.currentIndex,
    required this.listOfAllMenuEntities,
    required this.onSelectionChanged,
    required this.listOfAllSelectedMenuEntities,
    required this.refreshMenuList,
  });

  final MenuEntity menuEntity;
  final int currentIndex;
  final List<MenuEntity> listOfAllMenuEntities;
  final List<MenuEntity> listOfAllSelectedMenuEntities;
  final Function(List<MenuEntity>) onSelectionChanged;
  final Function() refreshMenuList;

  @override
  _MenuCardWidgetState createState() => _MenuCardWidgetState();
}

class _MenuCardWidgetState extends State<MenuCardWidget> {
  Color carBackgroundColor = Colors.white;
  var _popupMenuItemIndex = 0;

  Widget _buildPopupMenuButton(int currentIndex, MenuEntity menuEntity) {
    return PopupMenuButton(
      onSelected: (value) {
        _onMenuItemSelected(value as int);
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
          menuEntity,
        ),
        _buildPopupMenuItem(
          'Edit',
          Icons.edit,
          MenuOptions.edit.index,
          currentIndex,
          menuEntity,
        ),
        _buildPopupMenuItem(
          'Remove from store',
          Icons.store,
          MenuOptions.removeFromStore.index,
          currentIndex,
          menuEntity,
        ),
        _buildPopupMenuItem(
          'Delete',
          Icons.restore_from_trash,
          MenuOptions.delete.index,
          currentIndex,
          menuEntity,
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
    MenuEntity menuEntity,
  ) {
    return PopupMenuItem(
      value: position,
      onTap: () async {
        switch (position) {
          case 0:
            {
              final navigateToMenuDetailsPage = await context.push(
                Routes.MENU_DETAILS_PAGE,
                extra: {
                  'menu': widget.menuEntity,
                  'allMenus': widget.listOfAllMenuEntities.toList(),
                  'index': widget.currentIndex,
                },
              );
              if (!mounted) {
                return;
              }
              await Future.delayed(const Duration(milliseconds: 500), () {});
              widget.refreshMenuList();
              setState(() {

              });
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
                          'Permanently delete this menu. If there is an order for this menu in any of your stores, then it will be deleted only after completing the order, and if you still confirm for delete, then this menu will remain pending and under review. Are you sure you want to delete this menu?',
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
                serviceLocator<List<MenuEntity>>().removeAt(currentIndex);
                await Future.delayed(const Duration(milliseconds: 500), () {});
                widget.refreshMenuList();
                setState(() {

                });
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
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ).translate(),
          ),
        ],
      ),
    );
  }

  void _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageHelper(
        image: widget.menuEntity.menuImages[0].assetPath,
        // image scale
        scale: 1.0,
        // Quality levels for image sampling in [ImageFilter] and [Shader] objects that sample
        filterQuality: FilterQuality.high,
        // border radius only work with [ImageShape.rounded]
        borderRadius: BorderRadiusDirectional.circular(30),
        // alignment of image
        //alignment: Alignment.center,
        // indicates where image will be loaded from, types are [network, asset,file]
        //imageType: ImageType.network,
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
        placeholderText: widget.menuEntity.menuName,
        placeholderTextStyle: context.labelLarge!.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
        placeholderBackgroundColor:
            context.colorScheme.primary.withOpacity(0.5),
        imageType: (widget.menuEntity.menuImages[0].assetPath.isNotEmpty)
            ? ImageType.network
            : ImageType.text,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
        //side: BorderSide(color: Color.fromRGBO(127, 129, 132, 1)),
      ),
      title: Text(
        widget.menuEntity.menuName,
        style: context.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${widget.menuEntity.menuCategories[0].title} | ${widget.menuEntity.menuCategories[0].subCategory[0].title}',
        //style: const TextStyle(color: Color.fromRGBO(127, 129, 132, 1)),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        maxLines: 3,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      //dense: true,
      //minLeadingWidth: 20,
      onTap: () {
        setState(() {
          widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity)
              ? widget.listOfAllSelectedMenuEntities.remove(widget.menuEntity)
              : widget.listOfAllSelectedMenuEntities.add(widget.menuEntity);
          widget.onSelectionChanged?.call(widget.listOfAllSelectedMenuEntities);
        });
      },
      selected:
          widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity),
      trailing:
          (widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity))
              ? const Icon(
                  Icons.check,
                  color: Color.fromRGBO(69, 201, 125, 1),
                )
              : _buildPopupMenuButton(
                  widget.currentIndex,
                  widget.menuEntity,
                ),
      selectedColor: const Color.fromRGBO(215, 243, 227, 1),
      selectedTileColor: const Color.fromRGBO(215, 243, 227, 1),
      tileColor: context.colorScheme.background,
    );
  }
}
