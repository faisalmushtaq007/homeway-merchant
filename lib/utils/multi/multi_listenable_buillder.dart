library multi_listenable;

import 'package:flutter/widgets.dart';

typedef WidgetBuilder = Widget Function(BuildContext context, Widget? child);

/// A widget whose content stays synced with a list of Listenable.
///
/// ```
/// MultiListenableBuilder(
/// 	listenable: [ /* your listables to listen */],
/// 	builder : (context) => Container(),
/// )
/// ```

/// ## Parameters

/// # required Iterable<[Listenable]> listenable
/// An iterable of [Listenable] to listen. When one (or more) of the listenable notify,
/// the builder function is called.

/// # required [WidgetBuilder] builder
/// A function to call every time a [Listener] passed in [listenable] notify.

class MultiListenableBuilder extends StatefulWidget {
  const MultiListenableBuilder({
    super.key,
    required this.listenables,
    required this.builder,
    this.child,
  });

  final Iterable<Listenable> listenables;

  final WidgetBuilder builder;
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _MultiListenableBuilderState();
}

class _MultiListenableBuilderState<T> extends State<MultiListenableBuilder> {
  Iterable<Listenable> get listenables => widget.listenables;

  @override
  void initState() {
    super.initState();
    _relink(newList: listenables);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, widget.child);

  @override
  void didUpdateWidget(MultiListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldList = oldWidget.listenables.toSet();
    final newList = listenables.toSet();
    if (newList.length != oldList.length) {
      _relink(oldList: oldList, newList: newList);
    } else if (oldList.any((e) => !newList.contains(e))) {
      _relink(oldList: oldList, newList: newList);
    }
  }

  @override
  void dispose() {
    _relink(oldList: listenables);
    super.dispose();
  }

  void _notified() {
    setState(() {});
  }

  void _relink({
    Iterable<Listenable>? oldList,
    Iterable<Listenable>? newList,
  }) {
    if (oldList != null) {
      for (final l in oldList) {
        l.removeListener(_notified);
      }
    }
    if (newList != null) {
      for (final l in newList) {
        l.addListener(_notified);
      }
    }
  }
}
