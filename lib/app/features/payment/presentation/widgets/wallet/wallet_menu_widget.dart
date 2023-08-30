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
      WalletMenuInfo(
        color: Colors.blue,
        title: 'Withdrawal',
        icon: FontAwesomeIcons.paperPlane,
      ),
      WalletMenuInfo(
        color: Colors.red,
        title: 'Activities',
        icon: FontAwesomeIcons.chartSimple,
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
      children: state.walletMenus
          .map(
            (e) => _menuItem(
              color: e.color,
              title: e.title,
              icon: e.icon,
            ),
          )
          .toList(),
    );
  }

  Widget _menuItem({
    Color color = Colors.red,
    String title = '',
    IconData icon = FontAwesomeIcons.wallet,
  }) {
    return Expanded(
      key: ValueKey(title),
      child: Column(
        textDirection: serviceLocator<LanguageController>().targetTextDirection,
        children: [
          Card(
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
  });

  Color color;
  String title;
  IconData icon;

  WalletMenuInfo copyWith({
    Color? color,
    String? title,
    IconData? icon,
  }) {
    return WalletMenuInfo(
      color: color ?? this.color,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }
}
