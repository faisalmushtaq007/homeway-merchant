import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';

class MenuCardWidget extends StatefulWidget {
  const MenuCardWidget({super.key, required this.menuEntity, required this.currentIndex, required this.listOfAllMenuEntity});

  final MenuEntity menuEntity;
  final int currentIndex;
  final List<MenuEntity> listOfAllMenuEntity;

  @override
  _MenuCardWidgetState createState() => _MenuCardWidgetState();
}

class _MenuCardWidgetState extends State<MenuCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${widget.menuEntity.menuName}'),
      ),
    );
  }
}
