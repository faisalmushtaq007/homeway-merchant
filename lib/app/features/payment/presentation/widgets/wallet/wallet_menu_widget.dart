part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WalletMenuWidget extends StatefulWidget {
  const WalletMenuWidget({super.key});

  @override
  _WalletMenuWidgetController createState() => _WalletMenuWidgetController();
}

class _WalletMenuWidgetController extends State<WalletMenuWidget> {
  final ScrollController scrollController = ScrollController();
  List<WalletMenuInfo> walletMenus = [];

  @override
  void initState() {
    super.initState();
    walletMenus = [
      /*WalletMenuInfo(
        color: Colors.blue,
        title: 'Withdrawal',
        icon: FontAwesomeIcons.paperPlane,
        onPressed: () async {
          final getResult = await context.push(
            Routes.WITHDRAWAL_PAGE,
          );
        },
      ),*/
      WalletMenuInfo(
        color: Colors.red,
        title: 'Activities',
        icon: FontAwesomeIcons.chartSimple,
        onPressed: () async {
          final getResult = await context.push(
            Routes.ALL_TRANSCATIONS_PAGE,
          );
        },
      ),
      WalletMenuInfo(
        color: Colors.cyan,
        title: 'Statics',
        icon: FontAwesomeIcons.chartPie,
      ),
      WalletMenuInfo(
        color: Colors.purple,
        title: 'Payment',
        icon: FontAwesomeIcons.wallet,
      ),
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _WalletMenuWidgetView(this);
}

class _WalletMenuWidgetView extends WidgetView<WalletMenuWidget, _WalletMenuWidgetController> {
  const _WalletMenuWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return ScrollableRow(
      controller: state.scrollController,
      padding: EdgeInsetsDirectional.zero,
      mainAxisSize: MainAxisSize.min,
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      physics: const BouncingScrollPhysics(),
      constraintsBuilder: (constraints) => BoxConstraints(
        minWidth: constraints.maxWidth,
      ),
      flexible: false,
      children: List.generate(
        state.walletMenus.length,
        (index) => _menuItem(
          color: state.walletMenus[index].color,
          title: state.walletMenus[index].title,
          icon: state.walletMenus[index].icon,
          onPressed: state.walletMenus[index].onPressed,
        ),
      ),
    );
  }

  Widget _menuItem({
    Color color = Colors.red,
    String title = '',
    IconData icon = FontAwesomeIcons.wallet,
    VoidCallback? onPressed,
  }) {
    return Expanded(
      key: ValueKey(title),
      child: Column(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          InkWell(
            onTap: onPressed,
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              margin: EdgeInsetsDirectional.zero,
              child: WaveContainer(
                color: color.withOpacity(0.3),
                padding: EdgeInsetsDirectional.all(16),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
            ),
          ),
          const AnimatedGap(6, duration: Duration(milliseconds: 200)),
          Wrap(
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              Text(
                title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WalletMenuInfo {
  WalletMenuInfo({
    required this.color,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  Color color;
  String title;
  IconData icon;
  VoidCallback? onPressed;

  WalletMenuInfo copyWith({
    Color? color,
    String? title,
    IconData? icon,
    VoidCallback? onPressed,
  }) {
    return WalletMenuInfo(
      color: color ?? this.color,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onPressed: onPressed ?? this.onPressed,
    );
  }
}
