import 'package:flutter/material.dart';

import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/indicators/base/indicator_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/shape/indicator_painter.dart';

/// BallBeat.
class BallBeat extends StatefulWidget {
  const BallBeat({Key? key}) : super(key: key);

  @override
  State<BallBeat> createState() => _BallBeatState();
}

class _BallBeatState extends State<BallBeat>
    with TickerProviderStateMixin, IndicatorController {
  static const _durationInMills = 700;

  static const _delayInMills = [350, 0, 350];

  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];

  @override
  List<AnimationController> get animationControllers => _animationControllers;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; i++) {
      _animationControllers.add(AnimationController(
        value: _delayInMills[i] / _durationInMills,
        vsync: this,
        duration: const Duration(milliseconds: _durationInMills),
      ));
      _scaleAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.75), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.75, end: 1.0), weight: 1),
      ]).animate(CurvedAnimation(
          parent: _animationControllers[i], curve: Curves.linear)));
      _opacityAnimations.add(TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.2), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.2, end: 1.0), weight: 1),
      ]).animate(CurvedAnimation(
          parent: _animationControllers[i], curve: Curves.linear)));

      _animationControllers[i].repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      List<Widget> widgets = List.filled(5, Container());
      for (int i = 0; i < 5; i++) {
        if (i.isEven) {
          widgets[i] = Expanded(
            child: FadeTransition(
              opacity: _opacityAnimations[i ~/ 2],
              child: ScaleTransition(
                scale: _scaleAnimations[i ~/ 2],
                child: IndicatorShapeWidget(
                  shape: const Circle(),
                  index: i ~/ 2,
                ),
              ),
            ),
          );
        } else {
          widgets[i] = const SizedBox(width: 2);
        }
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets,
      );
    });
  }
}
