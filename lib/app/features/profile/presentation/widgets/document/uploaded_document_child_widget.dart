part of 'package:homemakers_merchant/app/features/profile/index.dart';

class UploadedDocumentChildWidget extends StatefulWidget {
  const UploadedDocumentChildWidget({
    required this.keyNameOfListView,
    super.key,
    this.allBusinessDocumentAssets = const [],
    this.hasEnableTextField = false,
    this.documentIDNumber = '',
    this.labelOfTextField = '',
    this.textEditingController,
    this.onChanged,
    this.onSubmitted,
  });

  final List<BusinessDocumentAssetsEntity> allBusinessDocumentAssets;
  final String keyNameOfListView;
  final bool hasEnableTextField;
  final String documentIDNumber;
  final String labelOfTextField;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<UploadedDocumentChildWidget> createState() => _UploadedDocumentChildWidgetState();
}

class _UploadedDocumentChildWidgetState extends State<UploadedDocumentChildWidget> {
  List<BusinessDocumentAssetsEntity> allBusinessDocumentAssets = [];
  List<Widget> allBusinessDocumentAssetsWidgets = [];
  ScrollController scrollController = ScrollController();
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = widget.textEditingController ?? TextEditingController();
    allBusinessDocumentAssets = [];
    allBusinessDocumentAssets.clear();
    allBusinessDocumentAssetsWidgets = [];
    allBusinessDocumentAssetsWidgets.clear();
    super.initState();
    /*if (widget.hasEnableTextField) {
      allBusinessDocumentAssets.add(
        BusinessDocumentAssetsEntity(
          assetExtension: '',
          assetIdNumber: widget.documentIDNumber,
          assetName: '',
          assetOriginalName: '',
          assetPath: '',
        ),
      );
    }*/
    allBusinessDocumentAssets.addAll(widget.allBusinessDocumentAssets.toList());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: BlocBuilder<BusinessDocumentBloc, BusinessDocumentState>(
        key: const Key('uploaded-document-child-bloc-builder-widget'),
        //buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return ImplicitlyAnimatedList<BusinessDocumentAssetsEntity>(
            key: Key(widget.keyNameOfListView),
            controller: scrollController,
            items: allBusinessDocumentAssets,
            updateDuration: const Duration(milliseconds: 400),
            padding: EdgeInsetsDirectional.only(
              top: 16,
            ),
            areItemsTheSame: (a, b) => a == b,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, animation, assets, index) {
              appLog.d('itemBuilder child: ${assets.assetOriginalName}');
              return SizeFadeTransition(
                //key: ObjectKey(assets),
                sizeFraction: 0.7,
                curve: Curves.easeInOut,
                animation: animation,
                child: index == 0 && widget.hasEnableTextField ? _buildTextFieldItem(assets, index) : _buildItem(assets, index),
              );
            },
            updateItemBuilder: (context, animation, assets) {
              appLog.d('updateItemBuilder child: ${assets.assetOriginalName}');
              return FadeTransition(
                //key: ObjectKey(assets),
                opacity: animation,
                child: _buildItem(assets),
              );
            },
            removeItemBuilder: (context, animation, oldAssets) {
              appLog.d('updateItemBuilder child: ${oldAssets.assetOriginalName}');
              return FadeTransition(
                //key: ObjectKey(oldAssets),
                opacity: animation,
                child: _buildItem(oldAssets),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildItem(BusinessDocumentAssetsEntity assets, [int index = -1]) {
    appLog.d('_buildItem child: ${assets.assetOriginalName}');
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 8, bottom: 4),
      child: ListTile(
        selected: true,
        selectedTileColor: Color.fromRGBO(226, 242, 228, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        title: Text(assets.assetName),
        trailing: SizedBox(
          height: 26,
          width: 26,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(234, 247, 238, 1),
              foregroundColor: Color.fromRGBO(127, 129, 132, 1),
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            onPressed: () {},
            child: const Icon(
              Icons.close,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldItem(
    BusinessDocumentAssetsEntity assets, [
    int index = 0,
  ]) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 12, bottom: 4),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
              decoration: InputDecoration(
                labelText: widget.labelOfTextField,
                alignLabelWithHint: true,
                isDense: true,
              ),
              onChanged: widget.onChanged,
              onSubmitted: (value) {
                widget.onSubmitted!(value);
                context.read<BusinessDocumentBloc>().add(
                      TradeLicenseNumberOnChanged(
                        textEditingController: textEditingController,
                        currentUpdatedValue: textEditingController.value.text.trim(),
                        index: index,
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
