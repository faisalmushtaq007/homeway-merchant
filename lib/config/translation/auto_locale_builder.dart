import 'package:flutter/widgets.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';

class AutoLocalBuilder extends StatefulWidget with GetItStatefulWidgetMixin {
  AutoLocalBuilder({
    super.key,
    required this.builder,
    this.text = const [],
    this.cache = true,
    LanguageController? translationWorker,
  })  : _extInit = translationWorker == null ? false : true,
        translationWorker =
            translationWorker ?? serviceLocator<LanguageController>();
  final Widget Function(LanguageController) builder;
  final List<String> text;
  final bool cache;
  final LanguageController translationWorker;
  final bool _extInit;

  @override
  _AutoLocalBuilderState createState() => _AutoLocalBuilderState();
}

class _AutoLocalBuilderState extends State<AutoLocalBuilder>
    with GetItStateMixin {
  final languageController = serviceLocator<LanguageController>();
  @override
  void initState() {
    super.initState();
    widget.translationWorker.set(widget.text);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (!widget._extInit) {
        widget.translationWorker.run(useCache: widget.cache);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.translationWorker,
      builder: (context, child) {
        return widget.builder(widget.translationWorker);
      },
    );
  }
}
