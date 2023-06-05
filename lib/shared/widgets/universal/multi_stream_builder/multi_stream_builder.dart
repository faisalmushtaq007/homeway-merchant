import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/streams.dart';

/// MultiStreamBuilder widget allowing to combine both multiple stream and value listenables
class MultiStreamBuilder extends StatefulWidget {
  const MultiStreamBuilder({
    super.key,
    this.controller,
    this.streams,
    this.valuesListenable,
    required this.builder,
    this.buildWhen,
    this.eventFilter,
  });
  static bool buildWhenAnyIsNotEqual(List previousDataList, List dataList) =>
      const DeepCollectionEquality().equals(previousDataList, dataList) ==
      false;

  static bool filterNullEvents(dynamic event, int index) => event != null;

  final MultiStreamBuilderController? controller;
  final List<Stream?>? streams;
  final List<ValueListenable?>? valuesListenable;
  final Widget Function(BuildContext context, List dataList) builder;
  final bool Function(List previousDataList, List latestDataList)? buildWhen;
  final bool Function(dynamic event, int index)? eventFilter;

  @override
  State createState() => _MultiStreamBuilderState();
}

/// MultiStreamBuilder controller
class MultiStreamBuilderController {
  _MultiStreamBuilderState? _currentState;

  Future<void> withAtomicUpdate(FutureOr<void> Function() bloc) async {
    final state = _currentState;
    if (state != null) {
      state._startAtomicUpdate();
      await bloc();
      state._endAtomicUpdate();
    }
  }
}

/// MultiStreamBuilder widget state
class _MultiStreamBuilderState extends State<MultiStreamBuilder> {
  List<StreamSubscription?> streamSubscriptionList = [];
  List<VoidCallback> valueListenableListenerList = [];
  List shownDataList = [];
  List latestDataList = [];
  bool isAtomicUpdating = false;

  @override
  void initState() {
    super.initState();
    widget.controller?._currentState = this;
    _initDataLists();
    _subscribe();
  }

  @override
  void didUpdateWidget(MultiStreamBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller?._currentState = this;
    if (const DeepCollectionEquality()
                .equals(oldWidget.valuesListenable, widget.valuesListenable) ==
            false ||
        const DeepCollectionEquality()
                .equals(oldWidget.streams, widget.streams) ==
            false) {
      // Dumb reload all subscriptions
      _unsubscribe(oldWidget);
      _initDataLists();
      _subscribe();
    }
  }

  @override
  void dispose() {
    widget.controller?._currentState = null;
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, shownDataList);
  }

  void _initDataLists() {
    final streamCount = widget.streams?.length ?? 0;
    final valueListenableCount = widget.valuesListenable?.length ?? 0;
    latestDataList = List.generate(streamCount + valueListenableCount, (index) {
      if (index < streamCount) {
        final stream = widget.streams![index];
        if (stream is ValueStream) {
          return stream.value;
        } else {
          return null;
        }
      } else {
        return widget.valuesListenable![index - streamCount]?.value;
      }
    });
    shownDataList = List.of(latestDataList);
  }

  void _subscribe() {
    final streamCount = widget.streams?.length ?? 0;
    final valueListenableCount = widget.valuesListenable?.length ?? 0;
    streamSubscriptionList = List.generate(streamCount, (index) {
      final subscription =
          widget.streams![index]?.listen((event) => _onEvent(event, index));
      subscription?.onError((error) => _onError(error, index));
      return subscription;
    });
    valueListenableListenerList = List.generate(valueListenableCount, (index) {
      final valueListenable = widget.valuesListenable![index];
      void listener() => _onEvent(valueListenable?.value, streamCount + index);
      valueListenable?.addListener(listener);
      return listener;
    });
  }

  void _unsubscribe([MultiStreamBuilder? widget]) {
    widget ??= this.widget;
    for (final subscription in streamSubscriptionList) {
      subscription?.cancel();
    }
    streamSubscriptionList = [];
    if (widget.valuesListenable != null) {
      for (var index = 0; index < widget.valuesListenable!.length; index++) {
        widget.valuesListenable![index]
            ?.removeListener(valueListenableListenerList[index]);
      }
    }
  }

  void _onEvent(event, int index) {
    if (widget.eventFilter == null || widget.eventFilter!(event, index)) {
      latestDataList[index] = event;
      if (!isAtomicUpdating &&
          (widget.buildWhen == null ||
              widget.buildWhen!(shownDataList, latestDataList))) {
        setState(() => shownDataList = List.of(latestDataList));
      }
    }
  }

  void _onError(error, int index) {
    latestDataList[index] = error;
    if (!isAtomicUpdating &&
        (widget.buildWhen == null ||
            widget.buildWhen!(shownDataList, latestDataList))) {
      setState(() => shownDataList = List.of(latestDataList));
    }
  }

  void _startAtomicUpdate() {
    if (isAtomicUpdating) {
      throw Exception('Called startAtomicUpdate within an atomic update');
    }
    isAtomicUpdating = true;
  }

  void _endAtomicUpdate() {
    if (!isAtomicUpdating) {
      throw Exception('Called endAtomicUpdate before startAtomicUpdate');
    }
    isAtomicUpdating = false;
    if (widget.buildWhen == null ||
        widget.buildWhen!(shownDataList, latestDataList)) {
      setState(() => shownDataList = List.of(latestDataList));
    }
  }
}
