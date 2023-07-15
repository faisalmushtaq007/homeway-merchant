import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/store//presentation/widgets/multi_select_store_available_accepted_payment_mode_widget.dart';
import 'package:homemakers_merchant/app/features/store/data/local/data_sources/store_local_data.dart';
import 'package:homemakers_merchant/app/features/store/presentation/manager/store_bloc.dart';
import 'package:homemakers_merchant/app/features/store/presentation/widgets/multi_select_store_available_food_preparation_widget.dart';
import 'package:homemakers_merchant/app/features/store/presentation/widgets/multi_select_store_available_food_types_widget.dart';
import 'package:homemakers_merchant/app/features/store/presentation/widgets/multi_select_store_available_working_days_widget.dart';
import 'package:homemakers_merchant/app/features/store/presentation/widgets/store_text_field_widget.dart';
import 'package:homemakers_merchant/app/features/permission/presentation/bloc/permission_bloc.dart';
import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/shared/widgets/app/app_logo.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animate_do/animate_do.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/carousel_animation/carousel_animations.dart';
import 'package:homemakers_merchant/shared/widgets/universal/constrained_scrollable_views/constrained_scrollable_views.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/shared/widgets/universal/date_time_picker_platform/datetime_picker_field_platform.dart';
import 'package:homemakers_merchant/shared/widgets/universal/double_tap_exit/double_tap_to_exit.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/multi_stream_builder.dart';
import 'package:homemakers_merchant/utils/fieldFocusChange.dart';
import 'package:homemakers_merchant/utils/input_formatters/mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:homemakers_merchant/utils/input_formatters/muskey.dart';

class SaveStorePage extends StatefulWidget {
  const SaveStorePage({super.key});

  @override
  _SaveStorePageState createState() => _SaveStorePageState();
}

class _SaveStorePageState extends State<SaveStorePage> {
  late final ScrollController scrollController;
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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
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
    maximumDeliveryTimeFormatter = MaskTextInputFormatter(mask: "##", filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  }

  @override
  void dispose() {
    scrollController.dispose();
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
        child: PlatformScaffold(
          material: (context, platform) {
            return MaterialScaffoldData(
              resizeToAvoidBottomInset: true,
            );
          },
          cupertino: (context, platform) {
            return CupertinoPageScaffoldData(
              resizeToAvoidBottomInset: true,
            );
          },
          appBar: PlatformAppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Add store',
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ),
            trailingActions: const [
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: LanguageSelectionWidget(),
              ),
            ],
          ),
          body: PageBody(
            controller: scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            padding: EdgeInsetsDirectional.only(
              top: margins,
              bottom: bottomPadding,
              start: margins * 2.5,
              end: margins * 2.5,
            ),
            child: BlocBuilder<PermissionBloc, PermissionState>(
              bloc: context.read<PermissionBloc>(),
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: media.size.height,
                  ),
                  child: Form(
                    key: storFormKey,
                    child: ScrollableColumn(
                      controller: scrollController,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                      physics: const ClampingScrollPhysics(),
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
                        cross_file_images.isNotEmpty
                            ? Swiper(
                                itemBuilder: (context, index) {
                                  final image = cross_file_images[index];
                                  return Image.asset(
                                    image.toString(),
                                    fit: BoxFit.fill,
                                  );
                                },
                                indicatorLayout: PageIndicatorLayout.COLOR,
                                autoplay: true,
                                itemCount: cross_file_images.length,
                                pagination: const SwiperPagination(),
                                control: const SwiperControl())
                            : GestureDetector(
                                onTap: () {},
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
                                storeOpeningTime: _storeOpeningTimeController.value.text,
                                storeClosingTime: _storeClosingTimeController.value.text,
                                storeID: ((DateTime.now().millisecondsSinceEpoch - DateTime.now().millisecond) / 100).toInt(),
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
                              );
                              serviceLocator<List<StoreEntity>>().add(storeInfo);
                              context.read<StoreBloc>().add(SaveStore(storeEntity: storeInfo, hasNewStore: true));
                              context.go(
                                Routes.NEW_STORE_GREETING_PAGE,
                                extra: storeInfo,
                              );
                              return;
                            }
                            return;
                          },
                          child: Text(
                            'Add Store',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
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
    );
  }
}
