import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/manager/phone_number_verification_bloc.dart';
import 'package:homemakers_merchant/app/features/authentication/presentation/pages/phone_number_verification_page.dart';
import 'package:homemakers_merchant/app/features/profile/domain/entities/bank/bank_info_tile_model.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/bank/bank_information_tile_widget.dart';
import 'package:homemakers_merchant/app/features/profile/presentation/widgets/bank/confirm_bank_information_dialog.dart';
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
import 'package:homemakers_merchant/utils/input_formatters/muskey.dart';

class BankInformationPage extends StatefulWidget {
  const BankInformationPage({super.key});

  @override
  State<BankInformationPage> createState() => _BankInformationPageState();
}

class _BankInformationPageState extends State<BankInformationPage> with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;

  late AnimationController _animationController;
  late Animation<double> _animation;

  final _bankInformationFormKey = GlobalKey<FormState>();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _confirmAccountNumberController = TextEditingController();
  TextEditingController _accountHolderNameController = TextEditingController();
  TextEditingController _ibanNumberController = TextEditingController();
  List<BankInfoTile> listOfBankInfoTiles = [];
  late FocusNode _bankNameControllerFocusNode;
  late FocusNode _accountHolderNameControllerFocusNode;
  late FocusNode _accountNumberControllerFocusNode;
  late FocusNode _confirmAccountNumberControllerFocusNode;
  late FocusNode _ibanNumberControllerFocusNode;
  // SA03 8000 0000 6080 1016 7519
  final ibanMuskeyFormatter = MuskeyFormatter(
    masks: ['@%## #### #### #### #### ####'],
    wildcards: {'#': RegExp('[0-9]'), '@': RegExp('[s|S]'), '%': RegExp('[a|A]')},
    charTransforms: {
      '@': (s) => s.toUpperCase(),
      '%': (s) => s.toUpperCase(),
    },
    allowAutofill: true,
    overflow: OverflowBehavior.forbidden(),
  );

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _bankNameControllerFocusNode = FocusNode();
    _accountHolderNameControllerFocusNode = FocusNode();
    _accountNumberControllerFocusNode = FocusNode();
    _confirmAccountNumberControllerFocusNode = FocusNode();
    _ibanNumberControllerFocusNode = FocusNode();
    listOfBankInfoTiles = [];
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
    _bankNameControllerFocusNode.dispose();
    _accountHolderNameControllerFocusNode.dispose();
    _accountNumberControllerFocusNode.dispose();
    _confirmAccountNumberControllerFocusNode.dispose();
    _ibanNumberControllerFocusNode.dispose();
    _animationController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _confirmAccountNumberController.dispose();
    _accountHolderNameController.dispose();
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
                    key: _bankInformationFormKey,
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
                                'Add Payment Details',
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
                                  'bank-name-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Bank Name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Please enter a bank name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _bankNameController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'Bank Name',
                                  'Please enter a bank name',
                                  _bankNameController.value.text.trim(),
                                ],
                                builder: (context, snapshot) {
                                  final String translateString = snapshot[2] as String;
                                  if (listOfBankInfoTiles.isNotEmpty && listOfBankInfoTiles.elementAtOrNull(0) != null) {
                                    listOfBankInfoTiles.removeAt(0);
                                    listOfBankInfoTiles.insert(
                                      0,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  } else {
                                    listOfBankInfoTiles.insert(
                                      0,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  }

                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _bankNameController,
                                      focusNode: _bankNameControllerFocusNode,
                                      textInputAction: TextInputAction.next,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '${snapshot[1]}';
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (_) => _fieldFocusChange(context, _bankNameControllerFocusNode, _accountNumberControllerFocusNode),
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
                                  'account-number-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Account Number'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a account number',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _accountNumberController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'Account Number',
                                  'Please enter a account number',
                                  _accountNumberController.value.text.trim(),
                                ],
                                builder: (context, snapshot) {
                                  if (listOfBankInfoTiles.isNotEmpty && listOfBankInfoTiles.elementAtOrNull(1) != null) {
                                    listOfBankInfoTiles.removeAt(1);
                                    listOfBankInfoTiles.insert(
                                      1,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  } else {
                                    listOfBankInfoTiles.insert(
                                      1,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  }

                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _accountNumberController,
                                      focusNode: _accountNumberControllerFocusNode,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '${snapshot[1]}';
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (_) =>
                                          _fieldFocusChange(context, _accountNumberControllerFocusNode, _confirmAccountNumberControllerFocusNode),
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
                                  'confirm-account-number-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Confirm Account Number'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter an confirm account number',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a valid account number',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _confirmAccountNumberController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'Confirm Account Number',
                                  'Please enter an confirm account number',
                                  'Please enter a valid account number',
                                  _confirmAccountNumberController.value.text.trim(),
                                ],
                                builder: (context, snapshot) {
                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _confirmAccountNumberController,
                                      focusNode: _confirmAccountNumberControllerFocusNode,
                                      textInputAction: TextInputAction.next,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '${snapshot[1]}';
                                        } else if (!_accountNumberController.value.text.contains(value)) {
                                          return '${snapshot[2]}';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onFieldSubmitted: (_) =>
                                          _fieldFocusChange(context, _confirmAccountNumberControllerFocusNode, _accountHolderNameControllerFocusNode),
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
                                  'bank-holder-name-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('Account Holder Name'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a account holder name',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      _accountHolderNameController.value.text.trim(),
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'Account Holder Name',
                                  'Please enter a account holder name',
                                  _accountHolderNameController.value.text.trim(),
                                ],
                                builder: (context, snapshot) {
                                  if (listOfBankInfoTiles.isNotEmpty && listOfBankInfoTiles.elementAtOrNull(2) != null) {
                                    listOfBankInfoTiles.removeAt(2);
                                    listOfBankInfoTiles.insert(
                                      2,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  } else {
                                    listOfBankInfoTiles.insert(
                                      2,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  }

                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _accountHolderNameController,
                                      focusNode: _accountHolderNameControllerFocusNode,
                                      textInputAction: TextInputAction.next,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        isDense: true,
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '${snapshot[1]}';
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (_) =>
                                          _fieldFocusChange(context, _accountHolderNameControllerFocusNode, _ibanNumberControllerFocusNode),
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
                                  'bank-iban-number-textFormField-key',
                                ),
                                buildWhen: (previousDataList, latestDataList) => previousDataList != latestDataList,
                                streams: [
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate('IBAN Number'),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      'Please enter a iban number',
                                    ),
                                  ),
                                  Stream.fromFuture(
                                    AppTranslator.instance.translate(
                                      //_ibanNumberController.value.text.trim(),
                                      ibanMuskeyFormatter.info.clean,
                                    ),
                                  ),
                                ],
                                initialStreamValue: [
                                  'IBAN Number',
                                  'Please enter a iban number',
                                  ibanMuskeyFormatter.info.clean,
                                  //_ibanNumberController.value.text.trim(),
                                ],
                                builder: (context, snapshot) {
                                  if (listOfBankInfoTiles.isNotEmpty && listOfBankInfoTiles.elementAtOrNull(3) != null) {
                                    listOfBankInfoTiles.removeAt(3);
                                    listOfBankInfoTiles.insert(
                                      3,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  } else {
                                    listOfBankInfoTiles.insert(
                                      3,
                                      BankInfoTile(label: snapshot[0] as String, content: snapshot[2] as String),
                                    );
                                  }

                                  return Directionality(
                                    textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                    child: TextFormField(
                                      controller: _ibanNumberController,
                                      focusNode: _ibanNumberControllerFocusNode,
                                      textInputAction: TextInputAction.done,
                                      textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                      decoration: InputDecoration(
                                        labelText: snapshot[0],
                                        hintText: 'SA## #### #### #### #### ####',
                                        hintTextDirection: serviceLocator<LanguageController>().targetTextDirection,
                                        isDense: true,
                                      ),
                                      //keyboardType: TextInputType.text,
                                      inputFormatters: [
                                        //FilteringTextInputFormatter.digitsOnly,
                                        // SA03 8000 0000 6080 1016 7519
                                        ibanMuskeyFormatter,
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty || ibanMuskeyFormatter.info.clean.isEmpty) {
                                          return '${snapshot[1]}';
                                        } else if (!ibanMuskeyFormatter.info.isValid) {
                                          return '${snapshot[1]}';
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SizedBox(
                              width: context.width - margins * 5,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_bankInformationFormKey.currentState!.validate() && ibanMuskeyFormatter.info.isValid) {
                                    // Registration logic here
                                    final accountHolderName = _accountHolderNameController.value.text;
                                    final bankName = _bankNameController.value.text;
                                    final confirmAccountNumber = _confirmAccountNumberController.value.text;
                                    final ibanNumber = ibanMuskeyFormatter.info.clean; //_ibanNumberController.value.text;
                                    final address = _accountHolderNameController.value.text;
                                    _bankInformationFormKey.currentState!.save();

                                    // Print the entered information
                                    print('Account holder name: $accountHolderName');
                                    print('Bank name: $bankName');
                                    print('Email: $confirmAccountNumber');
                                    print('Phone: $ibanNumber');

                                    // Show confirmation dialog
                                    List<BankInformationTileWidget> listOfBankTileWidgets = [];
                                    listOfBankTileWidgets.clear();
                                    listOfBankInfoTiles.asMap().forEach((
                                      key,
                                      value,
                                    ) {
                                      listOfBankTileWidgets.insert(
                                        key,
                                        BankInformationTileWidget(
                                          key: ObjectKey(value),
                                          bankInfoTile: value,
                                        ),
                                      );
                                    });
                                    final result = await showConfirmationDialog<bool>(
                                      context: context,
                                      barrierDismissible: true,
                                      curve: Curves.fastOutSlowIn,
                                      duration: const Duration(milliseconds: 700),
                                      builder: (BuildContext context) {
                                        return ResponsiveDialog(
                                          context: context,
                                          hideButtons: false,
                                          maxLongSide: context.height / 2.25,
                                          maxShortSide: context.width,
                                          title: 'Confirm Payment',
                                          confirmText: 'Confirm',
                                          cancelText: 'Cancel',
                                          okPressed: () async {
                                            debugPrint('Dialog confirmed');
                                            Navigator.of(context).pop(true);
                                          },
                                          cancelPressed: () {
                                            debugPrint('Dialog cancelled');
                                            Navigator.of(context).pop(false);
                                          },
                                          child: ListView.builder(
                                            padding: EdgeInsetsDirectional.zero,
                                            itemCount: listOfBankTileWidgets.length,
                                            itemBuilder: (context, index) => listOfBankTileWidgets[index],
                                            shrinkWrap: true,
                                          ),
                                        );
                                      },
                                    );
                                    if (result != null && result) {
                                      await Future.delayed(const Duration(milliseconds: 500), () {});
                                      if (!mounted) {
                                        return;
                                      }
                                      context.go(Routes.DOCUMENT_LIST_PAGE);
                                    }
                                  }
                                },
                                child: Text(
                                  'Save Payment Details',
                                  textDirection: serviceLocator<LanguageController>().targetTextDirection,
                                ).translate(),
                              ),
                            ),
                          )
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

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
