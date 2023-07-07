import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/multi_select_store_available_accepted_payment_mode_widget.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/multi_select_store_available_food_preparation_widget.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/multi_select_store_available_food_types_widget.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/multi_select_store_available_working_days_widget.dart';
import 'package:homemakers_merchant/app/features/dashboard/presentation/widgets/store_text_field_widget.dart';
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

class SaveStorePage extends StatefulWidget {
  const SaveStorePage({super.key});

  @override
  _SaveStorePageState createState() => _SaveStorePageState();
}

class _SaveStorePageState extends State<SaveStorePage> {
  final ScrollController scrollController = ScrollController();
  static final storFormKey = GlobalKey<FormState>();
  List<File>? file_images = [];
  List<XFile> cross_file_images = [];
  TextEditingController _storeAddressController = TextEditingController();
  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _storeMaxDeliveryTimeController = TextEditingController();
  bool? _hasStoreOpenAllDays;
  double _maximumDeliveryRadiusValue = 6.0;
  List<StoreAvailableFoodTypes> _storeAvailableFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _storeAvailableFoodPreparationType = [];
  List<StoreAcceptedPaymentModes> _storeAcceptedPaymentModes = [];
  List<StoreWorkingDayAndTime> _storeWorkingDays = [];
  TextEditingController _storeOpeningTimeController = TextEditingController();
  TextEditingController _storeClosingTimeController = TextEditingController();

  List<StoreAvailableFoodTypes> _selectedFoodTypes = [];
  List<StoreAvailableFoodPreparationType> _selectedFoodPreparationType = [];
  List<StoreAcceptedPaymentModes> _selectedAcceptedPaymentModes = [];
  List<StoreWorkingDayAndTime> _selectedWorkingDays = [];

  bool _hasStoreOwnDeliveryService = false;
  TextEditingController _storeOwnerDriverNameController = TextEditingController();
  TextEditingController _storeOwnerDriverPhoneNumberController = TextEditingController();
  TextEditingController _storeOwnerDriverLicenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _storeAddressController.dispose();
    _storeNameController.dispose();
    _storeMaxDeliveryTimeController.dispose();
    _storeOpeningTimeController.dispose();
    _storeClosingTimeController.dispose();
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
    _storeAvailableFoodPreparationType = [
      StoreAvailableFoodPreparationType(id: 0, title: 'Cooking'),
      StoreAvailableFoodPreparationType(id: 1, title: 'Cooked'),
      StoreAvailableFoodPreparationType(id: 2, title: 'Baking'),
      StoreAvailableFoodPreparationType(id: 3, title: 'Baked'),
      StoreAvailableFoodPreparationType(id: 4, title: 'Sauteing'),
      StoreAvailableFoodPreparationType(id: 5, title: 'Poaching'),
      StoreAvailableFoodPreparationType(id: 6, title: 'Broiling'),
      StoreAvailableFoodPreparationType(id: 7, title: 'Grilling'),
      StoreAvailableFoodPreparationType(id: 8, title: 'Roasting'),
      StoreAvailableFoodPreparationType(id: 9, title: 'Deep Frying'),
      StoreAvailableFoodPreparationType(id: 10, title: 'Sallow Frying'),
      StoreAvailableFoodPreparationType(id: 11, title: 'Pan Frying'),
      StoreAvailableFoodPreparationType(id: 12, title: 'Stir Frying'),
      StoreAvailableFoodPreparationType(id: 13, title: 'Searing'),
      StoreAvailableFoodPreparationType(id: 14, title: 'Boiling'),
      StoreAvailableFoodPreparationType(id: 15, title: 'Flambeing'),
    ];
  }

  void initializeStoreAvailableFoodTypes() {
    _storeAvailableFoodTypes = [
      StoreAvailableFoodTypes(title: 'Veg', id: 0),
      StoreAvailableFoodTypes(title: 'Chicken', id: 1),
      StoreAvailableFoodTypes(title: 'Vegan', id: 2),
      StoreAvailableFoodTypes(title: 'Egg', id: 3),
      StoreAvailableFoodTypes(title: 'Seeds', id: 3),
      StoreAvailableFoodTypes(title: 'Dairy', id: 4),
      StoreAvailableFoodTypes(title: 'Soups', id: 5),
      StoreAvailableFoodTypes(title: 'Legumes', id: 6),
      StoreAvailableFoodTypes(title: 'Meat', id: 7),
      StoreAvailableFoodTypes(title: 'Fish', id: 8),
      StoreAvailableFoodTypes(title: 'Prawns', id: 9),
      StoreAvailableFoodTypes(title: 'Others', id: 10),
    ];
  }

  void initializeStoreWorkingDays() {
    _storeWorkingDays = [
      StoreWorkingDayAndTime(day: 'Monday', id: 0, shortName: 'Sun'),
      StoreWorkingDayAndTime(day: 'Monday', id: 1, shortName: 'Mon'),
      StoreWorkingDayAndTime(day: 'Tuesday', id: 2, shortName: 'Tue'),
      StoreWorkingDayAndTime(day: 'Wednesday', id: 3, shortName: 'Wed'),
      StoreWorkingDayAndTime(day: 'Thursday', id: 4, shortName: 'Thur'),
      StoreWorkingDayAndTime(day: 'Friday', id: 5, shortName: 'Fri'),
      StoreWorkingDayAndTime(day: 'Saturday', id: 6, shortName: 'Sat'),
    ];
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
                        const AnimatedGap(10, duration: Duration(milliseconds: 500)),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'Enter store details',
                            style: context.titleLarge,
                          ),
                        ),
                        const AnimatedGap(10, duration: Duration(milliseconds: 500)),
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
                        const AnimatedGap(10, duration: Duration(milliseconds: 500)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: StoreTextFieldWidget(
                                controller: _storeNameController,
                                decoration: InputDecoration(
                                  labelText: 'Store name',
                                  hintText: 'Enter your store name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isDense: true,
                                ),
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
                        MultiSelectStoreAvailableWorkingDays(
                          onSelectionChanged: (List<StoreWorkingDayAndTime> selectedWorkingDays) {},
                          availableWorkingDayList: _storeWorkingDays.toList(),
                        ),
                        CheckboxListTile(
                          value: _hasStoreOpenAllDays,
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          contentPadding: EdgeInsetsDirectional.zero,
                          visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                          isThreeLine: false,
                          onChanged: (value) {
                            setState(() {
                              _hasStoreOpenAllDays = value;
                            });
                          },
                          tristate: true,
                          title: Text(
                            'All days',
                            textDirection: serviceLocator<LanguageController>().targetTextDirection,
                            style: context.titleSmall,
                          ),
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
                        MultiSelectStoreAvailableFoodTypes(
                          onSelectionChanged: (List<StoreAvailableFoodTypes> selectedFoodTypes) {},
                          availableFoodTypesList: _storeAvailableFoodTypes.toList(),
                        ),
                        const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                        Text(
                          'Food preparation type',
                          style: context.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        ).translate(),
                        MultiSelectStoreAvailableFoodPreparationTypes(
                          onSelectionChanged: (List<StoreAvailableFoodPreparationType> selectedPreparationTypes) {},
                          availableFoodPreparationTypesList: _storeAvailableFoodPreparationType.toList(),
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
                              'I have own delivery service',
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
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeOwnerDriverNameController,
                                            decoration: InputDecoration(
                                              labelText: 'Driver name',
                                              hintText: 'Enter driver name',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeOwnerDriverPhoneNumberController,
                                            decoration: InputDecoration(
                                              labelText: 'Driver mobile number',
                                              hintText: 'Enter driver mobile number',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const AnimatedGap(12, duration: Duration(milliseconds: 500)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: StoreTextFieldWidget(
                                            controller: _storeOwnerDriverLicenseController,
                                            decoration: InputDecoration(
                                              labelText: 'Driver driving license number',
                                              hintText: 'Enter driver driving license',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              isDense: true,
                                            ),
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
                          children: [
                            Directionality(
                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              child: Expanded(
                                child: StoreTextFieldWidget(
                                  controller: _storeMaxDeliveryTimeController,
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  decoration: InputDecoration(
                                    hintText: '30 mins',
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                        Slider(
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
                        Divider(),
                        Text(
                          'Accepted payment mode',
                          style: context.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        ).translate(),
                        MultiSelectStoreAvailablePaymentMode(
                          onSelectionChanged: (List<StoreAcceptedPaymentModes> selectedPaymentModes) {},
                          availablePaymentModes: _storeAcceptedPaymentModes.toList(),
                        ),
                        const AnimatedGap(30, duration: Duration(milliseconds: 500)),
                        ElevatedButton(
                          onPressed: () {},
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
