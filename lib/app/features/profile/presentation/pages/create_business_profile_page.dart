import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/config/translation/extension/string_extension.dart';
import 'package:homemakers_merchant/core/constants/global_app_constants.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/core/extensions/string/pattern.dart';
import 'package:homemakers_merchant/shared/widgets/app/page_body.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/animated_gap/src/widgets/gap.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phone_form_field_bloc.dart';
import 'package:homemakers_merchant/shared/widgets/universal/phone_number_text_field/phonenumber_form_field_widget.dart';

class CreateBusinessProfilePage extends StatefulWidget {
  const CreateBusinessProfilePage({super.key});

  @override
  _CreateBusinessProfilePageState createState() =>
      _CreateBusinessProfilePageState();
}

class _CreateBusinessProfilePageState extends State<CreateBusinessProfilePage>
    with SingleTickerProviderStateMixin {
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
  PhoneNumberVerification phoneNumberVerification =
      PhoneNumberVerification.none;

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
    final double topPadding = margins *
        1.5; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
        body: PageBody(
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
                    padding: EdgeInsets.fromLTRB(
                      margins * 2.5,
                      topPadding,
                      margins * 2.5,
                      bottomPadding,
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          controller: scrollController,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Enter the business details'.tr(),
                                  style: context.titleLarge,
                                )
                              ],
                            ),
                            const AnimatedGap(
                              16,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Full name'.tr(),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a full name'.tr();
                                }
                                return null;
                              },
                            ),
                            const AnimatedGap(
                              16,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            TextFormField(
                              controller: _businessNameController,
                              decoration: InputDecoration(
                                labelText: 'Business name'.tr(),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a business name'.tr();
                                }
                                return null;
                              },
                            ),
                            const AnimatedGap(
                              16,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Business email address'.tr(),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email address'.tr();
                                }
                                /*else if (!value.contains('@')) {
                                  return 'Please enter a valid email address'.tr();
                                }*/
                                else if (!value.hasValidEmailAddress(value)) {
                                  return 'Please enter a valid email address'
                                      .tr();
                                }
                                return null;
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
                                  child: BlocBuilder<PhoneFormFieldBloc,
                                      PhoneNumberFormFieldState>(
                                    bloc: context.read<PhoneFormFieldBloc>(),
                                    buildWhen: (previous, current) =>
                                        previous != current,
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
                                          this.phoneNumberVerification =
                                              phoneNumberVerification;
                                          this.userEnteredPhoneNumber =
                                              userEnteredPhoneNumber;
                                        },
                                      );
                                      return PhoneNumberFieldWidget(
                                        key: const Key(
                                            'user-business-phone-number-widget-key'),
                                        isCountryChipPersistent: false,
                                        outlineBorder: true,
                                        shouldFormat: true,
                                        useRtl: false,
                                        withLabel: true,
                                        decoration: InputDecoration(
                                          labelText:
                                              'Business phone number'.tr(),
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
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            /* TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Business phone number'.tr(),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number'.tr();
                                }
                                return null;
                              },
                            ),*/
                            const AnimatedGap(
                              16,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: 'Business address'.tr(),
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an address'.tr();
                                }
                                return null;
                              },
                            ),
                            const AnimatedGap(
                              16,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Gender'.tr(),
                                isDense: true,
                              ),
                              value: _selectedGender,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Male'.tr(),
                                  child: Text('Male'.tr()),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Female'.tr(),
                                  child: Text('Female'.tr()),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Other'.tr(),
                                  child: Text('Other'.tr()),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            const AnimatedGap(
                              32,
                              duration: Duration(
                                milliseconds: 300,
                              ),
                            ),
                            SizedBox(
                              width: context.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_createBusinessProfileFormKey
                                      .currentState!
                                      .validate()) {
                                    // Registration logic here
                                    final username = _usernameController.text;
                                    final email = _emailController.text;
                                    final phone = _phoneController.text;
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
