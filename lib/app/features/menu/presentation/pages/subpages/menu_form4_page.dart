part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm4Page extends StatefulWidget {
  const MenuForm4Page({super.key});

  @override
  State<MenuForm4Page> createState() => _MenuForm4PageState();
}

class _MenuForm4PageState extends State<MenuForm4Page> {
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
      color: Colors.blue,
      child: Text('Form4'),
    );
  }
}
