import 'dart:math';

import 'package:flutter/material.dart';
import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/indicators/base/indicator_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/shape/indicator_painter.dart';

/// BallClipRotate.
class BallClipRotate extends StatefulWidget {
  const BallClipRotate({Key? key}) : super(key: key);

  @override
  State<BallClipRotate> createState() => _BallClipRotateState();
}

class _BallClipRotateState extends State<BallClipRotate>
    with SingleTickerProviderStateMixin, IndicatorController {
  static const _durationInMills = 750;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  List<AnimationController> get animationControllers => [_animationController];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _durationInMills),
    );
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
    _rotateAnimation = Tween(begin: 0.0, end: 2 * pi).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value)
            ..rotateZ(_rotateAnimation.value),
          child: child,
        );
      },
      child: const IndicatorShapeWidget(shape: RingThirdFour()),
    );
  }
}
