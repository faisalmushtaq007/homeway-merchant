part of 'package:homemakers_merchant/app/features/common/index.dart';
class AppSearchInputSliverWidget extends StatefulWidget {
  const AppSearchInputSliverWidget({super.key,this.onChanged,
  this.debounceTime,
  this.isEnabled = true,});
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;
  final bool isEnabled;
  @override
  _AppSearchInputSliverWidgetController createState() => _AppSearchInputSliverWidgetController();
}
class _AppSearchInputSliverWidgetController extends State<AppSearchInputSliverWidget> {
  final StreamController<String> _textChangeStreamController = StreamController();
  late StreamSubscription _textChangesSubscription;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
      widget.debounceTime ??
          const Duration(
            seconds: 1,
          ),
    )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AppSearchInputSliverWidgetView(this);
}
class _AppSearchInputSliverWidgetView extends WidgetView<AppSearchInputSliverWidget, _AppSearchInputSliverWidgetController> {
  const _AppSearchInputSliverWidgetView(super.state);
@override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: (widget.isEnabled) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
      firstChild: Container(
        height: 56,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 0,
          vertical: 4,
        ),
        margin: const EdgeInsetsDirectional.only(
          bottom: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  labelText: 'Search',
                ),
                onChanged: state._textChangeStreamController.add,
              ),
            ),
          ],
        ),
      ),
      secondChild: nil,
    );
  }
}