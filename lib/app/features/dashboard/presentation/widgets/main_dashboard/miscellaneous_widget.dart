part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class MiscellaneousTileInfo {
  const MiscellaneousTileInfo({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.message,
  });

  factory MiscellaneousTileInfo.fromMap(Map<String, dynamic> map) {
    return MiscellaneousTileInfo(
      icon: map['icon'] as Widget,
      title: map['title'] as String,
      subTitle: map['subTitle'] as String,
      value: map['value'] as int,
      message: map['message'] as String,
    );
  }

  final Widget icon;
  final String title;
  final String subTitle;
  final int value;
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MiscellaneousTileInfo &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          subTitle == other.subTitle &&
          value == other.value &&
          message == other.message);

  @override
  int get hashCode => icon.hashCode ^ title.hashCode ^ subTitle.hashCode ^ value.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'MiscellaneousTileInfo{ icon: $icon, title: $title, subTitle: $subTitle, value: $value, message: $message,}';
  }

  MiscellaneousTileInfo copyWith({
    Widget? icon,
    String? title,
    String? subTitle,
    int? value,
    String? message,
  }) {
    return MiscellaneousTileInfo(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      value: value ?? this.value,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': this.icon,
      'title': this.title,
      'subTitle': this.subTitle,
      'value': this.value,
      'message': this.message,
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
      MiscellaneousTileInfo(
        icon: Icon(
          Icons.account_balance,
          size: 28,
          color: context.primaryColor,
        ),
        title: 'Payments',
        subTitle: 'Add or Edit Bank',
        message: 'Bank Listed',
        value: 1,
      ),
      MiscellaneousTileInfo(
        icon: Icon(
          Icons.storefront,
          size: 28,
          color: context.primaryColor,
        ),
        title: 'Store',
        subTitle: 'Add or Edit Stores',
        message: 'Live Store',
        value: 3,
      ),
      MiscellaneousTileInfo(
        icon: Icon(
          Icons.restaurant_menu,
          size: 28,
          color: context.primaryColor,
        ),
        title: 'Food Menus',
        subTitle: 'Add or Edit Menus',
        message: 'Menus',
        value: 253,
      ),
      MiscellaneousTileInfo(
        icon: SizedBox.square(
          child: SvgPicture.asset(
            'assets/svg/online_driver.svg',
            semanticsLabel: 'Driver icon',
          ),
          dimension: 28,
        ),
        title: 'My Drivers',
        subTitle: 'Add or Edit Drivers',
        message: 'Drivers',
        value: 26,
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
    return SizedBox(
      height: context.height / 2.5,
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
    );
  }
}
