part of 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuForm5Page extends StatefulWidget {
  const MenuForm5Page({super.key});

  @override
  State<MenuForm5Page> createState() => _MenuForm5PageState();
}

class _MenuForm5PageState extends State<MenuForm5Page> {
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
      color: Colors.pink,
      child: Text('Form5'),
    );
  }
}
