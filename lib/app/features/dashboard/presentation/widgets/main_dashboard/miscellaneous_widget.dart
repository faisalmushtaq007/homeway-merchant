part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class MiscellaneousTileInfo {
  const MiscellaneousTileInfo({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.child,
  });

  factory MiscellaneousTileInfo.fromMap(Map<String, dynamic> map) {
    return MiscellaneousTileInfo(
      icon: map['icon'] as Widget,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      child: map['children'] as Widget,
    );
  }

  final Widget icon;
  final String title;
  final String subTitle;
  final Widget child;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MiscellaneousTileInfo &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          subTitle == other.subTitle &&
          child == other.child);

  @override
  int get hashCode => icon.hashCode ^ title.hashCode ^ subTitle.hashCode ^ child.hashCode;

  @override
  String toString() {
    return 'MiscellaneousInfo{ icon: $icon, title: $title, subTitle: $subTitle, children: $child,}';
  }

  MiscellaneousTileInfo copyWith({
    Widget? icon,
    String? title,
    String? subTitle,
    Widget? child,
  }) {
    return MiscellaneousTileInfo(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      child: child ?? this.child,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': this.icon,
      'title': this.title,
      'subTitle': this.subTitle,
      'children': this.child,
    };
  }
}

class MiscellaneousWidget extends StatefulWidget {
  const MiscellaneousWidget({super.key});

  @override
  _MiscellaneousWidgetController createState() => _MiscellaneousWidgetController();
}

class _MiscellaneousWidgetController extends State<MiscellaneousWidget> {
  List<MiscellaneousTileInfo> listOfMiscellaneousTileInfo = <MiscellaneousTileInfo>[];

  @override
  void initState() {
    super.initState();
    listOfMiscellaneousTileInfo = <MiscellaneousTileInfo>[];
    listOfMiscellaneousTileInfo.clear();
  }

  @override
  void dispose() {
    listOfMiscellaneousTileInfo = <MiscellaneousTileInfo>[];
    listOfMiscellaneousTileInfo.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listOfMiscellaneousTileInfo = <MiscellaneousTileInfo>[
      const MiscellaneousTileInfo(
        icon: Icon(Icons.account_balance),
        title: 'Payments',
        subTitle: 'Add or Edit Bank Account',
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: EdgeInsetsDirectional.zero,
          horizontalTitleGap: 0,
          title: Text('Bank Of Saudi Arabia'),
          subtitle: Text('50XXXXXXXXXXX589'),
          trailing: CircleAvatar(
              radius: 12,
              backgroundColor: Color.fromRGBO(215, 243, 227, 1),
              child: Icon(
                Icons.check,
                size: 13,
                color: Color.fromRGBO(69, 201, 125, 1),
              )),
        ),
      ),
      MiscellaneousTileInfo(
        icon: Icon(Icons.storefront),
        title: 'Store',
        subTitle: 'Add or Edit Stores',
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '3',
              style: context.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(255, 90, 39, 1),
              ),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ).translate(),
            Text(
              'Live Store Listed',
              style: context.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                //color: Color.fromRGBO(255, 125, 113, 1),
              ),
              textDirection: serviceLocator<LanguageController>().targetTextDirection,
            ).translate(),
          ],
        ),
      ),
      MiscellaneousTileInfo(
        icon: Icon(Icons.restaurant_menu),
        title: 'Food Menus',
        subTitle: 'Add or Edit Food Menus',
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '253',
              style: context.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(255, 90, 39, 1),
              ),
            ).translate(),
            Text(
              'Food Menu Listed',
              style: context.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                //color: Color.fromRGBO(255, 125, 113, 1),
              ),
            ).translate(),
          ],
        ),
      ),
      MiscellaneousTileInfo(
        icon: SizedBox.square(
          child: SvgPicture.asset('assets/svg/online_driver.svg', semanticsLabel: 'Driver icon'),
          dimension: 24,
        ),
        title: 'My Drivers',
        subTitle: 'Add or Edit Drivers',
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '26',
              style: context.labelMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(255, 90, 39, 1),
              ),
            ),
            Text(
              'Drivers with you',
              style: context.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                //color: Color.fromRGBO(255, 125, 113, 1),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => _MiscellaneousWidgetView(this);
}

class _MiscellaneousWidgetView extends WidgetView<MiscellaneousWidget, _MiscellaneousWidgetController> {
  const _MiscellaneousWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: context.height / 2.55,
        child: GridView.custom(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: state.listOfMiscellaneousTileInfo.length,
            (context, index) {
              return MiscellaneousTile(
                index: index,
                miscellaneousTileInfo: state.listOfMiscellaneousTileInfo[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
