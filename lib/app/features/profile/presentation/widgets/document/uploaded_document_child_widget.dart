import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/document/business_document_uploaded_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';

class UploadedDocumentChildWidget extends StatefulWidget {
  const UploadedDocumentChildWidget({
    required this.keyNameOfListView,
    super.key,
    this.allBusinessDocumentAssets = const [],
    this.hasEnableTextField = false,
    this.documentIDNumber = '',
  });

  final List<BusinessDocumentAssetsEntity> allBusinessDocumentAssets;
  final String keyNameOfListView;
  final bool hasEnableTextField;
  final String documentIDNumber;

  @override
  State<UploadedDocumentChildWidget> createState() =>
      _UploadedDocumentChildWidgetState();
}

class _UploadedDocumentChildWidgetState
    extends State<UploadedDocumentChildWidget> {
  List<BusinessDocumentAssetsEntity> allBusinessDocumentAssets = [];
  List<Widget> allBusinessDocumentAssetsWidgets = [];
  ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    allBusinessDocumentAssets = [];
    allBusinessDocumentAssets.clear();
    allBusinessDocumentAssetsWidgets = [];
    allBusinessDocumentAssetsWidgets.clear();
    super.initState();
    if (widget.hasEnableTextField) {
      allBusinessDocumentAssets.add(
        BusinessDocumentAssetsEntity(
          assetExtension: '',
          assetIdNumber: widget.documentIDNumber,
          assetName: '',
          assetOriginalName: '',
          assetPath: '',
        ),
      );
    }
    allBusinessDocumentAssets.addAll(widget.allBusinessDocumentAssets.toList());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: ImplicitlyAnimatedList<BusinessDocumentAssetsEntity>(
        key: Key(widget.keyNameOfListView),
        controller: scrollController,
        items: allBusinessDocumentAssets,
        updateDuration: const Duration(milliseconds: 400),
        padding: EdgeInsetsDirectional.only(
          top: 20,
        ),
        areItemsTheSame: (a, b) => a == b,
        shrinkWrap: true,
        itemBuilder: (context, animation, assets, index) {
          return SizeFadeTransition(
            key: ObjectKey(assets),
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: animation,
            child: index == 0 && widget.hasEnableTextField
                ? _buildTextFieldItem(assets, index)
                : _buildItem(assets, index),
          );
        },
        updateItemBuilder: (context, animation, assets) {
          return FadeTransition(
            key: ObjectKey(assets),
            opacity: animation,
            child: _buildItem(assets),
          );
        },
        removeItemBuilder: (context, animation, oldAssets) {
          return FadeTransition(
            key: ObjectKey(oldAssets),
            opacity: animation,
            child: _buildItem(oldAssets),
          );
        },
      ),
    );
  }

  Widget _buildItem(BusinessDocumentAssetsEntity assets, [int index = -1]) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
      title: Text(assets.assetName),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.close),
      ),
    );
  }

  Widget _buildTextFieldItem(
    BusinessDocumentAssetsEntity assets, [
    int index = 0,
  ]) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 12),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              decoration: const InputDecoration(
                labelText: 'Trade License Number',
                alignLabelWithHint: true,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
