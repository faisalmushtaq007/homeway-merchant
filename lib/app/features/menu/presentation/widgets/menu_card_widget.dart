import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/universal/image_loader/image_helper.dart';
import 'package:homemakers_merchant/shared/widgets/universal/progressive_image/progressive_image.dart';

class MenuCardWidget extends StatefulWidget {
  const MenuCardWidget({
    super.key,
    required this.menuEntity,
    required this.currentIndex,
    required this.listOfAllMenuEntities,
    required this.onSelectionChanged,
    required this.listOfAllSelectedMenuEntities,
  });

  final MenuEntity menuEntity;
  final int currentIndex;
  final List<MenuEntity> listOfAllMenuEntities;
  final List<MenuEntity> listOfAllSelectedMenuEntities;
  final Function(List<MenuEntity>) onSelectionChanged;

  @override
  _MenuCardWidgetState createState() => _MenuCardWidgetState();
}

class _MenuCardWidgetState extends State<MenuCardWidget> {
  Color carBackgroundColor = Colors.white;
  var _popupMenuItemIndex = 0;

  Widget _buildPopupMenuButton() {
    return PopupMenuButton(
      onSelected: (value) {
        _onMenuItemSelected(value as int);
      },
      offset: Offset(0.0, AppBar().preferredSize.height),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem('View', Icons.remove_red_eye, MenuOptions.view.index),
        _buildPopupMenuItem('Edit', Icons.edit, MenuOptions.edit.index),
        _buildPopupMenuItem('Remove from store', Icons.store, MenuOptions.removeFromStore.index),
        _buildPopupMenuItem('Delete', Icons.restore_from_trash, MenuOptions.delete.index),
      ],
    );
  }

//MenuOptions
  PopupMenuItem<int> _buildPopupMenuItem(
    String title,
    IconData iconData,
    int position,
  ) {
    return PopupMenuItem(
      value: position,
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
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
        imageType: ImageType.network,
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
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
        //side: BorderSide(color: Color.fromRGBO(127, 129, 132, 1)),
      ),
      title: Text(
        widget.menuEntity.menuName,
        style: context.titleMedium!.copyWith(color: Color.fromRGBO(31, 31, 31, 1)),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
      ),
      subtitle: Text(
        widget.menuEntity.menuCategories[0].title,
        style: TextStyle(color: Color.fromRGBO(127, 129, 132, 1)),
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
      ),
      dense: true,
      minLeadingWidth: 20,
      onTap: () {
        setState(() {
          widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity)
              ? widget.listOfAllSelectedMenuEntities.remove(widget.menuEntity)
              : widget.listOfAllSelectedMenuEntities.add(widget.menuEntity);
          widget.onSelectionChanged?.call(widget.listOfAllSelectedMenuEntities);
        });
      },
      selected: widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity),
      trailing: (widget.listOfAllSelectedMenuEntities.contains(widget.menuEntity))
          ? Icon(
              Icons.check,
              color: Color.fromRGBO(69, 201, 125, 1),
            )
          : _buildPopupMenuButton(),
      selectedColor: const Color.fromRGBO(215, 243, 227, 1),
      selectedTileColor: const Color.fromRGBO(215, 243, 227, 1),
      tileColor: Colors.white,
    );
  }
}
