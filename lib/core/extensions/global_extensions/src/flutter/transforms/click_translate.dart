import 'package:flutter/material.dart';

class TranslateOnClick extends StatefulWidget {
  final Widget child;

  const TranslateOnClick({Key? key, required this.child}) : super(key: key);

  @override
  _TranslateOnClickState createState() => _TranslateOnClickState();
}

class _TranslateOnClickState extends State<TranslateOnClick> {
  final nonClickTransform = Matrix4.identity();
  final clickTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _clicking = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) => _userClick(true),
      onTapUp: (d) => _userClick(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: widget.child,
        transform: _clicking ? clickTransform : nonClickTransform,
      ),
    );
  }

  void _userClick(bool click) {
    setState(() {
      _clicking = click;
    });
  }
}
