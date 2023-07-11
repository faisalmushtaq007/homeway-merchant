import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/address/domain/entities/address_model.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/business/business_profile_entity.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/user_entity.dart';
import 'package:homemakers_merchant/base/app_base.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/app_translator.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/config/translation/widgets/language_selection_widget.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/core/extensions/string/pattern.dart';
import 'package:homemakers_merchant/shared/router/app_pages.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/multi_stream_builder/multi_stream_builder.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phonenumber_form_field_widget.dart';

class BusinessInformationPage extends StatefulWidget {
  const BusinessInformationPage({super.key});

  @override
  _BusinessInformationPageState createState() => _BusinessInformationPageState();
}

class _BusinessInformationPageState extends State<BusinessInformationPage> with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;

  late AnimationController _animationController;
  late Animation<double> _animation;

  final _createBusinessProfileFormKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String _selectedGender = 'Male';

  // Local PhoneController variables
  String? phoneValidation;
  String userEnteredPhoneNumber = '';
  PhoneNumberVerification phoneNumberVerification = PhoneNumberVerification.none;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _animationController.dispose();
    _usernameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding = margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
    final double bottomPadding = media.padding.bottom + margins;
    final double width = media.size.width;
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        useDivider: false,
        opacity: 0.60,
        noAppBar: true,
      ),
      child: PlatformScaffold(
        material: (context, platform) {
          return MaterialScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        cupertino: (context, platform) {
          return CupertinoPageScaffoldData(
            resizeToAvoidBottomInset: false,
          );
        },
        appBar: PlatformAppBar(
          trailingActions: const [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
              child: LanguageSelectionWidget(),
            ),
          ],
        ),
        body: Directionality(
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          child: PageBody(
            controller: scrollController,
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: media.size.height,
            ),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.translationValues(
                    _animation.value * width,
                    0.0,
                    0.0,
                  ),
                  child: Form(
                    key: _createBusinessProfileFormKey,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: topPadding,
                        bottom: bottomPadding,
                      ),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        clipBehavior: Clip.none,
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        children: [
                          ListView(
                            controller: scrollController,
                            shrinkWrap: true,
                            padding: EdgeInsetsDirectional.only(
                              start: margins * 2.5,
                              end: margins * 2.5,
                            ),
                            children: [
                              Text(
                                'Enter the business details',
                                style: context.titleLarge,
                                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                              ).translate(),
                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              MultiStreamBuilder(
                                key: const Key(
                                  'business-fullname-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Full name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Please enter a full name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _usernameController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: const ['Full name', 'Please enter a full name', ''],
                                builder: (context, snapshot) {
                                  final String translateString = snapshot[2] as String;
                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _usernameController,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
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
                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              MultiStreamBuilder(
                                key: const Key(
                                  'business-name-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Business name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a business name',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _businessNameController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: const ['Business name', 'Please enter a business name', ''],
                                builder: (context, snapshot) {
                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _businessNameController,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
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
                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              MultiStreamBuilder(
                                key: const Key(
                                  'business-email-address-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Business email address'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter an email address',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a valid email address',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _emailController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: const ['Business email address', 'Please enter an email address', 'Please enter a valid email address', ''],
                                builder: (context, snapshot) {
                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _emailController,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '${snapshot[1]}';
                                        }
                                        /*else if (!value.contains('@')) {
                                          return 'Please enter a valid email address'.tr();
                                        }*/
                                        else if (!value.hasValidEmailAddress(value)) {
                                          return '${snapshot[2]}';
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                },
                              ),
                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: BlocBuilder<PhoneFormFieldBloc, PhoneNumberFormFieldState>(
                                      bloc: context.read<PhoneFormFieldBloc>(),
                                      buildWhen: (previous, current) => previous != current,
                                      builder: (context, state) {
                                        state.maybeWhen(
                                          orElse: () {},
                                          validate: (
                                            isAllowEmpty,
                                            mobileOnly,
                                            phoneNumberInputValidator,
                                            phoneValidation,
                                            phoneController,
                                            phoneNumber,
                                            phoneNumberVerification,
                                            userEnteredPhoneNumber,
                                            countryDialCode,
                                            country,
                                          ) {
                                            this.phoneNumberVerification = phoneNumberVerification;
                                            this.userEnteredPhoneNumber = userEnteredPhoneNumber;
                                          },
                                        );
                                        return MultiStreamBuilder(
                                          key: const Key(
                                            'business-phone-number-textFormField-key',
                                          ),
                                          buildWhen: (
                                            previousDataList,
                                            latestDataList,
                                          ) =>
                                              previousDataList != latestDataList,
                                          streams: [
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                'Business phone number',
                                              ),
                                            ),
                                            Stream.fromFuture(
                                              AppTranslator.instance.translate(
                                                '$phoneValidation',
                                              ),
                                            ),
                                          ],
                                          initialStreamValue: [
                                            'Business phone number',
                                            phoneValidation,
                                          ],
                                          builder: (context, snapshot) {
                                            return Directionality(
                                              textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                              child: PhoneNumberFieldWidget(
                                                key: const Key(
                                                  'user-business-phone-number-widget-key',
                                                ),
                                                isCountryChipPersistent: false,
                                                outlineBorder: true,
                                                shouldFormat: true,
                                                useRtl: false,
                                                withLabel: true,
                                                decoration: InputDecoration(
                                                  labelText: snapshot[0],
                                                  alignLabelWithHint: true,
                                                  //hintText: 'Mobile number',
                                                  errorText: phoneValidation,
                                                  isDense: true,
                                                ),
                                                isAllowEmpty: false,
                                                autofocus: false,
                                                style: context.bodyLarge,
                                                showFlagInInput: false,
                                                countryCodeStyle: context.bodyLarge,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              MultiStreamBuilder(
                                key: const Key(
                                  'business-address-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Business address'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Please enter an address'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _addressController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: const ['Business address', 'Please enter an address', ''],
                                builder: (context, snapshot) {
                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _addressController,
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
/*                              const AnimatedGap(
                                16,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              MultiStreamBuilder(
                                key: const Key(
                                  'business-fullname-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) =>
                                    previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Gender'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Male'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Female',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Other',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _selectedGender,
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'Gender',
                                  'Male',
                                  'Female',
                                  'Other',
                                  _selectedGender
                                ],
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: snapshot[0],
                                      isDense: true,
                                    ),
                                    value: snapshot[4],
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: snapshot[1],
                                        child: Text('Male').translate(),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: snapshot[2],
                                        child: Text('Female').translate(),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: snapshot[3],
                                        child: Text('Other').translate(),
                                      ),
                                    ],
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  );
                                },
                              ),*/
                              AnimatedGap(
                                context.height / 3.15 - bottomPadding,
                                duration: Duration(
                                  milliseconds: 300,
                                ),
                              ),
                              SizedBox(
                                width: context.width - margins * 5,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_createBusinessProfileFormKey.currentState!.validate()) {
                                      _createBusinessProfileFormKey.currentState!.save();
                                      await Future.delayed(const Duration(milliseconds: 500), () {});
                                      if (!mounted) {
                                        return;
                                      }
                                      var businessProfile = serviceLocator<BusinessProfileEntity>().copyWith(
                                        userName: _usernameController.value.text,
                                        businessAddress: AddressModel(
                                          address: AddressBean(area: _addressController.value.text),
                                        ),
                                        businessEmailAddress: _emailController.value.text,
                                        businessName: _businessNameController.value.text,
                                        businessPhoneNumber: userEnteredPhoneNumber,
                                      );
                                      serviceLocator<AppUserEntity>().currentProfileStatus = CurrentProfileStatus.basicProfileSaved;
                                      serviceLocator<AppUserEntity>().businessProfile = businessProfile;
                                      context.go(Routes.CONFIRM_BUSINESS_TYPE_PAGE);
                                    }
                                  },
                                  child: Text(
                                    'Next',
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                  ).translate(),
                                ),
                              ),
                            ],
                          ),

                          /*Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: context.width - margins * 5,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_createBusinessProfileFormKey.currentState!
                                      .validate()) {
                                    // Registration logic here
                                    final username = _usernameController.text;
                                    final email = _emailController.text;
                                    final phone = userEnteredPhoneNumber;
                                    final address = _addressController.text;

                                    // Print the entered information
                                    print('Username: $username');
                                    print('Email: $email');
                                    print('Phone: $phone');
                                    print('Address: $address');
                                    print('Gender: $_selectedGender');
                                  }
                                },
                                child: Text('Next'.tr()),
                              ),
                            ),
                          ),*/
                        ],
                      ),
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
