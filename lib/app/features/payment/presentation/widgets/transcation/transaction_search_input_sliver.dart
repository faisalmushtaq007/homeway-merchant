part of 'package:homemakers_merchant/app/features/payment/index.dart';

class TranscationSearchInputSliver extends StatefulWidget {
  const TranscationSearchInputSliver({
    super.key,
    this.onChanged,
    this.debounceTime,
    this.isEnabled = true,
  });
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;
  final bool isEnabled;

  @override
  _TranscationSearchInputSliverState createState() =>
      _TranscationSearchInputSliverState();
}

class _TranscationSearchInputSliverState
    extends State<TranscationSearchInputSliver> {
  final StreamController<String> _textChangeStreamController =
      StreamController();
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
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: AnimatedCrossFade(
          crossFadeState: (widget.isEnabled)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
          firstChild: Container(
            height: 60,
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
                    onChanged: _textChangeStreamController.add,
                  ),
                ),
              ],
            ),
          ),
          secondChild: nil,
        ),
      );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}
