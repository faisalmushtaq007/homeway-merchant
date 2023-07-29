part of 'package:homemakers_merchant/app/features/store/index.dart';

class SaveStorePage extends StatefulWidget {
  const SaveStorePage({
    super.key,
    this.haveNewStore = true,
    this.currentIndex = -1,
    this.storeEntity,
  });

  final bool haveNewStore;
  final int currentIndex;
  final StoreEntity? storeEntity;

  @override
  _SaveStorePageState createState() => _SaveStorePageState();
}

class _SaveStorePageState extends State<SaveStorePage> {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  static final storFormKey = GlobalKey<FormState>();
  List<File>? file_images = [];
  List<XFile> cross_file_images = [];
  final TextEditingController _storeAddressController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _storeMaxDeliveryTimeController = TextEditingController();

  double _maximumDeliveryRadiusValue = 6.0;
  List<StoreAvailableFoodTypes> _storeAvailableFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _storeAvailableFoodPreparationType = [];
  List<StoreAcceptedPaymentModes> _storeAcceptedPaymentModes = [];
  List<StoreWorkingDayAndTime> _storeWorkingDays = [];
  final TextEditingController _storeOpeningTimeController = TextEditingController();
  final TextEditingController _storeClosingTimeController = TextEditingController();

  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];
  List<StoreAcceptedPaymentModes> _selectedAcceptedPaymentModes = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];

  bool _hasStoreOwnDeliveryService = false;
  final TextEditingController _storeOwnerDriverNameController = TextEditingController();
  final TextEditingController _storeOwnerDriverPhoneNumberController = TextEditingController();
  final TextEditingController _storeOwnerDriverLicenseController = TextEditingController();

  final deliveryTimeMuskeyFormatter = MuskeyFormatter(
    masks: ['### min'],
    wildcards: {'#': RegExp('[0-9]'), '@': RegExp('[s|S]'), '%': RegExp('[a|A]')},
    charTransforms: {
      '@': (s) => s.toUpperCase(),
      '%': (s) => s.toUpperCase(),
    },
    allowAutofill: true,
    overflow: OverflowBehavior.forbidden(),
  );
  late final MaskTextInputFormatter maximumDeliveryTimeFormatter;
  List<FocusNode> focusList = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  List<BannerModel> listBanners = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    innerScrollController = ScrollController();
    file_images = [];
    cross_file_images = [];
    //
    _storeAcceptedPaymentModes = [];
    _storeAvailableFoodPreparationType = [];
    _storeAvailableFoodTypes = [];
    _storeWorkingDays = [];
    //
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedAcceptedPaymentModes = [];
    _selectedWorkingDays = [];
    initializeStoreAcceptedPaymentModes();
    initializeStoreAvailableFoodPreparationType();
    initializeStoreWorkingDays();
    initializeStoreAvailableFoodTypes();
    listBanners = [];
    listBanners.clear();
    maximumDeliveryTimeFormatter = MaskTextInputFormatter(mask: "##", filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  }

  @override
  void dispose() {
    scrollController.dispose();
    innerScrollController.dispose();
    _storeAddressController.dispose();
    _storeNameController.dispose();
    _storeMaxDeliveryTimeController.dispose();
    _storeOpeningTimeController.dispose();
    _storeClosingTimeController.dispose();
    _storeOwnerDriverNameController.dispose();
    _storeOwnerDriverLicenseController.dispose();
    _storeOwnerDriverPhoneNumberController.dispose();
    _selectedFoodTypes = [];
    _selectedFoodPreparationType = [];
    _selectedAcceptedPaymentModes = [];
    _selectedWorkingDays = [];
    _storeAcceptedPaymentModes = [];
    _storeAvailableFoodPreparationType = [];
    _storeAvailableFoodTypes = [];
    _storeWorkingDays = [];
    file_images = [];
    cross_file_images = [];
    focusList.asMap().forEach((key, value) => value.dispose());
    super.dispose();
  }

  void initializeStoreAcceptedPaymentModes() {
    _storeAcceptedPaymentModes = [
      StoreAcceptedPaymentModes(
        title: 'Cash',
        id: 0,
      ),
      StoreAcceptedPaymentModes(
        title: 'Card',
        id: 1,
      ),
      StoreAcceptedPaymentModes(
        title: 'Online',
        id: 2,
      ),
      StoreAcceptedPaymentModes(
        title: 'Wallet',
        id: 3,
      ),
    ];
  }

  void initializeStoreAvailableFoodPreparationType() {
    _storeAvailableFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(localStoreAvailableFoodPreparationType.toList());
  }

  void initializeStoreAvailableFoodTypes() {
    _storeAvailableFoodTypes = List<StoreAvailableFoodTypes>.from(localStoreAvailableFoodTypes.toList());
  }

  void initializeStoreWorkingDays() {
    _storeWorkingDays = List<StoreWorkingDayAndTime>.from(localStoreWorkingDays.toList());
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: FlexColorScheme.themedSystemNavigationBar(
          context,
          useDivider: false,
          opacity: 0.60,
          noAppBar: true,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Add store',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            actions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: BlocListener<StoreBloc, StoreState>(
            bloc: context.watch<StoreBloc>(),
            key: const Key('save_store-page-bloc-listener-widget'),
            listener: (context, state) {
              if (state is SaveStoreState) {
                context.go(
                  Routes.NEW_STORE_GREETING_PAGE,
                  extra: state.storeEntity,
                );
                return;
              }
            },
            child: PageBody(
              controller: scrollController,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: media.size.height,
              ),
              padding: EdgeInsetsDirectional.only(
                //top: margins,
                //bottom: margins,
                start: margins * 2.5,
                end: margins * 2.5,
              ),
              child: BlocBuilder<PermissionBloc, PermissionState>(
                bloc: context.read<PermissionBloc>(),
                buildWhen: (previous, current) => previous != current,
                builder: (context, permissionState) {
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: media.size.height,
                    ),
                    child: Form(
                      key: storFormKey,
                      child: CustomScrollView(
                        controller: innerScrollController,
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  children: [
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Text(
                                        'Enter store details',
                                        style: context.titleLarge,
                                      ),
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    if (listBanners.isNotEmpty)
                                      BannerCarousel(
                                        banners: listBanners.toList(),
                                        customizedIndicators: const IndicatorModel.animation(width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                                        height: 150,
                                        activeColor: Colors.amberAccent,
                                        disableColor: Colors.white,
                                        animation: true,
                                        margin: EdgeInsetsDirectional.zero,
                                        borderRadius: 10,
                                        onTap: (id) => print(id),
                                        //width: 250,
                                        indicatorBottom: true,
                                      )
                                    else
                                      GestureDetector(
                                        onTap: () async {
                                          // Navigate to document picker page
                                          final List<dynamic>? result = await context.push<List<dynamic>>(
                                            Routes.UPLOAD_DOCUMENT_PAGE,
                                            extra: jsonEncode(
                                              {
                                                'documentType': DocumentType.other.name,
                                              },
                                            ),
                                          );
                                          // Check is Result exists or not
                                          if (result != null && result.isNotEmpty) {
                                            // Extarct and store the value
                                            String filePath = result[0] as String;
                                            XFile? xCroppedDocumentFile = result[1] as XFile;
                                            File? croppedDocumentFile = result[2] as File;
                                            XFile? xFile = result[5] as XFile;
                                            File? file = result[6] as File;
                                            String? assetNetworkUrl = result[7] as String?;
                                            final int timeStamp = DateTime.now().millisecondsSinceEpoch;
                                            var tempName = 'homeway_store_image_$timeStamp';
                                            var fileNameWithExtension =
                                                path.basenameWithoutExtension(xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? tempName);
                                            String fileExtension = path.extension(xCroppedDocumentFile?.path ?? croppedDocumentFile?.path ?? '.png');
                                            String croppedFilePath = (xCroppedDocumentFile.path.isEmpty) ? xCroppedDocumentFile.path : croppedDocumentFile.path;
                                            listBanners.insert(
                                                0,
                                                BannerModel(
                                                  imagePath: croppedFilePath,
                                                  id: Uuid().v4(),
                                                ));
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadiusDirectional.circular(10),
                                            border: BorderDirectional(
                                              start: BorderSide(width: 0.5),
                                              end: BorderSide(width: 0.5),
                                              top: BorderSide(width: 0.5),
                                              bottom: BorderSide(width: 0.5),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.camera_alt,
                                                size: 40,
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                'Upload store cover photo',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ).translate(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Wrap(
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Text(
                                          'Make sure your store image is clear and visible with jpg or png format',
                                          style: context.labelMedium!.copyWith(
                                            color: Color.fromRGBO(127, 129, 132, 1),
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          maxLines: 2,
                                          softWrap: true,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeNameController,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              labelText: 'Store name',
                                              hintText: 'Enter your store name',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                            ),
                                            focusNode: focusList[0],
                                            textInputAction: TextInputAction.next,
                                            onFieldSubmitted: (_) => fieldFocusChange(context, focusList[0], focusList[1]),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Enter store name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    MultiStreamBuilder(
                                      key: const Key(
                                        'store-address-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Store address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate('Please enter an address'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            _storeAddressController.value.text.trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: const ['Store address', 'Please enter an address', ''],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                          child: TextFormField(
                                            controller: _storeAddressController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            maxLines: 3,
                                            focusNode: focusList[1],
                                            textInputAction: TextInputAction.next,
                                            onFieldSubmitted: (_) => fieldFocusChange(context, focusList[1], focusList[2]),
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                              suffixIcon: Container(
                                                width: kMinInteractiveDimension * 1.05,
                                                constraints: BoxConstraints(
                                                  minWidth: kMinInteractiveDimension * 1.05,
                                                  minHeight: kMinInteractiveDimension * 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: BorderDirectional(
                                                    start: BorderSide(
                                                      width: 1.0,
                                                      color: Color.fromRGBO(
                                                        201,
                                                        201,
                                                        203,
                                                        1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.my_location,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Service availability',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                        const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                        Text(
                                          'Select store availability day(s) and time',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Select days',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailableWorkingDaysFormField(
                                      onSelectionChanged: (List<StoreWorkingDayAndTime> selectedWorkingDays) {
                                        _selectedWorkingDays = List<StoreWorkingDayAndTime>.from(selectedWorkingDays);
                                        setState(() {});
                                      },
                                      availableWorkingDaysList: _storeWorkingDays.toList(),
                                      validator: (value) {
                                        if (value == null || value.length == 0) {
                                          return 'Select one or more days';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedAvailableWorkingDaysList: [],
                                      onSaved: (newValue) {},
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Select time',
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      style: context.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: DateTimeFieldPlatform(
                                            mode: DateMode.time,
                                            maximumDate: DateTime.now().add(const Duration(hours: 2)),
                                            minimumDate: DateTime.now().subtract(const Duration(hours: 2)),
                                            controller: _storeOpeningTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Open time',
                                              hintText: 'Select open time',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                              isDense: true,
                                              contentPadding: EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Select open time';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const AnimatedGap(16, duration: Duration(milliseconds: 500)),
                                        Expanded(
                                          child: DateTimeFieldPlatform(
                                            mode: DateMode.time,
                                            maximumDate: DateTime.now().add(const Duration(hours: 2)),
                                            minimumDate: DateTime.now().subtract(const Duration(hours: 2)),
                                            controller: _storeClosingTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Close time',
                                              hintText: 'Select close time',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                              isDense: true,
                                              contentPadding: EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 12),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Select close time';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Text(
                                      'Food types',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailableFoodTypeFormField(
                                      onSelectionChanged: (List<StoreAvailableFoodTypes> selectedFoodTypes) {
                                        _selectedFoodTypes = List<StoreAvailableFoodTypes>.from(selectedFoodTypes);
                                        setState(() {});
                                      },
                                      availableFoodTypesList: _storeAvailableFoodTypes.toList(),
                                      validator: (value) {
                                        if (value == null || value.length == 0) {
                                          return 'Select one or more food type';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedAvailableFoodTypesList: [],
                                      onSaved: (newValue) {},
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Food preparation method',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailableFoodPreparationTypesFormField(
                                      onSelectionChanged: (List<StoreAvailableFoodPreparationType> selectedPreparationTypes) {
                                        _selectedFoodPreparationType = List<StoreAvailableFoodPreparationType>.from(selectedPreparationTypes);
                                        setState(() {});
                                      },
                                      availableFoodPreparationTypesList: _storeAvailableFoodPreparationType.toList(),
                                      validator: (value) {
                                        if (value == null || value.length == 0) {
                                          return 'Select one or more food preparation method';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedFoodPreparationTypesList: [],
                                      onSaved: (newValue) {},
                                    ),
                                    Divider(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Delivery options',
                                          style: context.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                        const AnimatedGap(2, duration: Duration(milliseconds: 500)),
                                        Text(
                                          'Do you have your own delivery service',
                                          style: context.labelMedium,
                                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        ).translate(),
                                      ],
                                    ),
                                    Card(
                                      margin: EdgeInsetsDirectional.only(start: 0, end: 0, top: 4, bottom: 4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          SwitchListTile(
                                            onChanged: (value) {
                                              setState(() {
                                                _hasStoreOwnDeliveryService = value;
                                              });
                                            },
                                            value: _hasStoreOwnDeliveryService,
                                            title: Text('I have my own delivery service').translate(),
                                            isThreeLine: false,
                                            dense: true,
                                            controlAffinity: ListTileControlAffinity.leading,
                                            visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                                          ),
                                          AnimatedCrossFade(
                                            firstChild: SizedBox.shrink(),
                                            secondChild: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                const AnimatedGap(8, duration: Duration(milliseconds: 500)),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      child: StoreTextFieldWidget(
                                                        controller: _storeOwnerDriverNameController,
                                                        focusNode: focusList[4],
                                                        textInputAction: TextInputAction.next,
                                                        onFieldSubmitted: (_) => fieldFocusChange(context, focusList[4], focusList[5]),
                                                        decoration: InputDecoration(
                                                          labelText: 'Driver name',
                                                          hintText: 'Enter driver name',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (_hasStoreOwnDeliveryService) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter driver name';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      child: StoreTextFieldWidget(
                                                        controller: _storeOwnerDriverPhoneNumberController,
                                                        focusNode: focusList[5],
                                                        textInputAction: TextInputAction.next,
                                                        onFieldSubmitted: (_) => fieldFocusChange(context, focusList[5], focusList[6]),
                                                        decoration: InputDecoration(
                                                          labelText: 'Driver mobile number',
                                                          hintText: 'Enter driver mobile number',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (_hasStoreOwnDeliveryService) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter driver mobile number';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                                  children: [
                                                    Expanded(
                                                      child: StoreTextFieldWidget(
                                                        controller: _storeOwnerDriverLicenseController,
                                                        focusNode: focusList[6],
                                                        textInputAction: TextInputAction.next,
                                                        onFieldSubmitted: (_) => fieldFocusChange(context, focusList[6], focusList[7]),
                                                        decoration: InputDecoration(
                                                          labelText: 'Driver driving license number',
                                                          hintText: 'Enter driver driving license',
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        validator: (value) {
                                                          if (_hasStoreOwnDeliveryService) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter driver driving license';
                                                            } else {
                                                              return null;
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            crossFadeState: (_hasStoreOwnDeliveryService == true) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                            duration: const Duration(milliseconds: 500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Maximum delivery time',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeMaxDeliveryTimeController,
                                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                            focusNode: focusList[7],
                                            textInputAction: TextInputAction.done,
                                            onFieldSubmitted: (_) => fieldFocusChange(context, focusList[7], focusList[8]),
                                            decoration: InputDecoration(
                                              hintText: '00',
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              suffixText: 'min',
                                            ),
                                            inputFormatters: [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              maximumDeliveryTimeFormatter,
                                            ],
                                            onChanged: (value) {},
                                            validator: (value) {
                                              if (value == null || value.isEmpty || maximumDeliveryTimeFormatter.getUnmaskedText().isEmpty) {
                                                return 'Please enter delivery time';
                                              } else {
                                                return null;
                                              }
                                              /*if (value == null || value.isEmpty || deliveryTimeMuskeyFormatter.info.clean.isEmpty) {
                                        return 'Please enter delivery time';
                                      } else if (!deliveryTimeMuskeyFormatter.info.isValid) {
                                        return 'Please enter delivery time';
                                      }*/
                                            },
                                          ),
                                        ),
                                        /*Expanded(
                                  flex: 3,
                                  child: SizedBox(),
                                ),*/
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Text(
                                      'Maximum delivery radius',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    SliderTheme(
                                      data: SliderThemeData(
                                        // here
                                        overlayShape: SliderComponentShape.noOverlay,
                                      ),
                                      child: Slider(
                                        min: 1.0,
                                        divisions: 19,
                                        max: 20.0,
                                        value: _maximumDeliveryRadiusValue,
                                        label: _maximumDeliveryRadiusValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _maximumDeliveryRadiusValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    Divider(),
                                    Text(
                                      'Accepted payment mode',
                                      style: context.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    ).translate(),
                                    const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                                    MultiSelectAvailablePaymentModeFormField(
                                      onSelectionChanged: (List<StoreAcceptedPaymentModes> selectedPaymentModes) {
                                        _selectedAcceptedPaymentModes = List<StoreAcceptedPaymentModes>.from(selectedPaymentModes);
                                        setState(() {});
                                      },
                                      availablePaymentModesList: _storeAcceptedPaymentModes.toList(),
                                      validator: (value) {
                                        if (value == null || value.length == 0) {
                                          return 'Select one or more payment mode';
                                        } else {
                                          return null;
                                        }
                                      },
                                      initialSelectedAvailablePaymentModesList: [],
                                      onSaved: (newValue) {},
                                    ),
                                    const AnimatedGap(30, duration: Duration(milliseconds: 500)),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (storFormKey.currentState!.validate()) {
                                          storFormKey.currentState!.save();

                                          final storeInfo = StoreEntity(
                                            storeName: _storeNameController.value.text,
                                            storeAddress: AddressModel(
                                              address: AddressBean(
                                                area: _storeAddressController.value.text,
                                              ),
                                            ),
                                            storeImagePath: '',
                                            storeImageMetaData: {},
                                            storeMaximumFoodDeliveryTime: int.parse(_storeMaxDeliveryTimeController.value.text),
                                            storeMaximumFoodDeliveryRadius: _maximumDeliveryRadiusValue.toInt(),
                                            storeOpeningTime: _storeOpeningTimeController.value.text.trim(),
                                            storeClosingTime: _storeClosingTimeController.value.text.trim(),
                                            hasStoreOwnDeliveryPartners: _hasStoreOwnDeliveryService,
                                            storeAcceptedPaymentModes: _selectedAcceptedPaymentModes.toList(),
                                            storeAvailableFoodPreparationType: _selectedFoodPreparationType.toList(),
                                            storeAvailableFoodTypes: _selectedFoodTypes.toList(),
                                            storeOwnDeliveryPartnersInfo: (_hasStoreOwnDeliveryService)
                                                ? [
                                                    StoreOwnDeliveryPartnersInfo(
                                                      driverMobileNumber: _storeOwnerDriverPhoneNumberController.value.text,
                                                      driverName: _storeOwnerDriverNameController.value.text,
                                                      drivingLicenseNumber: _storeOwnerDriverLicenseController.value.text,
                                                    ),
                                                  ]
                                                : [],
                                            storeWorkingDays: _selectedWorkingDays.toList(),
                                            hasNewStore: widget.haveNewStore,
                                          );
                                          StoreEntity storeEntity;
                                          if (!widget.haveNewStore && widget.storeEntity != null && widget.currentIndex != -1) {
                                            storeEntity = storeInfo.copyWith(
                                              storeID: widget.storeEntity?.storeID,
                                            );
                                          } else {
                                            storeEntity = storeInfo.copyWith(
                                              storeID: ((DateTime.now().millisecondsSinceEpoch - DateTime.now().millisecond) / 100).toInt(),
                                            );
                                          }
                                          if (!mounted) {
                                            return;
                                          }
                                          context.read<StoreBloc>().add(SaveStore(
                                                storeEntity: storeEntity,
                                                hasNewStore: widget.haveNewStore,
                                              ));
                                          return;
                                        }
                                        return;
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(69, 201, 125, 1),
                                      ),
                                      child: Text(
                                        'Save Store',
                                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
