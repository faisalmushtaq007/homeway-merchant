import 'package:flutter/material.dart';
import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/indicators/base/indicator_controller.dart';
import 'package:homemakers_merchant/shared/widgets/universal/loading_indicators/src/shape/indicator_painter.dart';

/// AudioEqualizer
class AudioEqualizer extends StatefulWidget {
  const AudioEqualizer({Key? key}) : super(key: key);

  @override
  State<AudioEqualizer> createState() => _AudioEqualizerState();
}

class _AudioEqualizerState extends State<AudioEqualizer>
    with TickerProviderStateMixin, IndicatorController {
  static const _lineNum = 4;

  static const _durationInMills = [
    4300,
    2500,
    1700,
    3100,
  ];

  static const _values = [
    0.0,
    0.7,
    0.4,
    0.05,
    0.95,
    0.3,
    0.9,
    0.4,
    0.15,
    0.18,
    0.75,
    0.01,
  ];
  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _animations = [];

  @override
  List<AnimationController> get animationControllers => _animationControllers;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _lineNum; i++) {
      _animationControllers.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: _durationInMills[i])));
      final sequences = <TweenSequenceItem<double>>[];
      for (int j = 0; j < _values.length - 1; j++) {
        sequences.add(TweenSequenceItem(
            tween: Tween(begin: _values[j], end: _values[j + 1]), weight: 1));
      }
      _animations
          .add(TweenSequence(sequences).animate(_animationControllers[i]));
      _animationControllers[i].repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = List<Widget>.filled(7, Container());
    for (int i = 0; i < widgets.length; i++) {
      if (i.isEven) {
        widgets[i] = Expanded(
          child: AnimatedBuilder(
            animation: _animations[i ~/ 2],
            builder: (_, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..scale(1.0, _animations[i ~/ 2].value),
                alignment: Alignment.bottomCenter,
                child: child,
              );
            },
            child: IndicatorShapeWidget(
              shape: const Square(),
              index: i ~/ 2,
            ),
          ),
        );
      } else {
        widgets[i] = const Expanded(child: SizedBox());
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}
