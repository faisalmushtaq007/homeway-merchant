part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BankInformationPage extends StatefulWidget {
  const BankInformationPage({
    super.key,
    this.paymentBankEntity,
    this.hasEditBankInformation = false,
    this.currentIndex = -1,
  });

  final bool hasEditBankInformation;
  final PaymentBankEntity? paymentBankEntity;
  final int currentIndex;

  @override
  State<BankInformationPage> createState() => _BankInformationPageState();
}

class _BankInformationPageState extends State<BankInformationPage>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController;
  late final ScrollController innerScrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _bankInformationFormKey = GlobalKey<FormState>();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _confirmAccountNumberController =
      TextEditingController();
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
    wildcards: {
      '#': RegExp('[0-9]'),
      '@': RegExp('[s|S]'),
      '%': RegExp('[a|A]')
    },
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
    innerScrollController = ScrollController();
    _bankNameControllerFocusNode = FocusNode();
    _accountHolderNameControllerFocusNode = FocusNode();
    _accountNumberControllerFocusNode = FocusNode();
    _confirmAccountNumberControllerFocusNode = FocusNode();
    _ibanNumberControllerFocusNode = FocusNode();
    listOfBankInfoTiles = [];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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
    innerScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double margins = GlobalApp.responsiveInsets(media.size.width);
    final double topPadding =
        margins; //media.padding.top + kToolbarHeight + margins; //margins * 1.5;
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
      child: Directionality(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        child: DoubleTapToExit(
          key: const Key('bank-information-doubleTap'),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: const Text('Payment'),
              actions: const [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 14),
                  child: LanguageSelectionWidget(),
                ),
              ],
            ),
            body: Directionality(
              textDirection:
                  serviceLocator<LanguageController>().targetTextDirection,
              child: PageBody(
                controller: scrollController,
                constraints: BoxConstraints(
                  minWidth: 1000,
                  minHeight: media.size.height,
                ),
                child: SlideInLeft(
                  key: const Key('bank-information-page-slideinleft'),
                  child: Form(
                    key: _bankInformationFormKey,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: topPadding,
                        start: margins * 2.5,
                        end: margins * 2.5,
                        //bottom: bottomPadding,
                      ),
                      child: BlocConsumer<PaymentBankBloc, PaymentBankState>(
                        listenWhen: (previous, current) => previous != current,
                        key: const Key('payment-page-consumer-widget'),
                        bloc: context.read<PaymentBankBloc>(),
                        buildWhen: (previous, current) => previous != current,
                        listener: (context, state) {
                          if (state is NavigateToNextPageState) {
                            return context
                                .pushReplacement(Routes.NEW_DOCUMENT_LIST_PAGE);
                          }
                        },
                        builder: (context, state) {
                          return CustomScrollView(
                            controller: innerScrollController,
                            slivers: [
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    Wrap(
                                      children: [
                                        Text(
                                          'Bank Account Information',
                                          style: context.titleLarge,
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      6,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          'To get monthly merchant payouts from HomeWay for your sales, add a bank account to your payments profile. Provide the exact info as it is on file with your bank.',
                                          style: context.labelSmall!.copyWith(
                                              fontStyle: FontStyle.italic),
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          softWrap: true,
                                        ).translate(),
                                      ],
                                    ),
                                    const AnimatedGap(
                                      16,
                                      duration: Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      textDirection:
                                          serviceLocator<LanguageController>()
                                              .targetTextDirection,
                                      children: [
                                        Wrap(
                                          children: [
                                            Text(
                                              'Bank account requirements',
                                              style:
                                                  context.titleMedium!.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ).translate(),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          6,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              'Your bank account must be:',
                                              style:
                                                  context.labelLarge!.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ).translate(),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          6,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              '1. Able to receive Electronic Funds Transfer (EFT) ',
                                              style:
                                                  context.labelMedium!.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                            ).translate(),
                                          ],
                                        ),
                                        const AnimatedGap(
                                          3,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              '2. In the same country or region where the merchant account is registered',
                                              style:
                                                  context.labelMedium!.copyWith(
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              softWrap: true,
                                            ).translate(),
                                          ],
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
                                        'bank-holder-name-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance
                                              .translate('Account Holder Name'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            'Please enter a account holder name',
                                          ),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            _accountHolderNameController
                                                .value.text
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: [
                                        'Account Holder Name',
                                        'Please enter a account holder name',
                                        _accountHolderNameController.value.text
                                            .trim(),
                                      ],
                                      builder: (context, snapshot) {
                                        if (listOfBankInfoTiles.isNotEmpty &&
                                            listOfBankInfoTiles
                                                    .elementAtOrNull(0) !=
                                                null) {
                                          listOfBankInfoTiles.removeAt(0);
                                          listOfBankInfoTiles.insert(
                                            0,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        } else {
                                          listOfBankInfoTiles.insert(
                                            0,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        }

                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller:
                                                _accountHolderNameController,
                                            focusNode:
                                                _accountHolderNameControllerFocusNode,
                                            textInputAction:
                                                TextInputAction.next,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-z A-Z ]')),
                                              FilteringTextInputFormatter.deny(
                                                  '  ')
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) => _fieldFocusChange(
                                                context,
                                                _accountHolderNameControllerFocusNode,
                                                _ibanNumberControllerFocusNode),
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
                                        'bank-name-textFormField-key',
                                      ),
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance
                                              .translate('Bank Name'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                              'Please enter a bank name'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            _bankNameController.value.text
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: [
                                        'Bank Name',
                                        'Please enter a bank name',
                                        _bankNameController.value.text.trim(),
                                      ],
                                      builder: (context, snapshot) {
                                        final String translateString =
                                            snapshot[2] as String;
                                        if (listOfBankInfoTiles.isNotEmpty &&
                                            listOfBankInfoTiles
                                                    .elementAtOrNull(1) !=
                                                null) {
                                          listOfBankInfoTiles.removeAt(1);
                                          listOfBankInfoTiles.insert(
                                            1,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        } else {
                                          listOfBankInfoTiles.insert(
                                            1,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        }

                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _bankNameController,
                                            focusNode:
                                                _bankNameControllerFocusNode,
                                            textInputAction:
                                                TextInputAction.next,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-z A-Z ]')),
                                              FilteringTextInputFormatter.deny(
                                                  '  ')
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) =>
                                                _fieldFocusChange(
                                                    context,
                                                    _bankNameControllerFocusNode,
                                                    _accountNumberControllerFocusNode),
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
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance
                                              .translate('Account Number'),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            'Please enter a account number',
                                          ),
                                        ),
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                            _accountNumberController.value.text
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: [
                                        'Account Number',
                                        'Please enter a account number',
                                        _accountNumberController.value.text
                                            .trim(),
                                      ],
                                      builder: (context, snapshot) {
                                        if (listOfBankInfoTiles.isNotEmpty &&
                                            listOfBankInfoTiles
                                                    .elementAtOrNull(2) !=
                                                null) {
                                          listOfBankInfoTiles.removeAt(2);
                                          listOfBankInfoTiles.insert(
                                            2,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        } else {
                                          listOfBankInfoTiles.insert(
                                            2,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        }

                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller:
                                                _accountNumberController,
                                            focusNode:
                                                _accountNumberControllerFocusNode,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) => _fieldFocusChange(
                                                context,
                                                _accountNumberControllerFocusNode,
                                                _confirmAccountNumberControllerFocusNode),
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
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance.translate(
                                              'Confirm Account Number'),
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
                                            _confirmAccountNumberController
                                                .value.text
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                      initialStreamValue: [
                                        'Confirm Account Number',
                                        'Please enter an confirm account number',
                                        'Please enter a valid account number',
                                        _confirmAccountNumberController
                                            .value.text
                                            .trim(),
                                      ],
                                      builder: (context, snapshot) {
                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller:
                                                _confirmAccountNumberController,
                                            focusNode:
                                                _confirmAccountNumberControllerFocusNode,
                                            textInputAction:
                                                TextInputAction.next,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              isDense: true,
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return '${snapshot[1]}';
                                              } else if (!_accountNumberController
                                                  .value.text
                                                  .contains(value)) {
                                                return '${snapshot[2]}';
                                              } else {
                                                return null;
                                              }
                                            },
                                            onFieldSubmitted: (_) => _fieldFocusChange(
                                                context,
                                                _confirmAccountNumberControllerFocusNode,
                                                _accountHolderNameControllerFocusNode),
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
                                      buildWhen: (previousDataList,
                                              latestDataList) =>
                                          previousDataList != latestDataList,
                                      streams: [
                                        Stream.fromFuture(
                                          AppTranslator.instance
                                              .translate('IBAN Number'),
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
                                        if (listOfBankInfoTiles.isNotEmpty &&
                                            listOfBankInfoTiles
                                                    .elementAtOrNull(3) !=
                                                null) {
                                          listOfBankInfoTiles.removeAt(3);
                                          listOfBankInfoTiles.insert(
                                            3,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        } else {
                                          listOfBankInfoTiles.insert(
                                            3,
                                            BankInfoTile(
                                                label: snapshot[0] as String,
                                                content: snapshot[2] as String),
                                          );
                                        }

                                        return Directionality(
                                          textDirection: serviceLocator<
                                                  LanguageController>()
                                              .targetTextDirection,
                                          child: AppTextFieldWidget(
                                            controller: _ibanNumberController,
                                            focusNode:
                                                _ibanNumberControllerFocusNode,
                                            textInputAction:
                                                TextInputAction.done,
                                            textDirection: serviceLocator<
                                                    LanguageController>()
                                                .targetTextDirection,
                                            decoration: InputDecoration(
                                              labelText: snapshot[0],
                                              hintText:
                                                  'SA## #### #### #### #### ####',
                                              hintTextDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                              isDense: true,
                                            ),
                                            //keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              // SA03 8000 0000 6080 1016 7519
                                              ibanMuskeyFormatter,
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  ibanMuskeyFormatter
                                                      .info.clean.isEmpty) {
                                                return '${snapshot[1]}';
                                              } else if (!ibanMuskeyFormatter
                                                  .info.isValid) {
                                                return '${snapshot[1]}';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (_) =>
                                                FocusScope.of(context)
                                                    .unfocus(),
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
                                  ],
                                ),
                              ),
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(
                                  textDirection:
                                      serviceLocator<LanguageController>()
                                          .targetTextDirection,
                                  children: [
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_bankInformationFormKey
                                                      .currentState!
                                                      .validate() &&
                                                  ibanMuskeyFormatter
                                                      .info.isValid) {
                                                // Registration logic here
                                                final accountHolderName =
                                                    _accountHolderNameController
                                                        .value.text;
                                                final bankName =
                                                    _bankNameController
                                                        .value.text;
                                                final confirmAccountNumber =
                                                    _confirmAccountNumberController
                                                        .value.text;
                                                final ibanNumber =
                                                    ibanMuskeyFormatter.info
                                                        .clean; //_ibanNumberController.value.text;
                                                final address =
                                                    _accountHolderNameController
                                                        .value.text;
                                                _bankInformationFormKey
                                                    .currentState!
                                                    .save();
                                                // Show confirmation dialog
                                                List<BankInformationTileWidget>
                                                    listOfBankTileWidgets = [];
                                                listOfBankTileWidgets.clear();
                                                listOfBankInfoTiles
                                                    .asMap()
                                                    .forEach((
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
                                                final result =
                                                    await showConfirmationDialog<
                                                        bool>(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  curve: Curves.fastOutSlowIn,
                                                  duration: const Duration(
                                                      milliseconds: 700),
                                                  builder:
                                                      (BuildContext context) {
                                                    return ResponsiveDialog(
                                                      context: context,
                                                      hideButtons: false,
                                                      maxLongSide:
                                                          context.width / 1.20,
                                                      maxShortSide:
                                                          context.width,
                                                      title:
                                                          'Confirm Bank Details',
                                                      confirmText: 'Confirm',
                                                      cancelText: 'Cancel',
                                                      okPressed: () async {
                                                        debugPrint(
                                                            'Dialog confirmed');
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                      cancelPressed: () {
                                                        debugPrint(
                                                            'Dialog cancelled');
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: ListView.builder(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .symmetric(
                                                                horizontal: 8),
                                                        itemCount:
                                                            listOfBankTileWidgets
                                                                .length,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            listOfBankTileWidgets[
                                                                index],
                                                        shrinkWrap: true,
                                                      ),
                                                    );
                                                  },
                                                );
                                                if (result != null && result) {
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {});
                                                  if (!mounted) {
                                                    return;
                                                  }
                                                  PaymentBankEntity
                                                      paymentBankEntity;
                                                  if (widget
                                                          .hasEditBankInformation &&
                                                      widget.paymentBankEntity !=
                                                          null) {
                                                    widget.paymentBankEntity
                                                        ?.copyWith(
                                                      ibanNumber: ibanNumber,
                                                      bankHolderName:
                                                          accountHolderName,
                                                      accountNumber:
                                                          confirmAccountNumber,
                                                      bankName: bankName,
                                                      acceptPaymentMode:
                                                          AcceptPaymentMode
                                                              .cash,
                                                    );
                                                  }
                                                  paymentBankEntity =
                                                      PaymentBankEntity(
                                                    accountNumber:
                                                        confirmAccountNumber,
                                                    bankHolderName:
                                                        accountHolderName,
                                                    bankName: bankName,
                                                    ibanNumber: ibanNumber,
                                                    acceptPaymentMode:
                                                        AcceptPaymentMode.cash,
                                                  );
                                                  serviceLocator<
                                                              AppUserEntity>()
                                                          .currentProfileStatus =
                                                      CurrentProfileStatus
                                                          .paymentDetailSaved;
                                                  if (!mounted) {
                                                    return;
                                                  }
                                                  context
                                                      .read<PaymentBankBloc>()
                                                      .add(
                                                        SavePaymentBank(
                                                          paymentBankEntity:
                                                              paymentBankEntity,
                                                          currentIndex: widget
                                                              .currentIndex,
                                                          hasEditPaymentBank: widget
                                                              .hasEditBankInformation,
                                                        ),
                                                      );
                                                  return;
                                                }
                                              }
                                              return;
                                            },
                                            child: Text(
                                              'Save Payment Details',
                                              textDirection: serviceLocator<
                                                      LanguageController>()
                                                  .targetTextDirection,
                                            ).translate(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
