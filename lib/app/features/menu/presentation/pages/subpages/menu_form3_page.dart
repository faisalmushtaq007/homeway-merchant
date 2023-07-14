part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm3Page extends StatefulWidget {
  const MenuForm3Page({super.key});

  @override
  State<MenuForm3Page> createState() => _MenuForm3PageState();
}

class _MenuForm3PageState extends State<MenuForm3Page> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Text('Form3'),
    );
  }
}
